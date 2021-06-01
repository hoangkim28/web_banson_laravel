@php
    $edit = !is_null($dataTypeContent->getKey());
    $add = is_null($dataTypeContent->getKey());
@endphp

@extends('voyager::master')

@section('css')
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <style>
        .panel .mce-panel {
            border-left-color: #fff;
            border-right-color: #fff;
        }

        .panel .mce-toolbar,
        .panel .mce-statusbar {
            padding-left: 20px;
        }

        .panel .mce-edit-area,
        .panel .mce-edit-area iframe,
        .panel .mce-edit-area iframe html {
            padding: 0 10px;
            min-height: 350px;
        }

        .mce-content-body {
            color: #555;
            font-size: 14px;
        }

        .panel.is-fullscreen .mce-statusbar {
            position: absolute;
            bottom: 0;
            width: 100%;
            z-index: 200000;
        }

        .panel.is-fullscreen .mce-tinymce {
            height: 100%;
        }

        .panel.is-fullscreen .mce-edit-area,
        .panel.is-fullscreen .mce-edit-area iframe,
        .panel.is-fullscreen .mce-edit-area iframe html {
            height: 100%;
            position: absolute;
            width: 99%;
            overflow-y: scroll;
            overflow-x: hidden;
            min-height: 100%;
        }

    </style>
@stop

