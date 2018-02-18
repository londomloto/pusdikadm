<?php
namespace Micro\Office;

class Spreadsheet {

    private $__2007 = TRUE;
    private $__book = NULL;

    public function __construct($template = FALSE) {
        if ($template) {
            $this->__book = \PhpOffice\PhpSpreadsheet\IOFactory::load($template);
            if (preg_match('/\.xls$/', $template)) {
                $this->__2007 = FALSE;
            }
        } else {
            $this->__book = new \PhpOffice\PhpSpreadsheet\Spreadsheet();

            $this->__book->getProperties()
                ->setCreator('spreadsheet')
                ->setLastModifiedBy('spreadsheet')
                ->setTitle('spreadsheet')
                ->setSubject('spreadsheet')
                ->setDescription('spreadsheet')
                ->setKeywords('spreadsheet')
                ->setCategory('spreadsheet');

            $this->__book->getDefaultStyle()
                ->getFont()
                ->setName('Arial')
                ->setSize(10);
        }

    }

    public function __call($method, $args) {
        return call_user_func_array(array($this->__book, $method), $args);
    }

    public function stream($filename = NULL) {
        if (empty($filename)) {
            if ($this->__2007) {
                $filename = 'download.xlsx';
                $format = 'Xlsx';
            } else {
                $filename = 'download.xls';
                $format = 'Xls';
            }
        } else {
            $format = preg_match('/\.xlsx$/', $filename) ? 'Xlsx' : 'Xls';
        }

        if ($format == 'Xlsx') {
            header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        } else {
            header('Content-Type: application/vnd.ms-excel');
        }

        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        header('Cache-Control: max-age=1');
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
        header('Cache-Control: cache, must-revalidate');
        header('Pragma: public');

        $writer = \PhpOffice\PhpSpreadsheet\IOFactory::createWriter($this->__book, $format);
        $writer->save('php://output');

        exit();
    }

}