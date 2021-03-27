@section('styles')
<style>
.nip-header .region-language .language-switcher-language-url {
  min-width: 200px;
}
</style>
@stop
<header class="header nip-header affix">
  <div class=" nip-header__topbar" style>
    <div class="region region-top-bar">
      <nav aria-labelledby="block-topbar" id="block-topbar" class="block block-system">
        <div class="container-wrap clearfix menu-wrap">
          @if (Route::has('login'))
          @auth
          <ul class="nav menu menu-parent">
            @if(auth()->user()->role_id == 1)
            <li class="menu-item"><a href="{{ route('voyager.dashboard') }}">Admin Dashboard</a>
            </li>
            @endif
            <li class="menu-item"><a href="{{route('auth.manager')}}">Quản lý tài
                khoản</a>
            </li>
            <li class="menu-item"><a href="{{ route('logout') }}"
                onclick="event.preventDefault(); document.getElementById('frm-logout').submit();">Đăng
                xuất</a></li>
            <form id="frm-logout" action="{{ route('logout') }}" method="POST" style="display: none;">
              {{ csrf_field() }}
            </form>
          </ul>
          @else
          <ul class="nav menu menu-parent">
            <li class="menu-item"><a href="{{route('login')}}">Đăng nhập</a>
            </li>
            <li class="menu-item"><a href="{{route('register')}}">Đăng ký</a></li>
          </ul>
          @endauth
          @endif
        </div>
      </nav>
    </div>
  </div>
  <div class="nip-header__midbar">
    <div class="container-wrap">
      <div class="navbar navbar-expand-md navbar-dark">
        <div class="navbar-brand header-brand">
          <div class="region region-branding">
            <div id="block-wosh-sub-branding" class="site-branding block block-system block-system-branding-block">
              <div class="top-paint-color hidden"></div>
              <div class="container-wrap clearfix">
                <div class="brand logo"><a href="/" title="Trang chủ" rel="home" class="site-branding-logo"> <img
                      src="{{asset('images/logo.png')}}" alt="Trang chủ"> </a></div>
              </div>
              <div class="bot-paint-color hidden"></div>
            </div>
          </div>
        </div>
        <button class="navbar-toggler nav-button" type="button" data-toggle="collapse" data-target="#main-menu"
          aria-controls="main-menu" aria-expanded="false" aria-label="Toggle navigation">
          <div class="navbar-toggler__icon"><span></span> <span></span> <span></span></div>
        </button>
        <div id="main-menu" class="nip-header__nav primary-navbar collapse navbar-collapse ">
          <div class="region region-primary-menu">
            <nav aria-labelledby="block-wosh-sub-main-menu" id="block-wosh-sub-main-menu" class="block block-system">
              <div class="container-wrap clearfix menu-wrap">
                <ul class="nav menu menu-parent sm sm-menu" data-smartmenus-id="15956439676389817">
                  @if($Categories)
                  @foreach($Categories->take(10) as $category)
                  @if($category->parent_id != 0 || $category->parent_id != null)
                  <li class="menu-item menu-item--expanded">
                    <a href="#main-content" data-drupal-link-system-path="<front>" class="has-submenu"
                      id="sm-15956439676389817-3" aria-haspopup="true" aria-controls="sm-15956439676389817-4"
                      aria-expanded="false">{{$category->name}}<span class="sub-arrow"></span></a>
                    <ul class="menu" id="sm-15956439676389817-4" role="group" aria-hidden="true"
                      aria-labelledby="sm-15956439676389817-3" aria-expanded="false">
                      <li class="menu-item menu-item--expanded">
                        <a href="{{route('product.cate',$category->slug)}}"
                          data-drupal-link-system-path="taxonomy/term/36" class="has-submenu"
                          id="sm-15956439676389817-5" aria-expanded="false">{{$category->name}}
                          @if($category->children()->count() > 0)
                          <span class="sub-arrow"></span> @endif</a>
                        @if ($category->children()->count() > 0)
                        <ul class="menu" id="sm-15956439676389817-6" role="group" aria-hidden="true"
                          aria-expanded="false">
                          @foreach($category->children as $category)
                          <li class="menu-item"><a href="{{route('product.cate',$category->slug)}}">
                              {{$category->name}}
                            </a></li>
                          @endforeach
                        </ul>
                        @endif
                      </li>
                    </ul>
                  </li>
                  @else
                  <li class="menu-item"><a href="{{route('product.cate',$category->slug)}}"
                      data-drupal-link-system-path="dai-ly">{{$category->name}}</a></li>
                  @endif
                  @endforeach
                  @endif
                </ul>
                <div class="menu-mobile">
                </div>
              </div>
            </nav>
          </div>
        </div>
        <div class="header-element icon--element">
          <div class="header-element__icon">
            <div class="header-element__item search--element">
              <button type="button" class="header-icon search-icon"
                onclick="location = '{{route('product.search')}}'"><span class="ion-ios-search-strong"></span></button>
            </div>
            <div class="header-element__item search--element">
              <button type="button" class="header-icon search-icon" onclick="location = '{{route('cart.index')}}'">
                <i class="fas fa-shopping-cart"></i>
                <span class="badge" name="cart-header" id="cart-header">{{\Cart::count()}} (SP) <i c></i></span>
              </button>

            </div>
            <div class="header-element__item language--element">
              <a href="javascript:void(0)" class="current-language"><i class="fas fa-user-circle"></i> </a> <span
                class="current-language__icon ion-ios-arrow-down"></span>
              <div class="region region-language">
                <div class="language-switcher-language-url block block-language block-language-blocklanguage-interface"
                  id="block-languageswitcher" role="navigation">
                  <div class="top-paint-color hidden"></div>
                  <div class="container-wrap clearfix">
                    <div class="block-content">
                      <ul class="links">
                        @auth
                        @if(auth()->user()->role_id == 1)
                        <li class="vi is-active"><a href="{{ route('voyager.dashboard') }}"
                            class="language-link is-active" hreflang="vi" data-drupal-link-system-path="node/1916">Quản
                            trị</a></li>
                        @else
                        <li class="vi is-active"><a href="{{ route('auth.manager') }}" class="language-link is-active"
                            hreflang="vi" data-drupal-link-system-path="node/1916">Quản lý tài khoản</a></li>
                        @endif
                        <li class="en"><a href="{{ route('logout') }}"
                            onclick="event.preventDefault(); document.getElementById('frm-logout').submit();"
                            class="language-link" hreflang="en" data-drupal-link-system-path="node/1916">Đăng xuất </a>
                        </li>
                        @else
                        <li class="vi is-active"><a href="{{ route('login') }}" class="language-link is-active"
                            hreflang="vi" data-drupal-link-system-path="node/1916">Đăng nhập </a></li>
                        <li class="en"><a href="{{ route('register') }}" class="language-link" hreflang="en"
                            data-drupal-link-system-path="node/1916">Đăng ký </a></li>
                        @endauth
                      </ul>
                    </div>
                  </div>
                  <div class="bot-paint-color hidden"></div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</header>