<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;

use App\Models\Product;
use Illuminate\Http\Request;


class ProductExportController extends Controller {

    public function bulkExport() {
        $pageTitle = 'Export Products';
        $products  = Product::paginate(getPaginate());
        $columns   = Product::getColumnNames();
        return view('admin.product.export', compact('pageTitle', 'columns', 'products'));
    }

    public  function bulkExportProduct(Request $request) {

        $columns = implode(',', Product::getColumnNames());

        $request->validate([
            'columns'   => 'required|array',
            'columns.*' => 'required|in:'. $columns,
            'from_id'   => 'required_with:to_id|integer|gte:0',
            'to_id'     => 'nullable|integer|gte:from_id',
        ]);

        $product                        = new Product();
        $product->exportColumns         = $request->columns;
        $product->fileName              = 'products_' . time() . '.csv';
        $product->exportItem            = $request->export_item;
        $product->orderBy               = "ASC";
        $product->startId               = $request->from_id;
        $product->endId                 = $request->to_id;
        return  $product->export();
    }
}
