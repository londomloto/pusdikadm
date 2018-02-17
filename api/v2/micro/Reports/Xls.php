<?php
namespace Micro\Reports;

use PhpOffice\PhpSpreadsheet\Spreadsheet,
    PhpOffice\PhpSpreadsheet\IOFactory;

class Xls {

    private $__engine;

    public function __construct(Spreadsheet $engine = NULL) {
        $this->__engine = is_null($engine) ? new Spreadsheet() : $engine;

        $this->__engine->getProperties()
            ->setCreator('pusdikadm')
            ->setLastModifiedBy('pusdikadm')
            ->setTitle('pusdikadm')
            ->setSubject('pusdikadm')
            ->setDescription('pusdikadm')
            ->setKeywords('pusdikadm')
            ->setCategory('pusdikadm');

        $this->__engine->getDefaultStyle()
            ->getFont()
            ->setName('Arial')
            ->setSize(10);
    }

    public function __call($method, $args) {
        return call_user_func_array(array($this->__engine, $method), $args);
    }

    public function stream($filename = 'download.xlsx') {

        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="'.$filename.'"');
        header('Cache-Control: max-age=0');
        header('Cache-Control: max-age=1');
        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
        header('Cache-Control: cache, must-revalidate');
        header('Pragma: public');

        $writer = IOFactory::createWriter($this->__engine, 'Xlsx');
        $writer->save('php://output');

        exit();
    }

    public static function load($template) {
        return new Xls(\PhpOffice\PhpSpreadsheet\IOFactory::load($template));
    }
}