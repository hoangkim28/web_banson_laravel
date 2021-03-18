@extends('voyager::master')
{{-- @section('page_header')
    <h1 class="page-title">
        <i class=""></i>
        Thêm sản phẩm con
    </h1>
@stop --}}
@section('style')
    <style>
        table.table.table-bordered.table-condensed tbody tr:hover {
            cursor: pointer;
            background-color: #eaeaea;
        }
    </style>
@endsection
@section('content')
    <form class="row" action="{{route('admin.product.attribute',$id)}}" method="POST" enctype="multipart/form-data">
        {{ csrf_field() }}
        <div class="col-md-9">
            <div class="panel">
                <div class="panel-heading">
                <h3 class="panel-title">Danh sách sản phẩm con - {{$product->name}}</h3>
                    <div class="panel-actions">
                        <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                           aria-hidden="true"></a>
                    </div>
                </div>
                <div class="panel-body">
                    @if($productAttributes->count() > 0)
                        <ul class="list-unstyled">
                            <li>
                                <table class="table table-bordered table-condensed">
                                    <thead>
                                    <tr>
                                        <th>Thuộc tính</th>
                                        <th>Giá bán</th>
                                        <th>Giá khuyến mãi</th>
                                        <th>Số lượng</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    @foreach($productAttributes as $pa)
                                    <tr title="Nhấn để cập nhật..." class="tr-attribute" data-id="{{$pa->id}}">
                                            <td>
                                                <ul class="list-unstyled">
                                                    @foreach($pa->attributesValues as $item)
                                                        @if($item->attribute->id == 2)
                                                            <li style="background-color: {{
                                                    $item->value}};">{{ $item->attribute->name }}
                                                                : {{$item->name}}</li>
                                                        @else
                                                            <li>{{ $item->attribute->name }} : {{ $item->name }}</li>
                                                        @endif
                                                    @endforeach
                                                </ul>
                                            </td>
                                            <td class="text-right">{{ format($pa->price) }} vnđ</td>
                                            <td class="text-right">@if($pa->sale_price>0){{ format($pa->sale_price) }} vnđ @endif</td>
                                            <td class="text-right">{{ $pa->quantity }}</td>
                                            
                                        @php
                                            $link_delete = route('admin.product.attribute', [$product->id,'delete' => 1, 'pa' => $pa->id]);
                                        @endphp
                                        </tr>
                                    @endforeach
                                    </tbody>
                                </table>
                            </li>
                        </ul>
                    @else
                        <p class="alert alert-warning">Hiện tại chưa có thông tin</p>
                    @endif
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="panel" id="add-edit-panel">
                <div class="panel-heading">
                    <h3 class="panel-title" id="title-add-edit">Thêm sản phẩm con</h3>
                    <div class="panel-actions">
                        <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                           aria-hidden="true"></a>
                    </div>
                </div>
                <div class="panel-body">
                    <input type="hidden" id="attributeID" name="attributeID" value="0" data-id="{{$product->id}}">
                    <div class="form-group mb-10">                    
                        <ul id="ul-attibute" class="list-unstyled attribute-lists">
                            @foreach($attributes as $attribute)
                                <li>
                                    <label for="attribute{{ $attribute->id }}"
                                           style="list-style: none; margin: 0; padding: 0;">
                                        {{ $attribute->name }}
                                        <input name="attribute[]" class="attribute" type="hidden"
                                               id="attribute{{ $attribute->id }}" value="{{ $attribute->id }}">
                                    </label>

                                    <label for="attributeValue{{ $attribute->id }}"
                                           style="display: none; visibility: hidden"></label>
                                    @if($attribute->values!=null)
                                        <select name="attributeValue[]" id="attributeValue{{ $attribute->id }}"
                                                class="form-control select2" style="width: 100%">
                                            @foreach($attribute->values as $attr)
                                                <option value="{{ $attr->id }}">{{ $attr->name }}</option>
                                            @endforeach
                                        </select>
                                    @endif
                                </li>
                            @endforeach
                        </ul>
                    </div>
                    <div class="form-group">
                        <label for="productAttributeQuantity">Số lượng <span class="text text-danger">*</span></label>
                        <input type="text" required name="productAttributeQuantity" id="productAttributeQuantity"
                               class="form-control" placeholder="Số lượng">
                    </div>
                    <div class="form-group">
                        <label for="productAttributePrice">Giá <span class="text text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fas fa-dollar-sign"></i></span>
                            <input type="text" required name="productAttributePrice" id="productAttributePrice"
                                   class="form-control" placeholder="Giá bán">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="salePrice">Giá khuyến mãi</label>
                        <div class="input-group">
                            <span class="input-group-addon"><i class="fas fa-dollar-sign"></i></span>
                            <input type="number" min="0" name="sale_price" id="sale_price" class="form-control"
                                   placeholder="Giá khuyến mãi">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="default">Đặt mặc định?</label> <br/>
                        <select name="default" id="default" class="form-control select2">
                            <option value="0" selected="selected">Không</option>
                            <option value="1">Có</option>
                        </select>
                    </div>
                    <div class="box-footer text-center">
                        <div class="btn-group">
                            <button id="btn-delete" title="Xóa sản phẩm này" type="button" class="btn btn-sm btn-danger" style="display:none;"> Xóa
                            </button>
                            <button id="btn-back" title="Trở về trang danh sách sản phẩm"  data-type="back" type="button" class="btn btn-sm btn-default">Quay lại danh
                                sách
                            </button>
                            <button id="btn-submit" title="Lưu thay đổi" type="submit" class="btn btn-sm btn-primary"> Lưu
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    {{-- Single delete modal --}}
    <div class="modal modal-danger fade" tabindex="-1" id="delete_modal" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-label="{{ __('voyager::generic.close') }}"><span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title"><i
                            class="voyager-trash"></i> Xác nhận xóa
                        ?</h4>
                </div>
                <div class="modal-footer">
                <form action="#" id="delete_form" method="POST">
                        {{ method_field('DELETE') }}
                        {{ csrf_field() }}
                        <input name="id_delete" id="id_delete" value="" type="hidden">
                        <input name="pa_detele" id="pa_delete" value="" type="hidden">
                        <input type="submit" class="btn btn-danger pull-right delete-confirm"
                               value="Xác nhận xóa">
                    </form>
                    <button type="button" class="btn btn-default pull-right"
                            data-dismiss="modal">Hủy</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->
