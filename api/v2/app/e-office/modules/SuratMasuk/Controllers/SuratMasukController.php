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
}