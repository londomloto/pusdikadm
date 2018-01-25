<?php
namespace Micro\Ldap;

class LdapResult implements \Iterator {

    private $__cursor;
    private $__entries;
    private $__count;

    public function __construct($conn, $query) {
        $this->__cursor = 0;
        $this->__entries = array();
        $this->__count = 0;

        $item = \ldap_first_entry($conn, $query);

        if ($item) {
            do {
                $entry = new LdapEntry($conn, $item);
                $this->__entries[] = $entry;
                $this->__count++;
            } while($item = \ldap_next_entry($conn, $item));    
        }
    }

    public function count() {
        return $this->__count;
    }

    public function getFirst() {
        return isset($this->__entries[0]) ? $this->__entries[0] : FALSE;
    }

    public function key() {
        return $this->__cursor;
    }

    public function current() {
        return $this->__entries[$this->__cursor];
    }

    public function rewind() {
        $this->__cursor = 0;
    }

    public function next() {
        ++$this->__cursor;
    }

    public function valid() {
        return isset($this->__entries[$this->__cursor]);
    }

}