<?php
namespace App\Tasks\Interfaces;

interface TaskModel {

    public function afterCreate();
    public function afterUpdate();
    public function afterFetch();
    public function suspendLog();
    public function resumeLog();
    public function getNamespace();
    public function getTitle();
    public function getLink();
    public function getCurrentStatuses();

}