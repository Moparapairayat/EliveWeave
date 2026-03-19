@extends('admin.layouts.app')
@section('panel')
    <div class="card">
        <div class="card-body">
            <form method="post" action="{{ route('admin.products.export.store') }}" id="importForm" enctype="multipart/form-data">
                @csrf
                <div class="modal-body">
                    <div class="form-group">
                        <div class="form-check mb-2">
                            <input type="checkbox" class="form-check-input" id="all-columns">
                            <label class="form-check-label m-0 lh-1 fw-bold" for="all-columns">@lang('Select Columns')</label>
                        </div>
                        <div class="row g-0 gy-1">
                            @foreach ($columns as $column)
                                <div class="col-md-3 col-6 mb-1">
                                    <div class="form-check">
                                        <input type="checkbox" class="form-check-input" name="columns[]" value="{{ $column }}" id="column_{{ $column }}">
                                        <label class="form-check-label m-0 lh-1" for="column_{{ $column }}">
                                            {{ __(keyToTitle($column)) }}
                                        </label>
                                    </div>
                                </div>
                            @endforeach
                        </div>
                    </div>

                    <div class="form-group select2-parent">
                        <label class="fw-bold">@lang('ID Range')</label>
                        <span title="@lang('Enter the starting and ending product IDs you want to export. Leave both fields blank to export all products, or leave only the ending ID blank to export all from the starting ID onward.')"><i class="la la-info-circle"></i></span>
                        <div class="input-group">
                            <input type="number" class="form-control" name="from_id" placeholder="@lang('From ID')">
                            <input type="number" class="form-control" name="to_id" placeholder="@lang('To ID')">
                        </div>
                    </div>
                </div>
                <button type="Submit" class="btn btn--primary w-100 h-45 contactExport">@lang('Export')</button>
            </form>
        </div>
    </div>
@endsection

@push('script')
    <script>
        "use strict";
        document.addEventListener('DOMContentLoaded', function() {
            const selectAllCheckbox = document.getElementById('all-columns');
            const columnCheckboxes = document.querySelectorAll('input[name="columns[]"]');

            selectAllCheckbox.addEventListener('change', function() {
                columnCheckboxes.forEach(function(checkbox) {
                    checkbox.checked = selectAllCheckbox.checked;
                });
            });

            columnCheckboxes.forEach(function(checkbox) {
                checkbox.addEventListener('change', function() {
                    if (!this.checked) {
                        selectAllCheckbox.checked = false;
                    } else {
                        const allChecked = Array.from(columnCheckboxes).every(cb => cb.checked);
                        selectAllCheckbox.checked = allChecked;
                    }
                });
            });
        });
    </script>
@endpush
