<?php
namespace Micro\Auth;

class AuthProvider extends \Micro\Component {

    protected $_providers;
    protected $_error;
    protected $_captcha;
    protected $_user;
    
    public function __construct() {
        $config = $this->getApp()->config->auth;

        $this->_providers = $config->providers;
        $this->_captcha = $config->captcha;
    }

    protected function _run($class, $method, $args = array()) {
        return call_user_func_array(array($class, $method), $args);
    }

    protected function _findUserByEmail($email) {
        return $this->_run($this->_providers->user, 'findFirstByEmail', array($email));
    }

    public function isCaptchaEnabled() {
        return $this->_captcha->enabled === TRUE;
    }

    public function id($token = NULL) {
        $user = $this->user($token);
        return $user ? $user['id'] : NULL;
    }

    public function user($token = NULL, $model = FALSE) {
        if (empty($token)) {
            $user = $this->_user;
            $data = NULL;

            if (is_null($user)) {
                $token = $this->token();

                if ($token) {
                    try {
                        $decode = $this->security->decodeToken($token);
                        $user = $this->_findUserByEmail($decode->data->su_email);
                        
                        if ($user) {
                            $this->_user = $user;
                            
                            $data = $user->toArray();
                            $this->secure($data);
                        }
                    }  catch(\Exception $ex) {}
                }
            } else {
                $data = $user->toArray();
            }

            return $model ? $user : $data;

        } else {
            $data = NULL;
            $user = NULL;

            try {
                $decode = $this->security->decodeToken($token);
                $user = $this->_findUserByEmail($decode->data->su_email);
                
                if ($user) {
                    $data = $user->toArray();
                    $this->secure($data);
                }
            }  catch(\Exception $ex) {}

            return $model ? $user : $data;
        }
    }

    public function guest() {
        
    }

    public function validate($token = NULL) {
        if ( ! $token) {
            $token = $this->token();    
        }
        
        if ($token) {
            try {
                $this->security->decodeToken($token);
                return TRUE;
            } 
            catch(\Exception $ex) {}
        }

        return FALSE;
    }

    public function login($email, $password, $remember = FALSE) {
        
        $user = $this->_findUserByEmail($email);

        if ( ! $user) {
            $this->_error = 'Pengguna tidak terdaftar';
            return FALSE;
        }

        if ( ! $user->su_active) {
            $this->_error = 'Akun Anda dalam pemblokiran';
            return FALSE;
        }

        if ( ! $this->security->verifyHash($password, $user->su_passwd)) {
            $this->_error = 'Sepertinya username dan password salah';
            return FALSE;
        }

        $user->su_access_token = $this->security->createToken(array(
            'su_email' => $user->su_email,
            'su_sr_id'  => $user->su_sr_id
        ));

        $user->save();

        $data = $user->toArray();
        $this->_user = $user;

        $this->secure($data);

        return $data;
    }

    public function logout() {
        // token lempar ke kotak sampah
        $this->_user = NULL;
    }

    public function token() {
        $token = $this->request->getQuery('access_token');

        if (empty($token)) {
            $header = $this->request->getHeader('Authorization');

            if (preg_match('/Bearer\s+(.*)/', $header, $matches)) {
                $token = $matches[1];
            }
        }

        return empty($token) ? NULL : $token;
    }

    public function error() {
        return $this->_error;
    }

    public function secure(&$user) {
        unset($user['su_passwd']);
        unset($user['su_invite_token']);
        unset($user['su_recover_token']);

        return $user;
    }

}