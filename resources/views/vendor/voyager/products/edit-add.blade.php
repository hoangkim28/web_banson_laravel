@php
    $edit = !is_null($dataTypeContent->getKey());
    $add  = is_null($dataTypeContent->getKey());
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

@section('page_title', __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular'))

@section('page_header')
    <h1 class="page-title">
        <i class="{{ $dataType->icon }}"></i>
        {{ __('voyager::generic.'.($edit ? 'edit' : 'add')).' '.$dataType->getTranslatedAttribute('display_name_singular') }}
    </h1>
    @include('voyager::multilingual.language-selector')
@stop

@section('content')

    <form class="page-content container-fluid form-edit-add" role="form"
          action="@if($edit){{ route('voyager.products.update', $dataTypeContent->id) }}@else{{ route('voyager.products.store') }}@endif"
          method="POST" enctype="multipart/form-data">

        <!-- PUT Method if we are editing -->
        @if($edit)
            {{ method_field("PUT") }}
        @endif
        {{ csrf_field() }}

        <div class="row">
            <div class="col-md-8">
                <!-- ### EXCERPT ### -->
                <div class="panel">
                    
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
                        <h3 class="panel-title">Gi???i thi???u s?? l?????t S??n</h3>
                        <div class="panel-actions">
                            <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                               aria-hidden="true"></a>
                        </div>
                    </div>
                    <div class="panel-body">
                        @include('voyager::multilingual.input-hidden', [
                            '_field_name'  => 'excerpt',
                            '_field_trans' => get_field_translations($dataTypeContent, 'excerpt')
                        ])
                        <textarea class="form-control"
                                  name="excerpt">{{ $dataTypeContent->excerpt ?? '' }}</textarea>
                    </div>
                </div>
                <!-- ### CONTENT ### -->
                <div class="panel">
                    <div class="panel-heading">
                        <h3 class="panel-title">Th??ng tin chi ti???t S??n</h3>
                        <div class="panel-actions">
                            <a class="panel-action voyager-resize-full" data-toggle="panel-fullscreen"
                               aria-hidden="true"></a>
                        </div>
                    </div>

                    <div class="panel-body">
                        @include('voyager::multilingual.input-hidden', [
                            '_field_name'  => 'body',
                            '_field_trans' => get_field_translations($dataTypeContent, 'body')
                        ])
                        @php
                            $dataTypeRows = $dataType->{($edit ? 'editRows' : 'addRows' )};
                            $row = $dataTypeRows->where('field', 'body')->first();
                        @endphp
                        {!! app('voyager')->formField($row, $dataType, $dataTypeContent) !!}
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <!-- ### DETAILS ### -->
                <div class="panel panel panel-bordered panel-warning">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="icon wb-clipboard"></i> Th??ng tin S??n</h3>
                        <div class="panel-actions">
                            <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                               aria-hidden="true"></a>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="category_id">Danh m???c S??n</label>
                            <select class="form-control form-select" name="category_id">
                                @foreach(Voyager::model('Category')::all() as $category)
                                    <option value="{{ $category->id }}"
                                            @if(isset($dataTypeContent->category_id) && $dataTypeContent->category_id == $category->id) selected="selected"@endif>{{ $category->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="category_id">Th????ng hi???u</label>
                            <select class="form-control" name="brand_id">
                                @foreach(App\Models\Brand::all() as $brand)
                                    <option value="{{ $brand->id }}"
                                            @if(isset($dataTypeContent->brand_id) && $dataTypeContent->brand_id == $brand->id) selected="selected"@endif>{{ $brand->name }}</option>
                                @endforeach
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="name">T??n s??n</label>
                            @include('voyager::multilingual.input-hidden', [
                                '_field_name'  => 'name',
                                '_field_trans' => get_field_translations($dataTypeContent, 'name')
                            ])
                            <input type="text" class="form-control forcus:bg-yellow-900" id="name" name="name"
                                   placeholder="T??n s??n"
                                   {!! isFieldSlugAutoGenerator($dataType, $dataTypeContent, "name") !!}
                                   value="{{ $dataTypeContent->name ?? '' }}">
                        </div>
                        <div class="form-group">
                            <label for="sku">M?? s??n</label>
                            @include('voyager::multilingual.input-hidden', [
                                '_field_name'  => 'sku',
                                '_field_trans' => get_field_translations($dataTypeContent, 'sku')
                            ])
                            <input type="text" class="form-control" id="sku" name="sku"
                                   placeholder="M?? s??n"
                                   {!! isFieldSlugAutoGenerator($dataType, $dataTypeContent, "sku") !!}
                                   value="{{ $dataTypeContent->sku ?? '' }}">
                        </div>
                        <div class="form-group">
                            <label for="slug">T??n tr??n ???????ng d???n (????? tr???ng ????? d??ng m???c ?????nh)</label>
                            @include('voyager::multilingual.input-hidden', [
                                '_field_name'  => 'slug',
                                '_field_trans' => get_field_translations($dataTypeContent, 'slug')
                            ])
                            <input type="text" class="form-control" id="slug" name="slug"
                                   placeholder="???????ng d???n"
                                   {!! isFieldSlugAutoGenerator($dataType, $dataTypeContent, "slug") !!}
                                   value="{{ $dataTypeContent->slug ?? '' }}">
                        </div>

                        <div class="form-group col-md-6">
                            <label for="status">Tr???ng th??i</label>
                            <div class="form-group">
                                <?php $checked = false; ?>
                                @if(isset($dataTypeContent->status) || old($dataTypeContent->status))
                                    <?php $checked = old($row->field, $dataTypeContent->status); ?>
                                @else
                                    <?php $checked = isset($options->checked) &&
                                    filter_var($options->checked, FILTER_VALIDATE_BOOLEAN) ? true : false; ?>
                                @endif

                                <?php $class = $options->class ?? "toggleswitch"; ?>

                                @if(isset($options->on) && isset($options->off))
                                    <input type="checkbox" name="status" class="{{ $class }}"
                                           data-on="Hi???n th???" {!! $checked ? 'checked="checked"' : '' !!}
                                           data-off="???n">

                                @else
                                    <input type="checkbox" name="status" class="{{ $class }}"
                                           @if($checked) checked @endif>
                                @endif
                            </div>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="featured">S???n ph???m n???i b???t</label>
                            <div class="form-group">
                                <?php $checked = false; ?>
                                @if(isset($dataTypeContent->status) || old($dataTypeContent->featured))
                                    <?php $checked = old($row->field, $dataTypeContent->featured); ?>
                                @else
                                    <?php $checked = isset($options->checked) &&
                                    filter_var($options->checked, FILTER_VALIDATE_BOOLEAN) ? true : false; ?>
                                @endif

                                <?php $class = $options->class ?? "toggleswitch"; ?>

                                @if(isset($options->on) && isset($options->off))
                                    <input type="checkbox" name="featured" class="{{ $class }}"
                                           data-on="Hi???n th???" {!! $checked ? 'checked="checked"' : '' !!}
                                           data-off="???n">

                                @else
                                    <input type="checkbox" name="featured" class="{{ $class }}"
                                           @if($checked) checked @endif>
                                @endif
                            </div>
                        </div>


                        <div class="form-group">
                            <label for="date_available">Th???i gian S??n s??? hi???n th??? t???i trang ch???</label>
                            <input class="form-control" type="datetime-local" name="date_available"
                                   @if(isset($dataTypeContent->date_available) && $dataTypeContent->date_available) value="@php echo date('Y-m-d\TH:i', strtotime($dataTypeContent->date_available)); @endphp"@endif>
                        </div>

                    </div>
                </div>
                <!-- ### IMAGE ### -->
                <div class="panel">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="icon wb-image"></i> H??nh, ???nh ?????i di???n S??n</h3>
                        <div class="panel-actions">
                            <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                               aria-hidden="true"></a>
                        </div>
                    </div>
                    <div class="panel-body text-center">
                        @if(isset($dataTypeContent->avatar))
                            <img
                                class=""
                                src="{{ filter_var($dataTypeContent->avatar, FILTER_VALIDATE_URL) ? $dataTypeContent->avatar : Voyager::image( $dataTypeContent->avatar ) }}"
                                style="width:auto;height: 150px;"/>
                        @endif
                        <input type="file" name="avatar" accept="image/*" placeholder="Ch???n h??nh">
                    </div>
                </div>
                <!-- ### SEO CONTENT ### -->
                <div class="panel panel-bordered panel-primary">
                    <div class="panel-heading">
                        <h3 class="panel-title"><i class="icon wb-search"></i> C??c th???c t??nh SEO</h3>
                        <div class="panel-actions">
                            <a class="panel-action voyager-angle-down" data-toggle="panel-collapse"
                               aria-hidden="true"></a>
                        </div>
                    </div>
                    <div class="panel-body">
                        <div class="form-group">
                            <label for="meta_description">{{ __('voyager::post.meta_description') }}</label>
                            @include('voyager::multilingual.input-hidden', [
                                '_field_name'  => 'meta_description',
                                '_field_trans' => get_field_translations($dataTypeContent, 'meta_description')
                            ])
                            <textarea class="form-control"
                                      name="meta_description">{{ $dataTypeContent->meta_description ?? '' }}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="meta_keywords">{{ __('voyager::post.meta_keywords') }}</label>
                            @include('voyager::multilingual.input-hidden', [
                                '_field_name'  => 'meta_keywords',
                                '_field_trans' => get_field_translations($dataTypeContent, 'meta_keywords')
                            ])
                            <textarea class="form-control"
                                      name="meta_keywords">{{ $dataTypeContent->meta_keywords ?? '' }}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="seo_title">{{ __('voyager::post.seo_title') }}</label>
                            @include('voyager::multilingual.input-hidden', [
                                '_field_name'  => 'seo_title',
                                '_field_trans' => get_field_translations($dataTypeContent, 'seo_title')
                            ])
                            <input type="text" class="form-control" name="seo_title" placeholder="SEO Title"
                                   value="{{ $dataTypeContent->seo_title ?? '' }}">
                        </div>
                    </div>
                </div>

            </div>
        </div>

        @section('submit-buttons')
            <button type="submit" class="btn btn-primary pull-right">
                @if($edit) C???p nh???t @else <i class="icon wb-plus-circle"></i> Th??m @endif
            </button>
        @stop
        @yield('submit-buttons')

    </form>
    <div class="modal fade modal-danger" id="confirm_delete_modal">
        <div class="modal-dialog">
            <div class="modal-content">

                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">&times;
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

            @if ($isModelTranslatable)
            $('.side-body').multilingual({"editing": true});
            @endif

            $('.side-body input[data-slug-origin]').each(function (i, el) {
                $(el).slugify();
            });

            $('.form-group').on('click', '.remove-multi-image', deleteHandler('img', true));
            $('.form-group').on('click', '.remove-single-image', deleteHandler('img', false));
            $('.form-group').on('click', '.remove-multi-file', deleteHandler('a', true));
            $('.form-group').on('click', '.remove-single-file', deleteHandler('a', false));

            $('#confirm_delete').on('click', function () {
                $.post('{{ route('voyager.'.$dataType->slug.'.media.remove') }}', params, function (response) {
                    if (response
                        && response.data
                        && response.data.status
                        && response.data.status == 200) {

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
@stop
