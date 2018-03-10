<?php
namespace Micro\Google;

use Google\Auth\Credentials\ServiceAccountCredentials;
use Google\Auth\Middleware\AuthTokenMiddleware;
use GuzzleHttp\Client;
use GuzzleHttp\HandlerStack;
use GuzzleHttp\RequestOptions;

class MessagingProvider extends \Micro\Component {  

    protected $_config;

    public function ready() {
        $this->_config = $this->getApp()->config->firebase;
    }

    public function subscribe($topic, $token) {
        $client = new Client(array(
            'base_uri' => 'https://iid.googleapis.com/iid/v1/'
        ));

        $response = $client->post(
            rawurlencode($token).'/rel/topics/'.$topic,
            array(
                'headers' => array(
                    'Content-Type' =>  'application/json',
                    'Authorization' => 'key='.$this->_config->server_key
                )
            )
        );

        $result = new \stdClass();
        $result->success = $response->getStatusCode() == 200;

        try {
            $result->data = json_decode((string) $response->getBody());
        } catch(\Exception $ex) {
            $result->data = NULL;
        }

        return $result;
    }

    public function send($token, $data) {
        $scopes = implode(' ', $this->_config->scopes->toArray());

        $serviceAccount = new ServiceAccountCredentials(
            $scopes,
            $this->_config->credential
        );

        $middleware = new AuthTokenMiddleware($serviceAccount);
        $stack = HandlerStack::create();
        $stack->push($middleware);

        $client = new Client(array(
            'handler' => $stack,
            'base_uri' => 'https://fcm.googleapis.com/v1/projects/',
            'auth' => 'google_auth'
        ));

        $response = $client->post(
            $this->_config->project_id.'/messages:send',
            array(
                RequestOptions::JSON => array(
                    'message' => array(
                        'token' => $token,
                        'data' => $data
                    )
                )
            )
        );

        $result = new \stdClass();
        $result->success = $response->getStatusCode() == 200;

        try {
            $result->data = json_decode((string) $response->getBody());
        } catch(\Exception $ex) {
            $result->data = NULL;
        }

        return $result;
    }

    public function broadcast($topic, $data) {
        
        $scopes = implode(' ', $this->_config->scopes->toArray());

        $serviceAccount = new ServiceAccountCredentials(
            $scopes,
            $this->_config->credential
        );

        $middleware = new AuthTokenMiddleware($serviceAccount);
        $stack = HandlerStack::create();
        $stack->push($middleware);

        $client = new Client(array(
            'handler' => $stack,
            'base_uri' => 'https://fcm.googleapis.com/v1/projects/',
            'auth' => 'google_auth'
        ));

        $response = $client->post(
            $this->_config->project_id.'/messages:send',
            array(
                RequestOptions::JSON => array(
                    'message' => array(
                        'topic' => $topic,
                        'data' => $data
                    )
                )
            )
        );

        $result = new \stdClass();
        $result->success = $response->getStatusCode() == 200;

        try {
            $result->data = json_decode((string) $response->getBody());
        } catch(\Exception $ex) {
            $result->data = NULL;
        }

        return $result;
    }
}