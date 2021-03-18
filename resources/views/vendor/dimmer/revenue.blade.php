<div class="panel widget center bgimage" style="margin-bottom:0;overflow:hidden;background-image:url('{{ $image }}');">
    <div class="dimmer"></div>
    <div class="panel-content">
        @if (isset($icon))<i class='{{ $icon }}'></i>@endif
        <div class="row">
                <h4>{!! $title !!}
                <span>{!! $text !!}</span></h4>
                <h4>{!! $title2 !!} 
                <span>{!! $text2 !!}</span></h4>
        </div>
        <a href="{{ $button['link'] }}" class="btn btn-primary">{!! $button['text'] !!}</a>
    </div>
</div>
