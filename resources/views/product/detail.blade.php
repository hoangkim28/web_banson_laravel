@extends('layouts.app')
@section('styles')
    <style>
        #profile-description {
            margin-top: 50px;
            position:relative;
            margin-bottom: 100px;
        }
        #profile-description .text {
            /*   width: 660px;  */
            margin-bottom: 10px;
            padding: 0 25px;
            position:relative;
            display: block;
        }
        #profile-description .show-more {
            /*   width: 690px;  */
            color: #777;
            position:absolute;
            font-size: 20px;
            border: unset;
            text-align: center;
            background: #f1f1f1;
            cursor: pointer;
        }
        #profile-description .show-more:hover {
            color: #F7941D;
        }
        #profile-description .show-more-height {
            height: 250px;
            overflow:hidden;
        }
    </style>
@endsection

@section('banner')
    <section id="page-title" class="page-title">
        <div class="container-wrap">
            <div class="region region-page-title">
                <div id="block-wosh-sub-page-title" class="block block-core block-page-title-block">
                    <div class="top-paint-color hidden"></div>
                    <div class="container-wrap clearfix">
                        <div class="block-content">
                            <div><span>{{$product->name}}</span></div>
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
                                    <li> {{$product->name}}</li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                    <div class="bot-paint-color hidden"></div>
                </div>
            </div>
        </div>
    </section>
