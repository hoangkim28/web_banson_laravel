<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class ProductAttribute extends Model
{
    protected $table = 'product_attributes';

    protected $fillable = [
        'quantity',
        'price',
        'sale_price',
        'default'
    ];
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\BelongsToMany
     */
    public function attributesValues()
    {
        return $this->belongsToMany(AttributeValue::class);
    }
}
