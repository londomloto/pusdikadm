<?php
namespace App\Lkh\Models;

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
        $data['lki_cost_formatted'] = number_format($this->lki_cost, 0, ',', '.');
        $data['files'] = $this->getFiles()->filter(function($model){
            $item = $model->toArray();
            return $item;
        });

        $data['lki_has_files'] = count($data['files']) > 0;

        return $data;
    }
}