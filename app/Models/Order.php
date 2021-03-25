<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\OrderStatus;
class Order extends Model
{
    //
    protected $guarded = [];

    protected $table = 'orders';

    public function userId()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function products()
    {
        return $this->belongsToMany(Product::class)->withPivot(['quantity']);
    }

    public function order_status()
    {
        return $this->belongsTo(OrderStatus::class, 'order_status', 'id');
    }
}
