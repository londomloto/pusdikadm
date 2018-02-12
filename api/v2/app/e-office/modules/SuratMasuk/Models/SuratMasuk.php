<?php
namespace App\SuratMasuk\Models;

use Phalcon\Mvc\Model\Relation;

class SuratMasuk extends \Micro\Model {

    public function initialize() {
        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\Document',
            'tsmd_tsm_id',
            array(
                'alias' => 'Documents',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_surat_masuk';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsm_code'] = empty($this->tsm_code) ? '-' : $this->tsm_code;
        $data['tsm_date_formatted'] = self::__formatDate($this->tsm_date);
        $data['tsm_receive_date_formatted'] = self::__formatDate($this->tsm_receive_date);

        return $data;
    }

    public function saveDocuments($items) {
        $create = array();
        $remove = array();

        $exists = array();

        foreach($this->documents as $e) {
            $exists[$e->tsmd_id] = TRUE;
        }

        foreach($items as $e) {
            if ( ! isset($e['tsmd_id'])) {
                $create[] = $e;
            } else {
                unset($exists[$e['tsmd_id']]);
            }
        }

        $exists = array_values(array_keys($exists));

        if (count($exists) > 0) {
            Document::get()
                ->inWhere('tsmd_id', $exists)
                ->execute()
                ->delete();
        }

        foreach($create as $e) {
            $doc = new Document();
            $e['tsmd_tsm_id'] = $this->tsm_id;
            $doc->save($e);
        }
    }

    private static function __formatDate($date) {
        $moment = new \Moment\Moment($date);
        return $moment->format('d M Y');
    }
}