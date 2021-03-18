<?php

namespace App\Http\Controllers;

use App\Http\Requests\CheckoutRequest;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\Product;
use App\Models\ProductAttribute;
use App\Notifications\OrderNotify;
use App\Notifications\Register;

class CheckoutController extends Controller
{
    // public function __construct()
    // {
    //     $this->middleware('auth');
    // }

    public function index()
    {
        $title = 'Đặt hàng';
        if (\Auth::user()) {
            return View('checkout')->with('title', $title);
        } else {
            // dd($title);
            return redirect()->route('login')->with('messages', 'Vui lòng đăng nhập!');
        }
    }

    public function success()
    {
        return View('success')->with('messages', 'Thành công!')->with('type', 'success');
    }

    public function store(CheckoutRequest $req)
    {
        if (!\Auth::user()) {
            return redirect()->route('login')->with('messages', 'Vui lòng đăng nhập!');
        }

        if (\Cart::count()) {
            $result = $this->addToOrderTables($req);
            if ($result) {
                $this->updateCost();
                $user = \Auth::user();

                $orderData = $result;
                $orderDetailData = OrderDetail::where('order_id', '=', $orderData->id)->get();

                $nofity = $user->notify(new OrderNotify($orderData, $orderDetailData));
                \Cart::destroy();
                return redirect()->route('home')->with('messages', 'Thành công!')->with('type', 'success');
            } else {
                return redirect()->route('cart.index')->with('messages', 'Có lỗi xảy ra!')->with('type', 'danger');
            }
        } else {
            return redirect()->route('cart')->with('messages', 'Giỏ hàng trống')->with('type', 'danger');
        }
    }

    protected function addToOrderTables($req)
    {
        $order = Order::create([
            'user_id' => auth()->user() ? auth()->user()->id : null,
            'full_name' => $req->name,
            'email' => $req->email,
            'phone' => $req->phone,
            'address1' => $req->address1,
            'address2' => $req->address2,
            'comment' => $req->comment,
            'order_status' => 1,
            'payment_method' => $req->paymend_method,
            'subtotal' => \Cart::subtotal(),
            'tax' => \Cart::tax(),
            'total' => \Cart::total(),
        ]);
        // Insert into order_product table
        $product = new Product();

        foreach (\Cart::content() as $item) {
            OrderDetail::create([
                'order_id' => $order->id,
                'product_id' => $item->id,
                'quantity' => $item->qty,
                'color' => $item->options->color,
                'product_price' => $product::find($item->id)->default_price() ? $product::find($item->id)->default_price() :  $item->product_price,
                'product_attribute_id' => $item->options->idattr,
                'product_name' => $product::find($item->id)->name,
                'product_sku' => $product::find($item->id)->sku,
            ]);
        }
        return $order;
    }

    protected function decreaseQuantities()
    {
        foreach (\Cart::content() as $item) {
            $product = Product::find($item->model->id);
            $stock = $product->stock - $item->qty;
            $product->update(['stock' => $stock]);
            $productAttrQty = ProductAttribute::find($item->options->idattr)->quantity;
            ProductAttribute::find($item->options->idattr)->update(['quantity' => $productAttrQty - $item->qty]);
        }
    }

    protected function updateCost()
    {
        foreach (\Cart::content() as $item) {
            $product = Product::find($item->model->id);
            $sold = $product->sold + $item->qty;
            $product->update(['sold' => $sold]);
        }
    }

    protected function productsAreNoLongerAvailable()
    {
        foreach (\Cart::content() as $item) {
            $product = Product::find($item->model->id);
            if ($product->stock < $item->qty) {
                return true;
            }
        }
        return false;
    }
}
