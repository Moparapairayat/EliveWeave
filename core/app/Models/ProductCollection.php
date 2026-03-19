<?php

namespace App\Models;

use App\Constants\Status;
use Illuminate\Database\Eloquent\Model;

class ProductCollection extends Model
{
    protected $casts = ['product_ids' => 'array'];

    public function products()
    {
        return Product::published()->whereIn('id', $this->product_ids ?? [])->ratingReviewCount()->with('brand:id,name', 'productVariants')->get();
    }
}
