@extends('Template::layouts.master')

@section('content')
    <div class="user-profile-section py-60">
        <div class="container">
            <div class="dashboard-wrapper">
                <aside class="dashboard-menu">
                    <ul>
                        @include('Template::user.partials.sidebar')
                    </ul>
                </aside>

                <div class="dashboard-content">
                    @if (!Route::is('user.dashboard'))
                        <div class="breadcrumb" aria-label="breadcrumb">
                            <h6>{{ __($pageTitle) }}</h6>
                        </div>
                    @endif
                    @yield('panel')
                </div>
            </div>
        </div>
    </div>
@endsection

@push('style')
    <link href="{{ asset(activeTemplate(true) . 'css/user-dashboard.css') }}" rel="stylesheet">
@endpush
