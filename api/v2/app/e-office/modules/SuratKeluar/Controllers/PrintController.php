<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\SuratKeluar,
    App\Company\Models\Company,
    Micro\Office\Spreadsheet,
    Micro\Office\Pdf;

class PrintController extends \Micro\Controller {

    public function documentAction($format, $id) {
        $method = '__document'.ucfirst(strtolower($format));
        $this->$method($id);
    }

    public function reportAction($format) {
        $method = '__report'.ucfirst(strtolower($format));
        $this->$method();
    }

    private function __documentPdf($id) {
        $data = SuratKeluar::get($id)->data;

        if ( ! $data) {
            throw new \Phalcon\Exception("Not Found", 404);
        }

        $html = $this->view->render('suratkeluar', array(
            'company' => Company::getDefault()->toArray(),
            'data' => $data->toArray()
        ));

        $pdf = new Pdf();
        $pdf->loadHtml($html);
        $pdf->setPaper('A4');

        $pdf->render();
        $pdf->stream('suratkeluar_'.$data->tsk_id.'.pdf');
    }

    private function __documentXls($id) {
        $data = SuratKeluar::get($id)->data;

        if ( ! $data) {
            throw new \Phalcon\Exception("Not Found", 404);
        }

        $company = Company::getDefault()->toArray();
        $data = $data->toArray();

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/suratkeluar.xlsx');
        
        $xls->getActiveSheet()
            ->setCellValue('A1', $company['scp_name'])
            ->setCellValue('A2', $company['scp_address'])
            ->setCellValue('A3', 'Telp. '.$company['scp_phone'].' Fax. '.$company['scp_fax'])
            ->setCellValue('A8', $data['tsk_seq'])
            ->setCellValue('B8', $data['tsk_send_date_formatted'])
            ->setCellValue('A10', $data['tsk_summary'])
            ->setCellValue('A12', $data['tsk_from'])
            ->setCellValue('B12', $data['tsk_to'])
            ->setCellValue('A14', $data['tsk_date_formatted'])
            ->setCellValue('B14', $data['tsk_no'])
            ->setCellValue('A16', $data['tsk_admin']);

        $xls->stream('suratkeluar_'.$data['tsk_id'].'.xlsx');
    }

    private function __reportPdf() {

    }

    private function __reportXls() {

    }

}