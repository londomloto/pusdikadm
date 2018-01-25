<?php
namespace App\Users\Controllers;

use App\Users\Models\User,
    App\Users\Models\UserStatus,
    App\Projects\Models\Project;

class UsersStatusesController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getParams();
        $display = isset($params['display']) ? $params['display'] : NULL;

        $user = User::findFirst($params['user']);
        $project = Project::findFirst($params['project']);

        switch($display) {
            case 'setup':

                return UserStatus::querySetup($project, $user);
                
            case 'granted':
                
                return UserStatus::queryGranted($project, $user);

            default:
                
                return UserStatus::get()->paginate();
        }
    }

    public function saveAction() {
        $post = $this->request->getJson();
        $user = User::findFirst($post['user']);
        $project = Project::findFirst($post['project']);

        foreach($post['panels'] as $panel) {
            if ($panel['panel_display'] == 'show') {
                UserStatus::find(array(
                    'sus_sp_id = :project: AND sus_su_id = :user: AND sus_kp_id = :panel:',
                    'bind' => array(
                        'project' => $project->sp_id,
                        'user' => $user->su_id,
                        'panel' => $panel['panel_id']
                    )
                ))->delete();
            } else {
                $created = array();
                $updated = array();
                $deleted = array();

                $found = UserStatus::find(array(
                    'sus_sp_id = :project: AND sus_su_id = :user: AND sus_kp_id = :panel:',
                    'bind' => array(
                        'project' => $project->sp_id,
                        'user' => $user->su_id,
                        'panel' => $panel['panel_id']
                    )
                ))->toArray();

                $saved = array();

                foreach($found as $item) {
                    $key = $item['sus_id'];
                    $saved[$key] = array(
                        'checked' => $item['sus_checked']
                    );
                }

                foreach($panel['panel_statuses'] as &$item) {

                    if ($panel['panel_display'] == 'hide') {
                        $item['sus_checked'] = 0;
                    }

                    if (is_null($item['sus_id'])) {
                        $created[] = $item;
                    } else {
                        if (isset($saved[$item['sus_id']])) {
                            // $item['sus_checked'] = $saved[$item['sus_id']]['checked'];
                            $updated[] = $item;
                            unset($saved[$item['sus_id']]);
                        }
                    }
                }

                foreach($created as $data) {
                    $item = new UserStatus();
                    $item->save($data);
                }

                foreach($updated as $data) {
                    $item = UserStatus::findFirst($data['sus_id']);
                    if ($item) {
                        $item->save($data);
                    }
                }
            }
        }
        
        return array(
            'success' => TRUE
        );
    }

}