<?php
namespace Micro\Ldap;

class LdapQuery {

    private $__conn;
    private $__base;
    private $__node;
    private $__cond;

    public function __construct($conn, $base, $node = NULL) {
        $this->__conn = $conn;
        $this->__base = $base;
        $this->__node = $node;
        $this->__cond = NULL;
    }

    public function where($condition) {
        $this->__cond = $condition;
        return $this;
    }

    public function execute() {
        $where = empty($this->__node) ? '(objectClass=*)' : '(objectClass='.$this->__node.')';
        
        if ( ! empty($this->__cond)) {
            $where = '(&'.$where.$this->__cond.')';
        }

        $query = \ldap_search($this->__conn, $this->__base, $where);
        return new LdapResult($this->__conn, $query);
    }

}