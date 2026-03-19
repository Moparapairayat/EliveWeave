<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductReviewReply extends Model
{

    protected $table = 'product_review_replies';
    
    public function productReviewReplyImage()
    {
        return $this->hasMany(ProductReviewImage::class, 'product_review_reply_id');
    }

    public function admin()
    {
        return $this->belongsTo(Admin::class,'admin_id');
    }
}
