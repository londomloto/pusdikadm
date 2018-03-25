<?php
namespace App\Lkh\Controllers;

use App\Items\Models\Item;
use App\Lkh\Models\LkhItem;
use App\Lkh\Models\LkhFile;
use Micro\Helpers\Date as DateHelper;

class LkhItemsController extends \Micro\Controller {

    public function findAction() {

        $lookup = $this->request->getQuery('lookup');
        $search = $this->request->getQuery('query');

        switch($lookup) {
            case 'lkh':

                $query = Item::get()
                    ->alias('a')
                    ->columns(array(
                        'MIN(b.lki_id) AS lki_id',
                        'a.ti_id AS lki_ti_id',
                        'MIN(a.ti_desc) AS lki_desc',
                        'SUM(b.lki_volume) AS lki_volume',
                        'MIN(b.lki_unit) AS lki_unit',
                        'SUM(b.lki_cost) as lki_cost'
                    ))
                    ->join('App\Lkh\Models\LkhItem', 'a.ti_id = b.lki_ti_id', 'b', 'left')
                    ->andWhere('a.ti_type = :type:', array('type' => 'lkh')) 
                    ->groupBy('a.ti_id');

                if ( ! empty($search)) {
                    $query->andWhere('UPPER(a.ti_desc) LIKE :search:', array('search' => '%'.strtoupper($search).'%'));
                }

                $result = $query->paginate();
                return $result;

            case 'skp':

                $query = LkhItem::get()
                    ->alias('a')    
                    ->columns(array(
                        'MIN(a.lki_id) AS lki_id',
                        'a.lki_ti_id',
                        'MIN(a.lki_desc) AS lki_desc',
                        'SUM(a.lki_volume) AS lki_volume',
                        'MIN(a.lki_unit) AS lki_unit',
                        'SUM(a.lki_cost) AS lki_cost',
                        'MIN(b.lkd_date) AS lki_start_date',
                        'MAX(b.lkd_date) AS lki_end_date'
                    ))
                    ->join('App\Lkh\Models\LkhDay', 'a.lki_lkd_id = b.lkd_id', 'b', 'LEFT') 
                    ->groupBy('a.lki_ti_id');

                if ( ! empty($search)) {
                    $query->andWhere('UPPER(a.lki_desc) LIKE :search:', array('search' => '%'.strtoupper($search).'%'));
                }

                $result = $query->paginate();

                $result = $result->map(function($row){
                    $data = $row->toArray();
                    $data['lki_cost'] = (double)$data['lki_cost'] > 0 ? $data['lki_cost'] : NULL;

                    $start = DateHelper::create($row->lki_start_date);
                    $end = DateHelper::create($row->lki_end_date);
                    $diff = floor($start->from($end)->getMonths()) + 1;

                    $data['lki_duration'] = $diff;
                    $data['lki_duration_unit'] = 'bulan';

                    return $data;
                });

                return $result;
            default:
                return LkhItem::get()
                    ->join('App\Lkh\Models\Lkh', 'lki_lkh_id = lkh_id', '', 'LEFT')
                    ->filterable()
                    ->sortable()
                    ->paginate();
        }
        
    }


    public function createAction() {
        $user = $this->auth->user();
        $post = $this->request->getJson();

        if ( ! isset($post['lki_ti_id'])) {
            $item = new Item();

            $item->ti_desc = $post['lki_desc'];
            $item->ti_user = $user['su_id'];
            $item->ti_type = 'lkh';    


            if ($item->save()) {
                $item = $item->refresh();
                $post['lki_ti_id'] = $item->ti_id;
            }
        }

        $data = new LkhItem();

        if ($data->save($post)) {
            return LkhItem::get($data->lki_id);
        }

        return LkhItem::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = LkhItem::get($id);

        if ($query->data) {
            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $data = LkhItem::get($id)->data;
        
        if ($data) {
            $data->delete();
        }

        return array(
            'success' => TRUE
        );
    }

    public function uploadAction($id) {
        $item = LkhItem::get($id)->data;
        
        if ($item) {

            $success = $this->uploader->initialize(array(
                'path' => APPPATH.'public/resources/lkh/',
                'encrypt' => TRUE
            ))->upload();

            if ($success) {
                $upload = $this->uploader->getResult();

                $file = new LkhFile();
                
                $file->lkf_lki_id = $id;
                $file->lkf_file = $upload->filename;
                $file->lkf_orig = $upload->origname;
                $file->lkf_size = $upload->filesize;
                $file->lkf_mime = $upload->filetype;

                $file->save();
                $file = $file->refresh();

                return array(
                    'success' => TRUE,
                    'data' => $file->toArray()
                );
            }
        }

        return array(
            'success' => FALSE
        );
    }
}