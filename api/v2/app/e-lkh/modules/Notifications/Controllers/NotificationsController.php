<?php
namespace App\Notifications\Controllers;

use App\Notifications\Models\Notification;
use App\Users\Models\UserToken;
use Micro\Http\Client as HttpClient;

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

    public function statusAction() {
        $auth = $this->auth->user(NULL, TRUE);
        $count = $auth->getTokens("sut_type = 'fcm'")->count();

        return array(
            'success' => TRUE,
            'data' => array(
                'subscribed' => $count > 0
            )
        );
    }

    public function subscribeAction() {
        $post = $this->request->getJson();
        $user = $this->auth->user(NULL, TRUE);
        $fire = $this->config->firebase;
        $chan = 'global';

        $http = new HttpClient();

        $http->send(
            'POST', 
            'https://iid.googleapis.com/iid/v1/'.$post['token'].'/rel/topics/'.$chan, 
            array(),
            array(
                'json' => TRUE,
                'insecure' => TRUE,
                'headers' => array(
                    'Authorization: key='.$fire->backend->server_key
                )
            )
        );

        $result = $http->result();

        if ($result['http_code'] == 200) {
            
            $token = UserToken::findFirst(array(
                'sut_type = :type: AND sut_su_id = :user: AND sut_token = :code:',
                'bind' => array(
                    'type' => 'fcm',
                    'user' => $user->su_id,
                    'code' => $post['token']
                )
            ));

            if ( ! $token) {
                $token = new UserToken();
            
                $token->sut_su_id = $user->su_id;
                $token->sut_type = 'fcm';
                $token->sut_device = $post['device'];
                $token->sut_channel = $chan;
                $token->sut_token = $post['token'];
                $token->sut_created = date('Y-m-d H:i:s');

                $token->save();
            }
            
        }

        return array(
            'success' => TRUE,
            'data' => $result
        );
    }

    public function unsubscribeAction() {
        $post = $this->request->getJson();
        $user = $this->auth->user(NULL, TRUE);

        $user->getTokens(array(
            'sut_type = :type: AND sut_su_id = :user: AND sut_token = :code:',
            'bind' => array(
                'type' => 'fcm',
                'user' => $user->su_id,
                'code' => $post['token']
            )
        ))->delete();

        return array(
            'success' => TRUE
        );
    }

    public function notifyAction() {
        $post = $this->request->getJson();
        $fire = $this->config->firebase;

        $data = array(
            'body' => $post['body'],
            'title' => $post['title']
        );

        if (isset($post['link'])) {
            $data['link'] = $post['link'];
        }

        $http = new HttpClient();

        $http->send(
            'POST',
            'https://fcm.googleapis.com/v1/projects/'.$fire->backend->project_id.'/messages:send',
            array(
                'message' => array(
                    'topic' => 'global',
                    'data' => $data
                )
            ),
            array(
                'json' => TRUE,
                'headers' => array(
                    'Authorization: Bearer '.$post['token']
                )
            )
        );

        $result = $http->result();

        return array(
            'success' => TRUE,
            'data' => $result
        );
    }
}