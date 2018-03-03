<?php
namespace App\Activities\Models;

use App\Users\Models\User,
    App\Labels\Models\Label;

class Activity extends \Micro\Model {

    public function initialize() {
        
        $this->hasOne(
            'ta_sender',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Sender'
            )
        );

        $this->belongsTo(
            'ta_sp_id',
            'App\Projects\Models\Project',
            'sp_id',
            array(
                'alias' => 'Project'
            )
        );
    }

    public function getSource() {
        return 'trx_activities';
    }

    public function getTask() {
        $ref = $this->getReference();

        if ($ref) {
            return call_user_func_array(array($ref['model'], 'findFirst'), array($this->ta_task_id));
        }

        return NULL;
    }

    public function getReference() {
        switch($this->ta_task_ns) {
            case '/registration':
                return array(
                    'model' => 'App\Registration\Models\Task',
                    'reference_key' => 'su_id',
                    'project_key' => 'su_sp_id'
                );
        }
        return FALSE;
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $user = \Micro\App::getDefault()->auth->user();
        
        $data['ta_is_comment'] = $this->ta_type == 'comment';
        $data['ta_is_history'] = ! $data['ta_is_comment'];
        $data['ta_is_editable'] = $user['su_id'] == $this->ta_sender;

        $data['sender_su_fullname'] = NULL;

        if ($this->sender) {
            $data['sender_su_fullname'] = $this->sender->su_fullname;
        }

        $data['ta_verb'] = $this->getVerb();
        $data['ta_icon'] = $this->getIcon();
        
        // parse attachment
        $data['ta_text'] = '';

        if ($this->ta_type == 'comment') {
            $data['ta_text'] = $this->getComment();
        }

        return $data;
    }

    public function getComment() {
        $text = $this->ta_data;
        $URL = \Micro\App::getDefault()->url;

        $text = preg_replace_callback('/\[image:([^\]]+)\]/', function($m) use ($URL){
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

        $text = preg_replace_callback('/\[attachment:([^\]]+)\]/', function($m) use ($URL){
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
            $date = $this->ta_created;
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
        switch($this->ta_type) {
            case 'comment':
                return 'communication:chat-bubble-outline';
            case 'create':
            case 'update':
                return 'image:edit';
            case 'update_status':
                return 'bookmark-border';
            case 'disposition':
                return 'send';
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
        $type = $this->ta_type;
        $time = $this->getRelativeTime();

        $sender = $this->ta_sender;
        $sender_name = '';

        if ($this->sender) {
            $sender_name = $this->sender->su_fullname;
        }

        switch($type) {
            case 'create':
                $verb = sprintf(
                    '**%s** membuat dokumen ini %s',
                    $sender_name,
                    $time
                );
                break;
            case 'update_status':
                $steps = json_decode($this->ta_data);
                $steps = implode(', ', $steps);

                $verb = sprintf(
                    '**%s** merubah status ke **%s** %s',
                    $sender_name,
                    $steps,
                    $time
                );
                break;
            case 'comment':
                $verb = sprintf(
                    '**%s** berkomentar %s',
                    $sender_name,
                    $time
                );
                break;
            case 'update':
            case 'update_title':
            case 'update_description':
                $verb = sprintf(
                    '**%s** menyunting dokumen %s',
                    $sender_name,
                    $time
                );
                break;
            case 'update_flag':
                $verb = sprintf(
                    '**%s** mengubah status dokumen ke **%s** %s',
                    $sender_name,
                    $this->ta_data,
                    $time
                );
                break;
            case 'update_due':
                $verb = sprintf(
                    '**%s** mengubah deadline ke **%s** %s',
                    $sender_name,
                    self::__formatDate($this->ta_data, 'd M Y'),
                    $time
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

                $action = $type == 'add_user' ? 'assigned' : 'removed';

                $verb = sprintf(
                    '**%s** %s %s %s',
                    $sender_name,
                    $action,
                    $assignee,
                    $time
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
                        $labels[] = '<span style="padding: 2px 8px; color: #fff; border-radius: 2px; background-color:'.$e->sl_color.'">'.$e->sl_label.'</span>';
                    }

                    $plural = count($labels) > 1 ? 'label' : 'label';
                    $labels = implode('&nbsp;', $labels);
                }

                $action = $type == 'add_label' ? 'menambahkan' : 'menghapus';

                $verb = sprintf(
                    '**%s** %s %s %s %s',
                    $sender_name,
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

        $data['ta_type'] = $type;
        $data['ta_created'] = date('Y-m-d H:i:s');
        $data['ta_sender'] = $auth['su_id'];

        $activity = new Activity();

        if ($activity->save($data)) {
            $activity->save();
            return $activity->get($activity->ta_id);
        }

        return Activity::none();
    }

    public function getLink() {
        $task = $this->getTask();
        return $task ? $task->getLink() : NULL;
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