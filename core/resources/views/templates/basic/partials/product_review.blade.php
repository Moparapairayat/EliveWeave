@forelse($reviews as $item)
    <div class="review-item d-flex flex-wrap flex-sm-nowrap">
        <div class="thumb d-none d-sm-block">
            <img src="{{ getImage(null) }}" data-src="{{ getAvatar('assets/images/user/profile/' . $item->user->image) }}" class="lazyload" alt="@lang('review')">
        </div>
        <div class="content">
            <div class="d-flex gap-3 align-items-start">
                <div class="thumb d-sm-none">
                    <img src="{{ getImage(null) }}" data-src="{{ getAvatar('assets/images/user/profile/' . $item->user->image) }}" class="lazyload" alt="@lang('review')">
                </div>

                <div class="w-100 entry-meta">
                    <h6 class="posted-by">
                        <span class="w-100 d-inline-flex flex-wrap align-items-center justify-content-between gap-1">
                            <span>{{ @$item->user->fullname }} </span>
                            <span class="w-auto posted-on fs-14">{{ diffForHumans($item->created_at) }}</span>
                        </span>
                    </h6>
                    <div class="ratings">@php echo displayRating($item->rating) @endphp</div>
                </div>
            </div>

            <p class="mt-3 mt-sm-0 mb-0">
                @php echo nl2br($item->review) @endphp
            </p>

            @if (!blank($item->productReviewImage))
                <div class="review--image flex-wrap review-gallery mt-3" id="galleryParent{{ $item->id }}">
                    @foreach ($item->productReviewImage as $productReviewImage)
                        <a href="{{ getImage(getFilePath('review') . '/' . $productReviewImage->image) }}">
                            <img src="{{ getImage(getFilePath('review') . '/' . $productReviewImage->image) }}" alt="Product review">
                        </a>
                    @endforeach
                </div>
            @endif

            <div class="review-reply-items">
                @if (!blank($item->productReviewReply))
                    @php
                        $reply = $item->productReviewReply;
                    @endphp
                    <div class="review-area my-3 mb-md-4" data-reply-id="{{ $reply->id }}">
                        <div class="review-item d-flex ">
                            <div class="thumb">
                                <img src="{{ siteFavicon() }}" data-src="{{ siteFavicon() }}" class="lazyload" alt="review">
                            </div>
                            <div class="content">
                                <div class="entry-meta">
                                    <h6 class="posted-by">
                                        <span class="d-inline-flex flex-wrap align-items-center gap-1">{{ __(gs('site_name')) }}</span>
                                        <span class="posted-on fs-14">{{ diffForHumans($reply->updated_at) }}</span>
                                    </h6>
                                </div>
                                <div class="d-flex gap-3">
                                    <p class="review-item__reply-msg mb-0">
                                        @php echo nl2br($reply->comment) @endphp
                                    </p>
                                </div>
                                @if (!blank($reply->productReviewReplyImage))
                                    <div class="review--image flex-wrap review-gallery mt-3" id="galleryParent4">
                                        @foreach ($reply->productReviewReplyImage as $reviewReplyImage)
                                            <a href="{{ getImage(getFilePath('review') . '/' . $reviewReplyImage->image) }}">
                                                <img src="{{ getImage(getFilePath('review') . '/' . $reviewReplyImage->image) }}" alt="Product review">
                                            </a>
                                        @endforeach
                                    </div>
                                @endif
                            </div>
                        </div>
                    </div>
                @endif
            </div>
        </div>
    </div>
@empty
    <h6 class="text-muted text-center">
        @lang('No reviews yet for this product')
    </h6>
@endforelse



@if ($reviews->currentPage() != $reviews->lastPage())
    <button type="button" class="load-more-btn" id="loadMoreBtn" data-url="{{ $reviews->nextPageUrl() }}">@lang('See More Reviews')</button>
@endif
