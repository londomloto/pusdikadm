<?php
namespace Micro;

abstract class Component {

    protected $_di;
    protected $_providers = array();

    public function ready() {
        
    }

    public function setDI($di) {
        $this->_di = $di;
    }

    public function getDI() {
        return $this->_di;
    }

    public function getApp() {
        return $this->_di->get('app', TRUE);
    }

    public function __get($key) {
        if (isset($this->_providers[$key])) {
            return $this->_providers[$key];
        }

        $di = $this->getDI();

        if ($di->has($key)) {
            $provider = $di->get($key, TRUE);
            $this->_providers[$key] = $provider;
            return $provider;
        } else {
            $class = get_called_class();
            throw new \Phalcon\Exception("Undefined property: {$class}::\${$key}");
        }
    }
}