<?php
namespace App\Users\Controllers;

use App\Users\Models\User,
    App\Roles\Models\Role;

class UsersController extends \Micro\Controller {

    public function testAction() {
        \App\Calendar\Models\Calendar::fill();
    }

    public function findAction() {
        return User::get()->filterable()->sortable()->paginate();
    }

    public function findByIdAction($id) {
        return User::get($id);
    }
    
    public function createAction() {
        $post = $this->request->getJson();
        $auth = $this->auth->user();

        $user = new User();

        $post['su_created_date'] = date('Y-m-d H:i:s');
        $post['su_created_by'] = $auth['su_fullname'];

        if (isset($post['su_passwd']) && ! empty($post['su_passwd'])) {
            $post['su_passwd'] = $this->security->createHash($post['su_passwd']);
        }

        if (isset($post['su_email'])) {
            if ( ! isset($post['su_fullname']) || empty($post['su_fullname'])) {
                $name = substr($post['su_email'], 0, strpos($post['su_email'], '@'));
                $name = ucwords(str_replace('.', ' ', $name));    
                $post['su_fullname'] = $name;
            }
        }

        if ($user->save($post)) {

            if (isset($post['su_kanban'])) {
                $user->saveKanban($post['su_kanban']);
            }

            if (isset($post['su_invite'], $post['su_email'])) {
                $user->su_invite_token = User::createInvitationToken(array('su_email' => $post['su_email']));
                $user->save();
                $user->sendInvitation();
            }

            return User::get($user->su_id);
        } else {
            $messages = [];

            foreach($user->getMessages() as $item) {
                $messages[] = $item->getMessage();
            }

            return (object) array(
                'success' => FALSE,
                'data' => NULL,
                'message' => implode('<br>', $messages)
            );
        }
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = User::get($id);

        if ($query->data) {

            if (isset($post['su_passwd']) && ! empty($post['su_passwd'])) {
                $post['su_passwd'] = $this->security->createHash($post['su_passwd']);
            }

            if ($query->data->save($post)) {
                if (isset($post['su_kanban'])) {
                    $query->data->saveKanban($post['su_kanban']);
                }

                if (isset($post['su_invite'], $post['su_email'])) {
                    $query->data->su_active = 0;
                    $query->data->su_invite_token = User::createInvitationToken(array('su_email' => $post['su_email']));
                    $query->data->save();
                    $query->data->sendInvitation();
                }
            } else {
                $query->success = FALSE;
                $query->message = [];

                foreach($query->data->getMessages() as $m) {
                    $query->message[] = $m;
                }

                $query->message = implode('<br>', $query->message);
            }

        }

        return $query;
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
                $user = User::findFirst(array(
                    'su_email = :email:',
                    'bind' => array(
                        'email' => $email
                    )
                ));

                if ( ! $user) {
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

                    if ($user->save()) {
                        
                        $user = $user->refresh();

                        if (isset($post['project']) && ! empty($post['project'])) {
                            $pu = new \App\Projects\Models\ProjectUser();
                            $pu->spu_su_id = $user->su_id;
                            $pu->spu_sp_id = $post['project'];
                            $pu->save();
                        }
                    }
                } else {
                    $user->su_active = 0;
                    $user->su_invite_token = User::createInvitationToken(array('su_email' => $email));
                    $user->save();

                    $user = $user->refresh();
                }

                $user->sendInvitation();

                return array(
                    'success' => TRUE,
                    'data' => $user->toArray()
                );
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
            'bind' => array('email' => $post['email'])
        ));

        $result = array(
            'success' => FALSE,
            'message' => NULL
        );

        if ($user && $user->su_active == 0) {
            if (empty($user->su_invite_token)) {
                $user->su_invite_token = User::createInvitationToken(array('su_email' => $post['email']));
                $user->save();
            }
            
            $sent = $user->sendInvitation();

            if (is_bool($sent)) {
                $result['success'] = $sent;
            } else {
                $result['message'] = $sent;
            }
        }

        return $result;
    }

    public function validateActivationAction() {
        $result = array(
            'success' => FALSE
        );

        $post = $this->request->getJson();
        $code = $this->url->decode($post['token']);

        if ( ! empty($code)) {
            $data = $this->security->decrypt($code, TRUE);

            if (isset($data->su_email)) {
                $user = User::findFirst(array(
                    'su_email = :email: AND su_invite_token = :code:',
                    'bind' => array(
                        'email' => $data->su_email,
                        'code' => $code
                    )
                ));

                if ($user) {
                    if ($user->su_active == 0) {
                        $result['success'] = TRUE;
                        $result['data'] = $user->toArray();
                    } else {
                        $result['message'] = 'Pengguna sudah aktif';
                    }
                } else {
                    $result['message'] = 'Kode aktivasi tidak valid';
                }
            } else {
                $result['message'] = 'Kode aktivasi tidak valid';    
            }
        } else {
            $result['message'] = 'Kode aktivasi tidak valid';
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
                if ($user->su_task_flag == 'CONFIRMATION') {
                    $task = \App\Registration\Models\Task::findFirst($user->su_id);
                    $task->forward();

                    $task->su_task_flag = NULL;
                    $task->save();
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