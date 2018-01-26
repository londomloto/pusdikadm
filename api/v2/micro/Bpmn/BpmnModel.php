<?php
namespace Micro\Bpmn;

class BpmnModel {

    protected $_model;
    protected $_identity;

    public function __construct($model) {
        $this->_model = $model;

        // find primary key
        $instance = new $model();
        $metadata = $instance->getModelsMetadata();
        $identity = $metadata->getPrimaryKeyAttributes($instance);

        unset($instance);

        if (is_array($identity) && count($identity) > 0) {
            $this->_identity = $identity[0];
        }

    }

    public function id($model) {
        if ($this->_identity) {
            if (is_array($model)) {
                return isset($model[$this->_identity]) ? $model[$this->_identity] : NULL;
            } else {
                return isset($model->{$this->_identity}) ? $model->{$this->_identity} : NULL;
            }
        }
        return NULL;
    }

    public function data($id) {
        if ($this->_model) {
            return call_user_func_array($this->_model.'::findFirst', array($id));
        }
        return NULL;
    }

    public function save($data = array()) {
        if ($this->_identity) {
            $id = isset($data[$this->_identity]) && !empty($data[$this->_identity]) ? $data[$this->_identity] : FALSE;
            
            if ( ! $id) {
                return call_user_func_array($this->_model.'::dbcreate', array($data));
            } else {
                return call_user_func_array($this->_model.'::dbupdate', array($id, $data));
            }
        }   

        return (object) array(
            'success' => FALSE,
            'data' => NULL,
            'message' => 'Primary key tidak ditemukan'
        );
    }
}