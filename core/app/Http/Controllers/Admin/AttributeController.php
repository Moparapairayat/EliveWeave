<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Lib\Downloader\Downloader;
use App\Models\Attribute;
use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;

class AttributeController extends Controller {
    public function index() {
        $pageTitle  = "All Attributes";
        $attributes = Attribute::searchable(['name'])->withCount('attributeValues')->latest()->paginate(getPaginate());
        return view('admin.attribute.index', compact('pageTitle', 'attributes'));
    }

    public function store(Request $request, $id = 0) {
        $request->validate([
            'name'          => 'required|string',
            'type'          => 'required|in:1,2,3',
        ]);

        if ($id == 0) {
            $attributeType = new Attribute();
            $notification  = 'Attribute type created successfully';
        } else {
            $attributeType = Attribute::findOrFail($id);
            $notification  = 'Attribute type updated successfully';
        }

        $attributeType->name          = $request->name;
        $attributeType->type          = $request->type;
        $attributeType->save();
        $notify[] = ['success', $notification];
        return back()->withNotify($notify);
    }

    public function status($id) {
        return Attribute::changeStatus($id);
    }

    public function downloadAttributes(Request $request) {
        $attributes = Attribute::all();
        $filename = 'attributes_' . time();
        $columns = ['id', 'name'];
        $headings = ['ID', 'Name'];

        $downloader = new Downloader($filename, $attributes, $columns, $headings);

        if ($request->type == 'pdf') {
            return $downloader->downloadAsPdf('All Attributes');
        } else {
            return $downloader->downloadAsCsv();
        }
    }
}
