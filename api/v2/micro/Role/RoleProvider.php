<?php
namespace Micro\Role;

class RoleProvider extends \Micro\Component {

    protected $_providers;
    protected $_auth;

    public function __construct() {
        $app = $this->getApp();

        $this->_providers = $app->config->role->providers;
        $this->_auth = $app->auth;
    }

    protected function _run($class, $method, $args) {
        return call_user_func_array(array($class, $method), $args);
    }

    protected function _get($model = FALSE) {
        static $role;

        if (is_null($role)) {
            $user = $this->_auth->user();    
            if ($user && ! empty($user['su_sr_id'])) {
                $role = $this->_run($this->_providers->role, 'findFirst', array($user['su_sr_id']));
            } else {
                $role = FALSE;
            }
        }
        
        return $role ? ($model ? $role : $role->toArray()) : NULL;
    }

    public function is($name = NULL) {
        return $this->name() == $name;
    }

    public function model() {
        return $this->_get(TRUE);
    }

    public function id() {
        $role = $this->_get();
        return $role ? $role['sr_id'] : NULL;
    }

    public function name() {
        $role = $this->_get();
        return $role ? $role['sr_slug'] : NULL;
    }

    public function menus() {
        $user = $this->_auth->user(NULL, TRUE);
        if ($user) {

            $nodes = array();
            
            $menus = $user->getMenus()->filter(function($elem){ 
                if ($elem->smn_visible == 1) {
                    return $elem;
                }
            });

            $stack = array_flip(array_map(function($elem){ return $elem->smn_id; }, $menus));

            foreach($menus as $menu) {
                if ($menu->smn_parent_id != 0) {
                    $menu->bubble(function($elem) use (&$stack, &$nodes){
                        if ( ! isset($stack[$elem->smn_id])) {
                            $nodes[] = $elem;
                            $stack[$elem->smn_id] = TRUE;
                        }
                    });
                }
                $nodes[] = $menu;
            }

            usort($nodes, function($a, $b){
                $va = $a->smn_order;
                $vb = $b->smn_order;

                if ($va == $vb) return 0;
                return $va < $vb ? -1 : 1;
            });

            $tree = array();

            self::__createTreeMenu($nodes, 0, $tree);

            return $tree;
        }

        return array();
    }

    private static function __createTreeMenu($menus, $parentId, &$result) {
        $stack = array_slice($menus, 0);

        foreach($menus as $idx => $elem) {
            if ($elem->smn_parent_id == $parentId) {
                $node = $elem->toArray();

                if (self::__menuIsParent($elem, $stack)) {
                    $node['smn_children']  = array();
                    self::__createTreeMenu($menus, $elem->smn_id, $node['smn_children']);
                } else {
                    array_splice($stack, $idx, 1);
                }
                $result[] = $node;
            }
        }
    }

    private static function __menuIsParent($menu, $menus) {
        foreach($menus as $elem) {
            if ($elem->smn_parent_id == $menu->smn_id) {
                return TRUE;
            }
        }
        return FALSE;
    }

    public function permissions() {
        static $perms;

        if (is_null($perms)) {
            $user = $this->_auth->user(NULL, TRUE);
            $perms = array();

            if ($user) {
                foreach($user->getPermissions() as $cap) {
                    $module = $cap->module;
                    if ($module) {
                        $context = $module->sm_name;
                        $permission = strtolower($cap->smc_name).'@'.$context;

                        $perms[] = array(
                            'permission' => $permission, 
                            'module' => $context,
                            'capability' => $cap->smc_name,
                            'description' => $cap->smc_description
                        );
                    }
                }
            }
        }

        return $perms;
    }

    public function has($permission) {
        static $stack;

        if (is_null($stack)) {
            $stack = array();
            if ($this->_providers->offsetExists('capability')) {

                $part = explode('@', $permission);
                $name = $part[0];

                $find = call_user_func_array(
                    $this->_providers->capability.'::find', 
                    array(
                        array(
                            'smc_name = :name:',
                            'bind' => array(
                                'name' => $name
                            )
                        )
                    )
                );

                foreach($find as $row) {
                    $perm = $row->getNamespace();
                    $stack[$perm] = TRUE;
                }
            }
        }

        return isset($stack[$permission]);
    }

