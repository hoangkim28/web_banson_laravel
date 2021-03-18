<?php

namespace App\Models;

use App\Models\AttributeValue;
use App\Models\Brand;
use App\Models\Category;
use App\Models\ProductAttribute;
use App\Models\Vendor;
use App\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\App;
use TCG\Voyager\Traits\Resizable;
use TCG\Voyager\Traits\Translatable;

class Product extends Model
{
    protected $table = 'products';

    use Translatable,
        Resizable;

    protected $translatable = ['title', 'seo_title', 'excerpt', 'body', 'slug', 'meta_description', 'meta_keywords'];

    const PUBLISHED = 'PUBLISHED';

    protected $guarded = [];

    public function save(array $options = [])
    {
        $this->date_lastview = now();

        if ($this->date_available) {
            $this->date_available = now();
        }

        parent::save();
    }

    public function authorId()
    {
        return $this->belongsTo(User::class, 'author_id', 'id');
    }

    /**
     * Scope a query to only published scopes.
     *
     * @param \Illuminate\Database\Eloquent\Builder $query
     *
     * @return \Illuminate\Database\Eloquent\Builder
     */
    public function scopePublished(Builder $query)
    {
        return $query->where('status', '=', static::PUBLISHED);
    }

    /**
     * @return \Illuminate\Database\Eloquent\Relations\HasOne
     */
    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function attributes()
    {
        return $this->hasMany(ProductAttribute::class);
    }

    public function saveCombination(ProductAttribute $productAttribute, AttributeValue...$attributeValues): Collection
    {
        return collect($attributeValues)->each(function (AttributeValue $value) use ($productAttribute) {
            return $productAttribute->attributesValues()->save($value);
        });
    }

    public function saveProductAttributes(ProductAttribute $productAttribute): ProductAttribute
    {
        $this->attributes()->save($productAttribute);
        return $productAttribute;
    }

    public function brand()
    {
        return $this->belongsTo(Brand::class);
    }

    public function getUrl()
    {
        return route('product.detail', ['slug' => $this->slug]);
    }


    public function getPrice()
    {
        $price = $this->price;
        if ($this->promotion > 0) {
            $price = $this->price - $this->price * $this->promotion / 100;
        }

        return $price;
    }

    public function default_price()
    {
        $attrbute = ProductAttribute::where('product_id', '=', $this->id)->where('default', '=', 1)->first();
        return $attrbute->sale_price ? $attrbute->price : $attrbute->sale_price;
    }

}