@stop
@section('content')
    <section id="page-wrapper" class="page-wrapper">
        <div class="main-content">
            <div class="region region-content">
                <div id="block-wosh-sub-content--2" class="block block-system block-system-main-block">
                    <div class="top-paint-color hidden"></div>
                    <div class="container-wrap clearfix">
                        <div class="block-content">
                            <div data-history-node-id="1916" role="article"
                                 about="/vi/son-noi-that/son-nippon-odour-less-spot-less"
                                 class="product-page-detail node node--type-product node--promoted node--view-mode-full">
                                <div class="node-content">
                                    <div class="row">
                                        <div class="col-md-12 product-page-detail__right__heading hide--pc-1024">
                                            <span>{{$product->name}}</span></div>
                                        <div class="col-md-3 product-page-detail__left">
                                            <div class="field field-field-image field-label-hidden field-item"><img
                                                    src="{{Voyager::image($product->avatar)}}" width="350" height="350"
                                                    alt typeof="foaf:Image"></div>
                                            <div class="block-colour-fortune hide--pc-1024">
                                                <div class="block-colour-author"></div>
                                            </div>
                                            <div class="group-btn-bg">
                                                @php
                                                    $default_product = \App\Models\ProductAttribute::where('product_id','=',$product->id)->where('default','=','1')->first();
                                                    $default_first = \App\Models\ProductAttribute::where('product_id','=',$product->id)->first();
                                                    $default = $default_product ? $default_product : $default_first;
                                                @endphp

                                                @if ($default)

                                                    <div class="item text-align-left">
                                                        <hr>
                                                        <dl class="param param-inline">
                                                            <dt>Giá bán:</dt>
                                                            @if ($default->sale_price != null)
                                                                <span class="price h3 text-warning" style="font-size: 5vh;">
                                <span class="num" id="span-price">{{format($default->sale_price)}}đ</span>
                            </span>
                                                                <span id="span-price-old"> <del>{{format($default->price)}}đ</del></span>
                                                            @else
                                                                <span class="price h3 text-warning">
                                <span class="num" id="span-price">{{format($default->price)}}đ</span>
                            </span><span id="span-price-old"> </span>
                                                        </dl>
                                                        @endif
                                                        <dl class="param param-inline">
                                                            <dt>Số lượng:</dt>
                                                            <dd style="padding-top: 2vh;padding-bottom: 2vh;">
                                                                <input id="p-quantity" name="p-quantity" type="number"
                                                                       class="form-control text-center col-md-6" value="1" min="1"/>
                                                            </dd>
                                                        </dl>
                                                        <dl>
                                                            <dt>Đơn vị:</dt>
                                                            <dd style="padding-top: 2vh;padding-bottom: 2vh;">
                                                                @foreach($productAttributes as $pa)
                                                                    @foreach($pa->attributesValues as $item)
                                                                        @if($item->attribute_id === 1)
                                                                            <input type="radio" id="unit{{$item->value}}"
                                                                                   name="p-unit"
                                                                                   value="{{$pa->id}}" data-id="{{$item->pivot->attribute_value_id}}"
                                                                                   @if($pa->default==1) checked @endif>
                                                                                  <input type="hidden" id="attibuteValue" name="attibuteValue" value="{{$item->pivot->attribute_value_id}}"> 
                                                                            <label
                                                                                for="unit{{$item->value}}">{{ $item->name }}</label>
                                                                            <br>
                                                                        @else
                                                                            <input type="hidden" name="p-unit-col">
                                                                        @endif
                                                                    @endforeach
                                                                @endforeach
                                                            </dd>
                                                        </dl>
                                                        <dl class="param param-inline">
                                                            <dt>Màu:</dt>
                                                            <dd style="padding-top: 2vh;padding-bottom: 2vh;">
                                                                <input type="hidden" class="p-color">
                                                                <input id="color" name="color" readonly="readonly"
                                                                       class="color-input form-control col-md-auto text-center"
                                                                       type="color-input" style="height: 10vh;"
                                                                       title="Nhấn để chọn màu">
                                                                <p style="font-style: inherit;font-size: 2vh;padding-top: 1vh; color:#F7941D;">
                                                                    ⬆ Nhấn để chọn màu ⬆</p>
                                                            </dd>
                                                        </dl>
                                                        @if($productAttributes->count()>0)
                                                            <div class="item"><a href="#" data-id="{{$product->id}}"
                                                                                 class="pa-btn text-uppercase a-add-to-cart">
                                                                    <i
                                                                        class="fa fa-shopping-cart"></i> Thêm vào giỏ hàng
                                                                </a></div>
                                                        @else
                                                            <a href="#" data-id="{{$product->id}}"
                                                               class="pa-btn text-uppercase"> Sản phẩm ngừng kinh doanh </a>
                                                        @endif
                                                    </div>
                                                @else
                                                    <a href="#" data-id="{{$product->id}}"
                                                       class="pa-btn text-uppercase"> Sản phẩm ngừng kinh doanh </a>
                                                @endif
                                            </div>
                                        </div>
                                        <div class="col-md-9 product-page-detail__right">
                                            <div class="product-page-detail__right-inner">
                                                <div class="product-page-detail__right__heading hide--mb-1024">
                                                    <div
                                                        class="field field-field-display-title field-label-hidden field-item">
                                                        <h3 style="color: slategrey;font-size: 25px;font-style: unset">{{$product->category->name}}</h3>
                                                        <h1 style="font-size:35px;">{{$product->name}}</h1>
                                                    </div>
                                                </div>
                                                <div class="block-colour-fortune hide--mb-1024">
                                                    <div class="block-colour-author"></div>
                                                </div>
                                                <div class="product-page-detail__right__information">
                                                    <div class="field field-field-product-infomation field-label-above">
                                                        <h2 class="field-label">Thông tin sản phẩm</h2>
                                                        <div class="field-item" id="profile-description">
                                                            <div class="text show-more-height">
                                                                {!!html_entity_decode($product->body)!!}
                                                            </div>

                                                            <div class="show-more btn">Xem thêm</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="block-slider-colour">
                                    <div class="row">
                                        <div class="col-md-12 block-slider-colour__left cus-col-12-1024">
                                            <div class="block-heading">
                                                <h2> Sản phẩm gợi ý</h2>
                                            </div>
                                            <div class="block-slider-colour__inner">
                                                <div class="views-element-container">
                                                    <div
                                                        class="block-suggestion-product js-view-dom-id-db748baf12e82ee57b6488ba4148bceb7cc8835436abe8b82b47fa08878da348">
                                                        <div class="item-list">
                                                            <ul class="slick-initialized slick-slider">
                                                                <div class="slick-list draggable">
                                                                    <div class="slick-track"
                                                                         style="opacity: 1; width: 2720px; transform: translate3d(-680px, 0px, 0px);">
                                                                        @foreach($related as $item)
                                                                            <div
                                                                                class="slick-slide slick-cloned text-center"
                                                                                data-slick-index="-4" aria-hidden="true"
                                                                                tabindex="-1" style="width: 170px;">
                                                                                <div>
                                                                                    <li style="width: 100%; display: inline-block;"
                                                                                        href="{{$item->getUrl()}}">
                                                                                        <div data-history-node-id="1909"
                                                                                             role="article"
                                                                                             about="{{$item->getUrl()}}"
                                                                                             class="node node--type-product node--promoted node--view-mode-suggestion-product">
                                                                                            <div class="node-content">
                                                                                                <div
                                                                                                    class="field field-field-image field-label-hidden field-item">
                                                                                                    <img
                                                                                                        src="{{Voyager::image($item->avatar)}}"
                                                                                                        width="350"
                                                                                                        height="350" alt
                                                                                                        typeof="foaf:Image">
                                                                                                </div>
                                                                                                <div
                                                                                                    class="field field-field-display-title field-label-hidden field-item">
                                                                                                    <h3>
                                                                                                        <a href="{{$item->getUrl()}}"
                                                                                                           hreflang="vi"
                                                                                                           tabindex="-1">{{$item->name}}</a>
                                                                                                    </h3>
                                                                                                </div>
                                                                                                <div
                                                                                                    class="field field-field-product-code field-label-hidden field-item"></div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </li>
                                                                                </div>
                                                                            </div>
                                                                        @endforeach
                                                                    </div>
                                                                </div>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bot-paint-color hidden"></div>
                </div>
            </div>
        </div>
    </section>
