<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class BillDetail extends Model
{
    //
    public $timestamps = false;

    protected $guarded = [];

    protected $table = 'bill_details';

    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}
