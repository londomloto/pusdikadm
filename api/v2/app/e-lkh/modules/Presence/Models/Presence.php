<?php
namespace App\Presence\Models;

class Presence extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'tpr_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'User'
            )
        );
    }

    public function getSource() {
        return 'trx_presence';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tpr_date_formatted'] = date('d M Y', strtotime($this->tpr_date));
        $data['tpr_checkin'] = empty($data['tpr_checkin']) ? '-' : $data['tpr_checkin'];
        $data['tpr_desc'] = empty($data['tpr_desc']) ? '-' : $data['tpr_desc'];
        $data['tpr_file'] = empty($data['tpr_file']) ? '-' : $data['tpr_file'];

        if ($this->user) {
            $user = $this->user->toArray();

            $data['tpr_su_fullname'] = $user['su_fullname'];
            $data['tpr_su_sj_name'] = $user['su_sj_name'];
            $data['tpr_su_sdp_name'] = $user['su_sdp_name'];
        }

        return $data;
    }
}