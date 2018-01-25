<?php
namespace App\Dashboard\Controllers;

use App\Projects\Models\Project,
    App\Tasks\Models\TaskStatus,
    App\Tasks\Models\TaskUser,
    App\Users\Models\User;

class AssignmentController extends \Micro\Controller {

    public function findAction() {

        $params = $this->request->getParams();
        $series = array();
        $config = array(
            'title' => 'Assignment',
            'subtitle' => ''
        );

        if (isset($params['projects'])) {
            $projectIds = json_decode($params['projects']);
            $userIds = isset($params['users']) ? json_decode($params['users']): array();

            $projects = Project::get()
                ->inWhere('sp_id', $projectIds)
                ->execute()
                ->map(function($e){
                    return $e;
                });

            $serie = array(
                'name' => 'assignment',
                'data' => array()
            );

            $users = array();
            $queryUser = FALSE;

            if (count($userIds) > 0) {
                $queryUser = TRUE;
                $users = User::get()
                    ->inWhere('su_id', $userIds)
                    ->execute()
                    ->map(function($e){
                        return $e;
                    });
            }

            foreach($projects as $project) {
                if ( ! $queryUser) {
                    $users = $project->users;
                }

                foreach($users as $user) {
                    $label = $user->getName();
                    $group = $label.'_'.$user->su_id;

                    if ( ! isset($serie['data'][$group])) {
                        $serie['data'][$group] = array(
                            'name' => $label,
                            'y' => 0
                        );
                    }

                    $query = TaskUser::get()
                        ->alias('a')
                        ->columns('COUNT(1) as total')
                        ->join('App\Tasks\Models\Task', 'a.ttu_tt_id = b.tt_id', 'b')
                        ->where('b.tt_sp_id = :project:', array('project' => $project->sp_id))
                        ->andWhere('a.ttu_su_id = :user:', array('user' => $user->su_id))
                        ->execute();


                    if ($query->count() > 0) {
                        // var_dump($query[0]->tt_title);
                        $serie['data'][$group]['y'] += (double)$query[0]->total;
                    }
                }
            }

            $serie['data'] = array_values($serie['data']);
            $series[] = $serie;
        }

        $result = array(
            'success' => TRUE,
            'data' => array(
                'series' => $series,
                'config' => $config
            )
        );

        return $result;

    }

}