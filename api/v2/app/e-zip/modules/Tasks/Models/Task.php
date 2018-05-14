<?php
namespace App\Tasks\Models;

use App\Tasks\Models\TaskLabel,
    App\Tasks\Models\TaskUser,
    App\Tasks\Models\TaskActivity,
    App\Tasks\Models\TaskStatus,
    Phalcon\Mvc\Model\Relation;

class Task extends \Micro\Model {

    private $__snapshot = NULL;
    private $__loggable = TRUE;

    public function initialize() {
        
        $this->hasMany(
            'tt_id',
            'App\Tasks\Models\TaskStatus',
            'tts_tt_id',
            array(
                'alias' => 'Statuses',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasOne(
            'tt_creator_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->belongsTo(
            'tt_sp_id',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Project'
            )
        );

        $this->hasMany(
            'tt_id',
            'App\Tasks\Models\TaskLabel',
            'ttl_tt_id',
            array(
                'alias' => 'TaskLabels',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'tt_id',
            'App\Tasks\Models\TaskLabel',
            'ttl_tt_id',
            'ttl_sl_id',
            'App\Labels\Models\Label',
            'sl_id',
            array(
                'alias' => 'Labels'
            )
        );

        $this->hasManyToMany(
            'tt_id',
            'App\Tasks\Models\TaskUser',
            'ttu_tt_id',
            'ttu_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Users'
            )
        );

        $this->hasMany(
            'tt_id',
            'App\Tasks\Models\TaskUser',
            'ttu_tt_id',
            array(
                'alias' => 'TaskUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'tt_id',
            'App\Tasks\Models\TaskActivity',
            'tta_tt_id',
            array(
                'alias' => 'Activities',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_tasks';
    }

    public function suspendLog() {
        $this->__loggable = FALSE;
    }

    public function resumeLog() {
        $this->__loggable = TRUE;
    }
    
    public function afterFetch() {
        
        if (isset(
            $this->tt_id, 
            $this->tt_due_date
        )) {
            $this->__snapshot = array(
                'tt_id' => $this->tt_id,
                'tt_due_date' => $this->tt_due_date
            );
        }
    }

    public function afterCreate() {
        if ($this->__loggable) {
            TaskActivity::log('create', array(
                'tta_tt_id' => $this->tt_id,
                'tta_data' => $this->tt_title
            ));    
        }
    }

    public function afterUpdate() {
        if ($this->__loggable) {
            $snapshot = $this->__snapshot;

            if ( ! is_null($snapshot) && ! empty($snapshot['tt_id'])) {

                $detail = TRUE;

                if ($snapshot['tt_due_date'] != $this->tt_due_date) {
                    
                    $detail = FALSE;

                    TaskActivity::log('update_due', array(
                        'tta_tt_id' => $this->tt_id,
                        'tta_data' => $this->tt_due_date
                    ));
                }

                if ($detail) {

                    TaskActivity::log('update', array(
                        'tta_tt_id' => $this->tt_id,
                        'tta_data' => $this->tt_title
                    ));
                }
            }
        }
    }

    public function toArray($columns = NULL) {
        $auth = \Micro\App::getDefault()->auth->user();
        $data = parent::toArray($columns);

        $data['creator_su_fullname'] = '';

        if ($this->creator) {
            $creator = $this->creator->toArray();

            $data['creator_su_fullname'] = $creator['su_fullname'];
            $data['creator_su_avatar_thumb'] = $creator['su_avatar_thumb'];
            $data['creator_sr_name'] = $creator['sr_name'];
        }

        $data['tt_created_dt_relative'] = self::__relativeTime($this->tt_created_dt);
        $data['tt_created_dt_formatted'] = self::__formatDate($this->tt_created_dt);
        $data['tt_updated_dt_formatted'] = self::__formatDate($this->tt_updated_dt);
        $data['tt_due_date_relative'] = self::__relativeTime($this->tt_due_date, 'd M Y');
        $data['tt_due_date_formatted'] = self::__formatDate($this->tt_due_date, 'd M Y');

        $data['tt_is_authorized'] = FALSE;

        if ($auth['su_id'] == $data['tt_creator_id']) {
            $data['tt_is_authorized'] = TRUE;
        }

        return $data;
    }

    public function getCurrentStatuses() {
        return $this->getStatuses(array(
            'conditions' => 'tts_deleted = 0',
            'orderBy' => 'tts_created DESC'
        ));
    }

    public function getPrevStatuses() {
        $current = $this->getCurrentStatuses();
        foreach($current as $c) {
            
        }
    }

    public function next($payload = NULL) {
        $app = \Micro\App::getDefault();

        $statuses = $this->getCurrentStatuses();
        $payload = is_null($payload) ? $this->toArray() : $payload;
        $worker = NULL;
        $affected = array();
        $removed = array();

        foreach($statuses as $status) {
            if (is_null($worker)) {
                $worker = $app->bpmn->worker($status->tts_worker);
            }

            $next = $worker->next($status->tts_status, $payload);
            $affected[] = $status->tts_status;

            if (count($next['data']) > 0) {
                $nextids = array_map(function($n){ return $n['id']; }, $next['data']);

                TaskStatus::get()
                    ->inWhere('tts_status', $nextids)
                    ->andWhere('tts_id = :id:', array('id' => $this->tt_id))
                    ->execute()
                    ->delete();

                foreach($next['data'] as $n) {
                    $affected[] = $n['id'];

                    $found = TaskStatus::findFirst(array(
                        'tts_tt_id = :id: AND tts_status = :status: AND tts_deleted = 0',
                        'bind' => array(
                            'id' => $this->tt_id,
                            'status' => $n['id']
                        )
                    ));

                    if ( ! $found) {
                        $item = new TaskStatus();
                        
                        $create = array(
                            'tts_tt_id' => $this->tt_id,
                            'tts_status' => $n['id'],
                            'tts_target' => $n['target'],
                            'tts_worker' => $worker->name(),
                            'tts_deleted' => 0,
                            'tts_created' => date('Y-m-d H:i:s')
                        );
                        
                        if ($item->save($create)) {
                            $removed[] = $status;
                        }
                    } else {
                        $removed[] = $status;
                    }
                }
            }
        }

        // nothing changed
        if (count($removed) > 0) {
            foreach($removed as $m) {
                $m->save(array('tts_deleted' => 1));
            }
        }
        
        $affected = array_values(array_unique($affected));
        
        return $affected;
    }

    public function saveLabels($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getLabels() as $e) {
            $current[$e->sl_id] = TRUE;
        }

        foreach($post as $e) {
            if (isset($current[$e['sl_id']])) {
                $updated[] = $e;
                unset($current[$e['sl_id']]);
            } else {
                $created[] = $e;
            }
        }

        $current = array_values(array_keys($current));

        if (count($current) > 0) {
            TaskLabel::get()
                ->inWhere('ttl_sl_id', $current)
                ->andWhere('ttl_tt_id = :task:', array('task' => $this->tt_id))
                ->execute()
                ->delete();

            TaskActivity::log('remove_label', array(
                'tta_tt_id' => $this->tt_id,
                'tta_data' => json_encode($current)
            ));
        }

        if (count($created) > 0) {
            $indexes = array();

            foreach($created as $e) {
                $r = new TaskLabel();
                $r->ttl_tt_id = $this->tt_id;
                $r->ttl_sl_id = $e['sl_id'];
                $r->save();

                $indexes[] = $e['sl_id'];
            }

            TaskActivity::log('add_label', array(
                'tta_tt_id' => $this->tt_id,
                'tta_data' => json_encode($indexes)
            ));
        }
    }

    public function saveUsers($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getUsers() as $e) {
            $current[$e->su_id] = TRUE;
        }

        foreach($post as $e) {
            if (isset($current[$e['su_id']])) {
                $updated[] = $e;
                unset($current[$e['su_id']]);
            } else {
                $created[] = $e;
            }
        }

        $current = array_values(array_keys($current));

        if (count($current) > 0) {
            TaskUser::get()
                ->inWhere('ttu_su_id', $current)
                ->andWhere('ttu_tt_id = :task:', array('task' => $this->tt_id))
                ->execute()
                ->delete();

            TaskActivity::log('remove_user', array(
                'tta_tt_id' => $this->tt_id,
                'tta_data' => json_encode($current)
            ));
        }

        if (count($created) > 0) {
            $indexes = array();

            foreach($created as $e) {
                $r = new TaskUser();

                $r->ttu_tt_id = $this->tt_id;
                $r->ttu_su_id = $e['su_id'];
                $r->save();

                $indexes[] = $e['su_id'];
            }

            TaskActivity::log('add_user', array(
                'tta_tt_id' => $this->tt_id,
                'tta_data' => json_encode($indexes)
            ));
        }
    }

    private static function __formatDate($date, $format = "d M Y H:i") {
        if (empty($date)) {
            return '';
        }
        $date = new \Moment\Moment(strtotime($date));
        return $date->format($format);
    }

    private static function __relativeTime($date, $format = "d M Y H:i") {
        $date = new \Moment\Moment(strtotime($date));
        $diff = $date->fromNow();

        if ($diff->getDirection() == 'past') {
            return $diff->getRelative();
        } else {
            return $date->format($format);
        }
    }
}