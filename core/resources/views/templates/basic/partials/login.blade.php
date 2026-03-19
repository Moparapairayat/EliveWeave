@php
    $content = getContent('login_page.content', true)->data_values;
    $idPrefix = isset($idPrefix) ? $idPrefix : '';

@endphp

<h5 class="modal-title mt-3">{{ @$content->heading }}</h5>
<div class="login-wrapper">
    <form method="POST" action="{{ route('user.login') }}" class="sign-in-form">
        @csrf
        <div class="form-group">
            <label class="form--label" for="{{$idPrefix}}login-username">@lang('Username')</label>
            <input type="text" class="form--control" name="username" id="{{$idPrefix}}login-username" value="{{ old('email') }}">
        </div>

        <div class="form-group">
            <label class="form--label" for="{{$idPrefix}}login-password">@lang('Password')</label>
            <input type="password" class="form--control" name="password" id="{{$idPrefix}}login-password">
        </div>

        <div class="form-group">
            <div class="d-flex gap-1 flex-wrap justify-content-between">

                <div class="form-check form--check d-flex gap-1 align-items-center mb-0">
                    <label class="form-check-label m-0 lh-1 d-flex align-items-center">
                        <input class="form-check-input me-1" type="checkbox" name="remember" id="{{$idPrefix}}remember-me">@lang('Remember Me')
                    </label>
                </div>

                <a href="{{ route('user.password.request') }}"
                    class="t-link d-block text-end text--base heading-clr sm-text fw-md">
                    @lang('Forgot Password?')
                </a>
            </div>
        </div>

        <x-captcha></x-captcha>

        <button type="submit" class="btn btn--base w-100 h-45">@lang('Login')</button>

        <p class="create-accounts mb-0 mt-2">
            <span class="text-dark">
                @lang('Don\'t have an account?') <a href="{{ route('user.register') }}" class="text--base">@lang('Create An Account')</a>
            </span>
        </p>
    </form>

    @include('Template::partials.social_login')
</div>

@push('style')
    <style>
        .form--check .form-check-input {
            margin-top: 1px !important;
        }
    </style>
@endpush
