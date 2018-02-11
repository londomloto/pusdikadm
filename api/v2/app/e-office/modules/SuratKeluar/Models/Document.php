<?php
namespace App\SuratKeluar\Models;

class Document extends \Micro\Model {

    public function getSource() {
        return 'trx_surat_keluar_docs';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tskd_download_url'] = $this->getDownloadUrl();
        return $data;
    }

    public function getDownloadUrl() {
        $app = \Micro\App::getDefault();
        return $app->url->getBaseUrl().'public/resources/documents/'.$this->tskd_file;
    }
}