<?php
namespace Micro\Ldap;

class LdapEntry implements \JsonSerializable {

    private $__data;

    public function __construct($conn, $entry) {
        $this->__data = array();

        $attr = \ldap_get_attributes($conn, $entry);
        $data = array();

        $excludes = array('objectClass', 'count');

        foreach($attr as $key => $val) {
            if (is_string($key) && ! in_array($key, $excludes)) {
                $data[$key] = is_array($val) ? $val[0] : $val;
                $this->$key = $data[$key];
            }
        }

        $data['dn'] = \ldap_get_dn($conn, $entry);
        $this->dn = $data['dn'];

        $this->__data = $data;
    }

    public function toArray() {
        return $this->__data;
    }

    public function jsonSerialize() {
        return $this->toArray();
    }

}