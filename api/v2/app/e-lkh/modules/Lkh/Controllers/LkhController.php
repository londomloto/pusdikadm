<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\Lkh;

class LkhController extends \Micro\Controller {

    public function findAction() {
        $display = $this->request->getQuery('display');
        switch($display) {
            case 'report':
                $report = json_decode($this->request->getQuery('report'), TRUE);
                $query = Lkh::get();

                if (isset($report['user'])) {
                    $query->andWhere('lkh_su_id = :user:', array('user' => $report['user']));
                }

                if (isset($report['year'], $report['month']) && ! empty($report['year']) && ! empty($report['month'])) {
                    $query->andWhere('MONTH(lkh_date) = :month: AND YEAR(lkh_date) = :year:', array(
                        'year' => $report['year'],
                        'month' => $report['month']
                    ));
                }

                $result = $query->filterable()->sortable()->paginate();

                $result->map(function($row){
                    $data = $row->toArray();
                    $data['items'] = $row->getSortedItems()->filter(function($e){ return $e->toArray(); });
                    return $data;
                });

                return $result;
            default:
                return Lkh::get()->filterable()->sortable()->paginate();
        }
        
    }

    public function findByIdAction($id) {
        return Lkh::get($id);
    }

    public function daysAction() {
        
    }
    
    public function createAction() {
        $post = $this->request->getJson();
        $auth = $this->auth->user();
        
        $post['lkh_created_dt'] = date('Y-m-d H:i:s');
        $post['lkh_created_by'] = $auth['su_id'];

        $data = new Lkh();

        if ($data->save($post)) {
            if (isset($post['items'])) {
                $data->saveItems($post['items']);
            }

            return Lkh::get($data->lkh_id);
        }
        return Lkh::none();
    }

    public function updateAction($id) {
        $query = Lkh::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            if ($query->data->save($post)) {
                if (isset($post['items'])) {
                    $query->data->saveItems($post['items']);
                }
            }
        }

        return Lkh::get($id);
    }

    public function deleteAction($id) {
        $data = Lkh::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array('success' => $done);
    }
}