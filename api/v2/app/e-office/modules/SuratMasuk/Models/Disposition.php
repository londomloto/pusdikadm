<?php
namespace App\SuratMasuk\Models;

use Phalcon\Mvc\Model\Relation;

class Disposition extends \Micro\Model {

    public function initialize() {
        $this->hasMany(
            'tsmf_id',
            'App\SuratMasuk\Models\DispositionUser',
            'tsmfu_tsmf_id',
            array(
                'alias' => 'DispositionUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_surat_masuk_disp';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsmf_date_formatted'] = date('d M Y', strtotime($this->tsmf_date));

        $label = array();
        $users = array();
        $count = 0;

        foreach($this->dispositionUsers as $item) {
            $count++;
            $label[] = '('. $count .') '. ($item->user ? $item->user->getName() : '');
            $users[] = $item->toArray();
        }

        $data['tsmf_users'] = implode(' ', $label);
        $data['users'] = $users;

        return $data;
    }

    public function saveUsers($items) {
        $create = array();
        $remove = array();

        $exists = array();

        foreach($this->dispositionUsers as $e) {
            $exists[$e->tsmfu_id] = TRUE;
        }

        foreach($items as $e) {
            if ( ! isset($e['tsmfu_id'])) {
                $create[] = $e;
            } else {
                unset($exists[$e['tsmfu_id']]);
            }
        }

        $exists = array_values(array_keys($exists));

        if (count($exists) > 0) {
            DispositionUser::get()
                ->inWhere('tsmfu_id', $exists)
                ->execute()
                ->delete();
        }

        foreach($create as $e) {
            $item = new DispositionUser();
            $e['tsmfu_tsmf_id'] = $this->tsmf_id;
            $item->save($e);
        }
    }
}