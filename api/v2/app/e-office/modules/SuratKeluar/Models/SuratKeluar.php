<?php
namespace App\SuratKeluar\Models;

class SuratKeluar extends \Micro\Model {

    public function initialize() {
        
    }

    public function getSource() {
        return 'trx_surat_keluar';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tsk_date_formatted'] = self::__formatDate($this->tsk_date);
        return $data;
    }

    private static function __formatDate($date) {
        $moment = new \Moment\Moment($date);
        return $moment->format('d M Y');
    }
}