<?php
namespace App\Messages\Controllers;

use App\Messages\Models\Outbox;
use App\Messages\Models\Recipient;
use App\Users\Models\UserToken;

class OutboxController extends \Micro\Controller {

    public function findAction() {
        $user = $this->auth->user();

        return Outbox::get()
            ->andWhere('smo_sender = :user:', array('user' => $user['su_id']))
            ->filterable()
            ->orderBy('smo_created_dt DESC') 
            ->paginate();
    }

    public function openAction($code) {
        $message = Outbox::findByCode($code);
        return array(
            'success' => $message ? TRUE : FALSE,
            'data' => $message ? $message->toArray() : NULL
        );
    }

    public function trashAction() {
        $post = $this->request->getJson();

        foreach($post['messages'] as $code) {
            $message = Outbox::findByCode($code);    
            if ($message) {
                $message->delete();
            }
        }
        
        return array(
            'success' => TRUE
        );
    }

    public function sendAction() {
        $user = $this->auth->user();

        $post = $this->request->getJson();

        $post['smo_sending_dt'] = date('Y-m-d H:i:s');
        $post['smo_created_dt'] = date('Y-m-d H:i:s');
        $post['smo_sender'] = $user['su_id'];
        $post['smo_code'] = Outbox::generateCode();
        $post['smo_sending'] = 1;

        $outbox = new Outbox();

        if ($outbox->save($post)) {
            $outbox = $outbox->refresh();
            $recipients = isset($post['smo_recipients']) ? $post['smo_recipients'] : array();

            foreach($recipients as $e) {
                $rcpt = new Recipient();
                
                $rcpt->smr_smo_id = $outbox->smo_id;
                $rcpt->smr_recipient = $e;
                $rcpt->save();

                $outbox->sendTo($e);
            }

            // notify
            $sender = $user['su_id'];

            $recipients = array_filter($recipients, function($e) use ($sender){
                if ($e != $sender) {
                    return $e;
                }
            });
            
            if (count($recipients) > 0) {

                $subscribers = UserToken::get()
                    ->columns(array('sut_token'))
                    ->inWhere('sut_su_id', $recipients)
                    ->execute()
                    ->toArray();

                $subscribers = array_map(function($e){ return $e['sut_token']; }, $subscribers);

                $this->notify($subscribers, array(
                    'title' => 'Pesan dari '.$user['su_fullname'],
                    'body' => $outbox->getSubject()
                ));
            }

            return Outbox::get($outbox->smo_id);
        }

        return Outbox::none();
    }

    public function notify(&$subscribers, $data) {
        if (count($subscribers) > 0) {
            $token = array_shift($subscribers);
            $response = $this->gcm->send($token, $data);
            sleep(1);
            $this->notify($subscribers, $data);
        }
    }

    public function saveAction() {
        $user = $this->auth->user();

        $post = $this->request->getJson();

        if (isset($post['smo_id'])) {
            unset($post['smo_id']);
        }

        $outbox = new Outbox();

        $post['smo_sending_dt'] = date('Y-m-d H:i:s');
        $post['smo_created_dt'] = date('Y-m-d H:i:s');
        $post['smo_sender'] = $user['su_id'];
        $post['smo_code'] = Outbox::generateCode();
        $post['smo_sending'] = 0;

        if ($outbox->save($post)) {
            $outbox = $outbox->refresh();
            $recipients = isset($post['smo_recipients']) ? $post['smo_recipients'] : array();

            foreach($recipients as $e) {
                $rcpt = new Recipient();
                
                $rcpt->smr_smo_id = $outbox->smo_id;
                $rcpt->smr_recipient = $e;
                $rcpt->save();
            }
            return Outbox::get($outbox->smo_id);
        }

        return Outbox::none();
    }

}