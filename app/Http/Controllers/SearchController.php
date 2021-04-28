<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Category;
use App\Models\Brand;

class SearchController extends Controller
{
    public function search(Request $request)
    {
        $title = 'Tìm kiếm sản phẩm';
        $data = new Product;
        $queries = [''];
        $sapxep = request('sap-xep');
        $pageSize = 9;
        $sort = 'asc';
        $q = '';
        $notfound = false;
        if (request()->has('danh-muc') && request('danh-muc')!=null && request('danh-muc')!='All') {
            $name = $request['danh-muc'];
            $cateID = Category::where('slug', '=', $name)->value('id');
            $cate_list = $data->where('category_id', '=', $cateID);
            if($cate_list->get()->count())
            $data = $cate_list;
        }

        if (request()->has('thuong-hieu') && request('thuong-hieu')!=null && request('thuong-hieu')!='All') {
            $name = $request['thuong-hieu'];
            $brandId = Brand::where('name', '=', $name)->value('id');
            $data = $data->where('brand_id', '=', $brandId);
        }

        
        if ($request['tu-khoa']!="") {
            $q = $request['tu-khoa'];
            $data->where('name', 'LIKE', '%'.$q.'%')
            ->orWhere('sku', 'LIKE', '%'.$q.'%');
        }else {
            $data->take(9)->inRandomOrder()->get();
            $notfound = true;
        }

        if (request()->has('sort')) {
            $sort= request('sort');
            $data = $data->orderBy('name', $sort);
            $queries['sort'] = request('sort');
        }

        if (request()->has('sap-xep')) {
            $sapxep = request('pageSize');
            $queries['sap-xep'] = $sapxep;
        }

        $data = $data->paginate($pageSize)->appends($queries);
        $data_cate = Category::all();
        return view('product.search', ['notfound'=> $notfound, 'data' => $data,'sap-xep'=>$sapxep,'sort'=>$sort,'keyword'=>$q,'title'=>$title,'data_cate'=>$data_cate]);
    }
}
