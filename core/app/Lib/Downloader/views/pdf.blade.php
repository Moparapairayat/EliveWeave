<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <title>{{ $pageTitle }}</title>
    <style>
        body {
            font-family: DejaVu Sans, sans-serif;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th,
        td {
            border: 1px solid #000;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f0f0f0;
        }
    </style>
</head>

<body>
    @if ($pageTitle)
        <h2>{{ $pageTitle }}</h2>
    @endif

    <table>
        <thead>
            <tr>
                @foreach ($headings as $heading)
                    <th>{{ $heading }}</th>
                @endforeach
            </tr>
        </thead>
        <tbody>
            @foreach ($data as $item)
                <tr>
                    @foreach ($columns as $column)
                        <td>{{ $item->$column }}</td>
                    @endforeach
                </tr>
            @endforeach
        </tbody>
    </table>

</body>

</html>
