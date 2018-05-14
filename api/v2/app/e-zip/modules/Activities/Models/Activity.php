<?php
namespace App\Activities\Models;

use App\Users\Models\User;
use App\Labels\Models\Label;

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
        return 'sys_activities';
    }

    public function getTask() {
        $ref = $this->getReference();

        if ($ref) {
            $task = call_user_func_array(array($ref['model'], 'findFirst'), array($this->ta_task_id));
            return $task;
        }

        return NULL;
    }

    public function getReference() {
        switch($this->ta_task_ns) {
            case 'registration':
                return array(
                    'model' => 'App\Registration\Models\Task'
                );
            case 'presence':
                return array(
                    'model' => 'App\Presence\Models\Task'
                );
            case 'lkh':
                return array(
                    'model' => 'App\Lkh\Models\Task'
                );
            case 'skp':
                return array(
                    'model' => 'App\Skp\Models\Task'
                );
            case 'surat-masuk':
                return array(
                    'model' => 'App\SuratMasuk\Models\Task'
                );
            case 'surat-keluar':
                return array(
                    'model' => 'App\SuratKeluar\Models\Task'
                );
        }
        return FALSE;
    }

    public function getSenderName() {
        $sender = '';

        if (is_null($this->ta_sender)) {
            $sender = 'System';
        } else if (($sender = $this->sender)) {
            $sender = $sender->getName();
        }
        
        return $sender;
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $user = \Micro\App::getDefault()->auth->user();
        
        $data['ta_is_comment'] = $this->isComment();
        $data['ta_is_history'] = ! $data['ta_is_comment'];
        $data['ta_is_editable'] = $user['su_id'] == $this->ta_sender;

        $data['ta_verb'] = $this->getVerb();
        $data['ta_icon'] = $this->getIcon();
        
        // parse attachment
        $data['ta_comment'] = '';
        $data['ta_comment_formatted'] = '';

        if ($data['ta_is_comment'] == 'comment') {
            $json = json_decode($this->ta_data, TRUE);

            $data['ta_comment'] = $json['comment'];
            $data['ta_comment_formatted'] = $this->getComment();
        }

        $data['sender_su_fullname'] = $this->getSenderName();

        return $data;
    }

    public function isUnread($user) {
        $unreads = json_decode($this->ta_unreads, TRUE);
        $unreads = is_null($unreads) ? array() : $unreads;
        return in_array($user, $unreads);
    }

    public function isComment() {
        return in_array($this->ta_type, array('comment', 'warning', 'examine'));
    }

    public function getComment() {
        $json = json_decode($this->ta_data, TRUE);
        $text = $json['comment'];
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
                '[%s](%s)',
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
            case 'delete':
                return 'delete-forever';
            case 'update_status':
                return 'bookmark-border';
            case 'distribution':
            case 'disposition':
                return 'communication:mail-outline';
            case 'receiving_disposition':
                return 'drafts';
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
            case 'warning':
                return 'warning';
            case 'alert':
                return 'warning';
            case 'activation':
                return 'lock-open';
        }
    }

    public function getVerb() {
        $verb = '';
        $type = $this->ta_type;
        $time = $this->getRelativeTime();

        $senderName = $this->getSenderName();

        switch($type) {
            case 'create':
                $verb = sprintf(
                    '**%s** membuat dokumen ini %s',
                    $senderName,
                    $time
                );
                break;
            case 'update_status':
                $statuses = json_decode($this->ta_data);
                $statuses = implode(', ', $statuses);

                $verb = sprintf(
                    '**%s** merubah status ke **%s** %s',
                    $senderName,
                    $statuses,
                    $time
                );
                break;
            case 'comment':
                $verb = sprintf(
                    '**%s** berkomentar %s',
                    $senderName,
                    $time
                );
                break;
            case 'warning':
                $verb = sprintf(
                    '**%s** mengirimkan pemberitahuan %s',
                    $senderName,
                    $time
                );
                break;
            case 'update':
            case 'update_title':
            case 'update_description':
                $verb = sprintf(
                    '**%s** menyunting dokumen %s',
                    $senderName,
                    $time
                );
                break;
            case 'update_flag':
                $verb = sprintf(
                    '**%s** mengubah status dokumen ke **%s** %s',
                    $senderName,
                    $this->ta_data,
                    $time
                );
                break;
            case 'update_due':
                $verb = sprintf(
                    '**%s** mengubah deadline ke **%s** %s',
                    $senderName,
                    self::_formatDate($this->ta_data, 'd M Y'),
                    $time
                );
                break;
            case 'add_user':
            case 'remove_user':

                $assignee = array();

                if ( ! empty($this->ta_data)) {
                    $json = json_decode($this->ta_data, TRUE);

                    foreach($json as $item) {
                        $assignee[] = sprintf('**%s**', $item['su_fullname']);
                    }

                    $assignee = implode(', ', $assignee);
                }

                $action = $type == 'add_user' ? 'menambahkan' : 'menghapus';

                $verb = sprintf(
                    '**%s** %s %s %s',
                    $senderName,
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
                    $json = json_decode($this->ta_data, TRUE);

                    foreach($json as $item) {
                        $labels[] = '<span style="padding: 2px 8px; color: #fff; border-radius: 2px; background-color:'.$item['sl_color'].'">'.$item['sl_label'].'</span>';
                    }

                    $plural = count($labels) > 1 ? 'label' : 'label';
                    $labels = implode('&nbsp;', $labels);
                }

                $action = $type == 'add_label' ? 'menambahkan' : 'menghapus';

                $verb = sprintf(
                    '**%s** %s %s %s %s',
                    $senderName,
                    $action,
                    $plural,
                    $labels,
                    $time
                );

                break;
            case 'alert':
                $json = json_decode($this->ta_data, TRUE);
                $verb = sprintf(
                    '**%s** memberitahukan %s %s',
                    $senderName,
                    $json['message'],
                    $time
                );
                break;
            case 'distribution':
                $json = json_decode($this->ta_data, TRUE);
                $verb = sprintf(
                    'Anda menerima surat masuk dari **%s** %s',
                    $json['from'],
                    $time
                );
                break;
            case 'disposition':
                $json = json_decode($this->ta_data, TRUE);
                $verb = sprintf(
                    'Anda menerima disposisi **%s** %s',
                    $json['from'],
                    $time
                );
                break;
            case 'receiving_disposition':
                $json = json_decode($this->ta_data, TRUE);

                if ( ! $json['represented']) {
                    $senderName = $json['position'].' ('.$senderName.')';
                } else {
                    $senderName = $json['position'];
                }

                $verb = sprintf(
                    '**%s** sudah menerima **%s** %s',
                    $senderName,
                    strtolower($json['disposition']),
                    $time
                );

                break;
        }

        return $verb;
    }

    public static function log($type, $data) {

        $data['ta_type'] = $type;
        $data['ta_created'] = date('Y-m-d H:i:s');

        if ( ! isset($data['ta_sender'])) {
            $auth = \Micro\App::getDefault()->auth->user();
            $data['ta_sender'] = $auth['su_id'];
        }

        if (isset($data['ta_data']) && is_array($data['ta_data'])) {
            $data['ta_data'] = json_encode($data['ta_data']);
        }

        $activity = new Activity();

        if ($activity->save($data)) {
            if (($task = $activity->getTask())) {
                $activity->ta_title = $task->getTitle();
                $activity->save();
            }

            $activity = $activity->refresh();
            return $activity;
        }

        return NULL;
    }

    public function broadcast() {
        $socket = \Micro\App::getDefault()->socket;

        $payload = array(
            'type' => $this->ta_type,
            'project' => $this->ta_sp_id,
            'scope' => $this->ta_task_ns,
            'task' => $this->ta_task_id,
            'data' => $this->ta_data
        );

        $socket->broadcast('notify', $payload);
    }

    public function subscribe($subs = NULL) {
        $auth = \Micro\App::getDefault()->auth->user();
        $unreads = array();

        if (is_null($subs)) {
            $subs = array();
            $task = $this->getTask();
            if ($task) {
                foreach($task->getUsers() as $user) {
                    $subs[] = $user->su_id;
                }    
            }
        }

        foreach($subs as $sub) {
            if ($sub != $auth['su_id']) {
                $unreads[] = $sub;
            }
        }

        $this->ta_subs = json_encode($subs);
        $this->ta_unreads = json_encode($unreads);
        $this->save();
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

    protected static function _formatDate($date, $format = "M dS, Y h:i a") {
        if (empty($date)) {
            return '';
        }

        $date = new \Moment\Moment(strtotime($date));
        return $date->format($format);
    }
}