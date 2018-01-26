<?php
namespace Micro;

class Mailer {
    
    private $_mail;
    private $_config;

    public function __construct($config = array()) {
        $this->_config = $config;
        
        if(strtoupper($this->_config->protocol) != 'RELAY')
        {
            $this->_mail   = new \PHPMailer\PHPMailer\PHPMailer();
            
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
                if(method_exists($this, '_'.$func)) $this->{'_'.$func}($param);
            }
        }

        if(!$this->_mail->Send()) {
            return $this->_mail->ErrorInfo;
        }

        // Clear address after send !
        $this->_mail->clearAddresses();
        $this->_mail->clearCCs();
        $this->_mail->clearBCCs();
        return true;
    }

    public function from($from = false, $fromName = false){
        $this->_from($from,$fromName);
    }

    public function to($to = false, $toName = false){
        $this->_to($to, $toName);
        // $args = func_get_args();
        // call_user_func_array(array($this,'_to'), $args);
    }

    public function subject($subj= false){
        $this->_subject($subj);
    }

    public function body($body = false){
        $this->_body($body);
    }

    private function _from($from = false, $fromName = false){
        if(is_array($from)){
            foreach($from as $email => $name){
                if(!filter_var($email, FILTER_VALIDATE_EMAIL) && filter_var($name, FILTER_VALIDATE_EMAIL)){
                    $this->_mail->setFrom($name);
                }else{
                    $this->_mail->setFrom($email);
                    $this->_mail->FromName = $name;
                }
            }
        }else{
            $this->_mail->setFrom($from);
        }
        // if($from) 
        // if($fromName) $this->_mail->FromName = $fromName;
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

    private function _to($to = false, $toName = false){
        if(is_array($to)){
            foreach ($to as $email => $name) {
                if( ! filter_var($email, FILTER_VALIDATE_EMAIL) && filter_var($name, FILTER_VALIDATE_EMAIL)){
                    $this->_mail->addAddress($name);
                } else {
                    $this->_mail->addAddress($email, $name);
                }
            }
        }else{
            if(filter_var($to, FILTER_VALIDATE_EMAIL) && !$toName){
                $this->_mail->addAddress($to);
            }else if(filter_var($to, FILTER_VALIDATE_EMAIL) && $toName){
                $this->_mail->addAddress($to,$toName);
            }
        }
    }

    private function _cc($cc = false){
        if($cc && filter_var($cc, FILTER_VALIDATE_EMAIL)) $this->_mail->addCC($cc);     
    }

    private function _bcc($bcc = false){
        if($bcc && filter_var($bcc, FILTER_VALIDATE_EMAIL)) $this->_mail->addBCC($bcc);     
    }

    private function _subject($subj = false){
        if($subj) $this->_mail->Subject = $subj;
    }

    private function _body($body = false){
        if($body) $this->_mail->Body = $body;
    }

}