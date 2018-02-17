<?php
namespace App\Company\Models;

class Company extends \Micro\Model {

    public function getSource() {
        return 'sys_company';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray();
        $logo = $data['scp_logo'];

        if (empty($logo)) {
            $logo = 'logo-empty.jpg';
        }

        $app = \Micro\App::getDefault();

        $data['scp_logo_url'] = $app->url->getBaseUrl().'public/resources/company/'.$logo;
        $data['scp_logo_thumb'] = $app->url->getSiteUrl('assets/thumb').'?s=public/resources/company/'.$logo;
        
        return $data;
    }

    public static function getDefault() {
        return self::findFirst('scp_default = 1');
    }
}