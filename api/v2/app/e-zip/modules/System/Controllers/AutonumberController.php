<?php
namespace App\System\Controllers;

use App\System\Models\Autonumber;

class AutonumberController extends \Micro\Controller {

    public function findAction() {
        return Autonumber::get()->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $post['sn_date'] = date('Y-m-d');
        
        $name = trim($post['sn_name']);

        $data = Autonumber::findFirst(array(
            'UPPER(sn_name) = :name:',
            'bind' => array(
                'name' => strtoupper($name)
            )
        ));

        if ($data) {
            return array(
                'success' => TRUE,
                'data' => $data->toArray()
            );
        }

        $data = new Autonumber();
        $post['sn_name'] = strtoupper($post['sn_name']);

        if ($data->save($post)) {
            return Autonumber::get($data->sn_id);
        }

        return Autonumber::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();

        if (isset($post['sn_type']) && $post['sn_type'] == 'SYSTEM') {
            unset($post['sn_name']);
        }

        $query = Autonumber::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $data = Autonumber::get($id)->data;
        $done = FALSE;

        if ($data) {
            if ($data->sn_type != 'SYSTEM') {
                $done = $data->delete();
            }
        }

        return array(
            'success' => $done
        );
    }

    public function generateAction() {
        $code = $this->request->getQuery('code');
        $value = Autonumber::generate($code);
        
        return array(
            'success' => TRUE,
            'data' => $value
        );
    }
}