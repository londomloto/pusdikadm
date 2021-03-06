<?php
namespace App\SuratMasuk\Models;

use App\Activities\Models\Activity;
use Micro\Helpers\Date;
use Phalcon\Mvc\Model\Relation;

class Task extends SuratMasuk implements \App\Tasks\Interfaces\TaskModel {
    
    private $__loggable = TRUE;
    private $__snapshot = NULL;
    
    public function initialize() {
        
        parent::initialize();

        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\TaskStatus',
            'tsms_tsm_id',
            array(
                'alias' => 'Statuses',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\TaskUser',
            'tsmu_tsm_id',
            array(
                'alias' => 'TaskUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'tsm_id',
            'App\SuratMasuk\Models\TaskUser',
            'tsmu_tsm_id',
            'tsmu_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Users'
            )
        );

        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\TaskLabel',
            'tsml_tsm_id',
            array(
                'alias' => 'TaskLabels',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'tsm_id',
            'App\SuratMasuk\Models\TaskLabel',
            'tsml_tsm_id',
            'tsml_sl_id',
            'App\Labels\Models\Label',
            'sl_id',
            array(
                'alias' => 'Labels'
            )
        );

        $this->hasOne(
            'tsm_created_by',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->belongsTo(
            'tsm_task_project',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Project'
            )
        );
    }

    public function getSource() {
        return 'trx_masuk';
    }

    public function getScope() {
        return 'surat-masuk';
    }

    public function afterCreate() {
        if ($this->__loggable) {
            $log = Activity::log('create', array(
                'ta_task_ns' => $this->getScope(),
                'ta_task_id' => $this->tsm_id,
                'ta_sp_id' => $this->tsm_task_project
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        
        $data['tsm_task_due_formatted'] = Date::format($this->tsm_task_due);
        $data['tsm_created_dt_relative'] = Date::formatRelative($this->tsm_created_dt);
        
        return $data;
    }

    public function suspendLog() {
        $this->__loggable = FALSE;
    }

    public function resumeLog() {
        $this->__loggable = TRUE;
    }

    public function getLink($absolute = FALSE) {
        $stat = $this->getCurrentStatuses()->getFirst();
        $link = NULL;

        if ($stat) {
            $link = 'worksheet/'.$this->project->sp_name.'/task/update/'.$stat->tsms_id;

            if ($absolute) {
                $link = \Micro\App::getDefault()->url->getClientUrl().$link;
            } else {
                $link = '/'.$link;
            }
        }
        
        return $link;
    }

    public function getCurrentStatuses() {
        return $this->getStatuses(array(
            'conditions' => 'tsms_deleted = 0',
            'orderBy' => 'tsms_created DESC'
        ));
    }

    public function saveUsers($post, $logging = TRUE) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getUsers() as $user) {
            $current[$user->su_id] = array(
                'su_id' => $user->su_id,
                'su_fullname' => $user->getName()
            );
        }

        foreach($post as $e) {
            if (isset($current[$e['su_id']])) {
                $updated[] = $e;
                unset($current[$e['su_id']]);
            } else {
                $created[] = $e;
            }
        }

        $removed = array_values(array_keys($current));

        if (count($removed) > 0) {
            TaskUser::get()
                ->inWhere('tsmu_su_id', $removed)
                ->andWhere('tsmu_tsm_id = :task:', array('task' => $this->tsm_id))
                ->execute()
                ->delete();

            if ($logging) {
                $users = array_values($current);

                $log = Activity::log('remove_user', array(
                    'ta_task_ns' => $this->getScope(),
                    'ta_sp_id' => $this->tsm_task_project,
                    'ta_task_id' => $this->tsm_id,
                    'ta_data' => json_encode($users)
                ));

                if ($log) {
                    $log->subscribe();
                }
            }

            
        }

        if (count($created) > 0) {
            $users = array();
            
            foreach($created as $e) {
                $r = new TaskUser();

                $r->tsmu_tsm_id = $this->tsm_id;
                $r->tsmu_su_id = $e['su_id'];
                $r->tsmu_persistent = isset($e['su_persistent']) ? $e['su_persistent'] : 1;

                $r->save();

                $users[] = array(
                    'su_id' => $e['su_id'],
                    'su_fullname' => $e['su_fullname']
                );
            }

            if ($logging) {
                $log = Activity::log('add_user', array(
                    'ta_task_ns' => $this->getScope(),
                    'ta_sp_id' => $this->tsm_task_project,
                    'ta_task_id' => $this->tsm_id,
                    'ta_data' => json_encode($users)
                ));

                if ($log) {
                    $log->subscribe();
                }
            }

            
        }
    }

    public function saveLabels($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getLabels() as $label) {
            $current[$label->sl_id] = array(
                'sl_id' => $label->sl_id,
                'sl_color' => $label->sl_color,
                'sl_label' => $label->sl_label
            );
        }

        foreach($post as $e) {
            if (isset($current[$e['sl_id']])) {
                $updated[] = $e;
                unset($current[$e['sl_id']]);
            } else {
                $created[] = $e;
            }
        }

        $removed = array_values(array_keys($current));

        if (count($removed) > 0) {
            TaskLabel::get()
                ->inWhere('tsml_sl_id', $removed)
                ->andWhere('tsml_tsm_id = :task:', array('task' => $this->tsm_id))
                ->execute()
                ->delete();

            $labels = array_values($current);

            $log = Activity::log('remove_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->tsm_task_project,
                'ta_task_id' => $this->tsm_id,
                'ta_data' => json_encode($labels)
            ));

            if ($log) {
                $log->subscribe();
            }
        }

        if (count($created) > 0) {
            $labels = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->tsml_tsm_id = $this->tsm_id;
                $r->tsml_sl_id = $e['sl_id'];
                $r->save();

                $labels[] = array(
                    'sl_id' => $e['sl_id'],
                    'sl_color' => $e['sl_color'],
                    'sl_label' => $e['sl_label']
                );
            }

            $log = Activity::log('add_label', array(
                'ta_task_ns' => $this->getScope(),
                'ta_sp_id' => $this->tsm_task_project,
                'ta_task_id' => $this->tsm_id,
                'ta_data' => json_encode($labels)
            ));

            if ($log) {
                $log->subscribe();
            }
        }
    }

    public function getAssignee() {
        return $this->getUsers()->filter(function($user){
            return $user->toSimpleArray();
        });
    }

    public function getAuthors() {
        $authors = array();

        if (($project = $this->project)) {
            $authors[] = $project->sp_creator_id;
        }

        if ($this->tsm_register_user) {
            $authors[] = $this->tsm_register_user;
        }

        $app = \Micro\App::getDefault();
        $auth = $app->auth->user();

        if ($app->role->can('manage@application')) {
            $authors[] = $auth['su_id'];
        }

        $authors = array_values(array_unique($authors));
        return $authors;
    }
    
    public function forward() {

    }
}