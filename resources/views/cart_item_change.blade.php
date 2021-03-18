@extends('layouts.app')
@php
    $detail = null;
    if(\Cart::count() > 0){
        foreach(Cart::content() as $cartItem){
                if($cartItem->rowId == request()->rowId){
                $detail=$cartItem->model;
                $cartRow =$cartItem;
            }
            }
    }

@endphp
@section('banner')
    <!-- Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="bread-inner">
                        <ul class="bread-list">
                            <li><a href="/home">Home<i class="ti-arrow-right"></i></a></li>
                            <li class="active"><a href="blog-single.html">{{$detail->name}}</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
<!-- End Breadcrumbs -->
@section('content')
    <main class="mt-5 pt-4">
        <div class="container dark-grey-text mt-5">
            <div class="row wow fadeIn">
                <div class="col-md-6 mb-4 text-center">
                    <img src="/storage/{{ $detail->avatar }}" class="img-fluid" alt="">
                </div>
                <div class="col-md-6 mb-4">
                    <div class="p-4">

                        <div class="mb-3">
                            <span class="text-upcase mr-1">{{ $detail->category->name }}</span>
                        </div>
                        <div class="mb-3">
                            <span class="text-upcase mr-1">{{ $detail->category->sku }}</span>
                        </div>
                        <div class="mb-3">
                            <h2>{{ $detail->name }}</h2>
                        </div>
                        @if($detail->promotion > 0)
                            <div class="mb-3">
                                <span class="badge red mr-1">Tiết kiệm {{ $detail->promotion }}%</span>
                            </div>
                        @endif
                        <p class="lead">
                            @if($detail->promotion > 0)
                                <span class="mr-1">
                            <del>{{ number_format($detail->price) }}đ</del>
                        </span>
                                <br>
                                <span class="h3"
                                      style="color:#f6931d;"><strong>{{ number_format($detail->price - ($detail->price*$detail->promotion/100)) }}đ</strong></span>
                            @else
                                <span class="h3"
                                      style="color:#f6931d;"><strong>{{ number_format($detail->price) }}đ</strong></span>
                            @endif
                        </p>
                        <p>{{ $detail->excerpt }}</p>
                        <hr>
                        Chọn màu: <input type="text" class="jscolor" value="{{$cartRow->options->color}}">
                        <hr>
                        <div class="mb-3">
                            <div style="font-weight: 600;
                        color: #666;
                        text-align: left;
                        font-size: 1.2rem;
                        width: 100%;">
                                Số lượng
                            </div>
                            <input name="qty" id="qty" type="number" value="{{$cartRow->qty}}" min="1"
                                   max="{{$detail->stock}}">
                        </div>
                        <hr>
                        <div class="d-flex justify-content-right">
                            <button class="btn btn-md my-0 p a-cart-item-change" data-product="{{$cartRow->id}}"
                                    data-id="{{$cartRow->rowId}}"
                                    type="button"><i class="ti-bag"></i> Thay đổi
                            </button>
                        </div>
                        <hr>
                        <div class="mb-3">
                            <p><strong>- Hình thức thanh toán :</strong> Giao hàng thu tiền mặt hoặc chuyển khoản trước
                                khi
                                giao hàng.</p>
                        </div>
                        <div class="mb-3">
                            <p><strong> - Hình thức giao hàng :</strong> Hỗ trợ giao hàng trong nội thành - TP.HCM .
                                Khách
                                hàng ở tỉnh được ship tận nhà miễn phí với những đơn hàng trên 500.000đ</p>
                        </div>
                    </div>
                </div>
            </div>
            <hr>
            @if($detail->images)
                <h3 class="text-center">Hình ảnh</h3>
                <br>
                <div class="row wow fadeIn">
                    @foreach(json_decode($detail->images) as $image)
                        <div class="col-lg-4 col-md-12 mb-4">
                            <img src="{{ asset("storage/$image") }}" class="img-fluid" alt="{{ $detail->name }}">
                        </div>
                    @endforeach
                </div>
            @endif
            <h3 class="text-center">Thông tin sản phẩm</h3>
            <br>
            {!!html_entity_decode($detail->body)!!}
            <hr>
        </div>
    </main>
@endsection
