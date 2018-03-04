<?php
namespace App\Registration\Controllers;

use App\Registration\Models\Task;

class RegistrationController extends \Micro\Controller {

    public function findAction() {

        return Task::get()->filterable()->sortable()->paginate();

    }

}