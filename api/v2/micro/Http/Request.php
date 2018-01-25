<?php
namespace Micro\Http;

class Request extends \Phalcon\Http\Request {
    
    public function getParams() {
        $query = $this->getQuery();
        unset($query['_url']);

        return $query;
    }

    public function getJson($field = NULL, $filters = NULL) {
        $json = $this->getJsonRawBody(TRUE);

        if (is_null($field)) {
            return $json;
        }

        $value = isset($json[$field]) ? $json[$field] : NULL;

        if ( ! is_null($value) && ! is_null($filters)) {
            $value = $this->getDI()->getShared('filter')->sanitize($value, $filters);
        }

        return $value;
    }

    public function getFiles() {
        return $this->getUploadedFiles();
    }

}