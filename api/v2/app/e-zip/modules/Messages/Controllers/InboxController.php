<?php
namespace App\Messages\Controllers;

Use App\Messages\Models\Inbox;

class InboxController extends \Micro\Controller {

    public function findAction() {

        //var_dump($this->security->getRandom()->base64Safe());

        $user = $this->auth->user();

        return Inbox::get()
            ->andWhere('smi_recipient = :user:', array('user' => $user['su_id']))
            ->filterable()
            ->orderBy('smi_created_dt DESC') 
            ->paginate();

    }

    public function infoAction() {
        $user = $this->auth->user();
        $result = Inbox::get()
            ->columns('COUNT(smi_id) as unread')
            ->andWhere('smi_recipient = :user:', array('user' => $user['su_id']))
            ->andWhere('smi_read = 0 AND smi_deleted = 0')
            ->execute();

        $unread = 0;
        $row = $result->getFirst();
        if ($row) {
            $unread = (int)$row->unread;
        }

        return array(
            'success' => TRUE,
            'data' => array(
                'unread' => $unread
            )
        );
    }

    public function readAction($code) {
        $message = Inbox::findByCode($code);

        if ($message) {
            $message->smi_read = 1;
            $message->save();

            return array(
                'success' => TRUE,
                'data' => $message->toArray()
            );
        }

        return array(
            'success' => FALSE,
            'data' => NULL
        );
    }

    public function trashAction() {
        $post = $this->request->getJson();

        foreach($post['messages'] as $code) {
            $message = Inbox::findByCode($code);    
            if ($message) {
                $message->smi_deleted = 1;
                $message->save();
            }
        }
        

        return array(
            'success' => TRUE
        );
    }

    public function restoreAction() {
        $post = $this->request->getJson();

        foreach($post['messages'] as $code) {
            $message = Inbox::findByCode($code);    
            if ($message) {
                $message->smi_deleted = 0;
                $message->save();
            }
        }
        

        return array(
            'success' => TRUE
        );
    }

    public function removeAction() {
        $post = $this->request->getJson();

        foreach($post['messages'] as $code) {
            $message = Inbox::findByCode($code);    
            if ($message) {
                $message->delete();
            }
        }
        

        return array(
            'success' => TRUE
        );
    }

}