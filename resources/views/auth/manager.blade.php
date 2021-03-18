@extends('layouts.app')
@section('banner')
    <section id="page-title" class="page-title">
        <div class="container-wrap">
            <div class="region region-page-title">
                <div id="block-wosh-sub-page-title" class="block block-core block-page-title-block">
                    <div class="top-paint-color hidden"></div>
                    <div class="container-wrap clearfix">
                        <div class="block-content">
                            <div><span>123</span></div>
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
                                    <li> <a href="/"> Trang chủ </a></li>
                                    <li> Quản lý tài khoản</li>
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
    <br>
    <div class="container">
        <div class="row">
            <div class="col-3">
                <div class="list-group" id="list-tab" role="tablist">
                    <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list"
                       href="#list-home" role="tab" aria-controls="home">Lịch sử đặt hàng</a>
                    <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list"
                       href="#list-profile" role="tab" aria-controls="profile">Thông tin tài khoản</a>
                    <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list"
                       href="#list-messages" role="tab" aria-controls="messages">Đổi Mật khẩu</a>
                </div>
            </div>
            <div class="col-9">
                <div class="tab-content" id="nav-tabContent">

                    <div class="tab-pane fade show active" id="list-home" role="tabpanel"
                         aria-labelledby="list-home-list">
                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered">
                                    <thead>
                                    <tr>
                                        <th>Mã</th>
                                        <th>Trước thuế</th>
                                        <th>Thuế</th>
                                        <th>Tổng</th>
                                        <th>Ngày đặt</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody id="tbl-content">
                                    @foreach($listOrder as $item)
                                        <tr>
                                            <td class="text-right">#{{ $item->id }}</td>
                                            <td class="text-right">{{ $item->subtotal }}đ</td>
                                            <td class="text-right">{{ $item->tax }}đ</td>
                                            <td class="text-right">{{ $item->total}}đ</td>
                                            <td class="text-center">
                                                {{ date_format($item->created_at,'d-m-Y') }}
                                            </td>
                                            <td class="text-center"><a href="{{route('order.detail',$item->id)}}">Xem</a></td>
                                        </tr>
                                    @endforeach
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
                        <div class="form-group">
                            <label for="exampleFormControlInput1">Email</label>
                            <label type="email" class="form-control" id="exampleFormControlInput1"
                                   placeholder="name@example.com"> {{ $user->email }}</label>
                        </div>
                        <div class="form-group">
                            <label for="exampleFormControlInput1">Tên</label>
                            <label type="email" class="form-control" id="exampleFormControlInput1"
                                   placeholder="name@example.com">{{ $user->name }}</label>
                        </div>
                        <div class="form-group">
                            <label for="exampleFormControlInput1">Ngày sinh</label>
                            <label type="email" class="form-control" id="exampleFormControlInput1"
                                   placeholder="name@example.com"> @if($user->birthday !=null)
                                    {{ date('d-m-Y', strtotime($user->birthday)) }} @else Chưa có
                                    thông tin @endif</label>
                        </div>
                        <div class="form-group">
                            <label for="exampleFormControlInput1">Địa chỉ</label>
                            <label type="email" class="form-control" id="exampleFormControlInput1"
                                   placeholder="name@example.com"> @if($user->address !=null) {{ $user->address }} @else
                                    Chưa
                                    có
                                    thông tin @endif</label>
                        </div>
                        <div class="form-group">
                            <label for="exampleFormControlInput1">Điện thoại</label>
                            <label type="email" class="form-control" id="exampleFormControlInput1"
                                   placeholder="name@example.com"> @if($user->phonephone !=null) {{ $user->phonephone }}
                                @else
                                    Chưa có thông tin @endif</label>
                        </div>
                        <h1></h1>
                        <div class="form-group">
                            <button class="btn btn-default">Cập nhật thông tin</button>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">
                        <div class="card-body">
                            <form method="POST" action="{{ route('change.password') }}">
                                @csrf

                                @foreach($errors->all() as $error)
                                    <p class="text-danger">{{ $error }}</p>
                                @endforeach

                                <div class="form-group row">
                                    <label for="password" class="col-md-4 col-form-label text-md-right">Mật khẩu hiện
                                        tại</label>

                                    <div class="col-md-6">
                                        <input id="password" type="password" class="form-control"
                                               name="current_password"
                                               autocomplete="current-password">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="password" class="col-md-4 col-form-label text-md-right">Mật khẩu
                                        mới</label>

                                    <div class="col-md-6">
                                        <input id="new_password" type="password" class="form-control"
                                               name="new_password"
                                               autocomplete="current-password">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="password" class="col-md-4 col-form-label text-md-right">Nhập lại Mật
                                        khẩu
                                        mới</label>

                                    <div class="col-md-6">
                                        <input id="new_confirm_password" type="password" class="form-control"
                                               name="new_confirm_password" autocomplete="current-password">
                                    </div>
                                </div>

                                <div class="form-group row mb-0">
                                    <div class="col-md-8 offset-md-4">
                                        <button type="submit" class="btn btn-primary">
                                            Lưu
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h1></h1>
@endsection
