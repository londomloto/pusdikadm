<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Skp;

class SkpController extends \Micro\Controller {

    public function findAction() {

    }

    public function findByIdAction($id) {
        return Skp::get($id);
    }
    
    public function createAction() {
        $post = $this->request->getJson();
        $year = date('Y', strtotime($post['skp_date']));

        $find = Skp::get()
            ->where(
                'YEAR(skp_date) = :year: AND skp_su_id = :user:',
                array(
                    'year' => $year,
                    'user' => $post['skp_su_id']
                )
            )
            ->execute();

        if ($find->count() > 0) {
            return array(
                'success' => FALSE,
                'message' => 'Dokumen SKP untuk tahun ' . $year .' sudah dibuat'
            );
        }

        $auth = $this->auth->user();
        
        $post['skp_created_dt'] = date('Y-m-d H:i:s');
        $post['skp_created_by'] = $auth['su_id'];

        $data = new Skp();

        if ($data->save($post)) {
            if (isset($post['items'])) {
                $data->saveItems($post['items']);
            }

            return Skp::get($data->skp_id);
        }
        return Skp::none();
    }

    public function updateAction($id) {
        $query = Skp::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            if ($query->data->save($post)) {
                if (isset($post['items'])) {
                    $query->data->saveItems($post['items']);
                }
            }
        }

        return Skp::get($id);
    }

    public function deleteAction($id) {
        $data = Skp::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array('success' => $done);
    }
}