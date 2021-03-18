<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Redirect;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\Product;
use App\Rules\MatchOldPassword;
use Illuminate\Support\Facades\Hash;
use App\User;


class ManagerController extends Controller
{
    //
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index()
    {
        $user = Auth::user();
        $listOrder = Order::where('user_id','=',$user->id)->orderby('updated_at','desc')->get();
        return view('auth.manager',compact('user','listOrder'));
    }
   
    /**
     * Show the application dashboard.
     *
     * @return \Illuminate\Contracts\Support\Renderable
     */
    public function changePassword(Request $request)
    {
        $request->validate([
            'current_password' => ['required', new MatchOldPassword],
            'new_password' => ['required'],
            'new_confirm_password' => ['same:new_password'],
        ]);
   
        User::find(auth()->user()->id)->update(['password'=> Hash::make($request->new_password)]);
   
        return redirect()->back()->with('status', 'Thành công!')->with('type','success');
    }

    public function orderDetail($id)
    {
        $order = Order::where('id','=',$id)->first();
        $details = OrderDetail::where('order_id','=',$id)->get();
        if(Auth::user()->email!=$order->email){
            return view('order_erro');
        }
        return view('order_detail',\compact('order','details'));
    }
}
