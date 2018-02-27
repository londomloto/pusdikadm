<?php
namespace App\Pendaftaran\Controllers;

use App\Users\Models\User;

class PendaftaranController extends \Micro\Controller {

    public function findAction() {

        return User::get()->filterable()->sortable()->paginate();

    }

}