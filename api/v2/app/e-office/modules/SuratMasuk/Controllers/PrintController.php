<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\SuratMasuk,
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
        $data = SuratMasuk::get($id)->data;
        
        if ( ! $data) {
            throw new \Phalcon\Exception("Not Found", 404);
        }

        $html = $this->view->render('suratmasuk', array(
            'company' => Company::getDefault()->toArray(),
            'data' => $data->toArray(),
            'dispositions' => $data->dispositions->filter(function($d){
                return $d->toArray();
            })
        ));

        $pdf = new Pdf();
        $pdf->loadHtml($html);
        $pdf->setPaper('A4');

        $pdf->render();
        $pdf->stream('suratmasuk_'.$data->tsm_id.'.pdf');
    }

    private function __documentXls($id) {

        $data = SuratMasuk::get($id)->data;

        if ( ! $data) {
            throw new \Phalcon\Exception("Not Found", 404);
        }

        $disp = $data->dispositions->filter(function($d){
            return $d->toArray();
        });

        $data = $data->toArray();
        $comp = Company::getDefault()->toArray();

        
        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/suratmasuk.xlsx');

        $sheet = $xls->getSheet(0);

        $sheet
            ->setCellValue('A1', $comp['scp_name'])
            ->setCellValue('A2', $comp['scp_address'])
            ->setCellValue('A3', 'Telp. '.$comp['scp_phone'].' Fax. '.$comp['scp_fax']);

        $sheet
            ->setCellValue('A8', $data['tsm_seq'])
            ->setCellValue('C8', $data['tsm_reg_date_formatted'])
            ->setCellValue('E8', $data['tsm_reg_no'])
            ->setCellValue('A10', $data['tsm_summary'])
            ->setCellValue('A12', $data['tsm_from'])
            ->setCellValue('D12', $data['tsm_to'])
            ->setCellValue('A14', $data['tsm_date_formatted'])
            ->setCellValue('D14', $data['tsm_no'])
            ->setCellValue('A16', $data['tsm_admin']);

        $temp = $xls->getSheetByName('LEMBAR DISPOSISI TPL');
        
        $temp
            ->setCellValue('A1', $comp['scp_name'])
            ->setCellValue('A2', $comp['scp_address'])
            ->setCellValue('A3', 'Telp. '.$comp['scp_phone'].' Fax. '.$comp['scp_fax']);

        $temp
            ->setCellValue('A8', $data['tsm_seq'])
            ->setCellValue('C8', $data['tsm_reg_date_formatted'])
            ->setCellValue('E8', $data['tsm_reg_no'])
            ->setCellValue('B9', $data['tsm_from'])
            ->setCellValue('B10', $data['tsm_summary'])
            ->setCellValue('B11', $data['tsm_date_formatted'])
            ->setCellValue('B12', $data['tsm_no']);

        $index = 1;

        foreach($disp as $item) {
            $copy = clone $temp;
            $copy->setCellValue('A14', $item['tsmf_content']);
            
            if ($index === 1) {
                $copy->setTitle('LEMBAR DISPOSISI');
            } else {
                $copy->setTitle('LEMBAR DISPOSISI - '.$i);
            }

            $users = '';
            $count = 1;

            foreach($item['users'] as $user) {
                $users .= $count.') '.$user['tsmfu_su_fullname']."\n";
                $count++;
            }

            $copy->setCellValue('D14', $users);

            $xls->addSheet($copy);

            $index++;
        }

        // remove sheet template
        $tempIndex = $xls->getIndex($temp);
        $xls->removeSheetByIndex($tempIndex);


        $xls->setActiveSheetIndex(0);
        $xls->stream('suratmasuk_'.$data['tsm_id'].'.xlsx');
    }

    private function __reportPdf() {

    }

    private function __reportXls() {
        
    }

}