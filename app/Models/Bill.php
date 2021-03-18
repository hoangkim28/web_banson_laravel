<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


class Bill extends Model
{
    protected $guarded = [];

    protected $table = 'bills';

    public function userId()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }
    
    public function products()
    {
        return $this->belongsToMany(Product::class)->withPivot(['quantity']);
    }
}
