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
        $lastestProduct = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('created_at', 'ASC')->with('category', 'brand')->take(6)->get();
        $topViewProduct = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('view', 'DESC')->with('category', 'brand')->take(6)->get();
        $topSoldProduct = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('sold', 'DESC')->orderby('created_at', 'ASC')->take(9)->get();
        $allCate = Category::where('status', '=', 1)->orderby('updated_at', 'ASC')->get();
        return view('welcome', compact('lastestProduct', 'topSoldProduct', 'allCate', 'topViewProduct', 'title'));
    }

    public function topViewProduct()
    {
        $date_now = date('Y-m-d H:i:s');
        $data = Product::where('status', '=', '1')->where('date_available', '<=', $date_now)->orderby('view', 'DESC')->paginate();
        return $data;
    }
}
