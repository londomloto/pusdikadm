<?php
namespace App\Users\Controllers;

use App\Users\Models\User,
    App\Roles\Models\Role;

class UsersController extends \Micro\Controller {

    public function testAction() {
        
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
        /*$post = $this->request->getJson();
        $user = new User();

        if (isset($post['su_passwd']) && ! empty($post['su_passwd'])) {
            $post['su_passwd'] = $this->security->createHash($post['su_passwd']);
        }

        $post['su_invite_token'] = $this->security->createToken(array(
            'su_email' => $post['su_email']
        ), 2678400);

        // define fullname
        if ( ! isset($post['su_fullname']) || empty($post['su_fullname'])) {
            $name = substr($post['su_email'], 0, strpos($post['su_email'], '@'));
            $name = ucwords(str_replace('.', ' ', $name));    
            $post['su_fullname'] = $name;
        }

        if ($user->save($post)) {
            if (isset($post['su_kanban'])) {
                $user->saveKanban($post['su_kanban']);
            }

            $message = $this->__sendInvitationEmail($post);

            $result = User::get($user->su_id);
            $result->message = $message;

            return $result;
        }else{
            $messages = $user->getMessages();
            $msg = [];
            foreach ($messages as $message) {
                array_push($msg, $message->getMessage());
            }
            return ["success"=>FALSE, "message"=> implode(',', $msg)];
        }

        return User::none();*/
    }

    public function updateAction($id) {
        $query = User::get($id);

        if ($query->data) {
            $post = $this->request->getJson();

            if (isset($post['su_passwd']) && ! empty($post['su_passwd'])) {
                $post['su_passwd'] = $this->security->createHash($post['su_passwd']);
            }

            if ($query->data->save($post)) {
                if (isset($post['su_kanban'])) {
                    $query->data->saveKanban($post['su_kanban']);
                }
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
                    $user->su_created_by = 'system';
                    $user->su_invite_token = $this->security->createToken(array(
                        'su_email' => $email
                    ), 2678400);

                    $user->su_sr_id = $role;

                    $this->__sendInvitationEmail($user->toArray());
                    $user->save();

                    if (isset($post['project']) && ! empty($post['project'])) {
                        $pu = new \App\Projects\Models\ProjectUser();
                        $pu->spu_su_id = $user->su_id;
                        $pu->spu_sp_id = $post['project'];
                        $pu->save();
                    }

                    $result['success'] = TRUE;
                    $result['data'] = User::get($user->su_id)->data;
                } else {
                    $result['message'] = 'Email address already registered';
                }
            } else {
                $result['message'] = 'Invalid email address';
            }
        } else {
            $result['message'] = 'Invalid email address';
        }

        return $result;
    }

    public function reinviteAction() {
        $post = $this->request->getJson();
        $user = User::findFirst(array('su_email = :email:', 'bind' => array('email' => $post['email'])));

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
                $code = $this->security->createToken(array('su_email' => $post['email']));
                $user->su_invite_token = $code;
                $user->save();

                $this->__sendInvitationEmail($user->toArray());
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
            $user->save($post);
        }

        $redir = $this->url->getClientUrl().'profile/';

        return array(
            'success' => TRUE,
            'data' => array(
                'redir' => $redir
            )
        );
    }

    private function __sendInvitationEmail($data) {
        $href = sprintf(
            '%sinvitation?code=%s',
            $this->url->getClientUrl(),
            $data['su_invite_token']
        ); 
        
        $body = $this->view->render('invitation', array(
            'app' => $this->config->app->name,
            'href' => $href,
            'support' => $this->mailer->account('support', TRUE)
        ));

        $options = array(
            'from' => $this->mailer->account('no-reply'),
            'to' => $data['su_email'],
            'subject' => 'Undangan untuk bergabung dengan aplikasi '.$this->config->app->name,
            'body' => $body
        );

        return $this->mailer->send($options);
    }
}