@extends('admin.layouts.app')
@section('panel')
    <div class="row gy-4">
        <div class="col-12">
            <div class="card">
                <div class="card-body px-0">
                    <h5 class="mb-2 px-3">@lang('Step by Step Guide')</h5>
                    <ol class="list-group list-group-flush list-group-numbered">
                        <li class="list-group-item">
                            <b>@lang('Download Template')</b>
                            <p>@lang('Download the preformatted template file in either CSV or Excel format. This file contains all the required fields, ensuring your product data is structured correctly for import.')</p>

                            <ul class="mt-2">
                                <li>
                                    <b>@lang('CSV Template')</b>:
                                    <a href="{{ asset('assets/files/template.csv') }}">
                                        @lang('Download CSV Template')
                                    </a>
                                </li>

                                <li>
                                    <b>@lang('Excel Template')</b>:
                                    <a href="{{ asset('assets/files/template.xlsx') }}">
                                        @lang('Download Excel Template')
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="list-group-item">
                            <b>@lang('Download Sample Files')</b>

                            <p>@lang('To assist you further, we’ve provided a sample file with example product data. This file can be used as a reference for how to structure your data in the template.')</p>

                            <ul class="mt-2">
                                <li>
                                    <b>@lang('Sample CSV File')</b>:
                                    <a href="{{ asset('assets/files/sample.csv') }}">
                                        @lang('Download Sample CSV')
                                    </a>
                                </li>
                                <li>
                                    <b>@lang('Sample Excel File')</b>:
                                    <a href="{{ asset('assets/files/sample.xlsx') }}">
                                        @lang('Download Excel Template')
                                    </a>
                                </li>
                            </ul>
                        </li>

                        <li class="list-group-item">
                            <b>@lang('Relational Data Collection')</b>
                            <p>
                                @lang('To retrieve the value of the') <strong>brand_id</strong>,
                                @lang('download brands')
                                <a href="{{ route('admin.brand.download') }}?type=csv">@lang('as CSV')</a> |
                                <a href="{{ route('admin.brand.download') }}?type=pdf">@lang('as PDF')</a>
                                <br>

                                @lang('To retrieve the value of the') <strong>categories</strong>,
                                @lang('download categories')
                                <a href="{{ route('admin.category.download') }}?type=csv">@lang('as CSV')</a> |
                                <a href="{{ route('admin.category.download') }}?type=pdf">@lang('as PDF')</a>
                                <br>

                                @lang('To retrieve the value of the') <strong>product_type</strong>,
                                @lang('download product types')
                                <a href="{{ route('admin.product.type.download') }}?type=csv">@lang('as CSV')</a> |
                                <a href="{{ route('admin.product.type.download') }}?type=pdf">@lang('as PDF')</a>
                                <br>

                                @lang('To retrieve the value of the') <strong>product_attributes</strong>,
                                @lang('download product types')
                                <a href="{{ route('admin.attribute.download') }}?type=csv">@lang('as CSV')</a> |
                                <a href="{{ route('admin.attribute.download') }}?type=pdf">@lang('as PDF')</a>
                                <br>

                                @lang('To retrieve the value of the') <strong>attribute_values</strong>,
                                @lang('download attribute values')
                                <a href="{{ route('admin.attribute.values.download') }}?type=csv">@lang('as CSV')</a> |
                                <a href="{{ route('admin.attribute.values.download') }}?type=pdf">@lang('as PDF')</a>
                                <br>

                                @lang('To retrieve the value of the ') <strong>main_image_id</strong> & <strong>gallery_images</strong>,
                                <a href="{{ route('admin.media') }}?show_id=1">@lang('View Media Files')</a>
                            </p>
                        </li>

                        <li class="list-group-item">
                            <b>@lang('Prepare Your Data')</b>
                            <p>
                                @lang('Download the provided template and fill in your product details.') @lang('Make sure to review the ') <a href="#fields-info">@lang('Field Information and Instructions')</a>
                                @lang('before entering your data.')
                            </p>
                        </li>

                        <li class="list-group-item">
                            <b>@lang('Upload the File')</b>
                            <p>@lang('Once you\'ve completed the template, return to this page and upload the CSV or Excel file.')</p>

                            <div class="uploader-wrapper">
                                <form action="{{ route('admin.products.import.store') }}" method="POST" enctype="multipart/form-data" id="addForm">
                                    @csrf
                                    <input type="file" name="file" class="w-100 px-0 mb-1 shadow-none" accept=".csv, .xls, .xlsx">
                                    <button type="submit" class="btn btn--primary" id="submitButton">
                                        <i class="la la-upload"></i> @lang('Upload File')
                                    </button>
                                </form>
                            </div>
                        </li>
                    </ol>

                    <p class="px-3 mt-2">
                        <b>@lang('Note')</b>
                        <br>
                        * @lang('You need to manually generate variants for each variable product.')
                        <br>
                        * @lang('For downloadable products, you must manually select the option and upload the files.')
                    </p>
                </div>
            </div>
        </div>

        <div class="col-12">
            <div class="card" id="fields-info">
                <div class="card-body">
                    <h5 class="mb-3">@lang('Field Information and Instructions')</h5>
                    <div class="mt-1 table-responsive">
                        <table class="table table-bordered">
                            <thead class="bg--secondary">
                                <tr>
                                    <th class="bg--dark">@lang('Field Name')</th>
                                    <th class="bg--dark text-start">@lang('Description')</th>
                                    <th class="bg--dark text-start">@lang('Is Required')</th>
                                    <th class="bg--dark text-start">@lang('Example')</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th>@lang('Name')</th>
                                    <td>@lang('The name of the product that will be displayed on the store')</td>
                                    <td>@lang('Yes')</td>
                                    <td>@lang('iPhone 15 Pro Max')</td>
                                </tr>
                                <tr>
                                    <th>@lang('Slug')</th>
                                    <td>@lang('A unique, URL-friendly identifier for the product. Ensure to check the existing product slugs, as it must be unique.')
                                        <br>
                                        <em class="text--info">@lang('Must be unique')</em>
                                    </td>
                                    <td>@lang('Yes')</td>
                                    <td>@lang('iphone-15-pro-max')</td>
                                </tr>
                                <tr>
                                    <th>@lang('Brand ID')</th>
                                    <td>
                                        @lang('The numerical ID representing the product brand')<br>
                                        <em class="text--info">@lang('Must exist in the brands list')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <th>@lang('Categories')</th>
                                    <td>
                                        @lang('A list of category IDs associated with the product, separated by commas')<br>
                                        <em class="text--info">@lang('These IDs must exist in the categories list')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>1,2</td>
                                </tr>
                                <tr>
                                    <th>@lang('Product Type')</th>
                                    <td>
                                        @lang('Defines whether the product is simple or variable.')<br>
                                        <em class="text--info">@lang('1 for Simple Product, 2 for Variable Product')</em>
                                    </td>
                                    <td>@lang('Yes')</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <th>@lang('Product Attributes')</th>
                                    <td>@lang('List of attribute IDs used for variations, applicable only for variable products')</td>
                                    <td>@lang('Required if Product Type = 2')</td>
                                    <td>1,2</td>
                                </tr>
                                <tr>
                                    <th>@lang('Attributes Values')</th>
                                    <td>
                                        @lang('A mapping of attribute IDs to their respective values.')<br>
                                        <em class="text--info">
                                            @lang('For example, "1:3,4|2:5,6" means that attribute ID 1 has values 3 and 4, and attribute ID 2 has values 5 and 6')
                                        </em>
                                    </td>
                                    <td>@lang('Required if Product Type = 2')</td>
                                    <td>1:3,4|2:5,6</td>
                                </tr>
                                <tr>
                                    <th>@lang('Regular Price')</th>
                                    <td>@lang('The standard selling price of the product before any discounts')</td>
                                    <td>@lang('Yes')</td>
                                    <td>100</td>
                                </tr>
                                <tr>
                                    <th>@lang('Sale Price')</th>
                                    <td>@lang('The discounted price of the product, if applicable')</td>
                                    <td>@lang('No')</td>
                                    <td>90</td>
                                </tr>
                                <tr>
                                    <th>@lang('Sale Starts From')</th>
                                    <td>
                                        @lang('The starting date and time when the sale price becomes active')
                                        <br>
                                        <em class="text--info">@lang('Format: m/d/Y h:i A')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>14/01/2025 10:00 AM</td>
                                </tr>
                                <tr>
                                    <th>@lang('Sale Ends At')</th>
                                    <td>
                                        @lang('The ending date and time when the sale price expires')
                                        <br>
                                        <em class="text--info">@lang('Format: m/d/Y h:i A')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>13/02/2025 11:59 PM</td>
                                </tr>
                                <tr>
                                    <th>@lang('Track Inventory')</th>
                                    <td>
                                        @lang('Indicates whether the stock of this product should be tracked')
                                        <br>
                                        <em class="text--info"> @lang('1 for Yes, 0 for No')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <th>@lang('SKU')</th>
                                    <td>@lang('A unique Stock Keeping Unit (SKU) for inventory management')</td>
                                    <td>@lang('No')</td>
                                    <td>IPH15PM123</td>
                                </tr>
                                <tr>
                                    <th>@lang('In Stock')</th>
                                    <td>@lang('The available stock quantity of the product. Leave it empty or set it to 0 if the stock is initially unavailable')</td>
                                    <td>@lang('No')</td>
                                    <td>50</td>
                                </tr>
                                <tr>
                                    <th>@lang('Alert Quantity')</th>
                                    <td>
                                        @lang('The minimum stock level at which the admin will receive a low-stock alert')

                                    </td>
                                    <td>@lang('No')</td>
                                    <td>5</td>
                                </tr>
                                <tr>
                                    <th>@lang('Main Image ID')</th>
                                    <td>@lang('The ID of the main product image in the media files')
                                        <br>
                                        <em class="text--info">@lang('Must be exists in the media files')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>101</td>
                                </tr>
                                <tr>
                                    <th>@lang('Gallery Images')</th>
                                    <td>@lang('A comma-separated list of media IDs for additional product images') <br>
                                        <em class="text--info">@lang('Must be exists in the media files')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>102,103,104</td>
                                </tr>
                                <tr>
                                    <th>@lang('Video Link')</th>
                                    <td>@lang('A YouTube embed link showcasing the product')</td>
                                    <td>@lang('No')</td>
                                    <td>https://www.youtube.com/embed/WOb4cj7izpE</td>
                                </tr>
                                <tr>
                                    <th>@lang('Summary')</th>
                                    <td>@lang('A brief overview of the product highlighting key features')</td>
                                    <td>@lang('No')</td>
                                    <td>@lang('Powerful smartphone with advanced features')</td>
                                </tr>
                                <tr>
                                    <th>@lang('Description')</th>
                                    <td>@lang('A detailed description of the product, including specifications and features')</td>
                                    <td>@lang('No')</td>
                                    <td>@lang('Includes A17 chip, 48MP camera, titanium build')</td>
                                </tr>
                                <tr>
                                    <th>@lang('Meta Title')</th>
                                    <td>@lang('The SEO-friendly title for the product page')</td>
                                    <td>@lang('No')</td>
                                    <td>@lang('Buy iPhone 15 Pro Max Online')</td>
                                </tr>
                                <tr>
                                    <th>@lang('Meta Description')</th>
                                    <td>@lang('A short SEO description that appears in search results')</td>
                                    <td>@lang('No')</td>
                                    <td>@lang('Get the best price on iPhone 15 Pro Max')</td>
                                </tr>
                                <tr>
                                    <th>@lang('Meta Keywords')</th>
                                    <td>@lang('A comma-separated list of SEO keywords relevant to the product')</td>
                                    <td>@lang('No')</td>
                                    <td>@lang('iPhone 15, Apple, smartphone')</td>
                                </tr>
                                <tr>
                                    <th>@lang('Is Published')</th>
                                    <td>
                                        @lang('Defines whether the product is published or saved as a draft')
                                        <br>
                                        <em class="text--info">@lang('1 for Published, 0 for Draft')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>1</td>
                                </tr>
                                <tr>
                                    <th>@lang('Show In Products Page')</th>
                                    <td>
                                        @lang('Controls whether the product appears on the products page')
                                        <br>
                                        <em class="text--info">@lang('1 for Yes, 0 for No')</em>
                                    </td>
                                    <td>@lang('No')</td>
                                    <td>1</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection

@push('style')
    <style>
        .table td,
        .table td:last-child {
            text-align: left
        }

        .table td {
            white-space: nowrap;
        }

        .border-dotted {
            border-style: dotted !important
        }

        .uploader-wrapper {
            padding: 1rem;
            margin-top: 1rem;
            border: 1px dashed #a7a7a7;
            border-radius: .625rem;
        }
    </style>
@endpush
