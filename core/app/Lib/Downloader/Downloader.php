<?php

namespace App\Lib\Downloader;

use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Support\Facades\View;

class Downloader {
    public $filename;
    public $headings;
    public $columns;
    public $data;

    public function __construct($filename, $data, $columns, $headings) {
        $this->filename = $filename;
        $this->data = $data;
        $this->columns = $columns;
        $this->headings = $headings;
    }

    public function downloadAsCsv() {
        $filename = $this->filename . '.csv';
        $data = $this->data;

        return response()->stream(function () use ($data) {
            $file = fopen('php://output', 'w');

            echo "\xEF\xBB\xBF"; // UTF-8 BOM for Excel

            fputcsv($file, $this->headings); // CSV header

            foreach ($data as $row) {
                $fields = [];
                foreach ($this->columns as $column) {
                    $fields[] = $row[$column] ?? ''; // Fallback to empty if key missing
                }
                fputcsv($file, $fields);
            }

            fclose($file);
        }, 200, [
            'Content-Type' => 'text/csv; charset=UTF-8',
            'Content-Disposition' => "attachment; filename=\"$filename\"",
        ]);
    }

    public function downloadAsPdf($pageTitle = '') {
        $data = $this->data;
        $headings = $this->headings;
        $columns = $this->columns;

        View::addLocation(app_path('Lib/Downloader/views'));
        $pdf = Pdf::loadView('pdf', compact('data', 'headings', 'columns', 'pageTitle')); // Replace with actual view
        return $pdf->download($this->filename . '.pdf');
    }
}
