<?php
namespace App\Notifications\Models;

use App\Users\Models\User,
    App\Labels\Models\Label;

class Notification extends \App\Tasks\Models\TaskActivity {

    public static function items($start = NULL, $limit = NULL) {
        $auth = \Micro\App::getDefault()->auth->user();
        $query = self::get()
            ->alias('a')
            ->join('App\Tasks\Models\Task', 'b.tt_id = a.tta_tt_id', 'b', 'left') 
            ->join('App\Projects\Models\Project', 'c.sp_id = b.tt_sp_id', 'c', 'left')
            ->join('App\Projects\Models\ProjectUser', 'd.spu_sp_id = c.sp_id', 'd', 'left')
            ->where('d.spu_su_id = :user:', array('user' => $auth['su_id']))
            ->orderBy('a.tta_created DESC');

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

        $data['tta_id'] = $this->tta_id;
        $data['tta_verb'] = $this->getVerb();
        $data['tta_time'] = ucfirst($time);
        $data['tta_icon'] = $icon;
        $data['tta_tt_id'] = $this->tta_tt_id;
        $data['tta_link'] = $this->getLink();
        $data['tta_sender'] = $this->tta_sender;

        return $data;
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
            case 'create':
                $verb = sprintf(
                    '**%s** membuat dokumen: "%s"',
                    $sender_name,
                    $task->tt_title
                );
                break;
            case 'update_status':
                $flags = json_decode($this->tta_data);
                $flags = implode(', ', $flags);

                $verb = sprintf(
                    '**%s** merubah status dokumen: %s" ke **%s**',
                    $sender_name,
                    $task->tt_title,
                    $flags
                );
                break;
            case 'comment':
                $verb = sprintf(
                    '**%s** mengomentari dokumen: "%s"',
                    $sender_name,
                    $task->tt_title
                );
                break;
            case 'update':
            case 'update_title':
            case 'update_description':
                $verb = sprintf(
                    '**%s** menyunting dokumen: "%s"',
                    $sender_name,
                    $task->tt_title
                );
                break;
            case 'update_flag':
                $verb = sprintf(
                    '**%s** merubah status menjadi **%s** untuk dokumen: "%s"',
                    $sender_name,
                    $this->tta_data,
                    $task->tt_title
                );
                break;
            case 'update_due':
                $verb = sprintf(
                    '**%s** merubah tanggal deadline menjadi **%s** untuk dokumen: "%s"',
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

                $action = $type == 'add_user' ? 'menugaskan' : 'menghapus';

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

                    $plural = count($labels) > 1 ? 'label' : 'label';
                    $labels = implode('&nbsp;', $labels);
                }

                $action = $type == 'add_label' ? 'menambah' : 'menghapus';

                $verb = sprintf(
                    '**%s** %s %s %s untuk dokumen: "%s"',
                    $sender_name,
                    $action,
                    $plural,
                    $labels,
                    $task->tt_title
                );

                break;
        }

        return $verb;
    }
}