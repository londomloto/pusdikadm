<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\Disposition;

class DispositionsController extends \Micro\Controller {

    public function findAction() {
        return Disposition::get()->filterable()->paginate();
    }

    public function createAction() {
        $data = new Disposition();
        $post = $this->request->getJson();

        if ($data->save($post)) {
            if (isset($post['users'])) {
                $data->saveUsers($post['users']);
            }
            return Disposition::get($data->tsmf_id);
        }

        return Disposition::none();
    }

    public function updateAction($id) {
        $query = Disposition::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            if ($query->data->save($post)) {
                if (isset($post['users'])) {
                    $query->data->saveUsers($post['users']);
                }
            }
        }

        return $query;
    }

    public function deleteAction($id) {
        $query = Disposition::get($id);
        
        if ($query->data) {
            $query->data->delete();
        }

        return array(
            'success' => TRUE
        );
    }
}