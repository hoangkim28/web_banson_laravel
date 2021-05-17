<!doctype html>
<html lang="vi">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{Voyager::setting('admin.title', '')}} @if(session()->has('title')) -{{$title}} @endif</title>

    <link rel="stylesheet" href="{{asset('css/app.css')}}">
    <link rel="stylesheet" href="{{asset('css/huebee.css')}}">
    <link rel="stylesheet" href="{{asset('css/css.css')}}" media="all">
    <link rel="stylesheet" href="{{asset('css/css_JbVnVxTf7KwJuOjfuANA8SK63EtDreszAbn-mz5rX98.css')}}" media="all">
    <link rel="stylesheet" href="{{asset('css/css_F4A8-msRqrU90vGczluZkFFzoCtfN4QQlchN6rfie_Y.css')}}" media="all">

    <script src="{{asset('js/jquery.min.js')}}"></script>
    <script src="{{asset('js/jquery-ui.min.js')}}"></script>
    <link rel="dns-prefetch" href="//fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css?family=Nunito" rel="stylesheet">

    <meta name="title" content="Sơn nội thất Nippon Odour-less Spot-less chống bám bẩn | Nippon Paint">
    <link rel="canonical" href="https://nipponpaint.com.vn/vi/son-noi-that/son-nippon-odour-less-spot-less">
    <meta http-equiv="content-language" content="vi-VN">
    <meta name="robots" content="index, follow">
    <meta name="description" content="Sơn Nippon Odour-less Spot-less cao cấp chống bám bẩn | Bền màu | An toàn cho sức khỏe | Bảo vệ tổ ấm toàn diện | Giá cả cạnh tranh. | Hơn 1000 màu sơn.">
    <meta name="Generator" content="Drupal 8 (https://www.drupal.org)">
    <meta name="MobileOptimized" content="width">
    <meta name="HandheldFriendly" content="true">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="{{asset('css/all.css')}}">
    <link rel="stylesheet" href="{{asset('css/style.css')}}">
    <script src="{{asset('js/all.js')}}"></script>
    <link rel="shortcut icon" href="nippon%20paint_favicon.ico" type="image/vnd.microsoft.icon">
    <link rel="alternate" hreflang="vi" href="http://nipponpaint.com.vn/vi/son-noi-that/son-nippon-odour-less-spot-less">
    <link rel="revision" href="">
    <style type="text/css" media="all">
        blockquote {
            font-size: 18px;
        }
        .h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
            line-height: 2;
        }
    </style>
    @yield('styles')
</head>

<body class="page-node-1916 path-node page-node-type-product page-son-noi-that-son-nippon-odour-less-spot-less">
<a href="#main-content" class="visually-hidden focusable"> Nhảy đến nội dung</a>
<div class="dialog-off-canvas-main-canvas" id="app" data-off-canvas-main-canvas>
    <div id="wrapper" class="wrapper wide-layout header-default">
        <div class="layout-wrap non-sticky-header">
            <div id="search-modal" class="nip-modal modal-wrapper modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-content-wrap">
                            <div class="modal-content-holder">
                                <div class="region region-search">
                                    <div id="block-searchplaceholder" class="block block-block-content block-block-content2c6feefe-f1f4-41ec-a908-6c1bdb645dee">
                                        <div class="top-paint-color hidden"></div>
                                        <div class="container-wrap clearfix">
                                            <div class="block-content"></div>
                                        </div>
                                        <div class="bot-paint-color hidden"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            @include('layouts.nav')
            @yield('banner')
            @yield('content')

            <div class="back-to-top fade-back white"> <span class="ion-ios-arrow-up"></span></div>
        </div>
    </div>
</div>
<script src="{{asset('js/app.js')}}"></script>
<script src="{{asset('js/page.js')}}"></script>
<script src="{{asset('js/notify/notify.js')}}"></script>
<script src="{{asset('js/notify/notify-metro.js')}}"></script>
<script src="{{asset('js/js_WNXorJ4BDUm_Ziu4fwiqk7Dctc-axPnPi6bEqSQmUFE.js')}}"></script>
<!-- <script src="{{asset('js/js_UAPMnSZ5_CzKlSnJRdj9fTedCW9w7soukQFWGM05LR8.js')}}"></script> -->
<script src="{{asset('js/js_zu-9NTF4-EokM8GSPqXnbnBirt2XLftTcUbPiZA4T2s.js')}}"></script>
<script src="{{asset('js/js_YlsFIXjolpdih-EpuUxeEfMVWpVkHxNrPP63EztD8oA.js')}}"></script>
<!-- <script src="{{asset('js/js_TG1gJBEzNW0XL7FDoP4DuKZg29L0dt_kDO3lop3KNps.js')}}"></script> -->
@yield('script')
@yield('scripts')
<div id="drupal-modal" class="ui-front" style="display: none;"></div><div style="position: absolute; bottom: 0px; left: 0px; width: 1px; height: 1px; overflow: hidden; visibility: hidden;"><iframe src="{{asset('images/_tracking1.gif')}}" name="admIframeTracking" id="admIframeTracking" style="width: 12px; height: 12px; visibility: hidden; position: absolute; left: 0px; bottom: 0px; border: none;"></iframe></div>
</body>

</html>
