<div class="modal custom--modal fade" id="loginAndGuestModal" tabindex="-1" role="dialog">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <button type="button" class="close modal-close-btn" data-bs-dismiss="modal" aria-label="Close">
                    <i class="las la-times"></i>
                </button>
                <div class="mt-3">
                    <ul class="nav nav-tabs user-tab" id="loginGuestTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="login-tab" data-bs-toggle="tab" data-bs-target="#login" type="button" role="tab" aria-controls="login" aria-selected="true">
                                @lang('Login')
                            </button>
                        </li>

                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="guest-tab" data-bs-toggle="tab" data-bs-target="#guest" type="button" role="tab" aria-controls="guest" aria-selected="false">
                                @lang('Guest Checkout')
                            </button>
                        </li>
                    </ul>
                </div>
                <div class="tab-content" id="loginGuestTabContent">
                    <div class="tab-pane fade show active" id="login" role="tabpanel" aria-labelledby="login-tab">
                        @include('Template::partials.login', ['idPrefix' => 'auth-user'])
                    </div>

                    @php
                        $guestUser = session('guest_user_data');

                        if ($guestUser && $guestUser->country_code) {
                            $mobileCode = $guestUser->country_code;
                        } else {
                            $info = json_decode(json_encode(getIpInfo()), true);
                            $mobileCode = implode(',', $info['code'] ?? []);
                        }
                        $countries = getCountries();
                        $checkoutContent = getContent('guest_checkout.content', true)?->data_values;
                    @endphp

                    <div class="tab-pane fade" id="guest" role="tabpanel" aria-labelledby="guest-tab">

                        @if (@$checkoutContent->description_in_checkout_form)
                            <p class="my-3">
                                <span class=""><i class="fa-solid fa-circle-info icon"></i></span>
                                <span class="text">{{ @$checkoutContent->description_in_checkout_form }}</span>
                            </p>
                        @endif

                        <form action="{{ route('checkout.guest.info.store') }}" method="POST">
                            @csrf

                            <div class="form-group">
                                <label for="guest-email">@lang('Email')</label>
                                <input type="text" value="{{ @$guestUser->email }}" class="form-control form--control" id="guest-email" name="email" required>
                            </div>

                            <input type="hidden" name="mobile_code">
                            <input type="hidden" name="country_code">

                            <div class="form-group">
                                <label for="guest-mobile">@lang('Mobile')</label>
                                <div class="input-group">
                                    <select name="country" class="input-group-text" required>
                                        @foreach ($countries as $key => $country)
                                            <option data-mobile_code="{{ $country->dial_code }}" value="{{ $country->country }}" data-code="{{ $key }}">+{{ __($country->dial_code) }}({{ $country->country }})</option>
                                        @endforeach
                                    </select>
                                    <input type="number" name="mobile" value="{{ @$guestUser->mobile }}" class="form-control form--control ps-0" required>
                                </div>
                            </div>

                            <button type="submit" class="btn btn--base w-100 h-45">@lang('Proceed as Guest')</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

@push('style-lib')
    <link rel="stylesheet" href="{{ asset('assets/global/css/select2.min.css') }}">
@endpush

@push('script-lib')
    <script src="{{ asset('assets/global/js/select2.min.js') }}"></script>
@endpush

@push('script')
    <script>
        "use strict";
        (function($) {
            const formatSelection = (state) => {
                if (!state.id) {
                    return state.text;
                }
                return `+${state.element.dataset.mobile_code}`;
            }

            @if ($mobileCode)
                const selectedCountry = $(`[data-code={{ $mobileCode }}]`).val();
            @else
                const selectedCountry = $('select[name=country] option').first().val();
            @endif

            $('#loginAndGuestModal select[name=country]').val(selectedCountry).select2({
                dropdownParent: $('#loginAndGuestModal select[name=country]').parent(),
                templateSelection: formatSelection
            });

            $('#loginAndGuestModal select[name=country]').on('change', function() {
                $('input[name=mobile_code]').val($('select[name=country] :selected').last().data('mobile_code'));
                $('input[name=country_code]').val($('select[name=country] :selected').last().data('code'));
                $('.mobile-code').text('+' + $('select[name=country] :selected').last().data('mobile_code'));
            });

            $('input[name=mobile_code]').val($('select[name=country] :selected').data('mobile_code'));
            $('input[name=country_code]').val($('select[name=country] :selected').data('code'));
            $('.mobile-code').text('+' + $('select[name=country] :selected').data('mobile_code'));
        })(jQuery);
    </script>
@endpush
