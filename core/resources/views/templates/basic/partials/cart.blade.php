<div class="cart-items-wrapper">
    @forelse ($cartItems as $cartItem)
        <x-dynamic-component :component="frontendComponent('cart-item')" :cartItem="$cartItem" :isCartPage="false" />
    @empty
        <div class="single-product-item no_data">
            <div class="no_data-thumb">
                <img src="{{ getImage('assets/images/empty_cart.png') }}" alt="img">
            </div>
            <h6>@lang('Your cart is empty')</h6>
        </div>
    @endforelse
</div>

@if ($subtotal > 0)
    <div class="cart-bottom">
        @include('Template::partials.cart_bottom')
        @if ($cartItems->count() > 0)
            <div class="btn-wrapper text-end">
                @php
                    $route = cartManager()->checkPhysicalProductExistence()
                        ? route('checkout.shipping.info')
                        : route('checkout.payment.methods');
                @endphp

                @auth
                    <a class="btn btn--base mt-3" href="{{ $route }}">@lang('Checkout')</a>
                @else
                    <button class="btn btn--base mt-3 login-trigger" data-bs-toggle="modal" data-bs-target="@if(gs('guest_checkout'))#loginAndGuestModal @else #loginModal @endif">@lang('Checkout')</button>
                @endauth
            </div>
        @endif
    </div>
@endif
