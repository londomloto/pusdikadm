<?php
namespace App\Lkh\Models;

use Micro\Helpers\Date;

class LkhItem extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'lki_lkd_id',
            'App\Lkh\Models\LkhDay',
            'lkd_id',
            array(
                'alias' => 'LkhDay'
            )
        );

        $this->hasMany(
            'lki_id',
            'App\Lkh\Models\LkhFile',
            'lkf_lki_id',
            array(
                'alias' => 'Files',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_lkh_items';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['lki_text'] = $this->lki_desc;
        $data['lki_expand'] = FALSE;
        $data['lki_cost_formatted'] = '';
        
        if ( ! is_null($this->lki_cost)) {
            $data['lki_cost_formatted'] = number_format($this->lki_cost, 0, ',', '.');
        }
        
        if (($day = $this->lkhDay)) {
            $data['lki_date'] = $day->lkd_date;
            $data['lki_date_formatted'] = Date::format($day->lkd_date, 'd M Y');

            if (($task = $day->task)) {
                $data['lki_period'] = $task->lkh_period;
                $data['lki_link'] = $task->getLink();

                if (($user = $task->user)) {
                    $data['lki_su_fullname'] = $user->getName();
                    $data['lki_su_no'] = $user->su_no;
                }
            }
        }

        $data['files'] = $this->getFiles()->filter(function($model){
            $item = $model->toArray();
            return $item;
        });

        $data['lki_has_files'] = count($data['files']) > 0;

        return $data;
    }
}