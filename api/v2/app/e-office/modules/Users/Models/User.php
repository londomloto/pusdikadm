<?php
namespace App\Users\Models;

use App\Users\Models\UserMenu,
    App\Users\Models\UserPermission,
    Phalcon\Mvc\Model\Relation,
    Phalcon\Validation,
    Phalcon\Validation\Validator\Uniqueness;

class User extends \Micro\Model {
    
    const AVATAR_DEFAULT = 'defaults/avatar-0.jpg';

    public function initialize() {

        $this->hasMany(
            'su_id',
            'App\Users\Models\UserKanban',
            'suk_su_id',
            array(
                'alias' => 'Kanban',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'su_id',
            'App\Bpmn\Models\FormUser',
            'bfu_su_id',
            array(
                'alias' => 'FormUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->belongsTo(
            'su_sr_id',
            'App\Roles\Models\Role',
            'sr_id',
            array(
                'alias' => 'Role'
            )
        );
        
        $this->hasMany(
            'su_id',
            'App\Users\Models\UserPermission',
            'sup_su_id',
            array(
                'alias' => 'UserPermissions',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'su_id',
            'App\Users\Models\UserPermission',
            'sup_su_id',
            'sup_smc_id',
            'App\Modules\Models\ModuleCapability',
            'smc_id',
            array(
                'alias' => 'Permissions'
            )
        );

        $this->hasMany(
            'su_id',
            'App\Users\Models\UserMenu',
            'sum_su_id',
            array(
                'alias' => 'UserMenus'
            )
        );

        $this->hasManyToMany(
            'su_id',
            'App\Users\Models\UserMenu',
            'sum_su_id',
            'sum_smn_id',
            'App\Menus\Models\Menu',
            'smn_id',
            array(
                'alias' => 'Menus'
            )
        );

        $this->hasMany(
            'su_id',
            'App\Tasks\Models\TaskUser',
            'ttu_su_id',
            array(
                'alias' => 'Tasks',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasOne(
            'su_sj_id',
            'App\Jobs\Models\Job',
            'sj_id',
            array(
                'alias' => 'Job'
            )
        );

        $this->hasOne(
            'su_scp_id',
            'App\Company\Models\Company',
            'scp_id',
            array(
                'alias' => 'Company'
            )
        );

        $this->hasOne(
            'su_sdp_id',
            'App\Departments\Models\Department',
            'sdp_id',
            array(
                'alias' => 'Department'
            )
        );

    }

    public function getSource() {
        return 'sys_users';
    }

    public function beforeSave() {
        if (isset($this->su_scp_id) && $this->su_scp_id== '') {
            $this->su_scp_id = NULL;
        }

        if (isset($this->su_sdp_id) && $this->su_sdp_id == '') {
            $this->su_sdp_id = NULL;
        }

        if (isset($this->su_sj_id) && $this->su_sj_id == '') {
            $this->su_sj_id = NULL;
        }

        if (isset($this->su_dob) && $this->su_dob == '') {
            $this->su_dob = NULL;
        }
    }

    public function validation()
    {
        $validator = new Validation();

        $validator->add(
            "su_email",
            new Uniqueness(
                [
                    "message" => "Email name already registered",
                ]
            )
        );

        return $this->validate($validator);
    }

    // @Override
    public function toArray($columns =  NULL) {
        $array = parent::toArray($columns);
        $array['su_dob_formatted'] = date('d M Y', strtotime($this->su_dob));

        if (empty($array['su_fullname'])) {
            $array['su_fullname'] = $array['su_email'];
        }

        // handle avatar
        $avatar = PUBPATH.'resources/avatars/'.$array['su_avatar'];
        $exists = file_exists($avatar) && ! is_dir($avatar);

        if ( ! $exists) {
            $array['su_avatar'] = self::AVATAR_DEFAULT;
        }

        $URL = $this->getDI()->get('url');

        $array['su_avatar_url'] = $URL->getBaseUrl().'public/resources/avatars/'.$array['su_avatar'];
        $array['su_avatar_thumb'] = $URL->getSiteUrl('assets/thumb?s=public/resources/avatars/'.$array['su_avatar']);

        // handle password
        unset($array['su_passwd']);    

        if ($this->role) {
            $array = array_merge($array, $this->role->toArray());
        }

        if ($this->job) {
            $array['su_sj_name'] = $this->job->sj_name;
        }

        if ($this->company) {
            $array['su_scp_name'] = $this->company->scp_name;
        }

        if ($this->department) {
            $array['su_sdp_name'] = $this->department->sdp_name;
        }

        // need to reinvite
        $array['su_need_reinvite'] = FALSE;

        if ( ! empty($array['su_invite_token'])) {
            $array['su_need_reinvite'] = TRUE;
        }

        return $array;
    }

    public function getName() {
        return empty($this->su_fullname) ? $this->su_email : $this->su_fullname;
    }

    public function getMenus($options = array()) {
        if ($this->userMenus->count() == 0) {
            if ($this->role) {
                return $this->role->getMenus();
            } else {
                return \App\Menus\Models\Menu::find('smn_id = -1');
            }
        } else {
            $conditions = '';

            if (isset($options[0]) && is_string($options[0])) {
                $conditions = $options[0];
                unset($options[0]);
            } else if (isset($options['conditions'])) {
                $conditions = $options['conditions'];
                unset($options['conditions']);
            }

            if ( ! empty($conditions)) {
                $conditions .= ' AND ';
            }
            
            $conditions .= 'App\Users\Models\UserMenu.sum_selected = 1';
            $options['conditions'] = $conditions;

            return parent::getMenus($options);
        }
    }

    public function getPermissions($options = array()) {
        if ($this->userPermissions->count() == 0) {
            if ($this->role) {
                return $this->role->getPermissions();
            } else {
                return \App\Modules\Models\ModuleCapability::find('smc_id = -1');
            }
        } else {
            $conditions = '';

            if (isset($options[0]) && is_string($options[0])) {
                $conditions .= ' AND ' . $options[0];
                unset($options[0]);
            } else if (isset($options['conditions'])) {
                $conditions = ' AND ' . $options['conditions'];
                unset($options['conditions']);
            }

            if ( ! empty($conditions)) {
                $conditions .= ' AND ';
            }

            $conditions .= 'App\Users\Models\UserPermission.sup_selected = 1';
            $options['conditions'] = $conditions;
        }

        return parent::getPermissions($options);
    }

    // @Override
    public static function findFirstByEmail($email) {
        return self::get()
            ->where('su_email = :email:', array('email' => $email))
            ->execute()
            ->getFirst();
    }

    public function saveKanban($items) {

        if (count($items) === 0) {
            // reset
            $this->kanban->delete();
            return;
        }

        $create = array();
        $update = array();
        $delete = array();

        $exists = array_map(
            function($item) {
                return $item['suk_id'];
            },
            $this->kanban->toArray()
        );

        $sliced = array();

        foreach($items as $item) {
            if (empty($item['suk_id'])) {
                if ($item['suk_selected']) {
                    $create[] = $item;    
                }
            } else {
                if (in_array($item['suk_id'], $exists)) {
                    if ($item['suk_selected']) {
                        $update[] = $item;
                        $sliced[] = $item['suk_id'];    
                    }
                }
            }
        }

        for ($i = count($exists) - 1; $i >= 0; $i--) {
            if ( ! in_array($exists[$i], $sliced)) {
                $delete[] = $exists[$i];
            }
        }

        if (count($delete) > 0) {
            $deleted = UserKanban::find('suk_id IN ('.implode(',', $delete).')');

            foreach($deleted as $item) {
                $item->suk_selected = 0;
                $item->save();
            }
        }

        if (count($update) > 0) {
            foreach($update as $item) {
                $k = UserKanban::findFirst($item['suk_id']);
                $k->save($item);
            }
        }

        if (count($create) > 0) {
            foreach($create as $item) {
                $k = new UserKanban();
                $item['suk_su_id'] = $this->su_id;
                $k->save($item);
            }
        }
    }

    public function saveMenus($items) {

        if (count($items) === 0) {
            // reset
            $this->userMenus->delete();
            return;
        }

        $create = array();
        $update = array();
        $exists = array();

        foreach($this->userMenus as $um) {
            $exists[$um->sum_smn_id] = $um;
        }

        foreach($items as $id) {
            if ( ! isset($exists[$id])) {
                $create[] = $id;
            } else {
                $update[] = $id;
                unset($exists[$id]);
            }
        }

        foreach($exists as $menu => $rm) {
            $rm->sum_selected = 0;
            $rm->save();
        }

        foreach($update as $id) {
            $um = UserMenu::findFirst(array(
                'sum_su_id = :user: AND sum_smn_id = :menu:',
                'bind' => array(
                    'user' => $this->su_id,
                    'menu' => $id
                )
            ));

            if ($um) {
                $um->sum_selected = 1;
                $um->save();
            }
        }

        foreach($create as $id) {
            $um = new UserMenu();

            $um->sum_su_id = $this->su_id;
            $um->sum_smn_id = $id;
            $um->sum_selected = 1;
            
            $um->save();
        }
    }

    public function savePermissions($items) {
        if (count($items) === 0) {
            // reset
            $this->userPermissions->delete();
            return;
        }
        
        $create = array();
        $update = array();
        $exists = array();

        foreach($this->userPermissions as $up) {
            $exists[$up->sup_smc_id] = $up;
        }

        foreach($items as $id) {
            if ( ! isset($exists[$id])) {
                $create[] = $id;
            } else {
                $update[] = $id;
                unset($exists[$id]);
            }
        }

        foreach($exists as $cap => $up) {
            $up->sup_selected = 0;
            $up->save();
        }

        foreach($update as $id) {
            $up = UserPermission::findFirst(array(
                'sup_su_id = :user: AND sup_smc_id = :capability:',
                'bind' => array(
                    'user' => $this->su_id,
                    'capability' => $id
                )
            ));

            if ($up) {
                $up->sup_selected = 1;
                $up->save();
            }
        }

        foreach($create as $id) {
            $up = new UserPermission();
            $up->sup_su_id = $this->su_id;
            $up->sup_smc_id = $id;
            $up->sup_selected = 1;
            $up->save();
        }
    }

    public static function dbcreate($data) {
        $app = \Micro\App::getDefault();

        $user = new User();
        $auth = $app->auth->user();

        $data['su_created_date'] = date('Y-m-d H:i:s');
        $data['su_created_by'] = $auth['su_fullname'];

        if (isset($data['su_passwd']) && ! empty($data['su_passwd'])) {
            $data['su_passwd'] = $app->security->createHash($data['su_passwd']);
        }

        if (isset($data['su_email'])) {
            if ( ! isset($data['su_fullname']) || empty($data['su_fullname'])) {
                $name = substr($data['su_email'], 0, strpos($data['su_email'], '@'));
                $name = ucwords(str_replace('.', ' ', $name));    
                $data['su_fullname'] = $name;
            }
        }

        if ($user->save($data)) {

            if (isset($data['su_kanban'])) {
                $user->saveKanban($data['su_kanban']);
            }

            if (isset($data['su_invite'], $data['su_email'])) {
                $user->su_invite_token = User::createInvitationToken(array('su_email' => $data['su_email']));
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

        User::none();
    }

    public static function dbupdate($id, $data = array()) {
        $app = \Micro\App::getDefault();
        $query = User::get($id);

        if ($query->data) {

            if (isset($data['su_passwd']) && ! empty($data['su_passwd'])) {
                $data['su_passwd'] = $app->security->createHash($data['su_passwd']);
            }

            if ($query->data->save($data)) {
                if (isset($data['su_kanban'])) {
                    $query->data->saveKanban($data['su_kanban']);
                }

                if (isset($data['su_invite'], $data['su_email'])) {
                    $query->data->su_active = 0;
                    $query->data->su_invite_token = User::createInvitationToken(array('su_email' => $data['su_email']));
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

    public static function dbdelete() {

    }

    public static function createInvitationToken($data = array()) {
        return \Micro\App::getDefault()->security->createToken($data, 2678400);
    }

    public function sendInvitation() {
        if (empty($this->su_email)) {
            return 'Alamat email tidak valid';
        }

        if (empty($this->su_invite_token)) {
            return 'Token tidak valid';
        }

        $app = \Micro\App::getDefault();

        $href = sprintf('%sinvitation?code=%s', $app->url->getClientUrl(), $this->su_invite_token);
        $body = $app->di->get('\App\Users\Controllers\UsersController', TRUE)
            ->view
            ->render('invitation', array(
                'app' => $app->config->app->name,
                'href' => $href,
                'support' => $app->mailer->account('support', TRUE)
            ));

        $options = array(
            'from' => $app->mailer->account('no-reply'),
            'to' => $this->su_email,
            'subject' => 'Undangan untuk bergabung dengan aplikasi '.$app->config->app->name,
            'body' => $body
        );

        return $app->mailer->send($options);
    }
}