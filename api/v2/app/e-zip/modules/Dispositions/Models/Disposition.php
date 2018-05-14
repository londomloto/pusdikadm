<?php
namespace App\Dispositions\Models;

use App\Users\Models\User;

class Disposition extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'stp_responsible',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Responsible'
            )
        );
    }

    public function getSource() {
        return 'sys_dispositions';
    }

    public function beforeSave() {
        $this->nulled(array(
            'stp_job',
            'stp_responsible'
        ));
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['subordinates'] = array();
        $data['stp_position'] = NULL;
        $data['responsible_su_fullname'] = NULL;

        if (($responsible = $this->responsible)) {
            $data['stp_position'] = $responsible->getJobName();
            $data['responsible_su_fullname'] = $responsible->getName();
        }

        if ( ! empty($data['stp_subordinates'])) {
            $data['subordinates'] = json_decode($data['stp_subordinates'], TRUE);
        }

        $data['flows'] = array();
        if ( ! empty($data['stp_flows'])) {
            $data['flows'] = json_decode($data['stp_flows'], TRUE);
        }

        return $data;
    }

    public function toArrayTemplate() {
        $data = $this->toArray();
        

        foreach($data['subordinates'] as &$sub) {
            $user = User::findFirst(array(
                'su_sj_id = :job:',
                'bind' => array(
                    'job' => $sub['su_sj_id']
                )
            ));

            $sub['su_id'] = NULL;
            $sub['su_fullname'] = NULL;

            if ($user) {
                $sub['su_id'] = $user->su_id;
                $sub['su_fullname'] = $user->getName();
            }
        }

        return $data;
    }

}