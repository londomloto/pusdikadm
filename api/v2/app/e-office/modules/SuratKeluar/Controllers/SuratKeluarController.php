<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\SuratKeluar;

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
        return SuratKeluar::get($id);
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new SuratKeluar();

        if ($data->save($post)) {
            return SuratKeluar::get($data->tsk_id);
        }

        return SuratKeluar::none();
    }

    public function updateAction($id) {
        $query = SuratKeluar::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $query->data->save($post);
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
}