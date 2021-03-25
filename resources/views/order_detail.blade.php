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
                                <li> Chi tiết đơn hàng</li>
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
<div class="container">
    <div id="invoice">
        <div class="invoice overflow-auto">
            <div style="min-width: 600px">
                <header>
                    <div class="row">
                        <div class="col">

                        </div>
                        <div class="col company-details">
                            <h2 class="name">
                                <a target="_blank" href="{{route('home')}}">
                                    Thành Tánh
                                </a>
                            </h2>
                            <div>132, 3/2, Ninhkieu, Cantho, Vietnam</div>
                            <div>0907 666 155</div>
                            <div>tanhb1401087@student.ctu.edu.vn</div>
                        </div>
                    </div>
                </header>
                <main>
                    <div class="row contacts">
                        <div class="col invoice-to">
                            <div class="text-gray-light">Người nhận</div>
                            <h2 class="to">Họ tên: 123</h2>
                            <div class="address">Địa chỉ 1: {{$order->address1}}</div>
                            <div class="address">Địa chỉ 2: {{$order->address2}}</div>
                            <div class="email"><a href="mailto:{{$order->email}}">{{$order->email}}</a></div>
                        </div>
                        <div class="col invoice-details">
                            <h1 class="invoice-id">Đơn hàng số #{{$order->id}}</h1>
                            <div class="date">Ngày đặt: {{ \Carbon\Carbon::parse($order->create_at)->format('d/m/Y H:i')}}
                            </div>
                            <div class="date">Ngày xác nhận đơn: {{ \Carbon\Carbon::parse($order->update_at)->format('d/m/Y H:i')}}</div>
                            <div>Trạng thái đơn hàng: {{$order->order_status()->first()->name}}</div>
                        </div>
                    </div>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th class="text-left">TÊN SẢN PHẨM</th>
                                <th class="text-right">Màu sắc</th>
                                <th class="text-right">SỐ LƯƠNG</th>
                                <th class="text-right">GIÁ</th>
                                <th class="text-right">TỔNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($details as $item)
                            <tr>
                                <td class="no">{{$item->id}}</td>
                                <td class="text-left">
                                    <h3>
                                        <a target="_blank" href="{{route('product.detail',$item->product_id)}}">
                                            {{$item->product_name}}
                                        </a>
                                    </h3>
                                    <a target="_blank" href="{{route('product.detail',$item->product_id)}}">
                                        {{$item->product_name}}
                                    </a>
                                </td>
                                <td class="text-left" style="background-color: {{$item->color ?? ''}}"></td>
                                <td class="unit">{{$item->quantity}}</td>
                                <td class="qty">{{$item->quantity}}</td>
                                <td class="total">{{$item->quantity* $item->product_price}}</td>
                            </tr>
                            @endforeach
                        </tbody>
                        <tfoot>
                            <tr>
                                <td colspan="3"></td>
                                <td colspan="2">Trước thuế</td>
                                <td>{{$order->subtotal}}</td>
                            </tr>
                            <tr>
                                <td colspan="3"></td>
                                <td colspan="2">Thuế 10%</td>
                                <td>{{$order->subtotal}}</td>
                            </tr>
                            <tr>
                                <td colspan="3"></td>
                                <td colspan="2">Sau thuế</td>
                                <td>{{$order->total}}</td>
                            </tr>
                        </tfoot>
                    </table>
                    <!-- <div class="thanks">Thank you!</div> -->
                    <div class="notices">
                        <div>Ghi chú:</div>
                        <div class="notice">Nếu bạn có bất kỳ câu hỏi nào, chỉ cần trả lời email này — chúng tôi luôn sẵn lòng trợ giúp.</div>
                    </div>
                    <p>
                        <hr>
                        <a class="btn btn-primary" href="{{route('auth.manager')}}">Quay về danh sách</a>
                    </p>
                </main>
            </div>
            <!--DO NOT DELETE THIS div. IT is responsible for showing footer always at the bottom-->
            <div></div>
        </div>
    </div>
</div>
@endsection