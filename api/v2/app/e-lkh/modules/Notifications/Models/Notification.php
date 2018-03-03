<?php
namespace App\Notifications\Models;

use App\Users\Models\User,
    App\Labels\Models\Label;

class Notification extends \App\Activities\Models\Activity {

    public static function items($start = NULL, $limit = NULL) {
        $auth = \Micro\App::getDefault()->auth->user();
        $query = self::get()
            ->alias('a')
            ->join('App\Projects\Models\Project', 'b.sp_id = a.ta_sp_id', 'b', 'left')
            ->join('App\Projects\Models\ProjectUser', 'c.spu_sp_id = b.sp_id', 'c', 'left')
            ->where('c.spu_su_id = :user:', array('user' => $auth['su_id']))
            ->orderBy('a.ta_created DESC');

        if ( ! is_null($start) && ! is_null($limit)) {
            $query->limit($limit, $start);
            return $query->paginate(FALSE);
        } else {
            return $query->paginate();
        }
    }

    public function toArray($columns = NULL) {
        $data = array();
        $time = $this->getRelativeTime();
        $time = str_replace(array('about ', 'at '), '', $time);
        $icon = $this->getIcon();

        $data['ta_id'] = $this->ta_id;
        $data['ta_verb'] = $this->getVerb();
        $data['ta_time'] = ucfirst($time);
        $data['ta_icon'] = $icon;
        $data['ta_task_id'] = $this->ta_task_id;
        $data['ta_link'] = $this->getLink();
        $data['ta_sender'] = $this->ta_sender;

        return $data;
    }

    // @Override
    public function getVerb() {
        $task = $this->getTask();

        if ( ! $task) {
            return '';
        }

        $verb = '';
        $type = $this->ta_type;
        $time = $this->getRelativeTime();

        $sender = $this->ta_sender;
        $senderName = '';
        $taskTitle = $task->getTitle();

        if ($this->sender) {
            $senderName = $this->sender->getName();
        }

        $projectTitle = '';

        if ($this->project) {
            $projectTitle = strtolower($this->project->sp_title);
        }

        switch($type) {
            case 'create':
                $verb = sprintf(
                    '**%s** membuat dokumen %s: "%s"',
                    $senderName,
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update_status':
                $flags = json_decode($this->ta_data);
                $flags = implode(', ', $flags);

                $verb = sprintf(
                    '**%s** merubah status dokumen %s: %s" ke **%s**',
                    $senderName,
                    $projectTitle,
                    $taskTitle,
                    $flags
                );
                break;
            case 'comment':
                $verb = sprintf(
                    '**%s** mengomentari dokumen %s: "%s"',
                    $senderName, 
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update':
            case 'update_title':
            case 'update_description':
                $verb = sprintf(
                    '**%s** menyunting dokumen %: "%s"',
                    $senderName,
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update_flag':
                $verb = sprintf(
                    '**%s** merubah status menjadi **%s** untuk dokumen %s: "%s"',
                    $senderName,
                    $this->ta_data,
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update_due':
                $verb = sprintf(
                    '**%s** merubah tanggal deadline menjadi **%s** untuk dokumen %s: "%s"',
                    $senderName,
                    self::_formatDate($this->ta_data, 'M d, Y'),
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'add_user':
            case 'remove_user':

                $assignee = array();

                if ( ! empty($this->ta_data)) {
                    $data = User::get()
                        ->columns('su_id, su_fullname, su_email')
                        ->inWhere('su_id', json_decode($this->ta_data))
                        ->execute();

                    foreach($data as $e) {
                        $name = empty($e->su_fullname) ? $e->su_email : $e->su_fullname;
                        $assignee[] = "**$name**";
                    }

                    $assignee = implode(', ', $assignee);
                }

                $action = $type == 'add_user' ? 'menugaskan' : 'menghapus';

                $verb = sprintf(
                    '**%s** %s %s on task: "%s"',
                    $senderName,
                    $action,
                    $assignee,
                    $taskTitle
                );
                break;
            case 'add_label':
            case 'remove_label':

                $labels = array();
                $plural = 'label';

                if ( ! empty($this->ta_data)) {
                    $data = Label::get()
                        ->columns('sl_id, sl_label, sl_color')
                        ->inWhere('sl_id', json_decode($this->ta_data))
                        ->execute();

                    foreach($data as $e) {
                        $labels[] = '<span style="font-weight: 500; color: '.$e->sl_color.'">'.$e->sl_label.'</span>';
                    }

                    $plural = count($labels) > 1 ? 'label' : 'label';
                    $labels = implode('&nbsp;', $labels);
                }

                $action = $type == 'add_label' ? 'menambah' : 'menghapus';

                $verb = sprintf(
                    '**%s** %s %s %s untuk dokumen %s: "%s"',
                    $senderName,
                    $action,
                    $plural,
                    $labels,
                    $projectTitle,
                    $taskTitle
                );
                
                break;
        }

        return $verb;
    }
}