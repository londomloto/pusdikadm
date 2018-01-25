<?php
namespace App\Departments\Models;

class Department extends \Micro\Model {

    public function getSource() {
        return 'sys_departments';
    }

}