@stop
@section('javascript')
    <script>
        let ATTRIBUTE_ID = 0;
        function backToInfoTab(){
            window.history.back();
        };
        $(document).ready(function () {
            $('#productAttributeQuantity').attr('disabled', false);
            $('#productAttributePrice').attr('disabled', false);
            $('#sale_price').attr('disabled', false);
            $('#default').attr('disabled', false);
            $('#btn-submit').attr('disabled', false);
            });
            $('.tr-attribute').on('click', function () {
                var that = $(this).data('id');
                ATTRIBUTE_ID = that;
                $.ajaxSetup({
                    headers: {
                        'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                    }
                });
                $.ajax({
                    type: "get",
                    url: '/admin/product-attribute/edit/' + that,
                    dataType: "JSON",
                    data: {
                        "Id": that
                    },
                    success: function (response) {
                        toastr.remove();
                        toastr.info('Vui lòng điền các thông tin bên dưới.');
                        document.getElementById("add-edit-panel").style.animation = "bounce 2s linear 1";
                        $('#attributeID').val(that);
                        $('#id_delete').val({{$product->id}});
                        $('#pa_delete').val(that);
                        $('#productAttributeQuantity').attr('disabled', false);
                        $('#productAttributePrice').attr('disabled', false);
                        $('#sale_price').attr('disabled', false);
                        $('#default').attr('disabled', false);
                        $('#btn-submit').attr('disabled', false);
                        $('#sale_price').val(response.sale_price);
                        $('#productAttributePrice').val(response.price);
                        $('#productAttributeQuantity').val(response.quantity);
                        $('#title-add-edit').text('Cập nhật');
                        $('#btn-back').text('Hủy thay đổi');
                        $('#btn-delete').css("display", "block");
                        $('#btn-back').attr('data-type','cancel');
                        $('#attributeValue1').attr('disabled', true);
                        $('#attributeValue2').attr('disabled', true);
                    },
                    error: function (xhr) {
                        console.log(xhr.responseText); // this line will save you tons of hours while debugging
                        toastr.info('Đã có lỗi xảy ra.');
                    }
            });
            $('#btn-back').on('click', function () {     
                document.getElementById("add-edit-panel").style.animation = "";          
                var type = $(this).data('type');
                $('#attributeID').val('');
                if(type == 'cancel'){
                    $('#btn-submit').text('Lưu');                
                    $('#sale_price').val('');
                    $('#productAttributePrice').val('');
                    $('#productAttributeQuantity').val('');
                    $('#title-add-edit').text('Thêm sản phẩm con');
                    toastr.remove();
                    toastr.success('Hủy thay đổi.');
                    $(this).text('Quay lại danh sách');
                    $(this).attr('data-type','back');                    
                    $('#attributeValue1').attr('disabled', false);
                    $('#attributeValue2').attr('disabled', false);
                    $('#btn-delete').css("display", "none");
                }
                if(type == 'back'){
                    backToInfoTab();
                }
            });
            $('#btn-delete').on('click', function (e) {                
                e.preventDefault();
                console.log(ATTRIBUTE_ID);
                $('#delete_form')[0].action = '{{ route('product.attibute.value.delete', '__id') }}'.replace('__id', ATTRIBUTE_ID);
                $('#delete_modal').modal('show');
                
                // mainJS.confirm('Xác nhận xóa?', function () {
                //     $.ajaxSetup({
                //     headers: {
                //         'X-CSRF-TOKEN': $('meta[name="csrf-token"]').attr('content')
                //     }
                //     });
                //     $.ajax({
                //     type: "get",
                //     url: '/admin/product-attribute/edit/' + ATTRIBUTE_ID,
                //     dataType: "JSON",
                //     data: {
                //         "Id": ATTRIBUTE_ID
                //     },
                //     success: function (response) {
                        
                //     },
                //     error: function (xhr) {
                //         console.log(xhr.responseText); // this line will save you tons of hours while debugging
                //         toastr.info('Đã có lỗi xảy ra.');
                //     }
                // });
            // });
        });
    });
    </script>
@stop
