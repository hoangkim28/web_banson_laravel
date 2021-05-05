@extends('voyager::master')

@section('page_title', __('voyager::generic.view').' '.$dataType->getTranslatedAttribute('display_name_singular'))

@section('page_header')
<h1 class="page-title">
  <i class="{{ $dataType->icon }}"></i> {{ __('voyager::generic.viewing') }}
  {{ ucfirst($dataType->getTranslatedAttribute('display_name_singular')) }} &nbsp;

  @can('edit', $dataTypeContent)
  <a href="{{ route('voyager.'.$dataType->slug.'.print', $dataTypeContent->getKey()) }}"
    title="In hóa đơn" class="btn btn-primary restore"
    data-id="{{ $dataTypeContent->getKey() }}" id="restore-{{ $dataTypeContent->getKey() }}">
    <i class="voyager-receipt"></i> <span class="hidden-xs hidden-sm">In hóa đơn</span>
  </a>
  @endcan
  @can('browse', $dataTypeContent)
  <a href="{{ route('voyager.'.$dataType->slug.'.index') }}" class="btn btn-warning">
    <span class="glyphicon glyphicon-list"></span>&nbsp;
    {{ __('voyager::generic.return_to_list') }}
  </a>
  @endcan
</h1>
@include('voyager::multilingual.language-selector')
@stop

@section('content')
<div class="page-content read container-fluid">
  <div class="row">
    <div class="col-md-12">
    <div class="panel panel-bordered" style="padding-bottom:5px;">

      <div class="panel-heading" style="border-bottom:0;">
        <h3 class="panel-title">Danh sách sản phảm</h3>
      </div>

      <div class="panel-body" style="padding-top:0;">
        <table class="table">
          <thead class="thead-dark">
            <tr>
              <th scope="col">#</th>
              <th scope="col">Tên sản phẩm</th>
              <th scope="col">Màu</th>
              <th scope="col">Kích thước</th>
              <th scope="col">Giá</th>
              <th scope="col">Số lượng</th>
              <th scope="col">Thành tiền</th>
            </tr>
          </thead>
          <tbody>
            @if($bill_details->count())
            @foreach($bill_details as $detail)
            <?php $no = 1 ?>
            <tr>
              <th scope="row">{{$no}}</th>
              <td class="text-right">{{$detail->product_name}} - {{$detail->product_sku}}</td>
              <td class="text-right" style="background-color: {{$item->color ?? ''}}"></td>
              <td class="text-right">{{\App\Models\Product::find($detail->product_id)->attributes()->find($detail->product_attribute_id)->attributesValues()->where('attribute_value_id','=',$detail->attribute_value_id)->first()->name}}</td>
              <td class="text-right">{{format($detail->product_price)}} vnd</td>
              <td class="text-center">{{$detail->quantity}}</td>
              <td class="text-right">{{format($detail->product_price * $detail->quantity)}} vnđ</td>
            </tr>
            <?php $no++?>
            @endforeach
            @else 
            <tr>
              <th class="text-danger text-center" scope="row">Lỗi - Không tìm thấy thông tin đơn hàng</th>
            </tr>
            @endif
          </tbody>
        </table>
      </div>
      </div>
    </div>
    <div class="col-md-4">
      <div class="panel panel-bordered" style="padding-bottom:5px;">
      <div class="panel-heading" style="border-bottom:0;">
          <h3 class="display-3 text-center text-primary">Thông tin đơn hàng</h3>
        </div>
        <!-- form start -->
        @foreach($dataType->readRows as $row)
        @php
        if ($dataTypeContent->{$row->field.'_read'}) {
        $dataTypeContent->{$row->field} = $dataTypeContent->{$row->field.'_read'};
        }
        @endphp
        <div class="panel-heading" style="border-bottom:0;">
          <h3 class="panel-title">{{ $row->getTranslatedAttribute('display_name') }}</h3>
        </div>

        <div class="panel-body" style="padding-top:0;">
          @if (isset($row->details->view))
          @include($row->details->view, ['row' => $row, 'dataType' => $dataType, 'dataTypeContent' => $dataTypeContent,
          'content' => $dataTypeContent->{$row->field}, 'action' => 'read', 'view' => 'read', 'options' =>
          $row->details])
          @elseif($row->type == "image")
          <img class="img-responsive"
            src="{{ filter_var($dataTypeContent->{$row->field}, FILTER_VALIDATE_URL) ? $dataTypeContent->{$row->field} : Voyager::image($dataTypeContent->{$row->field}) }}">
          @elseif($row->type == 'multiple_images')
          @if(json_decode($dataTypeContent->{$row->field}))
          @foreach(json_decode($dataTypeContent->{$row->field}) as $file)
          <img class="img-responsive"
            src="{{ filter_var($file, FILTER_VALIDATE_URL) ? $file : Voyager::image($file) }}">
          @endforeach
          @else
          <img class="img-responsive"
            src="{{ filter_var($dataTypeContent->{$row->field}, FILTER_VALIDATE_URL) ? $dataTypeContent->{$row->field} : Voyager::image($dataTypeContent->{$row->field}) }}">
          @endif
          @elseif($row->type == 'relationship')
          @include('voyager::formfields.relationship', ['view' => 'read', 'options' => $row->details])
          @elseif($row->type == 'select_dropdown' && property_exists($row->details, 'options') &&
          !empty($row->details->options->{$dataTypeContent->{$row->field}})
          )
          <?php echo $row->details->options->{$dataTypeContent->{$row->field}};?>
          @elseif($row->type == 'select_multiple')
          @if(property_exists($row->details, 'relationship'))

          @foreach(json_decode($dataTypeContent->{$row->field}) as $item)
          {{ $item->{$row->field}  }}
          @endforeach

          @elseif(property_exists($row->details, 'options'))
          @if (!empty(json_decode($dataTypeContent->{$row->field})))
          @foreach(json_decode($dataTypeContent->{$row->field}) as $item)
          @if (@$row->details->options->{$item})
          {{ $row->details->options->{$item} . (!$loop->last ? ', ' : '') }}
          @endif
          @endforeach
          @else
          {{ __('voyager::generic.none') }}
          @endif
          @endif
          @elseif($row->type == 'date' || $row->type == 'timestamp')
          @if ( property_exists($row->details, 'format') && !is_null($dataTypeContent->{$row->field}) )
          {{ \Carbon\Carbon::parse($dataTypeContent->{$row->field})->formatLocalized($row->details->format) }}
          @else
          {{ $dataTypeContent->{$row->field} }}
          @endif
          @elseif($row->type == 'checkbox')
          @if(property_exists($row->details, 'on') && property_exists($row->details, 'off'))
          @if($dataTypeContent->{$row->field})
          <span class="label label-info">{{ $row->details->on }}</span>
          @else
          <span class="label label-primary">{{ $row->details->off }}</span>
          @endif
          @else
          {{ $dataTypeContent->{$row->field} }}
          @endif
          @elseif($row->type == 'color')
          <span class="badge badge-lg"
            style="background-color: {{ $dataTypeContent->{$row->field} }}">{{ $dataTypeContent->{$row->field} }}</span>
          @elseif($row->type == 'coordinates')
          @include('voyager::partials.coordinates')
          @elseif($row->type == 'rich_text_box')
          @include('voyager::multilingual.input-hidden-bread-read')
          {!! $dataTypeContent->{$row->field} !!}
          @elseif($row->type == 'file')
          @if(json_decode($dataTypeContent->{$row->field}))
          @foreach(json_decode($dataTypeContent->{$row->field}) as $file)
          <a href="{{ Storage::disk(config('voyager.storage.disk'))->url($file->download_link) ?: '' }}">
            {{ $file->original_name ?: '' }}
          </a>
          <br />
          @endforeach
          @else
          <a href="{{ Storage::disk(config('voyager.storage.disk'))->url($row->field) ?: '' }}">
            {{ __('voyager::generic.download') }}
          </a>
          @endif
          @else
          @include('voyager::multilingual.input-hidden-bread-read')
          <p>{{ $dataTypeContent->{$row->field} }}</p>
          @endif
        </div><!-- panel-body -->
        @if(!$loop->last)
        <hr style="margin:0;">
        @endif
        @endforeach

      </div>
    </div>
  </div>
