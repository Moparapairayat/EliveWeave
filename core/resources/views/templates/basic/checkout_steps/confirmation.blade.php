@php
    $content = getContent('order_confirmation.content', true);
@endphp

@extends('Template::layouts.checkout')

@section('blade')
    <div class="address-wrapper">
        <div class="confirmation-card">
            <div class="confirmation-card-icon">
                <img src="{{ asset(activeTemplate(true) . 'images/order-completed.gif') }}" class="w-100 lazyload" alt="image">
            </div>
            <h3 class="confirmation-card-title mb-2">{{ __(@$content->data_values->title) }}</h3>
            <p class="confirmation-card-desc mb-4">{{ __(@$content->data_values->description) }}</p>
            <a href="{{ route('orders.details', $order->order_number) }}" class="btn btn-outline--light h-45">@lang('View Order Details')</a>
        </div>
    </div>
@endsection

@push('style')
    <style>
        .confirmation-card {
            max-width: 500px;
            width: 100%;
            border-radius: 6px;
            margin: 0 auto;
            text-align: center;
            padding: 40px;
        }

        .confirmation-card-icon {
            max-width: 150px;
            width: 100%;
            margin: 0 auto;
        }
    </style>
@endpush
