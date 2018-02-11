<?php
namespace App\SuratKeluar\Models;

use Phalcon\Mvc\Model\Relation;

class SuratKeluar extends \Micro\Model {

    public function initialize() {
        $this->hasMany(
            'tsk_id',
            'App\SuratKeluar\Models\Document',
            'tskd_tsk_id',
            array(
                'alias' => 'Documents',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_surat_keluar';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsk_code'] = empty($this->tsk_code) ? '-' : $this->tsk_code;
        $data['tsk_date_formatted'] = self::__formatDate($this->tsk_date);
        $data['tsk_create_date_formatted'] = self::__formatDate($this->tsk_create_date);

        

        return $data;
    }

    public function saveDocuments($items) {
        $create = array();
        $remove = array();

        $exists = array();

        foreach($this->documents as $e) {
            $exists[$e->tskd_id] = TRUE;
        }

        foreach($items as $e) {
            if ( ! isset($e['tskd_id'])) {
                $create[] = $e;
            } else {
                unset($exists[$e['tskd_id']]);
            }
        }

        $exists = array_values(array_keys($exists));

        if (count($exists) > 0) {
            Document::get()
                ->inWhere('tskd_id', $exists)
                ->execute()
                ->delete();
        }

        foreach($create as $e) {
            $doc = new Document();
            $e['tskd_tsk_id'] = $this->tsk_id;
            $doc->save($e);
        }
    }

    private static function __formatDate($date) {
        $moment = new \Moment\Moment($date);
        return $moment->format('d M Y');
    }
}