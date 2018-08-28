<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\SuratKeluarExam;
use App\Users\Models\User;

class SuratKeluarExamsController extends \Micro\Controller {

    public function findAction() {
        return SuratKeluarExam::get()
            ->filterable()
            ->orderBy('tske_created ASC') 
            ->paginate();
    }

    public function createAction() {
        $post = $this->request->getJson();
        $post['tske_created'] = date('Y-m-d H:i:s');

        $data = new SuratKeluarExam();

        if ($data->save($post)) {
            return SuratKeluarExam::get($data->tske_id);
        }
        return SuratKeluarExam::none();
    }

    public function signatureAction($id) {
        $data = SuratKeluarExam::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $this->uploader->initialize(array(
                'path' => PUBPATH.'resources/signatures/',
                'encrypt' => TRUE
            ))->upload();

            if ($done) {
                $upload = $this->uploader->getResult();

                $data->tske_signature = $upload->filename;
                $data->save();

                $user = User::findFirst($data->tske_user);

                if ($user) {
                    $user->su_signature = $data->tske_signature;
                    $user->save();
                }
            } else {
                print_r($this->uploader->getMessage());
            }
        }

        return array(
            'success' => $done
        );
    }

    public function deleteAction($id) {
        $data = SuratKeluarExam::get($id)->data;
        $done = FALSE;

        if ($data) {
            $done = $data->delete();
        }

        return array(
            'success' => $done
        );
    }
}