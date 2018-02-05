<?php
namespace App\Users\Controllers;

use App\Users\Models\User,
    App\Roles\Models\Role;

class UsersController extends \Micro\Controller {

    public function testAction() {
        $data = \App\Lkh\Models\Lkh::get(1)->data;
        $post = $data->toArray();

        $flag = array();
        $date = $post['lkh_date'];
        $user = $post['lkh_su_id'];
        $time = strtotime($date);

        $m = date('m', $time);
        $y = date('Y', $time);

        $exam = \App\Lkh\Models\Exam::findFirst(array(
            'lke_su_id = :user: AND YEAR(lke_date) = :y:',
            'bind' => array(
                'user' => $user,
                'y' => $y
            )
        ));

        if ( ! $exam) {
            $flag[] = 'Y';
        }

        $exam = \App\Lkh\Models\Exam::findFirst(array(
            'lke_su_id = :user: AND MONTH(lke_date) = :m: AND YEAR(lke_date) = :y:',
            'bind' => array(
                'user' => $user,
                'y' => $y,
                'm' => $m
            )
        ));

        if ( ! $exam) {
            $flag[] = 'M';
        }

        $exam = \App\Lkh\Models\Exam::findFirst(array(
            'lke_su_id = :user: AND lke_date = :d:',
            'bind' => array(
                'user' => $user,
                'd' => $date
            )
        ));

        if ( ! $exam) {
            $flag[] = 'D';
        }

        $flag = implode('', $flag);

        print_r($flag);
    }

    public function findAction() {
        return User::get()->filterable()->sortable()->paginate();
    }

    public function findByIdAction($id) {
        return User::get($id);
    }
    
    public function createAction() {
        $post = $this->request->getJson();
        return User::dbcreate($post);
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        return User::dbupdate($id, $post);
    }

    public function deleteAction($id) {
        $query = User::get($id);

        if ($query->data) {
            return array(
                'success' => $query->data->delete()
            );
        }
        
        return array('success' => FALSE);
    }

    public function uploadAction($id) {
        $query = User::get($id);

        if ($query->data) {
            if ($this->request->hasFiles()) {
                foreach($this->request->getFiles() as $file) {
                    $type = $file->getExtension();
                    
                    $name = str_replace(array('@', '.'), '_', $query->data->su_email).'.'.$type;
                    $path = APPPATH.'public/resources/avatars/'.$name;

                    if (@$file->moveTo($path)) {
                        $query->data->save(array(
                            'su_avatar' => $name
                        ));
                    }
                }
            }
        }

        return $query;
    }

    public function inviteAction() {
        $post = $this->request->getJson();
        $auth = $this->auth->user();

        $email = isset($post['email']) ? $post['email'] : NULL;
        $role = isset($post['role']) ? $post['role'] : NULL;
        
        $result = array(
            'success' => FALSE
        );

        if ( ! empty($email)) {
            if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
                $found = User::findFirst(array(
                    'su_email = :email:',
                    'bind' => array('email' => $email)
                ));

                if ( ! $found) {
                    $user = new User();

                    if (empty($role)) {
                        $role = Role::defaultRole();
                        if ($role) {
                            $role = $role->sr_id;
                        }
                    }

                    $user->su_email = $email;

                    // define fullname
                    $name = substr($email, 0, strpos($email, '@'));
                    $name = ucwords(str_replace('.', ' ', $name));
                    $user->su_fullname = $name;
                    $user->su_active = 0;
                    $user->su_created_date = date('Y-m-d H:i:s');
                    $user->su_created_by = $auth['su_fullname'];
                    $user->su_invite_token = User::createInvitationToken(array('su_email' => $email));

                    $user->su_sr_id = $role;

                    $user->save();
                    $user->sendInvitation();

                    if (isset($post['project']) && ! empty($post['project'])) {
                        $pu = new \App\Projects\Models\ProjectUser();
                        $pu->spu_su_id = $user->su_id;
                        $pu->spu_sp_id = $post['project'];
                        $pu->save();
                    }

                    $result['success'] = TRUE;
                    $result['data'] = User::get($user->su_id)->data;
                } else {
                    $result['message'] = 'Alamat email sudah terdaftar';
                }
            } else {
                $result['message'] = 'Alamat email tidak valid';
            }
        } else {
            $result['message'] = 'Alamat email tidak valid';
        }

        return $result;
    }

    public function reinviteAction() {
        $post = $this->request->getJson();

        $user = User::findFirst(array(
            'su_email = :email:', 
            'bind' => array(
                'email' => $post['email']
            )
        ));

        if ($user && $user->su_active == 0) {
            $token = $user->su_invite_token;
            $need = FALSE;

            if ( ! empty($token)) {
                $verify = $this->security->verifyToken($token);
                if ( ! $verify['success']) {
                    $need = TRUE;
                }
            } else {
                $need = TRUE;
            }

            if ($need) {
                $user->su_invite_token = User::createInvitationToken(array('su_email' => $post['email']));
                $user->save();
                $user->sendInvitation();
            }
        }

        return array(
            'success' => TRUE
        );
    }

    public function validateActivationAction() {
        $result = array(
            'success' => FALSE
        );

        $post = $this->request->getJson();
        $code = $post['token'];

        $verify = $this->security->verifyToken($code);

        if ($verify['success']) {
            $email = $verify['payload']->su_email;
            
            $user = User::findFirst(array(
                'su_email = :email: AND su_invite_token = :code:',
                'bind' => array(
                    'email' => $email,
                    'code' => $code
                )
            ));

            if ($user) {
                if ($user->su_active == 0) {
                    $result['success'] = TRUE;
                    $result['data'] = $user->toArray();
                } else {
                    $result['message'] = 'Akun sudah aktif';
                }
            } else {
                $result['message'] = 'Kode aktivasi tidak valid';
            }
        } else {
            $result['message'] = $verify['message'];
        }
        
        return $result;
    }

    public function activateAction() {
        $post = $this->request->getJson();
        $user = User::findFirst($post['su_id']);

        $post['su_active'] = 1;
        $post['su_invite_token'] = NULL;

        if (isset($post['password'])) {
            $post['su_passwd'] = $this->security->createHash($post['password']);
        }

        if ($user) {
            if ($user->save($post)) {
                if ( ! empty($user->su_ticket)) {
                    $task = \App\Tasks\Models\Task::get($user->su_ticket)->data;
                    
                    if ($task) {
                        $task->next($user->toArray());
                        $user->su_ticket = NULL;
                        $user->save();
                    }
                }
            }
        }

        $redir = $this->url->getClientUrl().'profile/';

        return array(
            'success' => TRUE,
            'data' => array(
                'redir' => $redir
            )
        );
    }
}