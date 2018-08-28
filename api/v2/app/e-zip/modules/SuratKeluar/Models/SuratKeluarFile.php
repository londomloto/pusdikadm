<?php
namespace App\SuratKeluar\Models;

class SuratKeluarFile extends \Micro\Model {

    public function getSource() {
        return 'trx_keluar_files';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tskf_size_formatted'] = $this->getFormattedSize();
        $data['tskf_type_formatted'] = $this->getFormattedType();
        $data['tskf_file_url'] = $this->getFileUrl();
        return $data;
    }

    public function getFileUrl() {
        if ( ! empty($this->tskf_file)) {
            return \Micro\App::getDefault()->url->getBaseUrl().'public/resources/attachments/'.$this->tskf_file;
        }
        return '';
    }

    public function getFormattedType() {
        return self::formatType($this->tskf_type);
    }

    public function getFormattedSize() {
        return self::formatSize($this->tskf_size);
    }

    public static function formatType($type) {
        $type = (string)$type;

        if (strpos($type, 'image') !== FALSE) {
            return 'Gambar';
        } else {
            return 'Dokumen';
        }
    }

    public static function formatSize($value, $decimal = 2) {
        $value = (double)$value;
        $units = array('B', 'KB', 'MB', 'GB', 'TB');

        $bytes = max($value, 0);
        $power = floor(($bytes ? log($bytes) : 0) / log(1024));
        $power = min($power, count($units) - 1);
        $bytes /= pow(1024, $power);

        return round($bytes, $decimal).' '.$units[$power];
    }
}