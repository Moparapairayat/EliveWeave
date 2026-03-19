<?php

namespace App\Http\Controllers\User;

use App\Models\Product;
use App\Constants\Status;
use App\Models\OrderDetail;
use Illuminate\Http\Request;
use App\Models\ProductReview;
use App\Rules\FileTypeValidate;
use App\Models\ProductReviewImage;
use App\Http\Controllers\Controller;

class ReviewController extends Controller {

    public function index() {
        $pageTitle = 'Review Products';

        $products = Product::join('order_details', 'products.id', 'order_details.product_id')
            ->join('orders', 'order_details.order_id', 'orders.id')
            ->where('orders.status', Status::ORDER_DELIVERED)
            ->orderBy('orders.created_at', 'DESC')
            ->select('products.*')
            ->where('orders.user_id', auth()->id())
            ->distinct()
            ->paginate(getPaginate());

        return view('Template::user.orders.products_for_review', compact('pageTitle', 'products'));
    }

    public function add(Request $request) {
        $request->validate([
            'pid'             => 'required|string',
            'review'          => 'nullable|string|max:2000',
            'rating'          => 'required|numeric|in:1,2,3,4,5',
            'images'          => ['nullable', 'array', 'max:10'],
            'images.*'        => ['nullable', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
            'old_images'      => ['nullable', 'array'],
            'old_images.*'    => ['nullable', 'exists:product_review_images,id'],
        ]);

        $user = auth()->user();

        OrderDetail::whereHas('order', function ($order) use ($user) {
            $order->where('user_id', $user->id)->where('status', Status::ORDER_DELIVERED);
        })->where('product_id', $request->pid)->firstOrFail();

        $review  = ProductReview::where('user_id', $user->id)->where('product_id', $request->pid)->first();

        if (!$review) {
            $update = false;
            $review             = new ProductReview();
            $review->user_id    = $user->id;
            $review->product_id = $request->pid;
            $notification       = 'added';
        } else {
            $update = true;
            $notification       = 'updated';
        }

        $review->rating = $request->rating;
        $review->review = $request->review;
        $review->is_viewed = Status::NO;
        $review->status = gs('product_review_auto_approval') ? Status::REVIEW_APPROVED : Status::REVIEW_PENDING;
        $review->save();

        $image = $this->insertImages($request, $review, $update);

        if (!$image) {
            return response()->json([
                'status' => 'error',
                'message' => "Couldn\'t upload images",
            ]);
        }

        $notify[] = ['success', "Review $notification successfully"];
        return back()->withNotify($notify);
    }

    protected function insertImages($request, $review, $update) {
        $path = getFilePath('review');

        if ($update) {
            $this->removeImages($request, $review, $path);
        }


        if ($request->file('images')) {
            $images    = [];
            foreach ($request->file('images') as $file) {
                try {
                    $name                      = fileUploader($file, $path);
                    $image                     = new ProductReviewImage();
                    $image->product_review_id = $review->id;
                    $image->image               = $name;
                    $images[]                  = $image;
                } catch (\Exception $exp) {
                    return false;
                }
            }
            $review->productReviewImage()->saveMany($images);
        }
        return true;
    }

    protected function removeImages($request, $review, $path) {
        $previousImages = $review->productReviewImage->pluck('id')->toArray();
        $imageToRemove  = array_values(array_diff($previousImages, $request->old_images ?? []));
        foreach ($imageToRemove as $item) {
            $reviewImage   = ProductReviewImage::find($item);
            fileManager()->removeFile($path . '/' . $reviewImage->image);
            $reviewImage->delete();
        }
    }
}
