<?php

namespace App\Http\Controllers;

use App\Models\Attribute;
use App\Models\Category;
use App\Models\Product;
use App\Models\ProductAttribute;

class ProductController extends Controller
{
    public function detail($slug)
    {
        $product = Product::where('slug', '=', $slug)
            ->where('status', '=', 1)
            ->with('category')
            ->first();

        $product->update(['view'=> $product->view+=1]);

        $related = Product::where('slug', '!=', $slug)
            ->inRandomOrder()
            ->take(9)
            ->get();
        $title = $product->name;
        $productAttributes = $product->attributes()->get();
        $attributes = Attribute::all();
        return view('product.detail', compact('product', 'productAttributes', 'attributes', 'related', 'title'));
    }

    public function product_cate($slug){
        $date_now = date('Y-m-d H:i:s');
        $parent = false;
        $cate_data = Category::where('slug','=',$slug)->first();
        $title = $cate_data->name;
        $data = Product::where('category_id','=',$cate_data->id)->with('brand')->where('date_available', '<=', $date_now)->orderby('updated_at', 'DESC')->paginate(9);
        
        return view('product.category',compact('data','cate_data','title','parent'));
    }

    public function hotProducts()
    {
        $date_now = date('yy/m/d');
        $title = "Sản phẩm HOT nhất";
        $hotProducts = Product::where('date_available', '<=', $date_now)->orderby('view', 'asc')->paginate();
        return View('product.hot', compact('hotProducts', 'title'));
    }

    public function newProducts()
    {
        $date_now = date('yy/m/d');
        $title = "Sản phẩm mới";
        $newProducts = Product::where('date_available', '<=', $date_now)->orderby('created_at', 'asc')->paginate();
        return View('product.new', compact('newProducts', 'title'));
    }

    public function productCate($slug)
    {
        $title = "Sản phẩm mới";
        return View('');
    }

    public function productAttribute($id)
    {
        return productAttribute::find($id);
    }
}