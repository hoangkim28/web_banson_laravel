<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderDetail extends Model
{
    //
    public $timestamps = false;

    protected $guarded = [];

    protected $table = 'order_details';

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
