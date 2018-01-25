<?php
namespace App\Labels\Models;

class Label extends \Micro\Model {

    public function getSource() {
        return 'sys_labels';
    }
}