@section('page_title', __('voyager::generic.'.($edit ? 'edit' : 'add')).'
'.$dataType->getTranslatedAttribute('display_name_singular'))

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i>
        {{ __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular') }}
    </h1>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')
    <div class="page-content container-fluid">
        <form class="form-edit-add" role="form"
              action="@if($edit){{ route('voyager.orders.update', $dataTypeContent->id) }}@else{{ route('voyager.products.store') }}@endif"
              method="POST" enctype="multipart/form-data">
            <!-- PUT Method if we are editing -->
            @if($edit)
                {{ method_field("PUT") }}
            @endif
            {{ csrf_field() }}
            <div class="row">
                <div class="col-md-9">
                    <div class="panel panel-bordered">
                        @if (count($errors) > 0)
                            <div class="alert alert-danger">
                                <ul>
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                        <div class="panel-heading">
                            <h3 class="panel-title">THÔNG TIN KHÁCH HÀNG</h3>
                            <div class="panel-actions">
                                <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                                   aria-hidden="true"></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            @php
                                $dataTypeRows = $dataType->{($edit ? 'editRows' : 'addRows' )};
                                $exclude =
                                ['total','tax','subtotal','order_belongsto_order_status_relationship','order_belongsto_payment_method_relationship'];
                            @endphp

                            @foreach($dataTypeRows as $row)
                                @if(!in_array($row->field, $exclude))
                                    @php
                                        $display_options = $row->details->display ?? NULL;
                                    @endphp
                                    @if (isset($row->details->formfields_custom))
                                        @include('voyager::formfields.custom.' . $row->details->formfields_custom)
                                    @else
                                        <div
                                            class="form-group @if($row->type == 'hidden') hidden @endif @if(isset($display_options->width)){{ 'col-md-' . $display_options->width }}@endif"
                                        @if(isset($display_options->id)){{ "id=$display_options->id" }}@endif>
                                            {{ $row->slugify }}
                                            <label for="name">{{ $row->getTranslatedAttribute('display_name') }}</label>
                                            @include('voyager::multilingual.input-hidden-bread-edit-add')
                                            @if($row->type == 'relationship')
                                                @include('voyager::formfields.relationship', ['options' => $row->details])
                                            @else
                                                {!! app('voyager')->formField($row, $dataType, $dataTypeContent) !!}
                                            @endif

                                            @foreach (app('voyager')->afterFormFields($row, $dataType, $dataTypeContent) as $after)
                                                {!! $after->handle($row, $dataType, $dataTypeContent) !!}
                                            @endforeach
                                        </div>
                                    @endif
                                @endif
                            @endforeach
                        </div>
                    </div>
                    <div class="panel panel panel-bordered">
                        <div class="panel-heading">
                            <h3 class="panel-title ">DANH SÁCH SẢN PHẨM TRONG ĐƠN HÀNG</h3>
                            <div class="panel-actions">
                                <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                                   aria-hidden="true"></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <table id="mytable" class="table table-bordered">
                                <thead>
                                <th>Tên sơn</th>
                                <th>Màu</th>
                                <th>Kích thước</th>
                                <th>Số lượng</th>
                                <th>Giá</th>
                                </thead>
                                <tbody>
                                @php
                                    $products = App\Models\Product::all()->where('stock','>=',1);
                                @endphp
                                @if (!is_null($dataTypeContent->getKey()))
                                    @foreach(App\Models\OrderDetail::where('order_id','=',$dataTypeContent->getKey())->get() as $item)
                                        <tr>
                                            <td>
                                                {{$item->product_name}}
                                            </td>
                                        <td class="text-center" style="background: {{$item->color}}">
                                                
                                            </td>
                                            <td class="text-center">
                                                {{App\Models\AttributeValue::find($item->product_attribute_id)->name}}
                                            </td>

                                            <td class="text-center" style="max-width: 70px">
                                                {{$item->quantity}}
                                            </td>
                                            <td class="text-right">
                                                {{number_format($item->product_price)}}đ
                                            </td>
                                        </tr>
                                    @endforeach
                                @endif
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="panel panel-bordered">
                        <div class="panel-heading">
                            <h3 class="panel-title">GIÁ TRỊ ĐƠN HÀNG</h3>
                            <div class="panel-actions">
                                <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                                   aria-hidden="true"></a>
                            </div>
                        </div>
                        <div class="panel-body">
                            <div class="form-group col-md-12">
                                <label for="subtotal">Tổng trước thuế </label>
                                <input type="text" readonly class="form-control" id="subtotal" name="subtotal"
                                       placeholder="Tên sơn" {!! isFieldSlugAutoGenerator($dataType,
                                $dataTypeContent, "subtotal" ) !!} value="{{ $dataTypeContent->subtotal ?? '' }}">
                            </div>
                            <div class="form-group col-md-12">
                                <label for="tax">Thuế (10%) </label>
                                <input type="text" readonly class="form-control" id="tax" name="tax"
                                       placeholder="Tên sơn"
                                       {!! isFieldSlugAutoGenerator($dataType, $dataTypeContent, "tax" ) !!}
                                       value="{{ $dataTypeContent->tax ?? '' }}">
                            </div>
                            <div class="form-group col-md-12">
                                <label for="total">Tổng </label>
                                <input type="text" readonly class="form-control" id="total" name="total"
                                       placeholder="Tên sơn" {!! isFieldSlugAutoGenerator($dataType, $dataTypeContent, "total"
                                ) !!} value="{{ $dataTypeContent->total ?? '' }}">
                            </div>
                            <div class="form-group col-md-12">
                                <label for="order_status">Trạng thái đơn
                                    hàng</label>
                                <select class="form-control" name="order_status">
                                    @foreach(App\Models\OrderStatus::all() as $status)
                                        <option value="{{ $status->id }}" @if(isset($dataTypeContent->order_status) &&
                                    $dataTypeContent->order_status == $status->id)
                                        selected="selected"@endif>{{ $status->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="form-group col-md-12">
                                <label for="payment_method">Phương thức
                                    thanh toán</label>
                                <select class="form-control" name="payment_method">
                                    @foreach(App\Models\PaymentMethod::all() as $status)
                                        <option value="{{ $status->id }}" @if(isset($dataTypeContent->payment_method) &&
                                    $dataTypeContent->payment_method == $status->id)
                                        selected="selected"@endif>{{ $status->name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                    @section('submit-buttons')
                        <button type="submit" class="btn btn-primary pull-right">
                            @if($edit) Cập nhật đơn hàng @else <i class="icon wb-plus-circle"></i> Thêm @endif
                        </button>
                    @stop
                    @yield('submit-buttons')
                </div>
            </div>
        </form>
    </div>

    <div class="modal fade modal-danger" id="confirm_delete_modal">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;
                    </button>
                    <h4 class="modal-title"><i class="voyager-warning"></i> {{ __('voyager::generic.are_you_sure') }}
                    </h4>
                </div>

                <div class="modal-body">
                    <h4>{{ __('voyager::generic.are_you_sure_delete') }} '<span class="confirm_delete_name"></span>'
                    </h4>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-default"
                            data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
                    <button type="button" class="btn btn-danger"
                            id="confirm_delete">{{ __('voyager::generic.delete_confirm') }}</button>
                </div>
            </div>
        </div>
    </div>
    <!-- End Delete File Modal -->
@stop

@section('javascript')
    <script>
        var params = {};
        var $file;

        function deleteHandler(tag, isMulti) {
            return function () {
                $file = $(this).siblings(tag);

                params = {
                    slug: '{{ $dataType->slug }}',
                    filename: $file.data('file-name'),
                    id: $file.data('id'),
                    field: $file.parent().data('field-name'),
                    multi: isMulti,
                    _token: '{{ csrf_token() }}'
                }

                $('.confirm_delete_name').text(params.filename);
                $('#confirm_delete_modal').modal('show');
            };
        }

        $('document').ready(function () {
            $('#slug').slugify();

            $('.toggleswitch').bootstrapToggle();

            //Init datepicker for date fields if data-datepicker attribute defined
            //or if browser does not handle date inputs
            $('.form-group input[type=date]').each(function (idx, elt) {
                if (elt.type != 'date' || elt.hasAttribute('data-datepicker')) {
                    elt.type = 'text';
                    $(elt).datetimepicker($(elt).data('datepicker'));
                }
            });

            @if($isModelTranslatable)
            $('.side-body').multilingual({
                "editing": true
            });
            @endif

            $('.side-body input[data-slug-origin]').each(function (i, el) {
                $(el).slugify();
            });

            $('.form-group').on('click', '.remove-multi-image', deleteHandler('img', true));
            $('.form-group').on('click', '.remove-single-image', deleteHandler('img', false));
            $('.form-group').on('click', '.remove-multi-file', deleteHandler('a', true));
            $('.form-group').on('click', '.remove-single-file', deleteHandler('a', false));

            $('#confirm_delete').on('click', function () {
                $.post('{{ route('voyager.'.$dataType->slug.'.media.remove') }}', params,
                    function (response) {
                        if (response &&
                            response.data &&
                            response.data.status &&
                            response.data.status == 200) {

                            toastr.success(response.data.message);
                            $file.parent().fadeOut(300, function () {
                                $(this).remove();
                            })
                        } else {
                            toastr.error("Error removing file.");
                        }
                    });

                $('#confirm_delete_modal').modal('hide');
            });
            $('[data-toggle="tooltip"]').tooltip();
        });

    </script>
    <script>
        $('document').ready(function () {
            $("#add-row").click(function () {
                $("#table-order-detail").each(function () {
                    var tds = '<tr>';
                    jQuery.each($('tr:last td', this), function () {
                        tds += '<td>' + $(this).html() + '</td>';
                    });
                    tds += '</tr>';
                    if ($('tbody', this).length > 0) {
                        $('tbody', this).append(tds);
                    } else {
                        $(this).append(tds);
                    }
                });
            });
            $("#insert-more").click(function () {
                $("#mytable").each(function () {
                    var tds = '<tr>';
                    jQuery.each($('tr:last td', this), function () {
                        tds += '<td>' + $(this).html() + '</td>';
                    });
                    tds += '</tr>';
                    if ($('tbody', this).length > 0) {
                        $('tbody', this).append(tds);
                    } else {
                        $(this).append(tds);
                    }
                });
            });
            $("#delete_row").click(function (e) {
                e.preventDefault();
                if (row_number > 1) {
                    $("#product" + (row_number - 1)).html('');
                    row_number--;
                }
            });

            function sayhello() {
                alert('12323');
            }
        });

    </script>
@stop
