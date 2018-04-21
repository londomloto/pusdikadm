<?php
namespace App\Departments\Models;

class Department extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'sdp_evaluator',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Evaluator'
            )
        );

        $this->hasOne(
            'sdp_examiner',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Examiner'
            )
        );
    }

    public function getSource() {
        return 'sys_departments';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['evaluator_su_fullname'] = '';
        $data['examiner_su_fullname'] = '';

        if (($evaluator = $this->evaluator)) {
            $data['evaluator_su_fullname'] = $evaluator->getName();
        }

        if (($examiner = $this->examiner)) {
            $data['examiner_su_fullname'] = $examiner->getName();
        }

        return $data;
    }

}