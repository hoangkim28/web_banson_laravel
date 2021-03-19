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
                                    <li><a href="/"> Trang chủ </a></li>
                                    <li> {{$cate_data->name}}</li>
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
                            <div>
                                @if($cate_data->parent_id==null)
                                    <div class="block-heading st-01 st-02">
                                        <h1>Các sản phẩm nổi bật</h1>
                                        <p>Tìm hiểu thông tin chi tiết về các sản phẩm của chúng tôi.</p>
                                    </div>

                                    <div class="term-link-wrap">
                                        <div class="block block-colour block-taxonomy-term-link-block">
                                            <div class="top-paint-color hidden"></div>
                                            <div class="container-wrap clearfix">
                                                <div class="block-content">
                                                    <ul class="children-term">
                                                        <li><a href="/son-noi-that" class="{{ Request::is('son-noi-that') ? 'active' : '' }}">Sơn nội thất</a></li>
                                                        <li><a href="/son-ngoai-that" class="{{ Request::is('son-ngoai-that') ? 'active' : '' }}" >Sơn ngoại thất</a></li>
                                                    </ul>
                                                </div>
                                            </div>
                                            <div class="bot-paint-color hidden"></div>
                                        </div>
                                    </div>
                                @endif
                                <div
                                    class="nip-full-width nip-select nip-spacing-paint nip-bg-paint nip-colour-product-paint ">
                                    <div class="container-wrap">
                                        <div class="accor" id="#filterProduct">
                                            <div id="headingFilter" class="heading-filter">
                                                <div class="heading-filter__click collapsed" data-toggle="collapse"
                                                     data-target="#collapseFilter" aria-expanded="true"
                                                     aria-controls="collapseFilter">Lọc theo<span
                                                        class="heading-filter__icon ion-ios-arrow-down"></span></div>
                                            </div>
                                            <div id="collapseFilter" class="filter-content collapse"
                                                 aria-labelledby="headingFilter" data-parent="#filterProduct">
                                                <form class="views-exposed-form bef-exposed-form"
                                                      action="{{route('product.search')}}" method="get"
                                                      id="views-exposed-form-product-page-1" accept-charset="UTF-8">
                                                    <div
                                                        class="js-form-item form-item js-form-type-select form-item-tid js-form-item-tid form-no-label">
                                                        <select data-drupal-selector="edit-tid" id="edit-tid"
                                                                name="danh-muc"
                                                                class="form-select select2-hidden-accessible"
                                                                data-select2-id="edit-tid" tabindex="-1"
                                                                aria-hidden="true">
                                                            @foreach($Categories as $cate)
                                                                <option value="{{$cate->slug}}" @if($cate_data->id==$cate->id) selected @endif>{{$cate->name}}</option>
                                                            @endforeach
                                                        </select>
                                                    </div>
                                                    <div
                                                        class="js-form-item form-item js-form-type-select form-item-tid1 js-form-item-tid1 form-no-label">
                                                        <select data-drupal-selector="edit-tid1" id="edit-tid1"
                                                                name="thuong-hieu"
                                                                class="form-select select2-hidden-accessible"
                                                                data-select2-id="edit-tid1" tabindex="-1"
                                                                aria-hidden="true">
                                                            @foreach($Brand as $brand)
                                                                <option value="{{$brand->slug}}">{{$brand->name}}</option>
                                                            @endforeach
                                                        </select>
                                                    </div>
                                                    <div
                                                        class="js-form-item form-item js-form-type-textfield form-item-results js-form-item-results form-no-label">
                                                        <input style="height: 52px;background: white"
                                                               placeholder="Vui lòng nhập từ khóa..."
                                                               data-drupal-selector="edit-results" type="text"
                                                               id="edit-results" name="tu-khoa" value="" size="32"
                                                               maxlength="128" class="form-text">
                                                    </div>
                                                    <div data-drupal-selector="edit-actions"
                                                         class="form-actions js-form-wrapper form-wrapper"
                                                         id="edit-actions"><input
                                                            data-drupal-selector="edit-submit-product" type="submit"
                                                            id="edit-submit-product" value="Tìm kiếm"
                                                            class="button js-form-submit form-submit"></div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="product-inner" style="padding-top: 8vh;">
                                    @if ($data->count())
                                    <div class="item-list">
                                        <ul>
                                            @foreach($data as $item)
                                                <li>
                                                    <div role="article" about="{{$item->getUrl()}}"
                                                         class="node node--type-product node--promoted node--view-mode-teaser">
                                                        <div class="node-content">
                                                            <div class="nip-product-img">
                                                                <div
                                                                    class="field field-field-image field-label-hidden field-item">
                                                                    <a href="{{$item->getUrl()}}">
                                                                        <img src="{{Voyager::image($item->avatar)}}"
                                                                             width="350" height="350" alt
                                                                             typeof="foaf:Image"></a>
                                                                </div>
                                                            </div>
                                                            <div class="nip-product-content">
                                                                <div class="nip-product-content__title">
                                                                    <span
                                                                        class="nip-product-content__icon ion-ios-arrow-right"></span>
                                                                    <div
                                                                        class="field field-field-display-title field-label-hidden field-item">
                                                                        <h2>
                                                                            <a href="{{$item->getUrl()}}">{{$item->name}}</a>
                                                                        </h2>
                                                                    </div>
                                                                </div>
                                                                <div
                                                                    class="field field-field-product-code field-label-hidden field-item">{{$item->category->name}} - {{$item->brand->name}}</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </li>
                                            @endforeach
                                        </ul>
                                    </div>
                                    @else
                                    <div class="item-list">
                                        <div class="col-md-10">
                                            <h3>Hiện chưa có sản phẩm thuộc danh mục này</h3>
                                        </div>
                                    </div>
                                    @endif
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
