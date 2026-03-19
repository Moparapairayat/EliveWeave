<?php

namespace App\Http\Controllers\Admin;

use App\Constants\Status;
use App\Http\Controllers\Controller;
use App\Models\Attribute;
use App\Models\AttributeValue;
use App\Models\Brand;
use App\Models\Category;
use App\Models\Media;
use App\Models\Product;
use App\Models\StockLog;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use App\Rules\FileTypeValidate;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class ProductImportController extends Controller {

    public function bulkImport() {
        $pageTitle = 'Import Products';
        $products  = Product::paginate(getPaginate());
        $columns   = Product::getColumnNames();
        return view('admin.product.import', compact('pageTitle', 'columns', 'products'));
    }

    private function getColumns() {
        return [
            'brand_id',
            'name',
            'slug',
            'sku',
            'regular_price',
            'sale_price',
            'sale_starts_from',
            'sale_ends_at',
            'main_image_id',
            'video_link',
            'description',
            'summary',
            'product_type_id',
            'track_inventory',
            'show_stock',
            'in_stock',
            'alert_quantity',
            'product_type',
            'is_published',
            'categories',
            'product_attributes',
            'attribute_values',
            'gallery_images',
            'meta_title',
            'meta_description',
            'meta_keywords',
            'show_in_products_page'
        ];
    }

    public function storeBulkImport(Request $request) {
        $request->validate(["file" => ['required', 'file', new FileTypeValidate(['csv', 'xlsx'])]]);
        try {
            $rows = importFileReader($request->file, $this->getColumns());
            $productsData        = [];
            $galleryImagesData   = [];
            $categoriesData      = [];
            $attributeData       = [];
            $attributeValuesData = [];
            $brandData           = [];
            $slugsData           = [];
            $stockLogs           = [];

            foreach ($rows->allData as $data) {
                $combinedData = $this->prepareData($data);

                if (!$combinedData) {
                    continue; // Skip invalid data
                }

                if (!empty($combinedData['gallery_images'])) {
                    $galleryImagesData[] = [
                        'slug'         => $combinedData['slug'],
                        'media_ids'    => $this->processGalleryImages($combinedData),
                    ];
                }

                if (!empty($combinedData['categories'])) {
                    $categoriesData[] = [
                        'slug'       => $combinedData['slug'],
                        'categories' => $combinedData['categories'],
                    ];
                }

                if (!empty($combinedData['brand_id'])) {
                    $brandData[] = [
                        'slug'       => $combinedData['slug'],
                        'brand_id' => $combinedData['brand_id'],
                    ];
                }

                if (!empty($combinedData['track_inventory'])) {
                    $stockLogs[] = [
                        'slug'     => $combinedData['slug'],
                        'quantity' => $combinedData['in_stock'] ?? 0,
                    ];
                }

                if ($combinedData['product_type'] == Status::PRODUCT_TYPE_VARIABLE && !empty($combinedData['product_attributes'])) {
                    $attributeData[] = [
                        'slug'       => $combinedData['slug'],
                        'product_attributes' => $combinedData['product_attributes'],
                    ];
                }

                if ($combinedData['product_type'] == Status::PRODUCT_TYPE_VARIABLE && !empty($combinedData['attribute_values'])) {
                    $attributeValuesData[] = [
                        'slug' => $combinedData['slug'],
                        'attribute_values' => $combinedData['attribute_values'],
                    ];
                }

                if (!empty($combinedData['slug'])) {
                    $slugsData[] = [
                        'slug' => $combinedData['slug']
                    ];
                }

                unset($combinedData['gallery_images']);
                unset($combinedData['categories']);
                unset($combinedData['product_attributes']);
                unset($combinedData['attribute_values']);

                if ($combinedData['sale_starts_from'] && $combinedData['sale_ends_at']) {
                    $combinedData['sale_starts_from'] = Carbon::parse($combinedData['sale_starts_from'])->format('Y-m-d H:i:s');
                    $combinedData['sale_ends_at'] = Carbon::parse($combinedData['sale_ends_at'])->format('Y-m-d H:i:s');
                }

                $productsData[] = $combinedData;
            }

            $errors = [];

            if ($error = $this->validateIds($brandData, 'brand_id', Brand::class, "Invalid brand ids: ")) {
                $errors[] = $error;
            }

            if ($error = $this->validateIds($categoriesData, 'categories', Category::class, "Invalid category ids: ")) {
                $errors[] = $error;
            }

            if ($error = $this->validateIds($attributeData, 'product_attributes', Attribute::class, "Invalid attribute ids: ")) {
                $errors[] = $error;
            }

            if ($error = $this->validateIds($attributeValuesData, 'attribute_values', AttributeValue::class, "Invalid attribute value ids: ")) {
                $errors[] = $error;
            }

            if ($error = $this->validateIds($galleryImagesData, 'media_ids', Media::class, "Invalid gallery image ids: ")) {
                $errors[] = $error;
            }

            if (!empty($errors)) {
                return back()->withNotify($errors);
            }

            //slug
            $slugs = array_flatten(array_column($slugsData, 'slug'));
            $duplicateSlugs = array_unique(array_diff_assoc($slugs, array_unique($slugs)));
            $existingSlugs = Product::whereIn('slug', $slugs)->pluck('slug')->toArray();
            $conflictingSlugs = array_unique(array_merge($duplicateSlugs, $existingSlugs));

            if (!empty($conflictingSlugs)) {
                $notify[] = ['error', "The following slugs are either duplicated or already exist: " . implode(", ", $conflictingSlugs)];
                return back()->withNotify($notify);
            }

            collect($productsData)->chunk(500)->each(function ($chunk) {
                Product::insert($chunk->toArray());
            });

            $productIds = Product::whereIn('slug', array_column($productsData, 'slug'))->pluck('id', 'slug')->toArray();

            $this->bulkInsertGalleryImages($galleryImagesData, $productIds);
            $this->bulkInsertCategories($categoriesData, $productIds);
            $this->bulkInsertStockLogs($stockLogs, $productIds);
            $this->bulkInsertProductAttributes($attributeData, $productIds);
            $this->bulkInsertAttributeValues($attributeValuesData, $productIds);

        } catch (\Exception $ex) {
            $notify[] = ['error', $ex->getMessage()];
            return back()->withNotify($notify);
        }

        $notify[] = ['success', 'Products imported successfully'];
        return back()->withNotify($notify);
    }

    /**
     * Bulk insert stock logs
     */
    private function bulkInsertStockLogs($stockLogs, $productIds) {
        $bulkData = [];

        foreach ($stockLogs as $entry) {

            if (!isset($productIds[$entry['slug']])) {
                continue;
            }

            $changeQuantity = $entry['quantity'] ?? 0;
            if ($changeQuantity == 0) {
                continue;
            }

            $string = Str::plural('product', abs($changeQuantity));
            $description = ($changeQuantity > 0) ? "$changeQuantity $string added" : abs($changeQuantity) . " $string subtracted";
            $remark = ($changeQuantity > 0) ? '+' : '-';
            $productId = $productIds[$entry['slug']];
            $product = Product::find($productId);

            $postQuantity = $product ? $product->in_stock : 0;
            $orderId = $entry['order_id'] ?? null;

            $bulkData[] = [
                'product_id'  => $productId,
                'change_quantity' => abs($changeQuantity),
                'post_quantity' => $postQuantity,
                'order_id'    => $orderId,
                'description' => $description,
                'remark'      => $remark,
                'created_at'  => now(),
                'updated_at'  => now(),
            ];
        }

        if (!empty($bulkData)) {
            StockLog::insert($bulkData);
        }
    }

    /**
     * Bulk insert gallery images into pivot table `media_product`
     */
    private function bulkInsertGalleryImages($galleryImagesData, $productIds) {
        $bulkData = [];

        foreach ($galleryImagesData as $entry) {
            foreach ($entry['media_ids'] as $imageId) {
                $bulkData[] = [
                    'product_id' => $productIds[$entry['slug']],
                    'media_id'   => $imageId,
                ];
            }
        }

        if (!empty($bulkData)) {
            DB::table('media_product')->insert($bulkData);
        }
    }

    /**
     * Bulk insert categories into pivot table `category_product`
     */
    private function bulkInsertCategories($categoriesData, $productIds) {
        $bulkData = [];

        foreach ($categoriesData as $entry) {
            foreach ($entry['categories'] as $categoryId) {
                $bulkData[] = [
                    'product_id'  => $productIds[$entry['slug']],
                    'category_id' => $categoryId,
                ];
            }
        }

        if (!empty($bulkData)) {
            DB::table('category_product')->insert($bulkData);
        }
    }

    /**
     * Bulk insert categories into pivot table `category_product`
     */
    private function bulkInsertProductAttributes($attributeData, $productIds) {
        $bulkData = [];

        foreach ($attributeData as $entry) {
            foreach ($entry['product_attributes'] as $attributeId) {
                $bulkData[] = [
                    'product_id'   => $productIds[$entry['slug']],
                    'attribute_id' => $attributeId,
                ];
            }
        }

        if (!empty($bulkData)) {
            DB::table('attribute_product')->insert($bulkData);
        }
    }

    private function bulkInsertAttributeValues($attributeValuesData, $productIds) {
        $bulkData = [];

        foreach ($attributeValuesData as $entry) {
            foreach ($entry['attribute_values'] as  $values) {
                foreach ($values as $valueId) {
                    $bulkData[] = [
                        'product_id' => $productIds[$entry['slug']],
                        'attribute_value_id' => $valueId,
                    ];
                }
            }
        }

        if (!empty($bulkData)) {
            DB::table('attribute_value_product')->insert($bulkData);
        }
    }

    /**
     * Process gallery images and validate their existence.
     */
    private function processGalleryImages(array $data) {
        $galleryImages = array_filter(explode(",", trim($data['gallery_images'], ',')));

        return $galleryImages;
    }

    /**
     * Prepare and validate product data from CSV row.
     */
    private function prepareData(array $data) {

        $data['meta_keywords'] = explode(',', $data['meta_keywords'] ?? '');
        $data['categories'] = explode(',', $data['categories'] ?? '');

        if ($data['product_type'] == Status::PRODUCT_TYPE_VARIABLE) {
            $data['product_attributes'] = explode(',', $data['product_attributes'] ?? '');
            $data['attribute_values'] = $this->parseAttributeValues($data['attribute_values'] ?? '');
        }

        if ($data['sale_starts_from'] && $data['sale_ends_at']) {
            $data['sale_starts_from'] = Carbon::parse($data['sale_starts_from'])->format('Y-m-d h:i A');
            $data['sale_ends_at'] = Carbon::parse($data['sale_ends_at'])->format('Y-m-d h:i A');
        }

        $validatedData = $this->validateData($data);

        if (!$validatedData) {
            return null;
        }

        $data['meta_keywords'] = json_encode($validatedData['meta_keywords']);

        return $data;
    }

    private function validateData($data) {
        $validationRules   = $this->validationRules();
        return Validator::make($data, $validationRules)->validated();
    }

    private function validationRules() {
        $productTypes = implode(',', [Status::PRODUCT_TYPE_SIMPLE, Status::PRODUCT_TYPE_VARIABLE]);

        return [
            // Basic Information
            'name'                      => 'nullable|string',
            'slug'                      => 'nullable|regex:/^[a-z0-9-]+$/',
            'product_type'              => 'nullable|in:' . $productTypes,
            'brand_id'                  => 'nullable|integer|gt:0',
            "categories"                => 'nullable|array|min:1',
            "categories.*"              => 'required|integer|gt:0',

            // Pricing
            'regular_price'             => 'nullable|required_with:sale_price|numeric|gte:0',
            'sale_price'                => 'nullable|numeric|lte:regular_price',
            "sale_starts_from"          => 'nullable|date|date_format:Y-m-d h:i A',
            "sale_ends_at"              => 'nullable|date|date_format:Y-m-d h:i A|after:sale_starts_from',

            // Product Description
            'description'               => 'nullable|string',
            'summary'                   => 'nullable|string|max:6000',

            // SEO Contents
            'meta_title'                => 'nullable|string',
            'meta_description'          => 'nullable|string',
            'meta_keywords'             => 'nullable|array',
            'meta_keywords.array.*'     => 'required_with:meta_keywords|string',

            // Media Contents
            'main_image_id'             => 'nullable|integer|gt:0',
            'gallery_images'            => 'nullable|string',
            'video_link'                => 'nullable|url',

            // Product Status
            'is_published'              => 'nullable|in:1',

            // Variant Management
            'product_attributes'        => 'nullable|required_if:product_type,' . Status::PRODUCT_TYPE_VARIABLE . '|array|min:1',
            'product_attributes.*'      => 'nullable|required_with:product_attributes',
            'attribute_values'          => 'nullable|required_with:product_attributes|array|min:1',
            'attribute_values.*'        => 'nullable|required_with:attribute_values',

            // Inventory
            'track_inventory'           => 'nullable|in:1',
            'show_stock'                => 'nullable|in:1',
            'sku'                       => 'nullable|string|max:40',
            'in_stock'                  => 'nullable|integer|gte:0',
            'alert_quantity'            => 'nullable|integer|gte:0',
        ];
    }

    private function parseAttributeValues($attributeValues) {
        $result = [];

        if (!$attributeValues) {
            return $result;
        }

        $pairs = explode('|', $attributeValues);

        foreach ($pairs as $pair) {
            [$attributeId, $values] = explode(':', $pair) + [null, null];
            if ($attributeId !== null && $values !== null) {
                $result[(int) $attributeId] = array_map('intval', explode(',', $values));
            }
        }

        return $result;
    }

    private function validateIds(array $data, string $column, string $modelClass, string $errorMessage) {
        $ids = array_unique(array_flatten(array_column($data, $column)));

        $existingIds = $modelClass::whereIn('id', $ids)->pluck('id')->toArray();
        $differenceIds = array_diff($ids, $existingIds);

        if (!empty($differenceIds)) {
            return ['error', $errorMessage . implode(",", $differenceIds)];
        }

        return null;
    }
}
