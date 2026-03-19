@extends('Template::layouts.' . $layout)

@php
    $sectionName = $layout == 'user' ? 'panel' : 'content';
@endphp

@section($sectionName)
    @if ($layout != 'user')
        <div class="container py-60">
    @endif
    <div class="order-details">
        <div class="order-details-top justify-content-between">
            <div>
                <span>
                    @php echo $order->paymentBadge() @endphp
                    @php echo $order->statusBadge() @endphp
                </span>
            </div>
            <div>
                <h5 class="order-details-id mb-1 d-flex align-items-center flex-wrap gap-3">
                    <span class="order-details-id">#{{ $order->order_number }}
                </h5>
                <span> {{ showDateTime($order->created_at, 'd F, Y') }}</span>
            </div>
        </div>

        <div class="order-details-products mb-3">
            <div class="table-responsive">
                <table class="table table-bordered table--responsive--md">
                    <thead>
                        <tr>
                            <th>@lang('Product')</th>
                            <th>@lang('Price')</th>
                            <th>@lang('Quantity')</th>
                            <th>@lang('Total Price')</th>
                        </tr>
                    </thead>
                    <tbody>
                        @php
                            $subtotal = $order->orderDetail->sum(function ($detail) {
                                return $detail->price * $detail->quantity;
                            });
                        @endphp

                        @foreach ($order->orderDetail as $data)
                            @php
                                $mainImage = $data->productVariant && @$data->productVariant->main_image_id ? $data->productVariant->mainImage(true) : @$data->product->mainImage(true);
                            @endphp

                            <tr>
                                <td>
                                    <div class="single-product-item  align-items-center">
                                        <div class="thumb">
                                            <img class="lazyload" src="{{ getImage(null) }}" data-src="{{ $mainImage }}" alt="{{ @$data->product->name ?? 'product' }}">
                                        </div>

                                        <div class="content d-flex flex-column">
                                            {{ @$data->product->name }}

                                            @if ($data->productVariant)
                                                - {{ @$data->productVariant->name }}
                                            @endif

                                            @if ($data->product->is_downloadable && $order->status == Status::ORDER_DELIVERED && $order->payment_status == Status::PAYMENT_SUCCESS)
                                                <a href="{{ route('order.item.download', encrypt($data->id)) }}" class="fw-light text-decoration-underline">
                                                    <i class="la la-download"></i> @lang('Download')
                                                </a>
                                            @endif
                                        </div>
                                    </div>
                                </td>
                                <td> {{ showAmount($data->price) }}</td>
                                <td>{{ $data->quantity }}</td>
                                <td class="text-end">{{ showAmount($data->price * $data->quantity) }}</td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        </div>

        <div class="row g-3 flex-md-row-reverse">
            <div class="col-md-6">
                <div class="details-info-list">
                    <h6 class="mb-3">@lang('Order Summary')</h6>
                    <ul>
                        <li>
                            <span>@lang('Subtotal')</span>
                            <span class="fw-semibold">{{ showAmount($subtotal, 2) }}</span>
                        </li>
                        @if ($order->appliedCoupon)
                            <li>
                                <span>(<i class="la la-minus"></i>) @lang('Coupon')
                                    ({{ $order->appliedCoupon->coupon->coupon_code }})</span>
                                <span> {{ showAmount($order->appliedCoupon->amount, 2) }}</span>
                            </li>
                        @endif

                        <li>
                            <span>(<i class="la la-plus"></i>) @lang('Shipping')</span>
                            <span>{{ showAmount($order->shipping_charge, 2) }}</span>
                        </li>

                        <li class="total">
                            <span>@lang('Total')</span>
                            <span>{{ showAmount($order->total_amount) }}</span>
                        </li>
                    </ul>
                </div>

                @if (isset($order->deposit) && $order->deposit->status != 0)
                    <div class="details-info-list">
                        <h6 class="mb-3">@lang('Payment Details')</h6>
                        <ul>
                            <li>
                                <span>@lang('Payment Method')</span>
                                <span>
                                    @if ($order->deposit->method_code == 0)
                                        @lang('Cash On Delivery')
                                    @else
                                        {{ __($order->deposit->gateway->name) }}
                                    @endif
                                </span>
                            </li>

                            <li>
                                <span>@lang('Total Bill')</span>
                                <span>{{ showAmount($order->total_amount) }}</span>
                            </li>

                            @if (@$order->deposit->charge > 0)
                                <li>
                                    <span>@lang('Gateway Charge')</span>
                                    <span>{{ gs('cur_sym') . getAmount(@$order->deposit->charge) }}</span>
                                </li>
                            @endif

                            <li class="total">
                                <span>@lang('Total Payable Amount') </span>
                                <span>{{ gs('cur_sym') . getAmount($order->deposit->amount + @$order->deposit->charge) }}</span>
                            </li>

                        </ul>
                    </div>
                @endif
            </div>

            <div class="col-md-6">
                @if ($order->shipping_address)
                    <div class="details-info-address">
                        <h6 class="mb-3">@lang('Shipping Details')</h6>
                        <ul class="info-address-list">
                            <li>
                                <span class="title">@lang('Name') </span>
                                <span>
                                    <span class="devide-colon">:</span>
                                    {{ $order->shipping_address->firstname . ' ' . $order->shipping_address->lastname }}
                                </span>
                            </li>
                            <li>
                                <span class="title">@lang('Address')</span>
                                <span>
                                    <span class="devide-colon">:</span>
                                    {{ $order->shipping_address->address }}
                                </span>
                            </li>
                            <li>
                                <span class="title">@lang('State')</span>
                                <span>
                                    <span class="devide-colon">:</span>
                                    {{ $order->shipping_address->state }}
                                </span>
                            </li>
                            <li>
                                <span class="title">@lang('City')</span>
                                <span>
                                    <span class="devide-colon">:</span>
                                    {{ $order->shipping_address->city }}
                                </span>
                            </li>
                            <li>
                                <span class="title">@lang('Zip')</span>
                                <span>
                                    <span class="devide-colon">:</span>
                                    {{ $order->shipping_address->zip }}
                                </span>
                            </li>
                            <li>
                                <span class="title">@lang('Country')</span>
                                <span>
                                    <span class="devide-colon">:</span>
                                    {{ $order->shipping_address->country }}
                                </span>
                            </li>
                        </ul>
                    </div>
                @endif
            </div>
        </div>

    </div>

    @if ($layout == 'user')
        </div>
    @endif
@endsection

@push('style')
    <link rel="stylesheet" href="{{ asset(activeTemplate(true) . 'css/order_details.css') }}">
@endpush
