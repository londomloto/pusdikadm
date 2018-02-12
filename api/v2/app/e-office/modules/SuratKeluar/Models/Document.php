<?php
namespace App\SuratKeluar\Models;

class Document extends \Micro\Model {

    public function getSource() {
        return 'trx_surat_keluar_docs';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tskd_size_formatted'] = \Micro\App::getDefault()->file->formatSize($this->tskd_size);
        $data['tskd_file_url'] = $this->getFileUrl();
        return $data;
    }
    
    public function getFileUrl() {
        $app = \Micro\App::getDefault();
        return $app->url->getBaseUrl().'public/resources/documents/'.$this->tskd_file;
    }
}