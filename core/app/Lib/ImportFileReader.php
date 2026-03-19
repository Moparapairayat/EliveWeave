<?php

namespace App\Lib;

use Exception;
use PhpOffice\PhpSpreadsheet\IOFactory;
use Illuminate\Support\Facades\Log; // Log facade for error logging

/**
 * Class ImportFileReader
 *
 * This class handles the importing of data from various file types (CSV, XLSX, TXT),
 * including the validation of headers and reading the data for further processing.
 */
class ImportFileReader {

    /**
     * @var array List of expected column names in the uploaded file.
     */
    public $columns = [];

    /**
     * @var string|null The model name associated with the data to be imported.
     */
    public $modelName;

    /**
     * The uploaded file.
     */
    public $file;

    /**
     * @var array Supported file extensions (CSV, XLSX, TXT).
     */
    public $fileSupportedExtension = ['csv', 'xlsx', 'txt'];

    /**
     * @var array The data read from the file.
     */
    public $allData = [];

    /**
     * @var array A collection of unique data from the file.
     */
    public $allUniqueData = [];

    /**
     * ImportFileReader constructor.
     *
     * Initializes the class with the uploaded file and an optional model name.
     *
     * @param mixed $file The uploaded file.
     * @param string|null $modelName The name of the model (optional).
     */
    public function __construct($file, $modelName = null) {
        $this->file = $file;
        $this->modelName = $modelName;
    }

    /**
     * Reads the file based on its extension.
     *
     * Delegates the reading process to the appropriate method based on the file extension.
     * It supports CSV, XLSX, and TXT file types.
     *
     * @return ImportFileReader Returns the instance of ImportFileReader for further chaining.
     * @throws Exception If the file extension is not supported.
     */
    public function readFile() {
        $fileExtension = strtolower($this->fileExtension());

        if ($fileExtension == 'csv') {
            return $this->readCsvFile();
        } elseif ($fileExtension == "xlsx") {
            return $this->readExcelFile();
        } elseif ($fileExtension == 'txt') {
            return $this->readTextFile();
        }
    }

    /**
     * Reads the CSV file.
     *
     * Opens and reads the CSV file line by line, validates the headers, and processes the data.
     *
     * @return ImportFileReader Returns the instance of ImportFileReader for further chaining.
     * @throws Exception If the file cannot be opened or the data is invalid.
     */
    public function readCsvFile() {
        if (($file = fopen($this->file, "r")) === false) {
            $this->exceptionSet("Unable to open CSV file.");
        }

        $fileHeader = fgetcsv($file);
        $this->validateFileHeader($fileHeader);
        $this->columns = $fileHeader;

        while (($row = fgetcsv($file)) !== false) {
            if ($row !== null) {
                $this->dataReadFromFile($row);
            }
        }

        fclose($file);
        return $this;
    }

    /**
     * Reads the Excel file (XLSX).
     *
     * Uses PhpSpreadsheet to load and read the data from an Excel file.
     *
     * @return ImportFileReader Returns the instance of ImportFileReader for further chaining.
     * @throws Exception If the file cannot be read or the data is invalid.
     */
    public function readExcelFile() {
        try {
            $spreadsheet = IOFactory::load($this->file);
            $data = $spreadsheet->getActiveSheet()->toArray();
        } catch (Exception $e) {
            $this->exceptionSet("Error reading Excel file: " . $e->getMessage());
        }

        if (count($data) <= 0) {
            $this->exceptionSet("File cannot be empty.");
            return 0;
        }

        $fileHeader = array_filter(@$data[0]);
        $this->validateFileHeader($fileHeader);
        $this->columns = $fileHeader;
        unset($data[0]);

        if(empty($data)){
            $this->exceptionSet("File cannot be empty.");
        }

        foreach ($data as $row) {
            $this->dataReadFromFile($row);
        }

        return $this;
    }

    public function readTextFile() {
        $fileContents = file_get_contents($this->file);
        $fileContents = explode(PHP_EOL, $fileContents);

        // Handle empty file edge case
        if (empty($fileContents)) {
            $this->exceptionSet("No data found to import");
        }

        $fileHeader = explode(',', trim($fileContents[0]));
        $this->validateFileHeader($fileHeader);
        $this->columns = $fileHeader;
        unset($fileContents[0]);

        foreach ($fileContents as $content) {
            $row = explode(',', trim($content));
            $this->dataReadFromFile($row);
        }

        return $this;
    }

    public function fileExtension() {
        $fileExtension = strtolower($this->file->getClientOriginalExtension());
        if (!in_array($fileExtension, $this->fileSupportedExtension)) {
            $this->exceptionSet("File type not supported.");
        }
        return $fileExtension;
    }

    public function validateFileHeader(array $fileHeader) {
        $fileHeader = array_map('trim', $fileHeader);
        $expectedColumns = array_map('trim', $this->columns);

        $missingColumns = array_diff($expectedColumns, $fileHeader);
        $extraColumns = array_diff($fileHeader, $expectedColumns);

        if (!empty($missingColumns)) {
            $this->exceptionSet("Missing required columns: " . implode(', ', $missingColumns));
        }

        if (!empty($extraColumns)) {
            $this->exceptionSet("Unexpected columns found: " . implode(', ', $extraColumns));
        }
    }

    public function dataReadFromFile($data) {
        if (gettype($data) != 'array') {
            return 0;
        }

        if(empty(array_filter($data))) {
            $this->exceptionSet("No data found to import");
            return 0;
        }

        if (count($data) != count($this->columns)) {
            $this->exceptionSet('Invalid data format.');
            return 0;
        }

        $this->allData[] = array_combine($this->columns, $data);
    }

    public function exceptionSet($exception) {
        throw new Exception($exception);
    }

    public function getReadData() {
        return $this->allData;
    }

    public function notifyMessage() {
        $notify = (object) $this->notify;
        return $notify;
    }
}
