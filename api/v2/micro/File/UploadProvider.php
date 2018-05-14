<?php
namespace Micro\File;

class UploadProvider {  

    protected $_types;
    protected $_path;
    protected $_encrypt;
    protected $_result;
    protected $_message;
    protected $_options;

    protected static $_mimes;

    public function __construct() {
        $this->_message = '';
        $this->_result = NULL;

        $this->reset();

        if (is_null(self::$_mimes)) {
            // load mimes
            self::$_mimes = require_once __DIR__.'/mimes.php';
        }
    }

    public function initialize($options = array()) {
        foreach($options as $key => $val) {
            $this->{'_'.$key} = $val;
        }
        return $this;
    }

    public function reset() {
        $options = \Micro\App::getDefault()->config->uploader->toArray();
        $this->initialize($options);
    }

    public function getMessage() {
        return $this->_message;
    }

    public function getResult() {
        return $this->_result;
    }

    public function upload() {
        $this->_message = '';
        $this->_result  = NULL;

        $request = \Micro\App::getDefault()->request;

        if ($request->hasFiles()) {
            $file = $request->getFiles();
            $file = $file[0];
            $mime = $file->getType();
            $orig = $file->getName();
            $name = $orig;

            $valid = FALSE;

            // validate mime
            if (count($this->_types) > 0) {
                $maps = isset(self::$_mimes[$mime]) ? self::$_mimes[$mime] : FALSE;
                if ($maps) {
                    $maps = array_flip($maps);
                    foreach($this->_types as $t) {
                        if (isset($maps[$t])) {
                            $valid = TRUE;
                            break;
                        }
                    }
                }
                if ( ! $valid) {
                    $this->_message = 'Format file tidak diperbolehkan';
                }
            } else {
                $valid = TRUE;
            }

            if ($valid) {
                if ($this->_encrypt) {
                    
                    $name = \Micro\App::getDefault()->security->getRandom()->uuid();
                    $name = str_replace('-', '', $name);
                    
                    if (($ext = $file->getExtension())) {
                        $name .= '.'.$ext;
                    }
                }

                $path = $this->_path.$name;
                $path = str_replace('\\', '/', $path);
                
                if (@$file->moveTo($path)) {
                    $this->_result = new \stdClass();

                    $this->_result->origname = $orig;
                    $this->_result->filename = $name;
                    $this->_result->filepath = $path;
                    $this->_result->filetype = $mime;
                    $this->_result->filesize = $file->getSize();

                    $this->reset();
                    return TRUE;
                } else {
                    $this->_message = 'Upload file gagal';
                }
            }
        } else {
            $this->_message = 'Tidak ada file yang diupload';
        }

        $this->reset();
        return FALSE;
    }
}