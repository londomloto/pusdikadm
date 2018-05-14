<?php
namespace App\Notifications\Models;

use App\Users\Models\User;
use App\Labels\Models\Label;

class Notification extends \App\Activities\Models\Activity {

    public static function items($start = NULL, $limit = NULL, $summary = FALSE) {
        $auth = \Micro\App::getDefault()->auth->user();
        $query = self::get()
            ->andWhere('ta_subs LIKE :user:', array(
                'user' => '%"'.$auth['su_id'].'"%'
            ))
            ->orderBy('ta_created DESC');

        if ( ! is_null($start) && ! is_null($limit)) {
            $query->limit($limit, $start);
            $result = $query->paginate(FALSE);
        } else {
            $result = $query->paginate();
        }

        $result->map(function($row) use ($auth) {
            $model = self::findFirst($row->ta_id);
            $array = $model->toArray();
            $array['ta_unread'] = $model->isUnread($auth['su_id']);

            return $array;
        });

        $extra = array(
            'unreads' => 0
        );

        if ($summary) {
            $query = self::get()
                ->columns('ta_id')
                ->where('ta_unreads LIKE :user:', array(
                    'user' => '%"'.$auth['su_id'].'"%'
                ))
                ->execute();

            $extra['unreads'] = $query->count();
        }

        $result->summary = $extra;

        return $result;
    }

    public static function summary($user = NULL) {
        if (is_null($user)) {
            $auth = \Micro\App::getDefault()->auth->user();
            $user = $auth['su_id'];
        }

        // summary unreads
        $query = self::get()
            ->columns('ta_id')
            ->where('ta_unreads LIKE :user:', array(
                'user' => '%"'.$user.'"%'
            ))
            ->execute();

        $unreads = $query->count();

        return array(
            'success' => TRUE,
            'data' => array(
                'unreads' => $unreads
            )
        );
    }

    public function toArray($columns = NULL) {
        $data = array();
        $time = $this->getRelativeTime();
        $time = str_replace(array('about ', 'at '), '', $time);
        $icon = $this->getIcon();

        $data['ta_id'] = $this->ta_id;
        $data['ta_verb'] = $this->getVerb();
        $data['ta_type'] = $this->ta_type;
        $data['ta_time'] = ucfirst($time);
        $data['ta_icon'] = $icon;
        $data['ta_task_id'] = $this->ta_task_id;
        $data['ta_link'] = $this->getLink();
        $data['ta_sender'] = $this->ta_sender;
        $data['ta_data'] = $this->ta_data;

        return $data;
    }

    // @Override
    public function getVerb() {
        $verb = '';
        $type = $this->ta_type;
        $time = $this->getRelativeTime();

        $senderName = $this->getSenderName();
        $taskTitle = $this->ta_title;

        $projectTitle = '';

        if ($this->project) {
            $projectTitle = strtolower($this->project->sp_title);
        }

        switch($type) {
            case 'create':
            case 'delete':
                $action = $type == 'create' ? 'membuat' : 'menghapus';
                $verb = sprintf(
                    '**%s** %s %s: "**%s**"',
                    $senderName,
                    $action,
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update_status':
                $statuses = json_decode($this->ta_data);
                $statuses = implode(', ', $statuses);

                $verb = sprintf(
                    '**%s** merubah status dokumen %s **%s** ke tahap **%s**',
                    $senderName,
                    $projectTitle,
                    $taskTitle,
                    $statuses
                );
                break;
            case 'comment':
                $verb = sprintf(
                    '**%s** mengomentari %s: "%s"',
                    $senderName, 
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'warning':
                $verb = sprintf(
                    '**%s** mengirimkan pemberitahuan pada %s: "%s"',
                    $senderName, 
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update':
            case 'update_title':
            case 'update_description':
                $verb = sprintf(
                    '**%s** menyunting %s: "**%s**"',
                    $senderName,
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update_flag':
                $verb = sprintf(
                    '**%s** merubah status menjadi **%s** untuk %s: "%s"',
                    $senderName,
                    $this->ta_data,
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'update_due':
                $verb = sprintf(
                    '**%s** merubah tanggal deadline menjadi **%s** untuk %s: "%s"',
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
                    $json = json_decode($this->ta_data, TRUE);
                    foreach($json as $item) {
                        $assignee[] = sprintf('**%s**', $item['su_fullname']);
                    }

                    $assignee = implode(', ', $assignee);
                }

                $action = $type == 'add_user' ? 'menambahkan' : 'menghapus';
                $dir = $type == 'add_user' ? 'ke' : 'dari';

                $verb = sprintf(
                    '**%s** %s %s %s %s: "%s"',
                    $senderName,
                    $action,
                    $assignee,
                    $dir,
                    $projectTitle,
                    $taskTitle
                );
                break;
            case 'add_label':
            case 'remove_label':

                $labels = array();
                $plural = 'label';

                if ( ! empty($this->ta_data)) {
                    $json = json_decode($this->ta_data, TRUE);
                    foreach($json as $item) {
                        $labels[] = '<span style="font-weight: 500; color: '.$item['sl_color'].'">'.$item['sl_label'].'</span>';
                    }

                    $plural = count($labels) > 1 ? 'label' : 'label';
                    $labels = implode('&nbsp;', $labels);
                }

                $action = $type == 'add_label' ? 'menambah' : 'menghapus';

                $verb = sprintf(
                    '**%s** %s %s %s untuk %s: "%s"',
                    $senderName,
                    $action,
                    $plural,
                    $labels,
                    $projectTitle,
                    $taskTitle
                );
                
                break;
            case 'alert':
                $json = json_decode($this->ta_data, TRUE);
                $verb = sprintf(
                    '**%s** mengirimkan pemberitahuan perihal: "%s"',
                    $senderName,
                    $json['message']
                );
                break;
            case 'activation':
                $verb = sprintf(
                    '**%s** melakukan aktivasi akun',
                    $senderName
                );
                break;
            case 'examine':
                $verb = sprintf(
                    '**%s** memberikan catatan pemeriksaan pada %s: "%s"',
                    $senderName,
                    $projectTitle,
                    $taskTitle
                );
                break;

            case 'distribution':
                $json = json_decode($this->ta_data, TRUE);
                $verb = sprintf(
                    'Anda menerima surat masuk dengan nomor **%s** dari **%s** perihal: "%s"',
                    $taskTitle,
                    $json['from'],
                    $json['subject']
                );
                break;
            case 'disposition':
                $json = json_decode($this->ta_data, TRUE);
                $verb = sprintf(
                    'Anda menerima disposisi surat masuk **%s** dari **%s**',
                    $taskTitle,
                    $json['from']
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
                    '**%s** sudah menerima **%s** untuk surat masuk: "%s"',
                    $senderName,
                    strtolower($json['disposition']),
                    $taskTitle
                );

                break;
        }

        return $verb;
    }
}