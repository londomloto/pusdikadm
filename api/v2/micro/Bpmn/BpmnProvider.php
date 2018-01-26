<?php
namespace Micro\Bpmn;

class BpmnProvider extends \Micro\Component {

    protected $_providers;
    protected static $_workers = array();
    protected $_config;

    public function __construct() {
        $app = $this->getApp();

        if ($app->config->offsetExists('bpmn')) {
            $this->_config = $app->config->bpmn;
        } else {
            throw new \Phalcon\Exception("BPMN configuration not found");
        }
    }
    
    public function workers() {
        $query = call_user_func_array($this->_config->providers->diagram.'::get', array());
        $query->orderBy('name ASC');
        $workers = array();

        foreach($query->execute() as $diagram) {
            $workers[] = $this->worker($diagram->slug);
        }

        return $workers;
    }

    public function worker($name) {
        $worker = isset(self::$_workers[$name]) ? self::$_workers[$name] : NULL;
        if (is_null($worker)) {
            $worker = new BpmnWorker($name, $this->_config);
            self::$_workers[$name] = $worker;
        }
        return $worker;
    }

}