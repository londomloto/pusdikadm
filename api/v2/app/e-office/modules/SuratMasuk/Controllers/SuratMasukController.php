<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\SuratMasuk,
    App\SuratMasuk\Models\Document;

class SuratMasukController extends \Micro\Controller {

    public function sequenceAction() {
        return array(
            'success' => TRUE,
            'data' => \App\System\Models\Autonumber::generate('SM_SEQUENCE')
        );
    }

    public function findByIdAction($id) {
        $query = SuratMasuk::get($id);
        
        if ($query->data) {
            $data = $query->data->toArray();
            $data['documents'] = $query->data->documents->filter(function($e){ return $e->toArray(); });

            $query->data = $data;
        }

        return $query;
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new SuratMasuk();

        if ($data->save($post)) {
            return SuratMasuk::get($data->tsm_id);
        }

        return SuratMasuk::none();
    }

    public function updateAction($id) {
        $query = SuratMasuk::get($id);
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
        $data = SuratMasuk::get($id)->data;
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
            $code = 'tsmd_'.md5_file($file->getTempname()).'.'.$file->getExtension();
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