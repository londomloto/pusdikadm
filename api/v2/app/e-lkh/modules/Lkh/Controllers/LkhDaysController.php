<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\LkhDay;

class LkhDaysController extends \Micro\Controller {

    public function findAction() {
        return LkhDay::get()->filterable()->paginate();
    }

    public function createAction() {
        $user = $this->auth->user();
        $post = $this->request->getJson();

        $post['lkd_created_dt'] = date('Y-m-d H:i:s');
        $post['lkd_created_by'] = $user['su_id'];

        $data = new LkhDay();

        if ($data->save($post)) {
            return LkhDay::get($data->lkd_id);
        }

        return LkhDay::none();
    }

    public function updateAction($id) {

    }

    public function deleteAction($id) {
        $data = LkhDay::get($id)->data;

        if ($data) {
            $lkh = $data->getTask();

            if ($data->delete()) {
                if ( ! is_null($lkh)) {
                    $this->socket->broadcast('live', array(
                        'type' => 'lkh_outstanding',
                        'user' => $lkh->lkh_su_id,
                        'task' => $lkh->lkh_id,
                        'date' => $data->lkd_date
                    ));
                }
            }
        }

        return array(
            'success' => TRUE
        );
    }
}