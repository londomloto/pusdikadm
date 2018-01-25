<?php
namespace Micro\Ldap;

class LdapProvider extends \Micro\Component {

    private $__config;
    private $__connected;
    private $__conn;
    private $__auth;

    public function __construct() {

        // default config
        $config = array_merge(array(
            'version' => 3,
            'referals' => 0,
            'secure' => FALSE,
            'port' => 389,
            'base' => NULL
        ), $this->getApp()->config->ldap->toArray());

        $this->__config = new \Phalcon\Config($config);
    }

    public function connect() {
        if ($this->__connected) {
            return;
        }

        $host = trim($this->__config->host);
        $port = $this->__config->port;

        if ( ! preg_match('/^ldaps?/', $host)) {
            $host = ($this->__config->secure ? 'ldaps://' : 'ldap://').$host;
        }

        $host .= ':'.$port;

        $this->__conn = @\ldap_connect($host);
        
        if ($this->__conn) {
            @\ldap_set_option($this->__conn, LDAP_OPT_PROTOCOL_VERSION, $this->__config->version);
            @\ldap_set_option($this->__conn, LDAP_OPT_REFERRALS, $this->__config->referals);

            $this->__connected = TRUE;
        } else {
            throw new \Phalcon\Exception("Unable to connect to ldap server");
        }
    }

    public function disconnect() {
        if ($this->__connected) {
            \ldap_close($this->__conn);
            $this->__connected = FALSE;
        }
    }

    public function isConnected() {
        return $this->__connected;
    }

    public function getDomains() {
        $query = \ldap_read($this->__conn, NULL, 'objectClass=*', array('namingcontexts'));
        $result = \ldap_get_entries($this->__conn, $query);
        $domains = array();

        for ($i = 0; $i < $result['count']; $i++) {
            $data = $result[$i];
            $domains[] = array(
                'dn' => $data['namingcontexts'][0],
                'name' => \ldap_dn2ufn($data['namingcontexts'][0])
            );
        }

        return $domains;
    }

    public function login($username = NULL, $password = NULL) {
        $this->connect();

        if (empty($username) && empty($password)) {
            return $this->__bindAnon();
        } else if (empty($password)) {
            return $this->__bindCred($username);
        } else {
            return $this->__bindUser($username, $password);
        }
    }

    public function logout() {
        $this->disconnect();
    }

    public function query($node = NULL) {
        return new LdapQuery($this->__conn, $this->__config->base, $node);
    }

    private function __bindAnon() {
        return \ldap_bind($this->__conn);
    }

    private function __bindCred($username) {
        return FALSE;
    }

    private function __bindUser($username, $password) {
        $entry = $this->query('person')
            ->where('(cn='.$username.')')
            ->execute()
            ->getFirst();

        if ($entry) {
            if (\ldap_bind($this->__conn, $entry->dn, $password)) {
                return $entry;
            }
        }

        return FALSE;
    }
}