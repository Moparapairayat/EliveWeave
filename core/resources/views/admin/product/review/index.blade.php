@extends('admin.layouts.app')

@section('panel')
    <div class="row">
        <div class="col-lg-12">
            <div class="card b-radius--10">
                <div class="table-responsive--md table-responsive">
                    <table class="table table--light style--two">
                        <thead>
                            <tr>
                                <th>@lang('Product')</th>
                                <th>@lang('User')</th>
                                <th>@lang('Rating')</th>
                                <th>@lang('Date')</th>
                                <th>@lang('Status')</th>
                                <th>@lang('Action')</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($reviews as $review)
                                <tr  @class(['bg-light' => $review->is_viewed == Status::NO])>
                                    <td>
                                        <a href="{{ route('admin.products.reviews.index') }}?product={{ $review->product->slug }}">{{ $review->product->name }}</a>
                                    </td>

                                    <td>
                                        <a href="{{ route('admin.products.reviews.index') }}?user={{ $review->user->username }}">{{ $review->user->username }}</a>
                                    </td>

                                    <td>{{ $review->rating }}</td>

                                    <td>{{ showDateTime($review->created_at, 'd M, Y h:i A') }}</td>

                                    <td>@php echo $review->statusBadge @endphp</td>

                                    <td>
                                        <div class="button-group">
                                            <a href="{{ route('admin.products.reviews.view', $review->id) }}" type="button" class="btn btn-outline--primary btn-sm">
                                                <i class="la la-desktop"></i>@lang('View')
                                            </a>

                                            <button type="button" class="btn btn-sm btn-outline--{{ $review->trashed() ? 'success' : 'danger' }} confirmationBtn" data-action="{{ route('admin.products.reviews.delete', $review->id) }}" data-question="@lang($review->trashed() ? 'Are you sure to restore this review?' : 'Are you sure to delete this review?')" data-type="{{ $review->trashed() ? 'restore' : 'delete' }}" data-id='{{ $review->id }}'>
                                                <i class="la la-{{ $review->trashed() ? 'redo' : 'trash' }}"></i>@lang($review->trashed() ? 'Restore' : 'Delete')
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            @empty
                                <tr>
                                    <td class="text-muted text-center" colspan="100%">{{ __($emptyMessage) }}</td>
                                </tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
            @if ($reviews->hasPages())
                <div class="card-footer py-4">
                    {{ paginateLinks($reviews) }}
                </div>
            @endif

        </div>
    </div>
    </div>
    <x-confirmation-modal />
@endsection

@push('breadcrumb-plugins')
    @if (!request()->routeIs('admin.products.reviews.index'))
        @if (request()->routeIs('admin.products.trashed.search'))
            <div class="d-flex flex-wrap justify-content-end gap-2 align-items-center">
                <x-back route="{{ route('admin.products.reviews.trashed') }}"></x-back>
            </div>
        @else
            <div class="d-flex flex-wrap justify-content-end gap-2 align-items-center">
                <x-back route="{{ route('admin.products.reviews.index') }}"></x-back>
            </div>
        @endif
    @endif

    @if (request()->routeIs('admin.products.reviews.index'))
        <div class="d-flex justify-content-end align-items-center flex-wrap gap-2 has-search-form">
            <select name="is_viewed" class="bg--white isViewed" form="search-form">
                <option value="">@lang('All')</option>
                <option value="0" @selected(request()->is_viewed === '0')>@lang('Not Viewed')</option>
                <option value="1" @selected(request()->is_viewed == 1)>@lang('Viewed')</option>
            </select>
            <x-search-form></x-search-form>
            <a href="{{ route('admin.products.reviews.trashed') }}" class="btn btn-sm btn-outline--danger"><i class="las la-trash-alt"></i>@lang('Trashed')</a>
        </div>
    @endif
@endpush

@push('script')
    <script>
        'use strict';
        (function($) {
            $('.isViewed').on('change', function() {
                $('#search-form').submit();
            });
        })(jQuery);
    </script>
@endpush
