@extends('Template::layouts.app')
@section('app')
    @php
        $bgImage = getContent('auth_pages_bg.content', true);
    @endphp

    <div class="auth-section auth-section--light py-60" @if (@$bgImage->data_values->image) style="background-image: url('{{ frontendImage('auth_pages_bg', @$bgImage->data_values->image) }}');" @endif>
        @yield('content')
    </div>
@endsection

@push('style')
    <style>
        body {
            padding-bottom: 0 !important;
        }
    </style>
@endpush