    public function can($permission) {
        static $stack;

        if (is_null($stack)) {
            $stack = array_flip(array_map(function($e){ return $e['permission']; }, $this->permissions()));
        }

        return isset($stack[$permission]);
    }

    public function validate($permission) {
        if ( ! $this->can($permission)) {
            throw new \Phalcon\Exception("You don't have privilege to perform this action");
        }
    }

}


class XRole {

    protected $_permissions;

    public function __construct(\Sys\Core\IApplication $app) {
        parent::__construct($app);

        if ($app->getConfig()->application->has('role')) {
            $this->_config = $app->getConfig()->application->role;
        } else {
            $this->_config = new \Sys\Core\Config(array(
                'source' => 'role'
            ));
        }

        $this->_permissions = $app->getConfig()->permissions;
        $this->_db = $app->getDefaultDatabase();
    }

    public function findBy($field, $value) {
        $source = $this->_config->source;
        $params = array($value);
        return $this->_db->fetchOne("SELECT * FROM {$source} WHERE {$field} = ?", array($value));
    }

    public function findById($id) {
        return $this->findBy('id', $id);
    }

    public function findByName($name) {
        return $this->findBy('name', $name);
    }

    public function findDefault() {
        return $this->findBy('is_default', 1);
    }

    public function getAvailablePermissions() {
        $perms = array();

        foreach($this->_permissions as $key => $spec) {
            $spec = $spec->toArray();
            $spec['name'] = $key;
            $perms[] = $spec;
        }

        return $perms;
    }

    public function getPermissions() {
        $session = $this->getSession();

        if ( ! $session->has('CURRENT_ROLE')) {
            return array();
        }

        $perms = $session->get('CURRENT_PERMISSIONsS');
        $perms = json_decode($perms);

        return $perms;
    }

    public function getPermissionWeight($name) {
        $name = trim($name);

        if ($this->_permissions->has($name)) {
            return pow(2, $this->_permissions->{$name}->value);
        }
        return 0;
    }

    public function assignPermissionToRole($role, $perms) {
        $bit = 0;

        if ($role) {
            
            foreach($perms as $key) {
                $bit |= $this->getPermissionWeight($key);
            }
        }

        $source = $this->_config->source;
        $this->_db->execute("UPDATE {$source} SET permission = ? WHERE id = ?", array($bit, $role->id));
    }

    public function assign($perms) {
        $role = $this->getCurrentRole();
        $this->assignPermissionToRole($role->name, $perms);
    }

    public function roleHasPermission($role, $perm) {
        if ($role) {
            $weight = $this->getPermissionWeight($perm);
            return ((int)$role->permission & $weight);
        }
        return 0;
    }

    public function has($perm) {
        $role = $this->getCurrentRole();
        return $this->roleHasPermission($perm);
    }

    public function roleCanPerform($role, $perm) {
        if ($role) {

            $self = $this;
            $perm = explode('&', $perm);
            
            if (count($perm) > 0) {
                $curr = (int)$role->permission;
                $able = TRUE;

                // array_every
                foreach($perm as $p) {
                    $able = !!($curr & $this->getPermissionWeight($p));
                    if ( ! $able) {
                        break;
                    }
                }

                return $able;
            } else {
                return FALSE;
            }
        }
        return FALSE;
    }

    public function can($perm) {
        $role = $this->getCurrentRole();
        return $this->roleCanPerform($role, $perm);
    }

    public function handle($name) {
        if ( ! $name) {
            $this->invalidate();
            return;
        }

        $session = $this->getSession();

        if ($session->has('CURRENT_ROLE') && $session->get('CURRENT_ROLE') == $name) {
            return;
        }

        $role = $this->findByName($name);

        if ($role) {
            $session->set('CURRENT_ROLE', $role);
        }
    }

    public function refresh() {
        $user = $this->getAuth()->getCurrentUser();
        $role = $this->getCurrentRole();

        if ($user && $role) {
            if ($user->role == $role) {
                $this->invalidate();
                $this->handle($role);
            }
        }
    }

    public function invalidate() {
        $session = $this->getSession();
        $session->remove('CURRENT_ROLE');
    }

    public function getCurrentRole() {
        $session = $this->getSession();
        return $session->get('CURRENT_ROLE');
    }

    public function validate($perm) {
        if ( ! $this->can($perm)) {
            throw new \Exception(_("You don't have permission to perform this action"), 403);
        }
    }
    
}