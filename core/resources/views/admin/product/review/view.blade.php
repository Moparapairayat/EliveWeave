@extends('admin.layouts.app')

@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="row mb-none-30 justify-content-center">
                <div class="col-xl-4 col-md-6 mb-30">
                    <div class="card overflow-hidden box--shadow1">

                        <div class="card-body p-0">
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span class="fw-semibold">@lang('Product Name')</span>
                                    <a href="{{ route('admin.products.edit', $review->product->id) }}">{{ __($review->product->name) }}</a>
                                </li>

                                <li class="list-group-item d-flex justify-content-between">
                                    <span class="fw-semibold">@lang('Customer')</span>
                                    <a href="{{ route('admin.users.detail', $review->user->id) }}">{{ $review->user->username }}</a>
                                </li>

                                <li class="list-group-item d-flex justify-content-between">
                                    <span class="fw-semibold">@lang('Rating')</span>
                                    <span>{{ $review->rating }}</span>
                                </li>

                                <li class="list-group-item d-flex justify-content-between">
                                    <span class="fw-semibold">@lang('Time') </span>
                                    <em class="text-muted">{{ showDateTime($review->created_at) }}</em>
                                </li>

                                <li class="list-group-item d-flex justify-content-between">
                                    <span class="fw-semibold">@lang('Status')</span>
                                    <span>@php echo $review->statusBadge @endphp</span>
                                </li>

                                @if ($review->reject_reason && $review->status == Status::REVIEW_REJECTED)
                                    <li class="list-group-item">
                                        <span class="fw-semibold">@lang('Reason of Rejection')</span>
                                        <p class="text--warning lh-sm">
                                            {{ $review->reject_reason }}
                                        </p>
                                    </li>
                                @endif


                                <li class="list-group-item d-flex justify-content-end gap-2">
                                    @if ($review->status != Status::REVIEW_REJECTED)
                                        <button class="btn btn-sm btn--danger rejectBtn" data-action="{{ route('admin.products.reviews.reject', $review->id) }}" data-question="@lang('Are you sure to reject this review?')"><i class="las la-times"></i>@lang('Reject')</button>
                                    @endif

                                    @if ($review->status != Status::REVIEW_APPROVED)
                                        <button class="btn btn-sm btn--success confirmationBtn" data-action="{{ route('admin.products.reviews.approve', $review->id) }}" data-question="@lang('Are you sure to approve this review?')">
                                            <i class="las la-check"></i>@lang('Approve')
                                        </button>
                                    @endif
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-xl-8 col-md-6 mb-30">
                    <div class="card overflow-hidden box--shadow1">
                        <div class="card-body">
                            <div class="product-reviews">
                                <div class="product-review-list">
                                    <div class="product-review-list-item">
                                        <div class="product-review-list-item__header d-flex flex-wrap align-items-center justify-content-between mb-2">
                                            <div class="d-flex align-items-center gap-2">
                                                <img class="thumb" src="{{ getAvatar(getFilePath('userProfile') . '/' . $review->user->image) }}" alt="profile image">
                                                <h6 class="name">{{ $review->user->fullname }}</h6>
                                            </div>
                                        </div>

                                        <div class="text-warning font-20 mb-2">
                                            @php echo displayRating($review->rating) @endphp
                                        </div>

                                        <p>@php echo nl2br($review->review) @endphp</p>

                                        @if (!blank($review->productReviewImage))
                                            <div class="review-attachment">
                                                @foreach ($review->productReviewImage ?? [] as $reviewImage)
                                                    <a class="review-attachment__img review-gallery" href="{{ getImage(getFilePath('review') . '/' . $reviewImage->image) }}">
                                                        <img src="{{ getImage(getFilePath('review') . '/' . $reviewImage->image) }}" alt="reply">
                                                    </a>
                                                @endforeach
                                            </div>
                                        @endif
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    @php
                        $reply = $review->productReviewReply;
                        $oldImages = [];
                    @endphp

                    @if ($reply)
                        <div class="card mt-3" id="replyCard">
                            <div class="card-header d-flex justify-content-between align-items-start">
                                <div>
                                    @lang('Replied By') <h6 class="name d-inline">{{ @$reply->admin->name }}</h6>
                                    <br>
                                    <small class="text-muted">{{ diffForHumans($reply->updated_at) }}</small>
                                </div>

                                <button class="btn btn--light border editReplyBtn"><i class="la la-pencil"></i>@lang('Edit Reply')</button>
                            </div>
                            <div class="card-body">

                                <p class="desc">
                                    @php echo nl2br($reply->comment) @endphp
                                </p>

                                @if (!blank($reply->productReviewReplyImage))
                                    <div class="review-attachment">
                                        @foreach ($reply->productReviewReplyImage ?? [] as $reviewReplyImage)
                                            @php
                                                array_push($oldImages, [
                                                    'id' => $reviewReplyImage->id,
                                                    'src' => getImage(getFilePath('review') . '/' . $reviewReplyImage->image),
                                                ]);
                                            @endphp

                                            <a class="review-attachment__img review-gallery" href="{{ getImage(getFilePath('review') . '/' . $reviewReplyImage->image) }}">
                                                <img src="{{ getImage(getFilePath('review') . '/' . $reviewReplyImage->image) }}" alt="reply">
                                            </a>
                                        @endforeach
                                    </div>
                                @endif
                            </div>
                        </div>
                    @endif

                    <div class="card mt-3 @if ($reply) d-none @endif" id="replyForm">
                        <div class="card-body">

                            <div class="mb-3 d-flex justify-content-between">
                                <h6>@lang('Your Reply')</h6>
                                @if ($reply)
                                    <button class="btn btn--light" id="cancelReplyUpdate"><i class="la la-times m-0"></i></button>
                                @endif
                            </div>

                            <form action="{{ route('admin.products.reviews.reply', $review->id) }}" method="post" enctype="multipart/form-data">
                                @csrf
                                <div class="form-group">
                                    <textarea name="comment" class="form-control" rows="3" placeholder="@lang('Write your reply here')">{{ old('comment', @$reply->comment) }}</textarea>
                                </div>

                                <div data-extensions=".png, .jpg, .jpeg" id="photos" data-input_name="images" data-max_files="10" data-old_input_name="old_images" data-old_files='@json($oldImages)'>
                                    <x-file-uploader />
                                </div>

                                <div class="text-end">
                                    <button type="submit" class="btn btn--primary"><i class="las la-reply"></i>@lang('Reply to Review')</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <x-confirmation-modal />
    <x-confirmation-modal id="reviewRejectModal" buttonClass="rejectBtn">
        <div class="form-group mb-0 mt-2">
            <label>@lang('Reason of Rejection')</label>
            <textarea name="reject_reason" rows="4" required></textarea>
        </div>
    </x-confirmation-modal>
