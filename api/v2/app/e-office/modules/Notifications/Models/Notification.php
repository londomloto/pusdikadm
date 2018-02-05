<?php
namespace App\Notifications\Models;

use App\Users\Models\User,
    App\Labels\Models\Label;

class Notification extends \App\Tasks\Models\TaskActivity {

    public static function top() {
        $auth = \Micro\App::getDefault()->auth->user();

        $rows = self::get()
            ->alias('a')
            ->join('App\Tasks\Models\Task', 'b.tt_id = a.tta_tt_id', 'b', 'left') 
            ->join('App\Projects\Models\Project', 'c.sp_id = b.tt_sp_id', 'c', 'left')
            ->join('App\Projects\Models\ProjectUser', 'd.spu_sp_id = c.sp_id', 'd', 'left')
            ->where('d.spu_su_id = :user:', array('user' => $auth['su_id']))
            ->limit(6, 0)
            ->orderBy('a.tta_created DESC') 
            ->execute();

        $data = array();

        foreach($rows as $elem) {
            $item = array();
            $time = $elem->getRelativeTime();
            $time = str_replace(array('about ', 'at '), '', $time);
            $icon = $elem->getIcon();

            $item['tta_verb'] = $elem->getVerb();
            $item['tta_time'] = ucfirst($time);
            $item['tta_icon'] = $icon;
            $item['tta_tt_id'] = $elem->tta_tt_id;
            $item['tta_link'] = $elem->getLink();

            $data[] = $item;
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    public function all() {

    }

    // @Override
    public function getVerb() {
        $verb = '';
        $type = $this->tta_type;
        $time = $this->getRelativeTime();
        $task = $this->task;

        $sender = $this->tta_sender;
        $sender_name = '';

        if ($this->sender) {
            $sender_name = $this->sender->getName();
        }

        switch($type) {
            case 'comment':
                $verb = sprintf(
                    '**%s** commented on task: "%s"',
                    $sender_name,
                    $task->tt_title
                );
                break;
            case 'update':
            case 'update_title':
            case 'update_description':
                $verb = sprintf(
                    '**%s** changed detail on task: "%s"',
                    $sender_name,
                    $task->tt_title
                );
                break;
            case 'update_flag':
                $verb = sprintf(
                    '**%s** changed status to **%s** on task: "%s"',
                    $sender_name,
                    $this->tta_data,
                    $task->tt_title
                );
                break;
            case 'update_due':
                $verb = sprintf(
                    '**%s** changed due date to **%s** on task: "%s"',
                    $sender_name,
                    self::_formatDate($this->tta_data, 'M d, Y'),
                    $task->tt_title
                );
                break;
            case 'add_user':
            case 'remove_user':

                $assignee = array();

                if ( ! empty($this->tta_data)) {
                    $data = User::get()
                        ->columns('su_id, su_fullname, su_email')
                        ->inWhere('su_id', json_decode($this->tta_data))
                        ->execute();

                    foreach($data as $e) {
                        $name = empty($e->su_fullname) ? $e->su_email : $e->su_fullname;
                        $assignee[] = "**$name**";
                    }

                    $assignee = implode(', ', $assignee);
                }

                $action = $type == 'add_user' ? 'assigned' : 'removed';

                $verb = sprintf(
                    '**%s** %s %s on task: "%s"',
                    $sender_name,
                    $action,
                    $assignee,
                    $task->tt_title
                );
                break;
            case 'add_label':
            case 'remove_label':

                $labels = array();
                $plural = 'label';

                if ( ! empty($this->tta_data)) {
                    $data = Label::get()
                        ->columns('sl_id, sl_label, sl_color')
                        ->inWhere('sl_id', json_decode($this->tta_data))
                        ->execute();

                    foreach($data as $e) {
                        $labels[] = '<span style="font-weight: 500; color: '.$e->sl_color.'">'.$e->sl_label.'</span>';
                    }

                    $plural = count($labels) > 1 ? 'labels' : 'label';
                    $labels = implode('&nbsp;', $labels);
                }

                $action = $type == 'add_label' ? 'add' : 'remove';

                $verb = sprintf(
                    '**%s** %s %s %s on task: "%s"',
                    $sender_name,
                    $action,
                    $labels,
                    $plural,
                    $task->tt_title
                );

                break;
        }

        return $verb;
    }
}