<?php
namespace App\Tasks\Models;

use App\Users\Models\User,
    App\Labels\Models\Label;

class TaskActivity extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'tta_tt_id',
            'App\Tasks\Models\Task',
            'tt_id',
            array(
                'alias' => 'Task'
            )
        );

        $this->hasOne(
            'tta_sender',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Sender'
            )
        );
    }

    public function getSource() {
        return 'trx_tasks_activities';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $user = \Micro\App::getDefault()->auth->user();
        
        $data['tta_is_comment'] = $this->tta_type == 'comment';
        $data['tta_is_history'] = ! $data['tta_is_comment'];
        $data['tta_is_editable'] = $user['su_id'] == $this->tta_sender;

        $data['sender_su_fullname'] = NULL;

        if ($this->sender) {
            $data['sender_su_fullname'] = $this->sender->su_fullname;
        }

        $data['tta_verb'] = $this->getVerb();
        $data['tta_icon'] = $this->getIcon();
        
        // parse attachment
        $data['tta_text'] = '';

        if ($this->tta_type == 'comment') {
            $data['tta_text'] = $this->getComment();
        }

        return $data;
    }

    public function getComment() {
        $text = $this->tta_data;
        $URL = \Micro\App::getDefault()->url;

        $text = preg_replace_callback('/\[image:(.*)\]/', function($m) use ($URL){
            $name = $m[1];
            $code = sprintf(
                '![%s](%s "%s")',
                $URL->getBaseUrl().'public/resources/attachments/'.$name,
                $URL->getSiteUrl('/assets/thumb').'?s=public/resources/attachments/'.$name.'&w=100&h=100',
                $name,
                $name
            );
            return $code;
        }, $text);

        $text = preg_replace_callback('/\[attachment:(.*)\]/', function($m) use ($URL){
            $name = $m[1];
            $code = sprintf(
                '<iron-icon icon="attachment"></iron-icon>&nbsp;[%s](%s)',
                $name,
                $URL->getBaseUrl().'public/resources/attachments/'.$name
            );
            return $code;
        }, $text);

        return $text;
    }

    public function getRelativeTime($date = NULL) {

        if (is_null($date)) {
            $date = $this->tta_created;
        }

        $date = new \Moment\Moment(strtotime($date));
        $diff = $date->fromNow();

        if ($diff->getDirection() == 'past') {
            return $diff->getRelative();
        } else {
            return $date->format('M dS, Y h:m a');
        }
    }

    public function getIcon() {
        switch($this->tta_type) {
            case 'comment':
                return 'communication:chat-bubble-outline';
            case 'update':
                return 'image:edit';
            case 'update_flag':
                return 'info-outline';
            case 'update_due':
                return 'today';
            case 'add_user':
            case 'remove_user':
                return 'face';
            case 'add_label':
            case 'remove_label':
                return 'label-outline';
        }
    }

    public function getVerb() {
        $verb = '';
        $type = $this->tta_type;
        $time = $this->getRelativeTime();

        $sender = $this->tta_sender;
        $sender_name = '';

        if ($this->sender) {
            $sender_name = $this->sender->su_fullname;
        }

        switch($type) {
            case 'comment':
                $verb = sprintf(
                    '**[%s](profile/%d)** berkomentar %s',
                    $sender_name,
                    $sender,
                    $time
                );
                break;
            case 'update':
            case 'update_title':
            case 'update_description':
                $verb = sprintf(
                    '**[%s](profile/%d)** mengubah kegiatan %s',
                    $sender_name,
                    $sender,
                    $time
                );
                break;
            case 'update_flag':
                $verb = sprintf(
                    '**[%s](profile/%d)** mengubah status ke **%s** %s',
                    $sender_name,
                    $sender,
                    $this->tta_data,
                    $time
                );
                break;
            case 'update_due':
                $verb = sprintf(
                    '**[%s](profile/%d)** mengubah deadline ke **%s** %s',
                    $sender_name,
                    $sender,
                    self::__formatDate($this->tta_data, 'd M Y'),
                    $time
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
                        $assignee[] = "**[$name](profile/$e->su_id)**";
                    }

                    $assignee = implode(', ', $assignee);
                }

                $action = $type == 'add_user' ? 'assigned' : 'removed';

                $verb = sprintf(
                    '**[%s](profile/%d)** %s %s %s',
                    $sender_name,
                    $sender,
                    $action,
                    $assignee,
                    $time
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
                        $labels[] = '<span style="padding: 2px 8px; color: #fff; border-radius: 2px; background-color:'.$e->sl_color.'">'.$e->sl_label.'</span>';
                    }

                    $plural = count($labels) > 1 ? 'label' : 'label';
                    $labels = implode('&nbsp;', $labels);
                }

                $action = $type == 'add_label' ? 'menambahkan' : 'menghapus';

                $verb = sprintf(
                    '**[%s](profile/%d)** %s %s %s %s',
                    $sender_name,
                    $sender,
                    $action,
                    $plural,
                    $labels,
                    $time
                );

                break;
        }

        return $verb;
    }

    public static function log($type, $data) {
        $auth = \Micro\App::getDefault()->auth->user();

        $data['tta_type'] = $type;
        $data['tta_created'] = date('Y-m-d H:i:s');
        $data['tta_sender'] = $auth['su_id'];

        $activity = new TaskActivity();

        if ($activity->save($data)) {
            $activity->save();
            return $activity->get($activity->tta_id);
        }

        return TaskActivity::none();
    }

    public function getLink() {
        $stat = $this->task->getCurrentStatuses()->getFirst();
        
        if ($stat) {
            return '/worksheet/'.$this->task->project->sp_name.'/task/update/'.$stat->tts_id;
        } else {
            return NULL;
        }
    }

    private static function __isImage($file) {
        $info = finfo_open(FILEINFO_MIME_TYPE);
        $mime = finfo_file($info, $file);

        finfo_close($info);

        $type = array('image/jpeg', 'image/png', 'image/gif');

        if (in_array($mime, $type)) {
            return TRUE;
        }
        
        return FALSE;
    }

    private static function __formatDate($date, $format = "M dS, Y h:i a") {
        if (empty($date)) {
            return '';
        }

        $date = new \Moment\Moment(strtotime($date));
        return $date->format($format);
    }
}