<?php

namespace App\Http\Controllers\Admin;

use App\Constants\Status;
use App\Http\Controllers\Controller;
use App\Lib\Downloader\Downloader;
use App\Models\Attribute;
use App\Models\AttributeValue;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;

class AttributeValueController extends Controller {
    public function index($id) {
        $attribute  = Attribute::findOrFail($id);
        $pageTitle  = "Values of " . $attribute->name;
        $attributeValues = $attribute->attributeValues()->searchable(['name', 'value'])->latest()->paginate(getPaginate());
        return view('admin.attribute.values', compact('pageTitle', 'attribute', 'attributeValues'));
    }

    function store(Request $request, $id) {
        $attribute = Attribute::findOrFail($id);

        $request->validate([
            "value_id" => "nullable|exists:attribute_values,id",
            'name'  => 'required|string',
            'value' => $this->validationRules($attribute->type),
        ]);

        $attributeValue =  $request->value_id ? AttributeValue::findOrFail($request->value_id) : new AttributeValue();

        if ($attribute->type == Status::ATTRIBUTE_TYPE_IMAGE) {
            $attributeValue->value = $this->uploadAttributeImage($request, $attributeValue->value ?? null);
        } else {
            $attributeValue->value = $request->value;
        }

        $attributeValue->attribute_id = $id;
        $attributeValue->name         = $request->name;
        $attributeValue->save();
        $notify[] = ['success', 'New attribute value added successfully'];
        return back()->withNotify($notify);
    }

    private function validationRules($type) {
        if ($type == Status::ATTRIBUTE_TYPE_IMAGE) {
            return ['nullable', 'required_if:value_id,null', 'image', new FileTypeValidate(['jpeg', 'jpg', 'png'])];
        } elseif ($type == Status::ATTRIBUTE_TYPE_COLOR) {
            return 'required|regex:/^[a-f0-9]{6}$/i';
        } else {
            return 'required|string';
        }
    }

    private function uploadAttributeImage($request, $oldValue) {
        if (is_file($request->value)) {
            return fileUploader($request->value, getFilePath('attribute'), getFileSize('attribute'), $oldValue);
        }
        return $oldValue;
    }

    public function downloadAttributeValues(Request $request) {
        $attributeValues = AttributeValue::with('attribute:id,name')->get()->map(function ($q) {
            $q->attribute_name = $q->attribute->name ?? null;
            return $q;
        });

        $filename = 'attribute_values_' . time();
        $columns = ['id', 'name', 'attribute_id', 'attribute_name'];
        $headings = ['ID', 'Name', 'Attribute ID', 'Attribute Name'];

        $downloader = new Downloader($filename, $attributeValues, $columns, $headings);

        if ($request->type == 'pdf') {
            return $downloader->downloadAsPdf('All Attribute Values');
        } else {
            return $downloader->downloadAsCsv();
        }
    }

}
