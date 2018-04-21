<?php
namespace App\Lkh\Models;

use Micro\Helpers\Date as DateHelper;

class LkhDay extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'lkd_lkh_id',
            'App\Lkh\Models\Task',
            'lkh_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->hasMany(
            'lkd_id',
            'App\Lkh\Models\LkhItem',
            'lki_lkd_id',
            array(
                'alias' => 'Items',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasOne(
            'lkd_tpr_id',
            'App\Presence\Models\Presence',
            'tpr_id',
            array(
                'alias' => 'Presence'
            )
        );

        $this->hasOne(
            'lkd_created_by',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );
    }

    public function getSource() {
        return 'trx_lkh_days';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['lkd_date_formatted'] = DateHelper::format($this->lkd_date, 'd M Y');
        $data['lkd_created_dt_formatted'] = DateHelper::format($this->lkd_created_dt);
        
        if ($this->presence) {
            $data['lkd_tpr_date_formatted'] = DateHelper::format($this->presence->tpr_date, 'd M Y');
        }

        $date = DateHelper::create($this->lkd_date);

        $data['folder'] = array(
            'name' => $this->lkd_date,
            'time' => $date->getTimestamp(),
            'd' => $date->format('d'),
            'm' => $date->format('M'),
            'y' => $date->format('Y')
        );

        $data['input'] = new \stdClass();

        $data['items'] = $this->getItems()->filter(function($model){
            return $model->toArray();
        });

        if (($creator = $this->creator)) {
            $data['creator_su_fullname'] = $creator->getName();
        }

        $data['lkd_busy'] = FALSE;

        return $data;
    }

    public function getSortedItems() {
        return $this->getItems(array('order' => 'lki_id DESC'));
    }

    public function saveItems($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->items as $model) {
            $current[$model->lki_id] = $model;
        }

        foreach($post as $item) {
            if ( ! isset($item['lki_id'])) {
                $created[] = $item;
            } else if (isset($current[$item['lki_id']])) {
                $model = $current[$item['lki_id']];
                $model->save($item);
                
                unset($current[$item['lki_id']]);
            }
        }

        if (count($current) > 0) {
            foreach($current as $model) {
                $model->delete();
            }
        }

        if (count($created) > 0) {
            foreach($created as $item) {
                if ( ! empty($item['lki_desc'])) {
                    $model = new LkhItem();
                    $item['lki_lkd_id'] = $this->lkd_id;
                    $model->save($item);
                }
            }
        }
        
    }
}