<?php
namespace App\Notifications\Controllers;

use App\Users\Models\UserToken;
use App\Notifications\Models\Notification;
use App\Activities\Models\Subscriber;

class NotificationsController extends \Micro\Controller {

    public function findAction() {
        $params = $this->request->getParams();
        $display = isset($params['display']) ? $params['display'] : FALSE;
        
        switch($display) {
            case 'top':
                return Notification::items(0, 6);
            default:
                return Notification::items();
        }

    }

    public function deleteAction($id) {
        $user = $this->auth->user();
        $data = Notification::get($id)->data;
        $done = FALSE;

        if ($data) {
            $array = json_decode($data->ta_subs);
            $array = is_null($array) ? array() : $array;

            $index = array_search($user['su_id'], $array);

            if ($index !== -1) {
                array_splice($array, $index, 1);
            }

            $data->ta_subs = json_encode($array);

            $array = json_decode($data->ta_unreads);
            $array = is_null($array) ? array() : $array;

            $index = array_search($user['su_id'], $array);

            if ($index !== -1) {
                array_splice($array, $index, 1);
            }

            $data->ta_unreads = json_encode($array);
            $done = $data->save();
        }
    }

    public function summaryAction($user) {
        return Notification::summary($user);
    }

    public function readAction($id) {
        $post = $this->request->getJson();
        $auth = $this->auth->user();

        $query = Notification::get($id);

        if ($query->data) {
            $unreads = json_decode($query->data->ta_unreads, TRUE);
            $unreads = is_null($unreads) ? array() : $unreads;
            $index = array_search($auth['su_id'], $unreads);

            if ($index > -1) {
                unset($unreads[$index]);
                $unreads = array_values($unreads);
                $query->data->ta_unreads = json_encode($unreads);
                $query->data->save();
            }
        }

        return $query;
    }

    public function subscribeAction() {
        $post = $this->request->getJson();
        $user = $this->auth->user(NULL, TRUE);

        $result = $this->gcm->subscribe($post['topic'], $post['token']);

        if ($result->success) {

            $found = UserToken::findFirst(array(
                'sut_su_id = :user: AND sut_token = :token:',
                'bind' => array(
                    'user' => $user->su_id,
                    'token' => $post['token']
                )
            ));

            if ( ! $found) {
                $token = new UserToken();

                $token->sut_type = 'gcm';
                $token->sut_su_id = $user->su_id;
                $token->sut_topic = $post['topic'];
                $token->sut_token = $post['token'];
                $token->sut_created = date('Y-m-d H:i:s');

                $token->save();
            }
            
        }

        return $result;
    }

    public function unsubscribeAction() {
        $post = $this->request->getJson();
        $user = $this->auth->user(NULL, TRUE);

        $user->getTokens(array(
            'sut_su_id = :user: AND sut_token = :token:',
            'bind' => array(
                'user' => $user->su_id,
                'token' => $post['token']
            )
        ))->delete();

        return array(
            'success' => TRUE
        );
    }
    
    public function notifyAction($id) {
        $post = $this->request->getJson();
        $data = Notification::get($id)->data;

        $result = new \stdClass();
        $result->success = TRUE;

        if ($data && ($task = $data->getTask())) {

            if ($post['target'] == 'users') {
                $devices = array();

                foreach($task->getUsers() as $user) {
                    if ($user->su_id != $data->ta_sender) {
                        foreach($user->getTokens() as $token) {
                            $devices[] = $token->sut_token;
                        }
                    }
                }

                if (count($devices) > 0) {
                    $title = sprintf(
                        '%s %s %s %s',
                        $data->getSenderName(),
                        $data->ta_type == 'warning' ? 'memberikan peringatan pada dokumen' : 'mengomentari dokumen',
                        $data->ta_task_ns,
                        $data->ta_title
                    );

                    $body = $data->getComment();
                    $body = strip_tags($body);

                    $payload = array(
                        'title' => $title,
                        'body' => $body
                    );

                    $link = $task->getLink(TRUE);

                    if ( ! empty($link)) {
                        $payload['link'] = $link;
                    }

                    $this->notifyDevices($devices, $payload, $result);
                }
            }
            
        }

        return $result;
    }

    public function notifyDevices($tokens, $payload = array(), &$result) {
        if (count($tokens) > 0) {
            $token = array_shift($tokens);
            $result = $this->gcm->send($token, $payload);
            sleep(1);
            $this->notifyDevices($tokens, $payload, $result);
        }
    }

    public function syncAction() {
        $post = $this->request->getJson();
        $user = $this->auth->user();

        $find = UserToken::findFirst(array(
            'sut_token = :token:',
            'bind' => array(
                'token' => $post['token']
            )
        ));

        if ( ! $find) {
            $sync = new UserToken();
            $sync->sut_type = 'gcm';
            $sync->sut_su_id = $user['su_id'];
            $sync->sut_token = $post['token'];
            $sync->sut_topic = $post['topic'];
            $sync->sut_created = date('Y-m-d H:i:s');
            $sync->save();
        }

        return array(
            'success' => TRUE
        );
    }
}