@endsection

@push('breadcrumb-plugins')
    <x-back route="{{ route('admin.products.reviews.index') }}" />
@endpush

@push('style-lib')
    <link rel="stylesheet" href="{{ asset(activeTemplate(true) . 'css/xzoom/magnific-popup.css') }}">
@endpush

@push('script-lib')
    <script src="{{ asset(activeTemplate(true) . 'js/xzoom/magnific-popup.js') }}"></script>
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";
            let oldImages = @json($oldImages);

            $('.review-gallery').on("click", function() {
                $('.review-attachment').each(function() {
                    $(this).magnificPopup({
                        delegate: 'a',
                        type: 'image',
                        gallery: {
                            enabled: true
                        }
                    });
                });
            });

            $('.editReplyBtn').on('click', function() {
                $('#replyCard').addClass('d-none');
                $('#replyForm').removeClass('d-none');
            });

            $('#cancelReplyUpdate').on('click', function() {
                $('#replyCard').removeClass('d-none');
                $('#replyForm').addClass('d-none');
            });
        })(jQuery);
    </script>
@endpush

@push('style')
    <style>
        .thumb {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            flex-shrink: 0;
        }

        @media screen and (max-width: 575px) {
            .thumb {
                width: 30px;
                height: 30px;
            }
        }

        .review-attachment {
            margin-top: 16px;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 8px;
        }

        .review-attachment__img {
            width: 80px;
            height: 80px;
            border: 1px solid #ebebebb0;
            border-radius: 3px;
            padding: 5px;
            display: block;
        }

        .review-attachment__img img {
            width: 100% !important;
            height: 100%;
            display: block;
            object-fit: cover;
        }
    </style>
@endpush
