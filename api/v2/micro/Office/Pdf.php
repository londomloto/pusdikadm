<?php
namespace Micro\Office;

class Pdf {

    private $__engine;

    public function __construct() {
        $this->__engine = new \Dompdf\Dompdf();
    }

    public function __call($method, $args) {
        return call_user_func_array(array($this->__engine, $method), $args);
    }

    public function stream($filename = NULL) {
        $this->__engine->stream($filename);
        exit();
    }
}