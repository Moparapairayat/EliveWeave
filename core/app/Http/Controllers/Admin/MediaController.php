<?php

namespace  App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Media;
use App\Rules\FileTypeValidate;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class MediaController extends Controller {

    public function media() {
        $pageTitle = 'Product Images';
        $mediaFiles = Media::searchable(['file_name'])
            ->withCount('products')
            ->withCount('productImages')
            ->withCount('productVariants')
            ->withCount('productVariantImages');

        if (request()->has('order_by')) {
            try {
                $orderBy = explode('::', request()->order_by);
                $mediaFiles->orderBy($orderBy[0], $orderBy[1]);
            } catch (\Exception $e) {
                $notify[] = ['error', 'Invalid data'];
                return back()->withNotify($notify);
            }
        }else{
            $mediaFiles->orderBy('id', 'desc');
        }

        $mediaFiles = $mediaFiles->paginate(48);

        return view('admin.uploaded_files', compact('pageTitle', 'mediaFiles'));
    }

    public function mediaFiles() {
        $mediaFiles = Media::orderBy('id', 'desc')->paginate(33);
        return response()->json($mediaFiles);
    }

    public function upload(Request $request) {
        $validator = Validator::make($request->all(), [
            'photos'           => 'required|array|max:20',
            'photos.*'         => ['required', 'image', new FileTypeValidate(['jpeg', 'jpg', 'png'])],
            'files_for'        => 'required|in:product,category,categoryIcon,brand'
        ], [
            'photos.required' => 'Please upload at least one image',
        ]);

        if ($validator->fails()) {
            return errorResponse($validator->errors());
        }

        $uploaded = [];

        $filesFor = $request->files_for;

        foreach ($request->photos as $photo) {

            $originalName = $photo->getClientOriginalName();
            $filename = pathinfo($originalName, PATHINFO_FILENAME);
            $extension = $photo->getClientOriginalExtension();
            $path = getFilePath($filesFor);

            $counter = 0;
            $newFilename = $originalName;

            while (file_exists($path . '/' . $newFilename)) {
                $counter++;
                $newFilename = $filename . '(' . $counter . ').' . $extension;
            }
            $media            = new Media();
            $media->path      = getFilePath($filesFor);
            $media->file_name = fileUploader($photo, getFilePath($filesFor), getFileSize($filesFor), null, getThumbSize($filesFor), $newFilename);
            $media->save();
            $uploaded[] = $media;
        }

        return successResponse('Uploaded successfully', ['uploaded' => $uploaded]);
    }

    function delete($id) {

        try {
            $media = Media::find($id);
            fileManager()->removeFile($media->path . '/' . @$media->file_name);
            fileManager()->removeFile($media->path . '/thumb_' . @$media->file_name);
            $media->delete();
        } catch (\Exception $e) {
            $notify[] = ['error', 'File not found'];
            return back()->withNotify($notify);
        }

        $notify[] = ['success', 'Deleted successfully'];
        return back()->withNotify($notify);
    }
}