@endsection

@section('script')
    <script src="{{asset('js/huebee.pkgd.min.js')}}"></script>
    <script>
        let hueb = new Huebee('.color-input', {
            "notation": "hex",
            "saturations": 2,
            "setText": '.p-color'
        });

        hueb.on('change', function () {
            hueb.close();
        });

        function formatNumber(number, precision) {
            if (!isFinite(number)) {
                return number.toString();
            }

            var a = number.toFixed(precision).split('.');
            a[0] = a[0].replace(/\d(?=(\d{3})+$)/g, '$&,');
            return a.join('.');
        }
    </script>
    <script>

        $('input[type=radio][name=p-unit]').change(function () {
            let id = this.value;

            $.ajax({
                type: "get",
                url: '/product-attribute/' + id,
                dataType: "json",
                success: function (data) {
                    if (data.sale_price != null) {
                        $("#span-price").text(formatNumber(parseInt(data.sale_price)) + 'đ');
                        document.getElementById("span-price-old").style.visibility = "visible";
                        $("#span-price-old").html('<del>' + formatNumber(data.price) + 'đ </del>');
                    } else {
                        $("#span-price").text(formatNumber(data.price) + 'đ');
                        document.getElementById("span-price-old").style.visibility = "hidden"
                    }
                }
            });
        });

        $('body').on('click', '.a-add-to-cart', function (e) {
            e.preventDefault();
            var color = $('.p-color').val();
            if (color == null)
                color = '0';
            var that = $(this).data('id');
            var qty = document.getElementById("p-quantity").value;

            var unit = $('input[name=p-unit]:checked').val();
            var attibuteValue = $('input[name=p-unit]:checked').data('id');
            
            if (unit == null)
                unit = '0';
            let _token = $('meta[name="csrf-token"]').attr('content');

            $.ajaxSetup({
                headers: {
                    'X-CSRF-TOKEN': _token
                }
            });

            $.ajax({
                type: "post",
                url: '{{route('cart.add')}}',
                dataType: "json",
                data: {
                    "id": that,
                    "qty": qty,
                    "color": color,
                    "unit": unit,
                    "attibuteValue":attibuteValue,
                },
                success: function (data) {
                    if (data.msg == "1") {
                        $.notify("Đã thêm vào giỏ hàng!", "success");
                        $('#cart-header').load(' #cart-header');
                        $('#cart-table').load(' #cart-table');
                        $('#checkout-content').load(' #checkout-content');
                    }
                    if (data.msg == "0") {
                        $.notify("Hàng hiện không đủ " + qty + " !", "error");
                        $('#cart-header').load(' #cart-header');
                        $('#cart-table').load(' #cart-table');
                        $('#checkout-content').load(' #checkout-content');
                    }
                }
            });
        });
    </script>

    <script>
        $(".show-more").click(function () {
            if($(".text").hasClass("show-more-height")) {
                $(this).text("Ẩn bớt");
            } else {
                $(this).text("Xem thêm");
            }
            $(".text").toggleClass("show-more-height");
        });
    </script>

@stop
