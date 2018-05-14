<?php
namespace App\SuratMasuk\Models;

use App\Users\Models\User;
use App\Activities\Models\Activity;
use Phalcon\Mvc\Model\Relation;
use Micro\Helpers\Date;

class Disposition extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'tdp_tsm_id',
            'App\SuratMasuk\Models\Task',
            'tsm_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->belongsTo(
            'tdp_parent',
            'App\SuratMasuk\Models\Disposition',
            'tdp_id',
            array(
                'alias' => 'Parent'
            )
        );

        $this->hasMany(
            'tdp_id',
            'App\SuratMasuk\Models\Disposition',
            'tdp_parent',
            array(
                'alias' => 'Children',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasOne(
            'tdp_responsible',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Responsible'
            )
        );

        $this->hasOne(
            'tdp_receiver',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Receiver'
            )
        );

        $this->hasOne(
            'tdp_priority',
            'App\Priorities\Models\Priority',
            'spt_id',
            array(
                'alias' => 'Priority'
            )
        );

        $this->hasOne(
            'tdp_shipment',
            'App\Shipments\Models\Shipment',
            'sdt_id',
            array(
                'alias' => 'Shipment'
            )
        );

        $this->hasOne(
            'tdp_category',
            'App\Categories\Models\Category',
            'sct_id',
            array(
                'alias' => 'Category'
            )
        );

        $this->hasOne(
            'tdp_template',
            'App\Dispositions\Models\Disposition',
            'stp_id',
            array(
                'alias' => 'ReportTemplate'
            )
        );
    }

    public function getSource() {
        return 'trx_dispositions';
    }

    public function beforeSave() {
        $this->nulled(array(
            'tdp_template',
            'tdp_sending_date',
            'tdp_receiving_date',
            'tdp_finish_date',
            'tdp_recurrent_date',
            'tdp_recurrent_user',
            'tdp_parent',
            'tdp_responsible',
            'tdp_receiver',
            'tdp_priority',
            'tdp_category',
            'tdp_shipment',
            'tdp_orig',
            'tdp_copy',
            'tdp_leaf'
        ));
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        $data['tdp_sending_date_formatted'] = Date::format($this->tdp_sending_date, 'd M Y');
        $data['tdp_receiving_date_formatted'] = Date::format($this->tdp_receiving_date, 'd M Y');
        $data['tdp_finish_date_formatted'] = Date::format($this->tdp_finish_date, 'd M Y');
        $data['tdp_paper_label'] = $this->getPaperLabel();

        $data['responsible_label'] = $this->getResponsibleLabel();

        if (($responsible = $this->responsible)) {
            foreach($responsible->toSimpleArray() as $key => $val) {
                $data['responsible_'.$key] = $val;
            }
        } else {
            $data['responsible_su_avatar_thumb'] = User::defaultAvatarThumb();
        }

        if (($receiver = $this->receiver)) {
            $data['receiver_su_fullname'] = $receiver->getName();
        }

        if (($priority = $this->priority)) {
            foreach($priority->toArray() as $key => $val) {
                $data['priority_'.$key] = $val;
            }
        }

        if (($category = $this->category)) {
            foreach($category->toArray() as $key => $val) {
                $data['category_'.$key] = $val;
            }
        }

        if (($shipment = $this->shipment)) {
            foreach($shipment->toArray() as $key => $val) {
                $data['shipment_'.$key] = $val;
            }
        }

        $data['instructions'] = array();

        if ( ! empty($data['tdp_instructions'])) {
            $data['instructions'] = json_decode($data['tdp_instructions'], TRUE);
        }

        $data['subordinates'] = array();
        
        if ( ! empty($data['tdp_subordinates'])) {
            $data['subordinates'] = json_decode($data['tdp_subordinates'], TRUE);
        }

        return $data;
    }

    public function toSimpleArray() {
        $data = array(
            'tdp_id' => $this->tdp_id,
            'tdp_type' => $this->tdp_type,
            'tdp_sending_date' => $this->tdp_sending_date,
            'tdp_sending_date_formatted' => Date::format($this->tdp_sending_date, 'd M Y'),
            'tdp_position' => $this->tdp_position,
            'tdp_responsible' => $this->tdp_responsible,
            'tdp_receiving_date' => $this->tdp_receiving_date,
            'tdp_receiving_date_formatted' => Date::format($this->tdp_receiving_date, 'd M Y'),
            'tdp_flag' => $this->tdp_flag
        );

        if (($responsible = $this->responsible)) {
            foreach($responsible->toSimpleArray() as $key => $val) {
                $data['responsible_'.$key] = $val;
            }
        }

        if (($receiver = $this->receiver)) {
            $data['receiver_su_fullname'] = $receiver->getName();
        }

        return $data;
    }

    public function getReportTitle() {
        if ($this->isRoot()) {
            $title = 'DISPOSISI-'.strtoupper($this->tdp_position);
        } else {
            $title = 'DISPOSISI-KEPADA-'.strtoupper($this->tdp_position);
        }

        $title = preg_replace('/[^a-z0-9_]/i', '-', $title);
        return $title;
    }

    public function getResponsibleName() {
        if (($responsible = $this->responsible)) {
            return $responsible->getName();
        }
        return '';
    }

    public function getResponsibleLabel() {
        $label = $this->tdp_position;
        if (($responsible = $this->responsible)) {
            $label .= ' ('.$responsible->getName() .')';
        }
        return $label;
    }

    public function getPaperLabel() {
        $types = array();

        if ($this->tdp_orig == 1) {
            $types[] = 'Berkas Asli';
        }

        if ($this->tdp_copy == 1) {
            $types[] = 'Tembusan';
        }

        return implode(', ', $types);
    }

    public function getSendingNode() {
        return $this->getParent();
    }

    public function getReceivingNodes() {
        return $this->getChildren();
    }

    public function hasChildren() {
        return $this->getChildren()->count() > 0;
    }

    public function isThread() {
        return !empty($this->tdp_name);
    }

    public function isLeaf() {
        return empty($this->tdp_name);
    }

    public function isRoot() {
        return $this->tdp_parent == 0;
    }

    public function findRoot() {
        $parent = $this->getParent();
        $root = FALSE;

        while($parent) {
            if ($parent->isRoot()) {
                $root = $parent;
                break;
            }

            $parent = $parent->getParent();
        }

        return $root;
    }

    public function getLeaves() {
        $leaves = array();

        $this->cascade(function($node) use (&$leaves){
            if ($node->isLeaf()) {
                $leaves[] = $node;
            }
        }, FALSE);

        return $leaves;
    }

    public function receive() {
        $task = $this->getTask();
        $auth = \Micro\App::getDefault()->auth->user();
        $sending = $this->getSendingNode();

        if ($task && $sending) {
            $sending->tdp_flag = 'RECEIVED';
            $sending->save();

            foreach($task->getTaskUsers() as $assignee) {
                if ($assignee->tsmu_su_id == $this->tdp_responsible) {
                    $assignee->tsmu_persistent = 1;
                    $assignee->save();
                }
            }

            $this->tdp_flag = 'RECEIVED';
            $this->tdp_receiving_date = date('Y-m-d');
            $this->tdp_receiver = $auth['su_id'];
            $this->save();

            if ($this->tdp_type == 'DISPOSITION') {

                if (empty($this->tdp_responsible)) {
                    $activitySender = $auth['su_id'];
                    $activityRepresented = TRUE;
                } else {
                    $activitySender = $this->tdp_responsible;
                    $activityRepresented = FALSE;
                }

                $log = Activity::log('receiving_disposition', array(
                    'ta_sender' => $activitySender,
                    'ta_task_ns' => $task->getScope(),
                    'ta_task_id' => $task->tsm_id,
                    'ta_sp_id' => $task->tsm_task_project,
                    'ta_data' => json_encode(array(
                        'disposition' => $sending->tdp_name,
                        'position' => $this->tdp_position,
                        'represented' => $activityRepresented
                    ))
                ));    

                if ($log) {
                    $log->subscribe();
                    $log->broadcast();
                }
            }

        }
    }

    public function broadcastUpdate() {
        if (($task = $this->getTask())) {
            $array = $this->toArray();

            $items = array(
                'tdp_id',
                'tdp_receiving_date',
                'tdp_receiving_date_formatted',
                'tdp_finish_date',
                'tdp_finish_date_formatted',
                'tdp_actions'
            );

            $data = array();

            foreach($items as $key) {
                $data[$key] = $array[$key];
            }

            \Micro\App::getDefault()->socket->broadcast('notify-disposition', array(
                'type' => 'update',
                'project' => $task->tsm_task_project,
                'scope' => $task->getScope(),
                'task' => $task->tsm_id,
                'data' => json_encode($data)
            ));

        }
    }

    public function cascade($callback, $start = TRUE) {
        if ($start) {
            $callback($this);
        }

        if ($this->hasChildren()) {
            foreach($this->getChildren() as $node) {
                $node->cascade($callback);
            }
        }
    }

    public function bubble($callback) {
        $callback($this);
        $parent = $this->getParent();

        if ($parent) {
            $parent->bubble($callback);
        }
    }

    public function createSheets() {
        $sheets = array();

        if ($this->isLeaf()) {
            $leaves = $this;
        } else {
            $leaves = $this->getLeaves();
        }

        $index = 1;

        foreach($leaves as $leaf) {
            $nodes = array();

            $leaf->bubble(function($node) use (&$nodes){
                $nodes[] = $node;
            });

            $nodes = array_reverse($nodes);
            $group = 'DISPOSISI '.$index;

            $sheets[$group] = array(
                'nodes' => $nodes
            );

            $index++;
        }

        return $sheets;
    }
}