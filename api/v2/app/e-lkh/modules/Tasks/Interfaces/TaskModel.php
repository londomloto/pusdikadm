<?php
namespace App\Tasks\Interfaces;

interface TaskModel {

    public function afterCreate();
    // public function afterUpdate();
    // public function afterFetch();
    public function suspendLog();
    public function resumeLog();
    public function getScope();
    public function getTitle();
    public function getLink();
    public function getCurrentStatuses();
    public function forward();
    
}