<div class="input-images"></div>
@once
    @push('style-lib')
        <link rel="stylesheet" href="{{ asset('assets/global/css/image-uploader.min.css') }}">
    @endpush

    @push('script-lib')
        <script src="{{ asset('assets/global/js/image-uploader.min.js') }}"></script>
    @endpush

    @push('script')
        <script>
            (function($) {
                "use strict";
                $('.input-images').each((i, element) => initImageUploader(element));
            })
            (jQuery);

            function initImageUploader(element) {
                const data = $(element).parent().data();
                const params = {}

                if (data.input_name) {
                    params.filesName = data.input_name
                }

                if (data.old_input_name) {
                    params.preloadedInputName = data.old_input_name
                }

                if (data.max_files) {
                    params.maxFiles = data.max_files
                }

                if (data.extensions) {
                    params.extensions = data.extensions.split(", ").map(item => item.trim());
                }

                if (data.old_files) {
                    params.preloaded = data.old_files
                }

                $(element).fileUploader(params);

                if(data.extensions){
                    $(element).append(`
                        <small class="form-text text-muted mt-1 d-block">
                            <i class="las la-info-circle"></i> @lang('Supported files:') ${data.extensions}
                        </small>
                    `);
                }

                if(data.max_files){
                    $(element).append(`
                        <small class="form-text text-muted mt-1 d-block">
                            <i class="las la-info-circle"></i> @lang('You can upload a maximum of') ${data.max_files} @lang('files')
                        </small>
                    `);
                }
            }
        </script>
    @endpush
@endonce
