<?php
namespace App\SuratMasuk\Models;

class DispositionUser extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'tsmfu_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'User'
            )
        );
    }

    public function getSource() {
        return 'trx_surat_masuk_disp_users';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['tsmfu_su_fullname'] = '';
        
        if ($this->user) {
            $data['tsmfu_su_fullname'] = $this->user->getName();
        }
        
        return $data;
    }
}