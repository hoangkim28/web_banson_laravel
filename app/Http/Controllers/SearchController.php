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
        if (request()->has('tu-khoa')) {
            $q = request('tu-khoa');
            $data->where('name', 'LIKE', '%'.$q.'%')
            ->orWhere('sku', 'LIKE', '%'.$q.'%')
            ->orWhere('seo_title', 'LIKE', '%'.$q.'%')
            ->orWhere('excerpt', 'LIKE', '%'.$q.'%')
            ->orWhere('body', 'LIKE', '%'.$q.'%')
            ->orWhere('slug', 'LIKE', '%'.$q.'%')
            ->orWhere('meta_keywords', 'LIKE', '%'.$q.'%');
        }

        if (request()->has('danh-muc') && request('danh-muc')!=null && request('danh-muc')!='All') {
            $name = request('danh-muc');
            $cateID = Category::where('slug', '=', $name)->value('id');

            $data = $data->where('category_id', '=', $cateID);
        }

        if (request()->has('thuong-hieu') && request('thuong-hieu')!=null && request('thuong-hieu')!='All') {
            $name = request('thuong-hieu');
            $brandId = Brand::where('name', '=', $name)->value('id');
            $data = $data->where('brand_id', '=', $brandId);
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
        return view('product.search', ['data' => $data,'sap-xep'=>$sapxep,'sort'=>$sort,'keyword'=>$q,'title'=>$title,'data_cate'=>$data_cate]);
    }
}
