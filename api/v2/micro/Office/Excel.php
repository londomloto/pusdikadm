<?php
namespace Micro\Office;

class Excel {

    private $__book = NULL;
    private $__2007 = FALSE;

    public function __construct($template = FALSE) {
        if ( $template ) {
            if (preg_match('/\.xlsx$/', $template)) {
                $this->__2007 = TRUE;
            }
        }

        $this->__book = new \ExcelBook('Said M Fahmi', 'win-edd01c7891abac1006082d3240p0d7u5', $this->__2007);

        if ( $template ) {
            $this->__book->loadFile($template);
        }
    }

    public function __call($method, $args = array()) {
        return call_user_func_array(array($this->__book, $method), $args);
    }

    public function stream($filename = NULL) {

        $text = $this->__book->save();
        $size = strlen($text);

        if ($this->__2007) {
            header('Content-Type: Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        } else {
            header('Content-Type: application/vnd.ms-excel');
        }

        if (empty($filename)) {
            $filename = $this->__2007 ? 'download.xlsx' : 'download.xls';
        }

        header('Content-Type: application/vnd.ms-excel');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
        header('Cache-Control: cache, must-revalidate');
        header('Pragma: public');

        echo $text;
        exit();
    }

}