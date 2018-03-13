<?php
namespace App\Lkh\Controllers;

use App\Items\Models\Item;
use App\Lkh\Models\LkhItem;
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
                        'SUM(IFNULL(b.lki_volume, 0)) AS lki_volume',
                        'MIN(b.lki_unit) AS lki_unit',
                        'SUM(IFNULL(b.lki_cost, 0)) as lki_cost'
                    ))
                    ->join('App\Lkh\Models\LkhItem', 'a.ti_id = b.lki_ti_id', 'b', 'left')
                    ->andWhere('b.ti_type = :type:', array('type' => 'lkh')) 
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
                        'MIN(b.lkh_date) AS lki_start_date',
                        'MAX(b.lkh_date) AS lki_end_date'
                    ))
                    ->join('App\Lkh\Models\Lkh', 'a.lki_lkh_id = b.lkh_id', 'b', 'LEFT')
                    ->groupBy('a.lki_ti_id');

                if ( ! empty($search)) {
                    $query->andWhere('UPPER(a.lki_desc) LIKE :search:', array('search' => '%'.strtoupper($search).'%'));
                }

                $result = $query->paginate();

                $result = $result->map(function($row){
                    $data = $row->toArray();

                    $start = DateHelper::create($row->lki_start_date);
                    $end = DateHelper::create($row->lki_end_date);
                    $diff = floor($start->from($end)->getMonths()) + 1;

                    $data['lki_duration'] = $diff;
                    $data['lki_duration_unit'] = 'bln';

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

}