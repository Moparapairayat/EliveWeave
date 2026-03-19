@extends('admin.layouts.app')
@section('panel')
    <div class="row mb-none-30">
        <div class="col-lg-12 col-md-12 mb-30">
            <div class="card">
                <div class="card-body">
                    <form method="POST">
                        @csrf
                        <div class="row">
                            <div class="col-md-4 col-sm-6">
                                <div class="form-group">
                                    <label>@lang('Site Title')</label>
                                    <input class="form-control" type="text" name="site_name" required value="{{ gs('site_name') }}" required>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-6">
                                <div class="form-group">
                                    <label>@lang('Preloader Title')</label>
                                    <input class="form-control" type="text" name="preloader_title" required value="{{ gs('preloader_title') }}" required>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-6">
                                <div class="form-group ">
                                    <label>@lang('Currency')</label>
                                    <input class="form-control" type="text" name="cur_text" value="{{ gs('cur_text') }}" required>
                                </div>
                            </div>

                            <div class="col-md-4 col-sm-6">
                                <div class="form-group ">
                                    <label>@lang('Currency Symbol')</label>
                                    <input class="form-control" type="text" name="cur_sym" value="{{ gs('cur_sym') }}" required>
                                </div>
                            </div>

                            <div class="form-group col-md-4 col-sm-6">
                                <label>@lang('Timezone')</label>
                                <select class="select2 form-control" name="timezone" required>
                                    @foreach ($timezones as $key => $timezone)
                                        <option value="{{ $key}}" @selected($key == $currentTimezone)>{{ __($timezone) }}</option>
                                    @endforeach
                                </select>
                            </div>

                            <div class="form-group col-md-4 col-sm-6">
                                <label class="required"> @lang('Site Base Color')</label>
                                <div class="input-group">
                                    <span class="input-group-text p-0 border-0">
                                        <input type='text' class="form-control colorPicker" value="{{ gs('base_color') }}">
                                    </span>
                                    <input type="text" class="form-control colorCode" name="base_color" value="{{ gs('base_color') }}">
                                </div>
                            </div>

                            <div class="form-group col-md-4 col-sm-6">
                                <label>@lang('Record to Display Per page')</label>
                                <select class="select2 form-control" name="paginate_number" data-minimum-results-for-search="-1" required>
                                    <option value="20" @selected(gs('paginate_number') == 20)>@lang('20 items per page')</option>
                                    <option value="50" @selected(gs('paginate_number') == 50)>@lang('50 items per page')</option>
                                    <option value="100" @selected(gs('paginate_number') == 100)>@lang('100 items per page')</option>
                                </select>
                            </div>

                            <div class="form-group col-md-4 col-sm-6 ">
                                <label>@lang('Currency Showing Format')</label>
                                <select class="select2 form-control" name="currency_format" data-minimum-results-for-search="-1" required>
                                    <option value="1" @selected(gs('currency_format') == Status::CUR_BOTH)>@lang('Show Currency Text and Symbol Both')</option>
                                    <option value="2" @selected(gs('currency_format') == Status::CUR_TEXT)>@lang('Show Currency Text Only')</option>
                                    <option value="3" @selected(gs('currency_format') == Status::CUR_SYM)>@lang('Show Currency Symbol Only')</option>
                                </select>
                            </div>

                            <div class="form-group col-md-4 col-sm-6">
                                <div class="form-group">
                                    <label>@lang('Number of Recently Viewed Products')</label>
                                    <span title="@lang('Set how many recently viewed products you want to show to users. Set it to 0 to hide this section.')">
                                        <i class="la la-info-circle"></i>
                                    </span>
                                    <input class="form-control" type="number" name="recently_viewed_items" value="{{ gs('recently_viewed_items') }}" required>
                                </div>
                            </div>

                            <div class="form-group col-md-4 col-sm-6">
                                <div class="form-group">
                                    <label>@lang('Track Views From the Past (Days)')</label>
                                    <span title="@lang('Only show products viewed within the last X days. For example, setting it to 7 means products viewed in the last 7 days will be shown.')">
                                        <i class="la la-info-circle"></i>
                                    </span>
                                    <div class="input-group">
                                        <input class="form-control" type="number" name="recently_viewed_days" value="{{ gs('recently_viewed_days') }}" required>
                                        <span class="input-group-text">@lang('Days')</span>
                                    </div>
                                </div>
                            </div>

                        </div>

                        <button type="submit" class="btn btn--primary w-100 h-45">@lang('Submit')</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('script-lib')
    <script src="{{ asset('assets/admin/js/spectrum.js') }}"></script>
@endpush

@push('style-lib')
    <link rel="stylesheet" href="{{ asset('assets/admin/css/spectrum.css') }}">
@endpush

@push('script')
    <script>
        (function($) {
            "use strict";


            $('.colorPicker').spectrum({
                color: $(this).data('color'),
                change: function(color) {
                    $(this).parent().siblings('.colorCode').val(color.toHexString().replace(/^#?/, ''));
                }
            });

            $('.colorCode').on('input', function() {
                var clr = $(this).val();
                $(this).parents('.input-group').find('.colorPicker').spectrum({
                    color: clr,
                });
            });
        })(jQuery);
    </script>
@endpush
