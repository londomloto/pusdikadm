<?php
namespace App\SuratKeluar\Models;

use Micro\Helpers\Date;
use Phalcon\Mvc\Model\Relation;

class SuratKeluar extends \Micro\Model {

    public function initialize() {
        $this->hasMany(
            'tsk_id',
            'App\SuratKeluar\Models\SuratKeluarFile',
            'tskf_tsk_id',
            array(
                'alias' => 'Files',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasOne(
            'tsk_register_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Conceptor'
            )
        );

        $this->hasOne(
            'tsk_evaluator',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Evaluator'
            )
        );

        $this->hasOne(
            'tsk_examiner',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Examiner'
            )
        );

        $this->hasOne(
            'tsk_from_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Responsible'
            )
        );

        $this->hasOne(
            'tsk_from_job',
            'App\Jobs\Models\Job',
            'sj_id',
            array(
                'alias' => 'Origin'
            )
        );

        $this->hasOne(
            'tsk_category',
            'App\Categories\Models\Category',
            'sct_id',
            array(
                'alias' => 'Category'
            )
        );

        $this->hasOne(
            'tsk_shipment',
            'App\Shipments\Models\Shipment',
            'sdt_id',
            array(
                'alias' => 'Shipment'
            )
        );

        $this->hasOne(
            'tsk_secrecy',
            'App\Secrecy\Models\Secrecy',
            'sst_id',
            array(
                'alias' => 'Secrecy'
            )
        );

        $this->hasOne(
            'tsk_class',
            'App\Classifications\Models\Classification',
            'scl_id',
            array(
                'alias' => 'CLassification'
            )
        );

        $this->hasOne(
            'tsk_tsm_id',
            'App\SuratMasuk\Models\SuratMasuk',
            'tsm_id',
            array(
                'alias' => 'Correspondence'
            )
        );

    }

    public function getSource() {
        return 'trx_keluar';
    }

    public function beforeSave() {
        $this->nulled(array(
            'tsk_tsm_id',
            'tsk_register_date',
            'tsk_register_user',
            'tsk_date',
            'tsk_class',
            'tsk_category',
            'tsk_shipment',
            'tsk_secrecy',
            'tsk_from_job',
            'tsk_from_user',
            'tsk_task_due',
            'tsk_evaluator',
            'tsk_examiner',
            'tsk_delivery_date',
            'tsk_received_date'
        ));
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsk_date_formatted'] = Date::format($this->tsk_date, 'd M Y');
        $data['tsk_register_date_formatted'] = Date::format($this->tsk_register_date, 'd M Y');
        $data['tsk_delivery_date_formatted'] = Date::format($this->tsk_delivery_date, 'd M Y');
        $data['tsk_received_date_formatted'] = Date::format($this->tsk_received_date, 'd M Y');

        if (($origin = $this->origin)) {
            $data['origin_label'] = $origin->sj_code.' - '.$origin->sj_name;
        }

        if (($conceptor = $this->conceptor)) {
            $data['conceptor_su_fullname'] = $conceptor->getName();
        }

        if (($evaluator = $this->evaluator)) {
            $data['evaluator_su_fullname'] = $evaluator->getName();
        }

        if (($examiner = $this->examiner)) {
            $data['examiner_su_fullname'] = $examiner->getName();
        }

        if (($responsible = $this->responsible)) {
            $data['responsible_su_fullname'] = $responsible->getName();
        }

        if (($class = $this->classification)) {
            foreach($class->toArray() as $key => $val) {
                $data['class_'.$key] = $val;
            }
        }

        if (($category = $this->category)) {
            foreach($category->toArray() as $key => $val) {
                $data['category_'.$key] = $val;
            }
        }

        if (($shipment = $this->shipment)) {
            foreach($shipment->toArray() as $key => $val) {
                $data['shipment_'.$key] = $val;
            }
        }

        if (($secrecy = $this->secrecy)) {
            foreach($secrecy->toArray() as $key => $val) {
                $data['secrecy_'.$key] = $val;
            }
        }

        if (($corres = $this->correspondence)) {
            $data['corres_tsm_no'] = $corres->tsm_no;
            $data['corres_tsm_from'] = $corres->tsm_from;
            $data['corres_tsm_subject'] = $corres->tsm_subject;
            $data['corres_tsm_date_formatted'] = Date::format($corres->tsm_date, 'd M Y');
            $data['corres_tsm_register_date_formatted'] = Date::format($corres->tsm_register_date, 'd M Y');
            $data['corres_label'] = $corres->tsm_no.' ('.$data['corres_tsm_date_formatted'].')';
        }

        return $data;
    }

    public function saveFiles($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getFiles() as $file) {
            $current[$file->tskf_id] = $file;
        }

        foreach($post as $item) { 
            if ( ! isset($item['tskf_id'])) {
                $created[] = $item;
            } else if (isset($current[$item['tskf_id']])) {
                $updated[] = array(
                    'file' => $current[$item['tskf_id']],
                    'data' => $item
                );

                unset($current[$item['tskf_id']]);
            }
        }

        foreach($current as $key => $file) {
            $file->delete();
        }

        if (count($created) > 0) {
            foreach($created as $item) {
                $file = new SuratKeluarFile();
                $item['tskf_tsk_id'] = $this->tsk_id;
                $file->save($item);
            }
        }
    }
}