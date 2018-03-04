<?php
namespace App\Notifications\Controllers;

use App\Users\Models\UserToken;
use App\Notifications\Models\Notification;

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

    public function notifyAction() {
        $post = $this->request->getJson();

        $data = array(
            'body' => $post['body'],
            'title' => $post['title']
        );

        if (isset($post['link'])) {
            $data['link'] = $post['link'];
        }

        return $this->gcm->send($post['topic'], $data);
        // return $this->gcm->send('chrome', $data);
    }
}