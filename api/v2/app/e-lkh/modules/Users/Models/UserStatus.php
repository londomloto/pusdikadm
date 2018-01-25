<?php
namespace App\Users\Models;

class UserStatus extends \Micro\Model {

    public function getSource() {
        return 'sys_users_statuses';
    }

    public static function queryGranted($project, $user) {
        $data = self::get()
            ->where('sus_sp_id = :project: AND sus_su_id = :user:', array(
                'project' => $project->sp_id,
                'user' => $user->su_id
            ))
            ->execute();

        return (object) array(
            'success' => TRUE,
            'data' => $data
        );
    }

    public static function querySetup($project, $user) {

        $result = array(
            'success' => TRUE,
            'data' => array()
        );

        if ($project->worksheet) {
            $data = array();

            foreach($project->worksheet->panels as $panel) {

                $statuses = array();
                $maps = array();

                $query = UserStatus::find(array(
                    'sus_sp_id = :project: AND sus_su_id = :user: AND sus_kp_id = :panel:',
                    'bind' => array(
                        'project' => $project->sp_id,
                        'user' => $user->su_id,
                        'panel' => $panel->kp_id
                    )
                ));

                if ($query->count() == 0) {
                    $display = 'show';
                } else {
                    $display = 'hide';

                    foreach($query as $item) {
                        $maps[$item->sus_kst_id] = array(
                            'id' => $item->sus_id,
                            'checked' => $item->sus_checked
                        );

                        if ($item->sus_checked == 1) {
                            $display = 'user';
                        }
                    }
                }

                foreach($panel->statuses as $ps) {
                    $ps = $ps->toArray();
                    
                    $id = NULL;
                    $checked = '0';

                    if (isset($maps[$ps['kst_id']])) {
                        $id = $maps[$ps['kst_id']]['id'];
                        $checked = (string) $maps[$ps['kst_id']]['checked'];
                    }

                    $statuses[] = array(
                        'sus_id' => $id,
                        'sus_su_id' => $user->su_id,
                        'sus_sp_id' => $project->sp_id,
                        'sus_kp_id' => $panel->kp_id,
                        'sus_kst_id' => $ps['kst_id'],
                        'sus_label' => $ps['kst_label'],
                        'sus_source_label' => $ps['kst_source_label'],
                        'sus_target_label' => $ps['kst_target_label'],
                        'sus_checked' => $checked
                    );
                }

                $data[] = array(
                    'panel_id' => $panel->kp_id,
                    'panel_title' => $panel->kp_title,
                    'panel_statuses' => $statuses,
                    'panel_display' => $display,
                    'panel_custom' => $display == 'user' ? TRUE : FALSE
                );

            }

            $result['data'] = $data;
        }

        return $result;

    }

}