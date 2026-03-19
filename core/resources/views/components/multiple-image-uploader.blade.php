@props(['oldImages' => []])

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
                $('.input-images').each((i, element) => {
                    const data = $(element).parent().data();

                    $(element).fileUploader({
                        preloaded: data.images,
                        filesName: 'photos',
                        preloadedInputName: 'old',
                        maxFiles: data.max_files
                    });
                });
            })(jQuery);
        </script>
    @endpush
@endonce
