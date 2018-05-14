<?php
namespace App\Dispositions\Controllers;

use App\Dispositions\Models\Disposition;
use App\Users\Models\User;

class DispositionsController extends \Micro\Controller {

    public function findAction() {
        $display = $this->request->getQuery('display');
        $result = Disposition::get()->filterable()->sortable()->paginate();

        switch($display) {
            case 'template':
                return $result->filter(function($item){
                    return $item->toArrayTemplate();
                });
            default:
                return $result;
        }
        
    }

    public function findByIdAction($id) {
        $disp = Disposition::get($id)->data;
        if ($disp) {
            $data = $disp->toArray();

            foreach($data['subordinates'] as &$sub) {
                $user = User::findFirst(array(
                    'su_sj_id = :job:',
                    'bind' => array(
                        'job' => $sub['su_sj_id']
                    )
                ));

                $sub['su_id'] = NULL;
                $sub['su_fullname'] = NULL;

                if ($user) {
                    $sub['su_id'] = $user->su_id;
                    $sub['su_fullname'] = $user->getName();
                }
            }

            return array(
                'success' => TRUE,
                'data' => $data
            );

        }

        return array(
            'success' => FALSE,
            'data' => NULL
        );
    }

    public function createAction() {
        $post = $this->request->getJson();
        $data = new Disposition();

        if (isset($post['subordinates'])) {
            $post['stp_subordinates'] = json_encode($post['subordinates']);
        }

        if (isset($post['flows'])) {
            $post['stp_flows'] = json_encode($post['flows']);
        }

        if ($data->save($post)) {
            return Disposition::get($data->stp_id);
        }

        return Disposition::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = Disposition::get($id);

        if ($query->data) {

            if (isset($post['subordinates'])) {
                $post['stp_subordinates'] = json_encode($post['subordinates']);
            }

            if (isset($post['flows'])) {
                $post['stp_flows'] = json_encode($post['flows']);
            }

            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $data = Disposition::get($id)->data;
        $done = FALSE;
        
        if ($data) {
            $done = $data->delete();
        }

        return array(
            'success' => $done
        );
    }

}