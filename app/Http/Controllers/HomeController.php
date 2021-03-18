<?php

namespace App\Http\Controllers;

use App\Models\Brand;
use App\Models\Category;
use App\Models\Product;
use App\Notifications\OrderNotify;

class HomeController extends Controller
{
    public function index()
    {
        $title = 'Trang chủ';
        $date_now = date('Y-m-d H:i:s');
        $lastestProduct = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('created_at', 'ASC')->take(10)->with('category', 'brand')->paginate(9);
        $topViewProduct = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('view', 'DESC')->take(4)->get();
        $saleProduct = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('updated_at', 'ASC')->take(4)->get();
        $allBrand = Brand::where('status', '=', 1)->orderby('updated_at', 'ASC')->get();
        $topSoldProduct = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('sold', 'DESC')->orderby('created_at', 'ASC')->take(9)->get();
        $allCate = Category::where('status', '=', 1)->orderby('updated_at', 'ASC')->get();
        return view('welcome', compact('lastestProduct', 'saleProduct', 'allBrand', 'topSoldProduct', 'allCate', 'topViewProduct', 'title'));
    }

    public function topViewProduct()
    {
        $date_now = date('Y-m-d H:i:s');
        $data = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('view', 'DESC')->paginate();
        return $data;
    }
}
