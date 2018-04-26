<?php
namespace App\Users\Models;

use App\Users\Models\UserMenu;
use App\Users\Models\UserPermission;
use Phalcon\Mvc\Model\Relation;
use Phalcon\Validation;
use Phalcon\Validation\Validator\Uniqueness;
use Micro\Helpers\Date;

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

        // $this->hasManyToMany(
        //     'su_id',
        //     'App\Users\Models\UserPermission',
        //     'sup_su_id',
        //     'sup_smc_id',
        //     'App\Modules\Models\ModuleCapability',
        //     'smc_id',
        //     array(
        //         'alias' => 'Permissions'
        //     )
        // );

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

        $this->hasManyToMany(
            'su_id',
            'App\Projects\Models\ProjectUser',
            'spu_su_id',
            'spu_sp_id',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Projects'
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

        $this->hasMany(
            'su_id',
            'App\Users\Models\UserToken',
            'sut_su_id',
            array(
                'alias' => 'Tokens',
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
            'su_sdp_id',
            'App\Departments\Models\Department',
            'sdp_id',
            array(
                'alias' => 'Department'
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
            'su_sg_id',
            'App\Grades\Models\Grade',
            'sg_id',
            array(
                'alias' => 'Grade'
            )
        );
    }

    public function getSource() {
        return 'sys_users';
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

    public function beforeSave() {
        if (isset($this->su_dob) && $this->su_dob == '') {
            $this->su_dob = NULL;
        }

        if (isset($this->su_sdp_id) && $this->su_sdp_id == '') {
            $this->su_sdp_id = NULL;
        }

        if (isset($this->su_sj_id) && $this->su_sj_id == '') {
            $this->su_sj_id = NULL;
        }

        if (isset($this->su_scp_id) && $this->su_scp_id == '') {
            $this->su_scp_id = NULL;
        }

        if (isset($this->su_sg_id) && $this->su_sg_id == '') {
            $this->su_sg_id = NULL;
        }
    }

    // @Override
    public function toArray($columns =  NULL) {
        $array = parent::toArray($columns);

        $array['su_fullname'] = $this->getName();
        $array['su_avatar'] = $this->getAvatar();
        $array['su_avatar_url'] = $this->getAvatarUrl();
        $array['su_avatar_thumb'] = $this->getAvatarThumb();
        $array['su_dob_formatted'] = ! empty($this->su_dob) ? Date::format($this->su_dob, 'd M Y') : '';
        $array['su_sex_initial'] = ! empty($this->su_sex) ? strtoupper(substr($this->su_sex, 0, 1)) : '';
        // handle password
        unset($array['su_passwd']);    

        if ($this->role) {
            $array = array_merge($array, $this->role->toArray());
        }

        // need to reinvite
        $array['su_need_reinvite'] = FALSE;

        if ( ! empty($array['su_invite_token'])) {
            $array['su_need_reinvite'] = TRUE;
        }

        if ($this->job) {
            $array['su_sj_name'] = $this->job->sj_name;
        }

        if ($this->department) {
            $array['su_sdp_name'] = $this->department->sdp_name;
        }

        if ($this->company) {
            $array['su_scp_name'] = $this->company->scp_name;
        }

        if ($this->grade) {
            $array['su_sg_name'] = $this->grade->sg_name;
        }

        return $array;
    }

    public function toSimpleArray() {
        $array = array(
            'su_id' => $this->su_id,
            'su_fullname' => $this->getName(),
            'su_no' => $this->su_no,
            'su_sg_name' => $this->getGradeName(),
            'su_sdp_name' => $this->department ? $this->department->sdp_name : NULL,
            'su_scp_name' => $this->company ? $this->company->scp_name : NULL,
            'su_sj_name' => $this->job ? $this->job->sj_name : NULL,
            'su_avatar_thumb' => $this->getAvatarThumb()
        );

        return $array;
    }

    public function getName() {
        return empty($this->su_fullname) ? $this->su_email : $this->su_fullname;
    }

    public function getGradeName() {
        if (($grade = $this->grade)) {
            return $grade->sg_name;
        }
        return NULL;
    }

    public function getAvatar() {
        // cache for multiple call in same time
        static $avatar = array();
        
        $key = $this->su_id;

        if ( ! isset($avatar[$key])) {
            $avatar[$key] = isset($this->su_avatar) ? $this->su_avatar : self::AVATAR_DEFAULT;
            $exists = FALSE;

            if ( ! empty($avatar[$key])) {
                $exists = file_exists(PUBPATH.'resources/avatars/'.$avatar[$key]);
            }

            if ( ! $exists) {
                $avatar[$key] = self::AVATAR_DEFAULT;
            }
        }

        return $avatar[$key];
    }

    public function getAvatarUrl() {
        $app = \Micro\App::getDefault();
        $avatar = $this->getAvatar();
        return $app->url->getBaseUrl().'public/resources/avatars/'.$avatar;
    }

    public function getAvatarThumb() {
        $app = \Micro\App::getDefault();
        $avatar = $this->getAvatar();
        return $app->url->getSiteUrl('assets/thumb?s=public/resources/avatars/'.$avatar);
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
                return array();
            }
        } 

        $perms = array();

        foreach($this->getUserPermissions($options) as $prof) {
            if (($cap = $prof->capability) && ($mod = $cap->module)) {
                $perms[] = array(
                    'authorized' => $prof->sup_selected ? TRUE : FALSE,
                    'permission' => strtolower($cap->smc_name).'@'.$mod->sm_name,
                    'capability' => $cap->smc_name,
                    'module_name' => $mod->sm_name,
                    'module_path' => $mod->sm_api
                );
            }
        }

        return $perms;
    }

    public function getAccesses() {
        if ($this->role) {
            return $this->role->getAccesses();
        }
        return array();
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

    public static function createInvitationToken($data = array()) {
        return \Micro\App::getDefault()->security->encrypt($data, TRUE);
    }

    public function sendInvitation() {
        if (empty($this->su_email)) {
            return 'Alamat email tidak valid';
        }

        if (empty($this->su_invite_token)) {
            return 'Token tidak valid';
        }

        $app = \Micro\App::getDefault();
        $code = $app->url->encode($this->su_invite_token);

        $href = sprintf('%sinvitation?code=%s', $app->url->getClientUrl(), $code);
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