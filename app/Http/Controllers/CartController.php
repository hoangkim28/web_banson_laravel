<?php

namespace App\Http\Controllers;

use App\Models\AttributeValue;
use App\Models\AttributeValueProductAttribute;
use App\Models\Product;
use App\Models\ProductAttribute;
use Illuminate\Http\Request;
use Cart;

class CartController extends Controller
{
    public function index()
    {
        $title = 'Giỏ hàng';
        return View('cart', ['title' => $title]);
    }

    public function store(Request $request)
    {
        $id = $request->id;
        $color = $request->color;
        $qty = $request->qty;
        $product = Product::find($id);
        $unitId = $request->unit;
        $attributeValueId = $request->attibuteValue;

        $productAttributes = ProductAttribute::where('id', '=', $unitId)->first();

        $attr = AttributeValue::find(
            AttributeValueProductAttribute::where('product_attribute_id', '=', $unitId)->first()->attribute_value_id)->name;

        $productPrice = 0;

        if ($productAttributes->sale_price != null || $productAttributes->sale_price > 0) {
            $productPrice = $productAttributes->sale_price;
        } else {
            $productPrice = $productAttributes->price;
        }

        // Kiem tra so luong con truoc khi dat
        if ($qty > $productAttributes->quantity) {
            return response()->json(['msg' => "0"]);
        }else{
          Cart::add(array(
            'id' => $attributeValueId,
            'name' => $product->name,
            'price' => $productPrice,
            'quantity' => $qty,
            'attributes' => ['color' => $color, 'unit' => $attr, 'idattr' => $unitId,'idattrvalue'=>$attributeValueId],
            'associatedModel' => $product
        ));
          return response()->json(['msg' => "1"]);
        }
    }

    public function update($rowId, $qty)
    {
        \Cart::update($rowId, $qty);
        return response()->json(['msg' => "1"]);
    }

    public function updateColor($id, $rowId, $qty, $color, $unit)
    {
        \Cart::remove($rowId);
        $product = Product::find($id)->first();
        $productPrice = $product->price;
        if ($product->promotion != 0) {
            get_last_price($product);
        }

        \Cart::add($id, $product->name, $qty, $productPrice, ['color' => $color])->associate('App\Models\Product');
        return response()->json(['msg' => "Đã cập nhật"]);
    }

    public function remove($rowId)
    {
        \Cart::remove($rowId);
        return response()->json(['msg' => "Đã xóa"]);
    }

    public function destroy()
    {
        \Cart::clear();
        return response()->json(['msg' => "Đã xóa"]);
    }

    public function updateItemCart($rowId)
    {
        $title = 'Thay đổi chọn thuộc tính sản phẩm';
        return View('cart_item_change', ['title' => $title]);
    }
}
