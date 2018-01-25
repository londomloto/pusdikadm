<?php
namespace App\Jobs\Models;

class Job extends \Micro\Model {

    public function getSource() {
        return 'sys_jobs';
    }

}