</div>

{{-- Single delete modal --}}
<div class="modal modal-danger fade" tabindex="-1" id="delete_modal" role="dialog">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="{{ __('voyager::generic.close') }}"><span
            aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="voyager-trash"></i> {{ __('voyager::generic.delete_question') }}
          {{ strtolower($dataType->getTranslatedAttribute('display_name_singular')) }}?</h4>
      </div>
      <div class="modal-footer">
        <form action="{{ route('voyager.'.$dataType->slug.'.index') }}" id="delete_form" method="POST">
          {{ method_field('DELETE') }}
          {{ csrf_field() }}
          <input type="submit" class="btn btn-danger pull-right delete-confirm"
            value="{{ __('voyager::generic.delete_confirm') }} {{ strtolower($dataType->getTranslatedAttribute('display_name_singular')) }}">
        </form>
        <button type="button" class="btn btn-default pull-right"
          data-dismiss="modal">{{ __('voyager::generic.cancel') }}</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
@stop

@section('javascript')
@if ($isModelTranslatable)
<script>
$(document).ready(function() {
  $('.side-body').multilingual();
});
</script>
@endif
<script>
var deleteFormAction;
$('.delete').on('click', function(e) {
  var form = $('#delete_form')[0];

  if (!deleteFormAction) {
    // Save form action initial value
    deleteFormAction = form.action;
  }

  form.action = deleteFormAction.match(/\/[0-9]+$/) ?
    deleteFormAction.replace(/([0-9]+$)/, $(this).data('id')) :
    deleteFormAction + '/' + $(this).data('id');

  $('#delete_modal').modal('show');
});
</script>
@stop