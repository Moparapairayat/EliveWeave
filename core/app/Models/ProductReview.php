<?php

namespace App\Models;

use App\Constants\Status;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Casts\Attribute;

class ProductReview extends Model {
    use SoftDeletes;

    protected $guarded = ['id'];

    public function product() {
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function productReviewImage() {
        return $this->hasMany(ProductReviewImage::class, 'product_review_id');
    }

    public function productReviewReply() {
        return $this->hasOne(ProductReviewReply::class, 'product_review_id');
    }

    public function user() {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function scopeApproved($query) {
        return $query->where('status', Status::REVIEW_APPROVED);
    }

    public function statusBadge(): Attribute {
        return Attribute::make(
            get: function () {
                if ($this->status == Status::REVIEW_PENDING) {
                    return '<span class="badge badge--warning">' . trans('Pending') . '</span>';
                } elseif ($this->status == Status::REVIEW_APPROVED) {
                    return '<span class="badge badge--success">' . trans('Approved') . '</span>';
                } else {
                    return '<span class="badge badge--danger">' . trans('Rejected') . '</span>';
                }
            }
        );
    }
}
