<?php
namespace App\Grades\Models;

class Grade extends \Micro\Model {

    public function getSource() {
        return 'sys_grades';
    }

}