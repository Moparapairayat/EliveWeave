@extends('Template::layouts.checkout')

@section('blade')
    <div class="address-wrapper">
        @foreach ($shippingAddresses as $item)
            @php
                $checkoutData = session('shipping_info');
                $guestShippingInfo = session('guest_shipping_info');
                if (@$checkoutData['shipping_address_id'] == $item->id) {
                    $isChecked = true;
                } elseif ($loop->first) {
                    $isChecked = true;
                } else {
                    $isChecked = false;
                }
            @endphp

            <label class="address-single" for="address-{{ $item->id }}">
                <div class="flex-fill">
                    <div class="address-item-left">
                        <div class="form--check d-inline-block">
                            <input class="form-check-input mt-0" type="radio" name="shipping_address_id" value="{{ $item->id }}" form="shipping-form" value="" id="address-{{ $item->id }}" @checked($isChecked)>
                        </div>
                        <h6>{{ $item->label }}</h6>
                    </div>
                    <div class="address-item-right">
                        <div class="address-item-inner">
                            <span class="address-item-label">@lang('Address')</span>
                            <span class="address-item-value"> <span class="item-devide">:</span> {{ $item->address }}</span>
                        </div>
                        <div class="address-item-inner">
                            <span class="address-item-label">@lang('Zip Code')</span>
                            <span class="address-item-value"> <span class="item-devide">:</span> {{ $item->zip }}</span>
                        </div>
                        <div class="address-item-inner">
                            <span class="address-item-label">@lang('City')</span>
                            <span class="address-item-value"> <span class="item-devide">:</span> {{ $item->city }}</span>
                        </div>
                        <div class="address-item-inner">
                            <span class="address-item-label">@lang('State')</span>
                            <span class="address-item-value"> <span class="item-devide">:</span> {{ $item->state }}</span>
                        </div>
                        <div class="address-item-inner">
                            <span class="address-item-label">@lang('Country')</span>
                            <span class="address-item-value"> <span class="item-devide">:</span> {{ $item->country }}</span>
                        </div>
                        <div class="address-item-inner">
                            <span class="address-item-label">@lang('Phone')</span>
                            <span class="address-item-value"> <span class="item-devide">:</span> {{ $item->mobile }}</span>
                        </div>
                    </div>
                </div>

                <div class="position-relative text-end">
                    <button type="button" data-resource="{{ $item }}" class="btn btn-outline--light editAddress">
                        <i class="la la-pencil"></i>
                        <span class="d-none d-sm-inline">@lang('Change')</span>
                    </button>
                </div>
            </label>
        @endforeach

        <button class="newAddress w-100 address-single-add-new">
            <i class="las la-plus-circle"></i>
            <span class="add-new-title d-block">@lang('Add New Address')</span>
        </button>
    </div>

    <div class="d-flex align-items-center justify-content-between flex-wrap mt-4">
        <a href="{{ route('cart.page') }}" class="text--base">
            <i class="las la-angle-left"></i> @lang('Back to Cart')
        </a>

        <form action="{{ route('checkout.shipping.info.add') }}" method="POST" id="shipping-form">
            @csrf
            <button type="submit" class="btn btn--base h-45">@lang('Continue to Next') <i class="las la-angle-right"></i></button>
        </form>

    </div>
@endsection

@push('modal')
    <x-dynamic-component :component="frontendComponent('shipping-address-modal')" :countries="$countries" />
@endpush

@push('style')
    <style>
        .add-new-title {
            font-size: 1rem;
            color: hsl(var(--body-color) / 0.8);
        }
    </style>
@endpush
