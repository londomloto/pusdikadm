<?php
namespace Micro;

use \PHPMailer\PHPMailer\PHPMailer;

// custom email validator
PHPMailer::$validator = function($email) {
    return Mailer::validateEmail($email);
};

class Mailer {
    
    private $_mail;
    private $_config;

    public function __construct($config = array()) {
        $this->_config = $config;
        
        if (strtoupper($this->_config->protocol) != 'RELAY') {
            $this->_mail   = new PHPMailer();
            
            switch ($this->_config->protocol) {
                case 'mail':
                    $this->_mail->isMail();
                    break;
                case 'sendmail':
                    $this->_mail->isSendmail();
                    $this->_mail->Host = $this->_config->smtp_host;
                    $this->_mail->Port = $this->_config->smtp_port;
                    break;
                case 'smtp':
                    $this->_mail->isSMTP();
                    $this->_mail->Host      = $this->_config->smtp_host;
                    $this->_mail->SMTPAuth  = $this->_config->smtp_auth;
                    $this->_mail->Username  = $this->_config->smtp_user;                 
                    $this->_mail->Password  = $this->_config->smtp_pass;                           
                    $this->_mail->SMTPSecure  = $this->_config->smtp_secure;  
                    $this->_mail->Port      = $this->_config->smtp_port;
                    $this->_mail->SMTPAutoTLS = FALSE;

                    if ($this->_config->smtp_secure != 'none') {
                        $this->_mail->SMTPOptions = array(
                            'ssl' => array(
                                'verify_peer' => false,
                                'verify_peer_name' => false
                            )
                        );
                    }

                    break;
                
                default:
                    $this->_mail->isMail();
                    break;
            }
            
            $this->_mail->isHTML(true);   
            $this->_mail->CharSet = 'UTF-8';
        }
    }

    

    public function send($params = false){
        if(is_array($params)){
            foreach ($params as $func => $param) {
                if (method_exists($this, '_'.$func)) $this->{'_'.$func}($param);
            }
        }

        if ( ! $this->_mail->Send()) {
            return $this->_mail->ErrorInfo;
        }

        // Clear address after send !
        $this->_mail->clearAddresses();
        $this->_mail->clearCCs();
        $this->_mail->clearBCCs();

        return TRUE;
    }

    public function from($email, $name = ''){
        $this->_from($email, $name);
    }

    public function to($email, $name = ''){
        $this->_to($email, $name);
    }

    public function subject($subject = FALSE){
        $this->_subject($subject);
    }

    public function body($body = FALSE){
        $this->_body($body);
    }

    

    private function _from($email, $name = ''){
        if (is_array($email)) {
            foreach($email as $key => $val) {
                if (is_numeric($key)) {
                    $addr = $val;
                    $name = '';
                } else {
                    $addr = $key;
                    $name = $val;
                }
                $this->_mail->setFrom($addr, $name);
            }
        } else {
            $this->_mail->setFrom($email, $name);
        }
    }
    
    public function account($alias, $email = FALSE) {
        $accounts = $this->_config->accounts->toArray();
        if (isset($accounts[$alias])) {
            $found = $accounts[$alias];
            if (is_array($found)) {
                if ($email && isset($found[0])) {
                    return $found[0];
                }
                return $found;
            }
            return $found;
        } else {
            return $alias.'@'.$_SERVER['SERVER_NAME'];
        }
    }

    private function _to($email, $name = ''){
        if (is_array($email)) {
            foreach($email as $key => $val) {
                if (is_numeric($key)) {
                    $addr = $val;
                    $name = '';
                } else {
                    $addr = $key;
                    $name = $val;
                }

                $this->_mail->addAddress($addr, $name);
            }
        } else {
            $this->_mail->addAddress($email, $name);
        }
    }

    private function _cc($cc){
        $this->_mail->addCC($cc);
    }

    private function _bcc($bcc){
        $this->_mail->addBCC($bcc);
    }

    private function _subject($subject = FALSE){
        if ($subject) $this->_mail->Subject = $subject;
    }

    private function _body($body = FALSE){
        if ($body) $this->_mail->Body = $body;
    }

    public static function validateEmail($email) {

        $parts = explode('@', $email);
        $domain = array_pop($parts);

        if ( ! empty($domain)) {
            $valid = filter_var($domain, FILTER_VALIDATE_IP);
            if ($valid) {
                $account = implode('', $parts);
                $email = $account.'@example.com';
            }
        }

        $valid = filter_var($email, FILTER_VALIDATE_EMAIL);
        return $valid !== FALSE;
    }
}