@extends('layouts.app')

@section('banner')
<section id="page-title" class="page-title" style="margin-top: 72px;">
  <div class="container-wrap">
    <div class="region region-page-title">
      <div id="block-wosh-sub-page-title" class="block block-core block-page-title-block">
        <div class="top-paint-color hidden"></div>
        <div class="container-wrap clearfix">
          <div class="block-content">
            <div><span>Đặt hàng thành công</span></div>
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
                <li> Thông báo đặt hàng</li>
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
<p class="alert alert-success"> Đặt hàng thành công! Bạn có thể kiễm tra thông tin <a href="{{route('auth.manager')}}"> tại đậy</a></p>
</div>
@endsection
