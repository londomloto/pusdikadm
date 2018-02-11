<?php
namespace App\References\Controllers;

use App\Projects\Models\Project,
    App\Receiver\Models\Receiver;

class ReceiverController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getParams();


        if (isset($params['project'])) {
            $project = Project::findFirst(array('sp_name = :name:', 'bind' => array('name' => $params['project'])));

            if ($project) {
                $project = $project->toArray();
                $group = $project['sp_worksheet_purpose'];

                $result = Receiver::get()
                    ->andWhere('trc_group = :group:', array('group' => $group))
                    ->filterable()
                    ->paginate();

                return $result;
            }
        }

        return array(
            'success' => TRUE,
            'data' => array(),
            'total' => 0
        );

    }

}