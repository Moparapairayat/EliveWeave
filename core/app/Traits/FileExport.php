<?php

namespace App\Traits;

use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Str;

/**
 * Trait FileExport
 *
 * Provides functionality to export model data to a CSV file.
 * To use, include this trait in an Eloquent model and call the `export()` method.
 */
trait FileExport {
    /**
     * @var string|null $fileName
     * The name of the CSV file to be generated. If not set, a default name is used based on the model.
     */
    public $fileName;

    /**
     * @var array|null $exportColumns
     * The specific columns to be included in the export. If not set, all columns will be exported.
     */
    public $exportColumns;

    /**
     * @var int|null Start ID for export range (inclusive).
     */
    public $startId;

    /**
     * @var int|null End ID for export range (inclusive).
     */
    public $endId;

    /**
     * @var string Order of the data retrieval based on the `id` field. Accepts 'asc' or 'desc'.
     */
    public $orderBy = 'desc';

    /**
     * Export the data to a CSV file and return it as a download response.
     *
     * @return \Symfony\Component\HttpFoundation\BinaryFileResponse|\Illuminate\Http\RedirectResponse
     */
    public function export() {
        $modelClass = get_class($this);
        $columns = $this->getColumnNames();

        // Build query
        $query = $modelClass::query();

        if ($this->startId && $this->endId) {
            $query->whereBetween('id', [$this->startId, $this->endId]);
        } elseif ($this->startId && !$this->endId) {
            $query->where('id', '>=', $this->startId);
        }

        // Select specific columns if set
        if ($this->exportColumns) {
            $query->select($this->exportColumns);
        }

        $query->orderBy('id', $this->orderBy);

        $data = $query->get();

        if ($data->isEmpty()) {
            $notify[] = ['warning', 'No data found'];
            return back()->withNotify($notify);
        }

        // Restrict columns if exportColumns is specified
        if ($this->exportColumns) {
            $columns = array_intersect($columns, $this->exportColumns);
        }

        // Generate file name if not set
        $fileName = $this->fileName ?? Str::slug(class_basename($this)) . '-export.csv';
        $filePath = storage_path("app/{$fileName}");
        $fp = fopen($filePath, 'w');

        // Write CSV header
        fputcsv($fp, $columns);

        // Write each data row
        foreach ($data as $item) {
            $row = [];
            foreach ($columns as $column) {
                $value = $item->$column;
                if (is_array($value) || is_object($value)) {
                    $value = json_encode($value);
                }
                $row[] = $value;
            }
            fputcsv($fp, $row);
        }

        fclose($fp);

        return response()->download($filePath)->deleteFileAfterSend(true);
    }

    public static function getColumnNames() {
        $modelClass = get_class();
        $tableName = app($modelClass)->getTable();
        $columns   = Schema::getColumnListing($tableName);
        return $columns;
    }
}
