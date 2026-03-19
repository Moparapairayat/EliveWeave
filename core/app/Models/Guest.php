<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

use Illuminate\Database\Eloquent\Casts\Attribute;

class Guest extends Model
{
    public function fullname(): Attribute {
        return new Attribute(
            get: fn() => $this->firstname . ' ' . $this->lastname,
        );
    }

    public function mobileNumber(): Attribute {
        return new Attribute(
            get: fn() => $this->dial_code . $this->mobile,
        );
    }
}
