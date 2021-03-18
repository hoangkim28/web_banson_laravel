extends('layouts.app')

@section('banner')
    <!-- Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="bread-inner">
                        <ul class="bread-list">
                            <li><a href="/home">Home<i class="ti-arrow-right"></i></a></li>
                            <li class="active"><a href="blog-single.html">{{ $title}}</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Breadcrumbs -->
@endsection

@section('content')
    <!-- Product Style -->
    <section class="product-area shop-sidebar shop section">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-12">
                    <div class="row">
                        <div class="col-12">
                            <!-- Shop Top -->
                            <form action="{{route('product.search')}}" class="shop-top" name="search-form">
                                <div class="shop-shorter">
                                    <div class="single-shorter">
                                        <label>Sắp xếp:</label>
                                        <select class="fillter" name="sap-xep">
                                            <option selected="selected" value="luot-xem">Theo lượt xem</option>
                                            <option value="gia">Theo giá bán</option>
                                            <option value="khuyen-mai">Theo Khuyến mãi</option>
                                        </select>
                                    </div>
                                    <div class="single-shorter">
                                        <label>Thứ tự:</label>
                                        <select class="fillter" name="sort">
                                            <option selected="selected" value="asc">Giảm dần</option>
                                            <option value="desc">Tăng dần</option>
                                        </select>
                                    </div>
                                </div>
                                <ul class="view-mode">
                                    <li class="active">
                                        <a href="" onclick="$('#search-form').submit()"><i class="fa fa-filter"></i></a>
                                    </li>
                                </ul>
                            </form>
                        </div>
                    </div>
                    <div class="row">
                        @foreach($hotProducts as $item)
                            <div class="col-lg-4 col-md-6 col-12">
                                <div class="single-product">
                                    <div class="product-img">
                                        <a href="{{route('product.detail',$item->slug)}}">
                                            <img class="default-img" src="/storage/{{ $item->avatar }}" alt="#">
                                            <img class="hover-img" src="/storage/{{ $item->avatar }}" alt="#">
                                            @if($item->promotion>0)
                                                <span class="out-of-stock">Giảm {{$item->promotion}}%</span>
                                            @endif
                                        </a>
                                        <div class="button-head">
                                            <div class="product-action">
                                                <a data-toggle="modal" data-target="#exampleModal" title="Quick View"
                                                   href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
                                            </div>
                                            <div class="product-action-2">
                                                <a title="Add to cart" class="a-add-to-cart" data-id="{{ $item->id }}"
                                                   href="">Thêm vào giỏ hàng</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="product-content">
                                        <h3>
                                            <a href="{{route('product.detail',$item->slug)}}">{{str_limit($item->name,50)}}</a>
                                        </h3>
                                        <div class="product-price">
                                            @if($item->promotion>0)
                                                <span class="old">{{ format($item->price) }}đ</span>
                                                <span>{{ format(((float)(($item->price-$item->price/$item->promotion)))) }}đ</span>
                                            @else
                                                <span>{{ format($item->price) }}đ</span>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>
                    {{ $hotProducts->links('vendor.pagination.bootstrap-4') }}

                </div>
            </div>
        </div>
    </section>
@endsection
