<?php

use Phalcon\Cli\Task;
use GuzzleHttp\Client;
use Moment\Moment;

class NotificationsTask extends Task {

    public function notifyAction() {

        $today = (new Moment())->format('Y-m-d');
        $date = (new Moment())->endOf('month')->format('Y-m-d');

        if ($today == $date) {
            $client = new Client(array(
                'base_uri' => $this->config->base.'/lkh/alert?date='.$date,
                'verify' => FALSE
            ));

            try {
                $client->request('GET');
            } catch(\Exception $e) {
                echo $e->getMessage().PHP_EOL;
            }    
        }

    }

}