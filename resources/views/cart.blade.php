@extends('layouts.app')

@section('banner')
<section id="page-title" class="page-title">
  <div class="container-wrap">
    <div class="region region-page-title">
      <div id="block-wosh-sub-page-title" class="block block-core block-page-title-block">
        <div class="top-paint-color hidden"></div>
        <div class="container-wrap clearfix">
          <div class="block-content">
            <div><span>Giỏ hàng</span></div>
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
                <li> Giỏ hàng</li>
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
<div class="container">
  <div class="row product-page-detail__table">
    <div class="col-md-12 product-page-detail__table-left">
      <div class="field field-field-recommended-paint-system field-label-above">
        @if(\Cart::count() > 0)
        <h2 class="field-label">Danh sách sản phẩm trong giỏ hàng</h2>
        @else
        <h2 class="field-label">Giỏ hàng trống</h2>
        @if(session('status'))
        <div class="alert alert-{{ session('type') }}">
          {{ session('status') }}
        </div>messages
        @endif
        @if(session('messages'))
        <div class="alert alert-danger">
          {{ session('messages') }}
        </div>
        @endif
        @endif
        <div class="field-item">
          @if(\Cart::count() > 0)
          <table border="0" style="border: none" cellpadding="1" cellspacing="1"
            class="table-sm table-detail son-de-nghi" id="cart-table">
            <thead>
            </thead>
            <tbody style="border: none">
              <tr>
                <td data-th="Tên sản phẩm">Tên sản phẩm</td>
                <td data-th="Màu" class="text-center">Màu</td>
                <td data-th="Kích thước">Kích thước</td>
                <td data-th="Giá" class="text-center">Giá</td>
                <td data-th="Số lượng" class="text-center">Số lượng</td>
                <td data-th="Xóa">Xóa</td>
              </tr>
              @foreach(Cart::content() as $item)
              <tr>
                <td data-th="Tên sản phẩm" class="text-left">{{$item->model->name}}</td>
                @php
                $khongchon = '';
                if(!$item->options->color){
                $khongchon = 'Màu Trắng';
                }
                @endphp
                <td data-th="Màu" style="background-color: {{$item->options->color ?? '#ffffff'}}; color:dddddd;">
                  {{$khongchon}}</td>
                <td data-th="Kích thước">{{$item->options->unit}}</td>
                <td data-th="Giá" class="text-right">{{format($item->price)}}đ</td>
                <td data-th="Số lượng" class="text-center">
                  {{$item->qty}}
                </td>
                <td data-th="Xóa"><a class="btn-remove" href="" data-id="{{$item->rowId}}"><i
                      class="fa fa-trash"></i></a></td>
              </tr>
              @endforeach
              <tr style="border: none">
                <td colspan="5" style="background: none;border-style: none;border: none"></td>
                <td><a class="btn-remove-all" href="" data-id="{{$item->rowId}}">Xóa tất cả </a></td>
              </tr>
              <tr style="border: none">
                <td colspan="6" style="background: none;border-style: none;border: none; padding: 15px 10px"></td>
              </tr>
              <tr style="border: none">
                <td colspan="4" style="background: none;border-style: none;border: none"></td>
                <td>Tạm tính:</td>
                <td class="text-right">{{\Cart::subtotal()}}đ</td>
              </tr>
              <tr style="border: none">
                <td colspan="4" style="background: none;border-style: none;border: none"></td>
                <td>Thuế:</td>
                <td class="text-right">{{\Cart::tax()}}đ</td>
              </tr>
              <tr style="border: none">
                <td colspan="4" style="background: none;border-style: none;border: none"></td>
                <td>Phí vẫn chuyển:</td>
                <td class="text-right font-weight-bold">Miễn phí</td>
              </tr>
              <tr style="border: none">
                <td colspan="4" style="background: none;border-style: none;border: none"></td>
                <td>Tổng tiền:</td>
                <td class="text-right">{{\Cart::total()}}đ</td>
              </tr>
            </tbody>
          </table>
          @endif
        </div>

        <div class="float-right" style="padding-bottom: 3vh;">
          <a href="{{route('home')}}" class="button pa-btn form-submit" style="padding-right: 5vh">Xem
            những sản phẩm khác</a>
          <a href="{{route('checkout.index')}}" class="button btn form-submit text-white">Đặt hàng</a>
        </div>
      </div>
    </div>
  </div>
</div>

@endsection

@section('script')
<script>
$('body').on('click', '.btn-remove', function(e) {
  e.preventDefault();
  var that = $(this).data('id');
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $.ajax({
    type: "get",
    url: '/remove/' + that,
    dataType: "JSON",
    data: {
      "rowId": that
    },
    success: function(response) {
      $.notify("Đã xóa sản phẩm khỏi giỏ hàng!", "success");
      $('#cart-header').load(' #cart-header');
      $('#cart-table').load(' #cart-table');
      $('#total-amount').load(' #total-amount');
      $('#checkout-content').load(' #checkout-content');
    },
    error: function(xhr) {
      console.log(xhr
        .responseText); // this line will save you tons of hours while debugging
      // do something here because of error
    }
  });
});

$('body').on('click', '.btn-remove-all', function(e) {
  e.preventDefault();
  var that = $(this).data('id');
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $.ajax({
    type: "get",
    url: '/destroy',
    dataType: "JSON",
    data: {
      "rowId": that
    },
    success: function(response) {
      $.notify("Giỏ hàng trống!", "success");
      $('#cart-header').load(' #cart-header');
      $('#cart-table').load(' #cart-table');
      $('#total-amount').load(' #total-amount');
      $('#checkout-content').load(' #checkout-content');
    },
    error: function(xhr) {
      console.log(xhr
        .responseText); // this line will save you tons of hours while debugging
      // do something here because of error
    }
  });
});

$('body').on('click', '.btn-minus', function(e) {
  e.preventDefault();
  console.log(document.getElementById("color-id").value);
  var rowId = $(this).data('field');
  var qty = $(this).data('qty') - 1;
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $.ajax({
    type: "get",
    url: '/update/' + rowId + '/' + qty,
    dataType: "JSON",
    data: {
      "rowId": rowId,
      "qty": qty
    },
    success: function(response) {
      $('#cart-header').load(' #cart-header');
      $('#cart-table').load(' #cart-table');
      $('#total-amount').load(' #total-amount');
      $('#checkout-content').load(' #checkout-content');
    },
    error: function(xhr) {
      console.log(xhr
        .responseText); // this line will save you tons of hours while debugging
      // do something here because of error
    }
  });
});

$('body').on('click', '.btn-plus', function(e) {
  e.preventDefault();
  var rowId = $(this).data('field');
  var qty = $(this).data('qty') + 1;
  $.ajaxSetup({
    headers: {
      'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
    }
  });
  $.ajax({
    type: "get",
    url: '/update/' + rowId + '/' + qty,
    dataType: "JSON",
    data: {
      "rowId": rowId,
      "qty": qty
    },
    success: function(response) {
      $('#cart-header').load(' #cart-header');
      $('#cart-table').load(' #cart-table');
      $('#total-amount').load(' #total-amount');
      $('#checkout-content').load(' #checkout-content');
    },
    error: function(xhr) {
      console.log(xhr
        .responseText); // this line will save you tons of hours while debugging
      // do something here because of error
    }
  });
});
</script>
@endsection