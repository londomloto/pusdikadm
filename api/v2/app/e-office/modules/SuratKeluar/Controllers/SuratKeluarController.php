<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\SuratKeluar,
    App\SuratKeluar\Models\Document,
    App\Company\Models\Company;

class SuratKeluarController extends \Micro\Controller {

    public function sequenceAction() {
        return array(
            'success' => TRUE,
            'data' => \App\System\Models\Autonumber::generate('SK_SEQUENCE')
        );
    }

    public function findAction() {
        return SuratKeluar::get()->paginate();
    }

    public function findByIdAction($id) {
        $query = SuratKeluar::get($id);
        
        if ($query->data) {
            $data = $query->data->toArray();
            $data['documents'] = $query->data->documents->filter(function($e){ return $e->toArray(); });

            $query->data = $data;
        }

        return $query;
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new SuratKeluar();

        if ($data->save($post)) {
            if (isset($post['documents'])) {

                foreach($post['documents'] as $item) {
                    $doc = new Document();
                    $item['tskd_tsk_id'] = $data->tsk_id;
                    $doc->save($item);
                }
            }
            return SuratKeluar::get($data->tsk_id);
        }

        return SuratKeluar::none();
    }

    public function updateAction($id) {
        $query = SuratKeluar::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            if ($query->data->save($post)) {
                if (isset($post['documents'])) {
                    $query->data->saveDocuments($post['documents']);
                }
            }
        }

        return $query;
    }

    public function deleteAction($id) {
        $data = SuratKeluar::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array('success' => $done);
    }

    public function uploadAction() {

        $success = $this->uploader->initialize(array(
            'path' => APPPATH.'public/resources/documents/',
            'encrypt' => TRUE
        ))->upload();

        if ($success) {
            
            $result = $this->uploader->getResult();
            
            return array(
                'success' => TRUE,
                'data' => array(
                    'orig' => $result->origname,
                    'mime' => $result->filetype,
                    'file' => $result->filename,
                    'size' => $result->filesize,
                    'size_formatted' => $this->file->formatSize($result->filesize),
                    'file_url' => $this->url->getBaseUrl().'public/resources/documents/'.$result->filename
                )
            );
        } else {
            return array(
                'success' => FALSE,
                'message' => $this->uploader->getMessage()
            );
        }

    }

    public function downloadAction($id) {
        $data = SuratKeluar::get($id)->data;
        
        if ( ! $data) {
            throw new \Phalcon\Exception("Not Found", 404);
        }

        $format = $this->request->getQuery('format');

        switch($format) {
            case 'pdf':

                $html = $this->view->render('suratkeluar', array(
                    'company' => Company::getDefault()->toArray(),
                    'data' => $data->toArray()
                ));

                $pdf = new \Micro\Reports\Pdf();
                $pdf->loadHtml($html);
                $pdf->setPaper('A4');

                $pdf->render();
                $pdf->stream('suratkeluar_'.$data->tsk_id.'.pdf');

                exit();

            case 'xls':

                $company = Company::getDefault()->toArray();
                $data = $data->toArray();

                $xls = \Micro\Reports\Xls::load(dirname(__DIR__).'/Templates/suratkeluar.xlsx');

                $xls->getActiveSheet()
                    ->setCellValue('A1', $company['scp_name'])
                    ->setCellValue('A2', $company['scp_address'])
                    ->setCellValue('A3', 'Telp. '.$company['scp_phone'].' Fax. '.$company['scp_fax'])
                    ->setCellValue('A8', $data['tsk_seq'])
                    ->setCellValue('B8', $data['tsk_send_date_formatted'])
                    ->setCellValue('A10', $data['tsk_subject'])
                    ->setCellValue('A12', $data['tsk_from'])
                    ->setCellValue('B12', $data['tsk_to'])
                    ->setCellValue('A14', $data['tsk_date_formatted'])
                    ->setCellValue('B14', $data['tsk_no'])
                    ->setCellValue('A16', $data['tsk_admin']);

                $xls->stream('suratkeluar_'.$data['tsk_id'].'.xlsx');

                exit();
        }

    }
}