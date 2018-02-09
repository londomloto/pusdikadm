<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\SuratMasuk,
    App\Sequence\Models\Sequence;

class SuratMasukController extends \Micro\Controller {

    public function sequenceAction() {
        return array(
            'success' => TRUE,
            'data' => array(
                'sequence' => Sequence::nextval('surat-masuk')
            )
        );
    }

    public function findByIdAction($id) {
        return SuratMasuk::get($id);
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
            $query->data->save($post);
        }

        return $query;
    }

}