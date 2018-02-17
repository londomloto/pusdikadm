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

        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\Disposition',
            'tsmf_tsm_id',
            array(
                'alias' => 'Dispositions',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasOne(
            'tsm_tcs_id',
            'App\Classifications\Models\Classification',
            'tcs_id',
            array(
                'alias' => 'Classification'
            )
        );

        $this->hasOne(
            'tsm_reg_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Registrar'
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
        $data['tsm_reg_date_formatted'] = self::__formatDate($this->tsm_reg_date);

        if ($this->registrar) {
            $data['tsm_reg_user_name'] = $this->registrar->getName();
        }

        if ($this->classification) {
            $data['tsm_tcs_name'] = $this->classification->tcs_name;
            $data['tsm_tcs_label'] = $this->classification->tcs_code.' - '.$this->classification->tcs_name;
        }

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

    public function saveDispositions($items) {
        $create = array();
        $remove = array();

        $exists = array();

        foreach($this->dispositions as $e) {
            $exists[$e->tsmf_id] = TRUE;
        }

        foreach($items as $e) {
            if ( ! isset($e['tsmf_id'])) {
                $create[] = $e;
            } else {
                unset($exists[$e['tsmf_id']]);
            }
        }

        $exists = array_values(array_keys($exists));

        if (count($exists) > 0) {
            Disposition::get()
                ->inWhere('tsmf_id', $exists)
                ->execute()
                ->delete();
        }

        foreach($create as $e) {
            $disp = new Disposition();
            $e['tsmf_tsm_id'] = $this->tsm_id;
            $disp->save($e);
        }
    }

    private static function __formatDate($date) {
        $moment = new \Moment\Moment($date);
        return $moment->format('d M Y');
    }
}