@extends('layouts.app')

@section('banner')
<section id="page-title" class="page-title" style="margin-top: 72px;">
  <div class="container-wrap">
    <div class="region region-page-title">
      <div id="block-wosh-sub-page-title" class="block block-core block-page-title-block">
        <div class="top-paint-color hidden"></div>
        <div class="container-wrap clearfix">
          <div class="block-content">
            <div><span>Thông tin đơn hàng</span></div>
          </div>
        </div>
        <div class="bot-paint-color hidden"></div>
      </div>
    </div>
    <div class="region region-breadcrumb">
      <div id="block-wosh-sub-breadcrumbs" class="block block-system block-system-breadcrumb-block">
        <div class="top-paint-color hidden"></div>
        <div class="container-wrap clearfix">
          <div class="block-content">
            <nav class="breadcrumb" aria-labelledby="system-breadcrumb">
              <ul>
                <li><a href="/"> Trang chủ </a></li>
                <li> Thông tin đơn hàng</li>
              </ul>
            </nav>
          </div>
        </div>
        <div class="bot-paint-color hidden"></div>
      </div>
    </div>
  </div>
</section>
@endsection
@section('content')
<section class="shop checkout section" id="checkout-content">
  <div class="container">
    <div class="row">
      <div class="col-lg-8 col-12">
        <div class="checkout-form">
          <h2>Vui lòng điền các thông tin bên dưới</h2>
          <p>Bạn có thể kiễm tra lại thông tin giỏ hàng
            <a href="{{route('cart.index')}}" class="text-primary">tại đây</a>
          </p>
          <br>
          @if (Route::has('login'))
          <form class="form" method="post" action="{{route('checkout.store')}}" name="checkoutForm">
            @csrf
            <div class="row">
              <div class="col-lg-8 col-md-8 col-12">
                <div class="form-group">
                  <div class="relative mb-4">
                    <label for="email" class="leading-7 text-lg text-gray-900">Họ và tên<span
                        class="text-red-500">*</span></label>
                    <input type="text" id="name" name="name" value="{{\Auth::user()->name}}"
                      class="require w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
                  </div>
                  @error('name')
                  <span class="text-danger" role="alert">
                    <strong>{{ $message }}</strong>
                  </span>
                  @enderror
                </div>
              </div>
              <div class="col-lg-8 col-md-8 col-12">
                <div class="form-group">
                  <div class="relative mb-4">
                    <label for="email" class="leading-7 text-lg text-gray-900">Địa chỉ Email<span class="text-red-500"
                        title="Bắt buộc nhập">*</span></label>
                    <input type="email" id="email" name="email" value="{{\Auth::user()->email}}"
                      class="require w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
                  </div>
                  @error('email')
                  <span class="text-danger" role="alert">
                    <strong>{{ $message }}</strong>
                  </span>
                  @enderror
                </div>
              </div>
              <div class="col-lg-8 col-md-8 col-12">
                <div class="form-group">
                  <div class="relative mb-4">
                    <label for="email" class="leading-7 text-lg text-gray-900">Điện thoại liên lạc<span
                        class="text-red-500" title="Bắt buộc nhập">*</span></label>
                    <input type="number" id="phone" name="phone" value="{{\Auth::user()->phone}}"
                      class="require w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
                  </div>
                  @error('phone')
                  <span class="text-danger" role="alert">
                    <strong>{{ $message }}</strong>
                  </span>
                  @enderror
                </div>
              </div>
              <div class="col-lg-8 col-md-8 col-12">
                <div class="form-group">
                  <div class="relative mb-4">
                    <label for="email" class="leading-7 text-lg text-gray-900">Địa chỉ nhận hàng 1<span
                        class="text-red-500" title="Bắt buộc nhập">*</span></label>
                    <input type="text" id="address1" name="address1" value=""
                      class="require w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
                  </div>
                  @error('address1')
                  <span class="text-danger" role="alert">
                    <strong>{{ $message }}</strong>
                  </span>
                  @enderror
                </div>
              </div>
              <div class="col-lg-8 col-md-8 col-12">
                <div class="relative mb-4">
                  <label for="email" class="leading-7 text-lg text-gray-900">Địa chỉ nhận hàng 2<span
                      class="text-red-500" title="Bắt buộc nhập">*</span></label>
                  <input type="text" id="address2" name="address2" value=""
                    class="require w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
                </div>
              </div>
              <div class="col-lg-12 col-md-12 col-12">
                <div class="form-group">
                  <p class="bg-blue-100 p-2">Sau khi xác nhận, nhân viên sẽ gọi điện đến số điện thoại mà quý khách
                    hàng cung
                    cấp để xác nhận, vui lòng nhận máy, xin cảm ơn quý khách!</p>
                </div>
              </div>
            </div>
          </form>
          @endif
        </div>
      </div>
      <div class="col-lg-4 col-12">
        <div class="order-details">
          <!-- Order Widget -->
          <div class="single-widget">
            <h2>TỔNG SỐ</h2>
            <div class="content">
              <ul class="ml-1 grid gap-2" style="list-style:none;">
                @if(\Cart::count() > 0)
                <li>Giá trị đơn hàng: <span>{{\Cart::subtotal()}}đ</span></li>
                <li>Thuế VAT (10%): <span>{{\Cart::tax()}}đ</span></li>
                <li class="last">Tổng: <span>{{\Cart::total()}}đ</span></li>
                @endif
              </ul>
            </div>
          </div>
          <!--/ End Order Widget -->
          <!-- Order Widget -->
          <div class="single-widget">
            <h2 class="text-uppercase">Thanh toán</h2>
            <div class="content">
              <div class="checkbox">
                <label class="checkbox-inline ml-1" for="2"><input name="news" id="2" type="checkbox" checked>
                  Thanh
                  toán khi nhận hàng - COD</label><br>
                <label class="checkbox-inline ml-1" for="3"><input name="news" id="3" type="checkbox">
                  ATM 34785974552125 Nguyễn Văn A</label>
                <label class="checkbox-inline ml-1" for="3"><input name="news" id="3" type="checkbox">
                  Momo 0907666155 </label>
              </div>
            </div>
          </div>
          <!--/ End Order Widget -->
          <!-- Payment Method Widget -->
          <div class="single-widget payement">
            <div class="content">
              <img src="images/payment-method.png" alt="#">
            </div>
          </div>
          <!--/ End Payment Method Widget -->
          <!-- Button Widget -->
          <script>
          function submitForm(e) {
            var x = document.getElementsByName('checkoutForm');
            x[0].submit();
            $(this).parents('checkoutForm').submit()
          }
          </script>
          <div class="single-widget get-button">
            <p></p>
            <div class="content">
              <a onclick="submitForm()" href="#" class="btn btn-dark" style="border-radius:unset">Xác nhận</a>
            </div>
          </div>
          <!--/ End Button Widget -->
        </div>
      </div>
    </div>
  </div>
</section>
@endsection