<?php
namespace Micro\Http;

class Client {

    protected $_remote;
    protected $_method;
    protected $_output;
    protected $_engine;
    protected $_result;

    public function send($method, $remote, $data = array(), $options = array()) {
        $method = strtoupper($method);

        $this->_remote = $remote;
        $this->_method = $method;
        $this->_engine = curl_init();

        if (is_null($data)) {
            $data = array();
        }

        if (is_null($options)) {
            $options = array();
        }

        if ( ! isset($options['headers'])) {
            $options['headers'] = array();
        }

        $jsonRequest = isset($options['json']) && $options['json'] == TRUE;

        if ($jsonRequest) {
            $options['headers'][] = 'Content-Type: application/json';
        }

        switch($method) {
            case 'POST':
                
                curl_setopt($this->_engine, CURLOPT_POST, TRUE);

                if (count($data) > 0) {
                    if ($jsonRequest) {
                        $data = json_encode($data);
                    }
                    curl_setopt($this->_engine, CURLOPT_POSTFIELDS, $data);
                } else {
                    curl_setopt($this->_engine, CURLOPT_POSTFIELDS, '');
                }

                break;

            case 'GET':
            default:

                if (count($data) > 0) {
                    $query = http_build_query($data);
                    $this->_remote .= (strpos($this->_remote, '?') !== FALSE ? '&' : '?') . $query;
                }
        }

        $this->_setup($options);

        $this->_output = curl_exec($this->_engine);
        $this->_result = curl_getinfo($this->_engine);

        curl_close($this->_engine);
        $this->_engine = NULL;

        return $this->_output;
    }

    public function get($remote, $data = array(), $options = array()) {
        return $this->send('GET', $remote, $data, $options);
    }

    public function post($remote, $data = array(), $options = array()) {
        return $this->send('POST', $remote, $data, $options);
    }

    public function result($key = NULL, $default = NULL) {
        if (is_null($key)) {
            return $this->_result;
        }
        return isset($this->_result[$key]) ? $this->_result[$key] : $default;
    }

    public function save($file) {
        $open = fopen($file, 'w');

        if ($open) {
            fwrite($open, $this->_output);
            fclose($open);
        }

        $open = NULL;

        return file_exists($file);
    }

    public function output() {
        return $this->_output;
    }

    protected function _setup($options) {
        curl_setopt($this->_engine, CURLOPT_URL, $this->_remote);
        curl_setopt($this->_engine, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
        //curl_setopt($this->_engine, CURLOPT_REFERER, 'https://www.google.com');

        if (isset($options['headers']) && count($options['headers']) > 0) {
            curl_setopt($this->_engine, CURLOPT_HTTPHEADER, $options['headers']);
        }

        if (isset($options['range'])) {
            curl_setopt($this->_engine, CURLOPT_RANGE, $options['range']);
        }

        if (isset($options['writer'])) {
            curl_setopt($this->_engine, CURLOPT_WRITEFUNCTION, $options['writer']);
        } else {
            curl_setopt($this->_engine, CURLOPT_RETURNTRANSFER, TRUE);
        }

        if (isset($options['redirect'])) {
            curl_setopt($this->_engine, CURLOPT_FOLLOWLOCATION, TRUE);
        }

        if (isset($options['header'])) {
            curl_setopt($this->_engine, CURLOPT_HEADER, TRUE); 
        }

        if (isset($options['body']) && $options['body'] === FALSE) {
            curl_setopt($this->_engine, CURLOPT_NOBODY, TRUE); 
        }

        if (isset($options['binary'])) {
            curl_setopt($this->_engine, CURLOPT_BINARYTRANSFER, TRUE); 
        }

        if (stripos($this->_remote, 'https://') === 0 || isset($options['insecure'])) {
            curl_setopt($this->_engine, CURLOPT_SSL_VERIFYHOST, FALSE);
            curl_setopt($this->_engine, CURLOPT_SSL_VERIFYPEER, FALSE);
        }
    }

}