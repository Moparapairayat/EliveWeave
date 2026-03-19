<?php

namespace App\Http\Controllers\Admin;

use App\Constants\Status;
use Illuminate\Http\Request;
use App\Models\ProductReview;
use App\Rules\FileTypeValidate;
use App\Models\ProductReviewImage;
use App\Models\ProductReviewReply;
use App\Http\Controllers\Controller;

class ProductReviewController extends Controller {
    public function reviews(Request $request) {
        $pageTitle = "All Product Reviews";
        $reviews   = ProductReview::searchable(['review', 'rating', 'product:name', 'user:username'])
            ->with(['product', 'user'])
            ->whereHas('product')
            ->whereHas('user');

        if (request()->user) {
            $reviews->whereHas('user', function ($q) {
                return $q->where('username', request()->user);
            });
        }

        if (request()->product) {
            $reviews->whereHas('product', function ($q) {
                return $q->where('slug', request()->product);
            });
        }

        if ($request->has('is_viewed') && $request->is_viewed != null) {
            $reviews->where('is_viewed', $request->is_viewed);
        }

        $reviews = $reviews->orderBy('id', 'DESC')->paginate(getPaginate());

        return view('admin.product.review.index', compact('pageTitle', 'reviews'));
    }

    public function trashedReviews() {
        $pageTitle = "All Product Reviews";
        $reviews   = ProductReview::onlyTrashed()
            ->with(['product', 'user'])
            ->whereHas('product')
            ->whereHas('user')
            ->orderBy('id', 'DESC')
            ->paginate(getPaginate());
        return view('admin.product.review.index', compact('pageTitle', 'reviews'));
    }

    public function reviewDelete($id) {
        $review  = ProductReview::where('id', $id)->withTrashed()->first();
        $product = $review->product;
        if ($review->trashed()) {
            $newReview = ProductReview::where('user_id', $review->user_id)->where('product_id', $review->product_id)->first();

            if ($newReview) {
                $notify[] = ['error', 'User already submitted another review'];
                return back()->withNotify($notify);
            }

            $review->restore();
            $notify[] = ['success', 'Review restored successfully'];
        } else {
            $review->delete();
            $notify[] = ['success', 'Review deleted successfully'];
        }
        $product->save();
        return back()->withNotify($notify);
    }

    public function view($id) {
        $pageTitle = 'Product Review';
        $review = ProductReview::with(['product:id,name', 'user:id,firstname,lastname,image,username', 'productReviewReply', 'productReviewImage:id,product_review_id,image', 'productReviewReply.admin:id,name,image', 'productReviewReply.productReviewReplyImage'])->findOrFail($id);

        $review->is_viewed = Status::YES;
        $review->save();
        return view('admin.product.review.view', compact('pageTitle', 'review'));
    }


    public function reviewReply(Request $request, $id) {
        $request->validate([
            'comment'      => ['required', 'string', 'max:2000'],
            'images'       => ['nullable', 'array', 'max:10'],
            'images.*'     => ['nullable', 'image', new FileTypeValidate(['jpg', 'jpeg', 'png'])],
            'old_images'   => ['nullable', 'array'],
            'old_images.*' => ['nullable', 'exists:product_review_images,id'],
        ],[
            'comment.required' => 'Please write your reply',
        ]);

        $review = ProductReview::with(['productReviewReply'])->findOrFail($id);

        $update = false;

        if ($review->productReviewReply) {
            $reply = $review->productReviewReply;
            $update = true;
            $message = 'Reply updated successfully';
        } else {
            $reply = new ProductReviewReply();
            $message = 'Replied successfully';
        }

        $reply->comment = $request->comment;
        $reply->admin_id = auth()->guard('admin')->id();
        $reply->product_review_id = $id;
        $reply->save();

        $image = $this->insertImages($request, $reply, $update);

        if (!$image) {
            $notify[] = ['error', 'Couldn\'t upload account listing images'];
            return back()->withNotify($notify);
        }

        $images = [];

        if (!empty($reply->productReviewReplyImage)) {
            foreach ($reply->productReviewReplyImage as $replyImage) {
                $images[] = getImage(getFilePath('review') . '/' . $replyImage->image);
            }
        }

        $notify[] = ['success', $message];
        return back()->withNotify($notify);
    }

    protected function insertImages($request, $reply, $update) {
        $path = getFilePath('review');
        if ($update) {
            $this->removeImages($request, $reply, $path);
        }

        $hasImages = $request->file('images');

        if ($hasImages) {
            $images    = [];

            foreach ($hasImages as $file) {
                try {
                    $name                      = fileUploader($file, $path);
                    $image                     = new ProductReviewImage();
                    $image->product_review_reply_id = $reply->id;
                    $image->image               = $name;
                    $images[]                  = $image;
                } catch (\Exception $exp) {
                    return false;
                }
            }

            $reply->productReviewReplyImage()->saveMany($images);
        }
        return true;
    }

    protected function removeImages($request, $reply, $path) {
        $previousImages = $reply->productReviewReplyImage->pluck('id')->toArray();
        $imageToRemove  = array_values(array_diff($previousImages, $request->old ?? []));
        foreach ($imageToRemove as $item) {
            $reviewImage   = ProductReviewImage::find($item);
            fileManager()->removeFile($path . '/' . $reviewImage->image);
            $reviewImage->delete();
        }
    }

    public function reviewApprove($id) {
        $review         = ProductReview::findOrFail($id);
        $review->status = Status::REVIEW_APPROVED;
        $review->reject_reason = '';
        $review->save();

        notify($review->user, 'REVIEW_APPROVE', [
            'product_name' => $review->product->name,
        ]);

        $notify[] = ['success', 'Review approved successfully'];
        return back()->withNotify($notify);
    }

    public function reviewReject(Request $request, $id) {
        $request->validate([
            'reject_reason' => 'required|string',
        ]);

        $review                = ProductReview::with('user')->findOrFail($id);
        $review->status        = Status::REVIEW_REJECTED;
        $review->reject_reason = $request->reject_reason;
        $review->save();

        notify($review->user, 'REVIEW_REJECT', [
            'product_name' => $review->product->name,
            'rejected_reason' => $review->reject_reason,
        ]);

        $notify[] = ['success', 'Review rejected successfully'];
        return back()->withNotify($notify);
    }
}
