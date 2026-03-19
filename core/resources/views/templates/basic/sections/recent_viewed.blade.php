@php
    $content = getContent('recent_viewed.content', true);
@endphp

<div class="recently-viewed-section mt-60 mb-60">
    <div class="container">
        <div class="section-header left-style">
            <h5 class="title">{{ @$content->data_values?->title }}</h5>
        </div>
        <div class="offer-wrapper">
            <div class="product-wrapper recent-view"></div>
        </div>
    </div>
</div>

@push('script')
    <script>
        (function($) {
            "use strict";


            function showRecentlyViewed() {
                const config = {
                    days: {{ gs('recently_viewed_days') }},
                    limit: {{ gs('recently_viewed_items') }}
                };

                let viewedProducts = JSON.parse(localStorage.getItem("recentlyViewed")) || [];
                let recentViewSection = $(".recently-viewed-section");
                let recentViewContainer = $(".recent-view");
                let now = new Date().getTime();
                let maxAge = config.days * 24 * 60 * 60 * 1000;

                recentViewContainer.empty();

                // Filter by age
                viewedProducts = viewedProducts.filter(product => now - product.date < maxAge);

                // Limit number of items
                viewedProducts = viewedProducts.slice(0, config.limit);

                if (viewedProducts.length > 0) {
                    viewedProducts.forEach(function(product) {
                        let productHtml = `
                        <div class="product-card">
                            <div class="product-thumb">
                                <a href="${product.plink}">
                                    <img src="${product.pima}" alt="${product.pna}">
                                </a>
                            </div>
                            <div class="product-content">
                                <h6 class="title">
                                    <a href="${product.plink}">${product.pna}</a>
                                </h6>
                            </div>
                        </div>
                    `;
                        recentViewContainer.append(productHtml);
                    });
                    localStorage.setItem("recentlyViewed", JSON.stringify(viewedProducts));
                } else {
                    recentViewSection.remove();
                }
            }

            showRecentlyViewed();
        })(jQuery);
    </script>
@endpush
