<?php
namespace App\Company\Controllers;

use App\Company\Models\Company;

class CompanyController extends \Micro\Controller {

    public function findAction() {
        return Company::get()->paginate();
    }

    public function findByIdAction($id) {
        return Company::get($id);
    }

    public function loadAction() {
        $company = Company::findFirst('scp_default = 1');

        if ($company) {
            return array(
                'success' => TRUE,
                'data' => $company->toArray()
            );
        }

        return array('success' => FALSE);
    }

    public function updateAction($id) {
        $query = Company::get($id);
        $post = $this->request->getJson();

        if ($query->data) {
            $logo = $query->data->scp_logo;

            if ($query->data->save($post)) {
                if (empty($post['scp_logo'])) {
                    @unlink(APPPATH.'public/resources/company/'.$logo);
                }
            }
        }

        return $query;
    }

    public function uploadAction() {
        $company = Company::getDefault();
        $result = array(
            'success' => FALSE
        );

        if ($company) {
            $upload = $this->uploader->initialize(array(
                'path' => APPPATH.'public/resources/company/',
                'types' => array('jpg', 'jpeg', 'png'),
                'encrypt' => TRUE
            ))->upload();

            if ($upload) {
                $info = $this->uploader->getResult();
                $company->scp_logo = $info->filename;
                $company->save();
            }

            $company->refresh();

            $result['success'] = TRUE;
            $result['data'] = $company->toArray();
        }

        return $result;
    }
}