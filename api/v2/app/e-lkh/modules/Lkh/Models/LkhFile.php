<?php
namespace App\Lkh\Models;

class LkhFile extends \Micro\Model {

    public function getSource() {
        return 'trx_lkh_files';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['lkf_url'] = \Micro\App::getDefault()->url->getBaseUrl().'public/resources/lkh/'.$this->lkf_file;
        
        return $data;
    }
}