@extends('Template::layouts.user')

@section('panel')
    <div class="mb-4 nav--links flex-wrap flex-md-nowrap">
        <a href="{{ route('user.orders.all') }}" class="nav--link {{ menuActive('user.orders.all') }}">@lang('All Orders')</a>
        <a href="{{ route('user.orders.pending') }}" class="nav--link {{ menuActive('user.orders.pending') }}">@lang('Pending')</a>
        <a href="{{ route('user.orders.processing') }}" class="nav--link {{ menuActive('user.orders.processing') }}">@lang('Processing')</a>
        <a href="{{ route('user.orders.dispatched') }}" class="nav--link {{ menuActive('user.orders.dispatched') }}">@lang('Dispatched')</a>
        <a href="{{ route('user.orders.completed') }}" class="nav--link {{ menuActive('user.orders.completed') }}">@lang('Completed')</a>
        <a href="{{ route('user.orders.canceled') }}" class="nav--link {{ menuActive('user.orders.canceled') }}">@lang('Cancelled')</a>
    </div>

    @include('Template::user.orders.orders_table')

    @if ($orders->hasPages())
        <div class="mt-4">
            {{ paginateLinks($orders) }}
        </div>
    @endif
@endsection

@push('style')
    <style>
        .nav--links {
            display: flex;
            gap: .5rem;
        }

        .nav--link {
            padding: .5rem 1rem;
            border-radius: 0.325rem;
            color: #545454;
            border: 1px solid hsl(var(--border));
            flex-shrink: 0;
        }

        .nav--link.active {
            background-color: hsl(var(--base));
            border-color: hsl(var(--base));
            color: hsl(var(--white));
        }

        @media(max-width: 575px) {
            .nav--link {
                flex-shrink: 1;
                flex-grow: 1;
                flex-basis: calc(50% - .5rem);
            }
        }

        @media(max-width: 480px) {
            .nav--link {
                padding: .25rem 1rem;
            }
        }
    </style>
@endpush
