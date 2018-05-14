<?php
namespace App\Company\Models;

class Company extends \Micro\Model {

    public function getSource() {
        return 'sys_company';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray();
        $data['scp_logo_thumb'] = $this->getLogoThumb();
        return $data;
    }

    public function getLogo() {
        static $logos = array();

        if ( ! isset($logos[$this->scp_id])) {
            $logo = empty($this->scp_logo) ? 'logo-empty.jpg' : $this->scp_logo;
            $path = PUBPATH.'resources/company/'.$logo;

            if ( ! file_exists($path)) {
                $logo = 'logo-empty.jpg';
            }

            $logos[$this->scp_id] = $logo;
        }

        return $logos[$this->scp_id];
    }

    public function getFullname() {
        $name = $this->scp_name;
        if ( ! empty($this->scp_parent)) {
            $name .= ', '.$this->scp_parent;
        }
        return $name;
    }

    public function getLogoThumb() {
        $logo = $this->getLogo();
        $app = \Micro\App::getDefault();

        return $app->url->getSiteUrl('assets/thumb').'?s=public/resources/company/'.$logo;
    }

    public static function getDefault() {
        return self::findFirst('scp_default = 1');
    }
}
