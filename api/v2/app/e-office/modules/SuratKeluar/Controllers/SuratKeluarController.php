<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\SuratKeluar,
    App\SuratKeluar\Models\Document;

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
        if ($this->request->hasFiles()) {
            $files = $this->request->getFiles();
            $file = $files[0];
            $orig = $file->getName();
            $mime = $file->getType();
            $code = 'doc_'.md5_file($file->getTempname()).'.'.$file->getExtension();
            $path = APPPATH.'public/resources/documents/'.$code;

            if (@$file->moveTo($path)) {
                return array(
                    'success' => TRUE,
                    'data' => array(
                        'mime' => $mime,
                        'orig' => $orig,
                        'file' => $code
                    )
                );
            }
        }

        return array(
            'success' => FALSE
        );
    }
}