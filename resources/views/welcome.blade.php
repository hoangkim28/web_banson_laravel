@extends('layouts.app')
@section('banner')
<section id="page-title" class="page-title">
  <div class="container-wrap">
    <div class="region region-breadcrumb">
      <div id="block-wosh-sub-breadcrumbs" class="block block-system block-system-breadcrumb-block">
        <div class="top-paint-color hidden"></div>
        <div class="container-wrap clearfix">
          <div class="block-content">
            <nav class="breadcrumb" aria-labelledby="system-breadcrumb">
              <ul>
                <li> <a href="/"> Trang chủ </a></li>
                <li> Các sản phẩm nổi bật</li>
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
            <div class="js-view-dom-id-f5a1202ad708dbc0c7899467e63f641e81af0d64ad4607380669f27d67155e64">
              <div class="product-inner" style="padding-top: 2vh;">
                <div class="item-list">
                  <ul>
                    @foreach($lastestProduct as $item)
                    <li>
                      <div role="article" about="{{$item->getUrl()}}"
                        class="node node--type-product node--promoted node--view-mode-teaser">
                        <div class="node-content">
                          <div class="nip-product-img">
                            <div class="field field-field-image field-label-hidden field-item">
                              <a href="{{$item->getUrl()}}">
                                <img src="{{Voyager::image($item->avatar)}}" width="350" height="350" alt
                                  typeof="foaf:Image"></a>
                            </div>
                          </div>
                          <div class="nip-product-content">
                            <div class="nip-product-content__title">
                              <span class="nip-product-content__icon ion-ios-arrow-right"></span>
                              <div class="field field-field-display-title field-label-hidden field-item">
                                <h2><a href="{{$item->getUrl()}}">{{$item->name}}</a>
                                </h2>
                              </div>
                            </div>
                            <div class="field field-field-product-code field-label-hidden field-item">
                              {{$item->brand->name}}</div>
                          </div>
                        </div>
                      </div>
                    </li>
                    @endforeach
                  </ul>
                </div>
                <hr>
                {{$lastestProduct->links()}}
              </div>
            </div>
          </div>
        </div>
        <div class="bot-paint-color hidden"></div>
      </div>
    </div>
  </div>
</section>

<section>
  
</section>
@endsection