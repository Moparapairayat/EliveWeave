@extends('Template::layouts.checkout')
@section('blade')
    <div class="cart-container">
        @if (!blank($cartData))
            <div class="cart">
                <div class="cart-body">
                    @foreach ($cartData as $cartItem)
                        <x-dynamic-component :component="frontendComponent('cart-item')" :cartItem="$cartItem" />
                    @endforeach
                </div>
                <div class="cart-footer">
                    @include('Template::partials.cart_bottom')
                </div>
            </div>
        @else
            <div class="single-product-item no_data empty-cart__page">
                <div class="no_data-thumb text-center mb-4">
                    <img src="{{ getImage('assets/images/empty_cart.png') }}" alt="Empty Cart">
                </div>
                <h6>@lang('Your cart is empty')</h6>
                <a href="{{ route('home') }}" class="btn btn-outline--light">@lang('Browse Products')</a>
            </div>
        @endif
    </div>

    @if (!blank($cartData))
        <div class="mt-4 text-end cart-next-step">
            @auth
                <a href="{{ route('checkout.shipping.info') }}" class="btn btn--base h-45">
                    @lang('Continue To Next') <i class="las la-angle-right"></i>
                </a>
            </div>
        @else
            <button class="btn btn--base mt-3 login-trigger" data-bs-toggle="modal" data-bs-target="@if (gs('guest_checkout')) #loginAndGuestModal @else #loginModal @endif">@lang('Continue To Next') <i class="las la-angle-right"></i></button>
        @endauth
    @endif
@endsection
