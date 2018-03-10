<?php
namespace App\Messages\Models;

use Micro\Helpers\Date as DateHelper;
use Micro\Helpers\Text as TextHelper;

class Outbox extends \Micro\Model {

    public function initialize() {
        $this->hasMany(
            'smo_id',
            'App\Messages\Models\Recipient',
            'smr_smo_id',
            array(
                'alias' => 'Recipients',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'sys_outbox';
    }

    public function getSubject() {
        return empty($this->smo_subject) ? '(subjek kosong)' : $this->smo_subject;
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['smo_sending_dt_formatted'] = DateHelper::format($this->smo_sending_dt);
        $data['smo_sending_dt_relative'] = DateHelper::formatRelative($this->smo_sending_dt);
        $data['smo_created_dt_formatted'] = DateHelper::format($this->smo_created_dt);
        $data['smo_summary'] = strip_tags($this->smo_text);
        $data['smo_summary'] = empty($data['smo_summary']) ? '(pesan kosong)' : TextHelper::limitWords($data['smo_summary'], 20);
        $data['smo_subject'] = empty($data['smo_subject']) ? '(subjek kosong)' : $data['smo_subject'];
        $data['smo_recipients'] = array();
        $data['smo_recipients_names'] = array();
        $data['smo_checked'] = 0;

        foreach($this->recipients as $e) {
            if (($rcpt = $e->recipient)) {
                $data['smo_recipients'][] = $rcpt->su_id;
                $data['smo_recipients_names'][] = $rcpt->getName();
            }
        }

        $data['smo_recipients_names'] = implode(', ', $data['smo_recipients_names']);
        $data['smo_has_recipients'] = count($data['smo_recipients']) > 0;

        return $data;
    }

    public function sendTo($recipient) {
        $inbox = new Inbox();
        
        $inbox->smi_code = Inbox::generateCode();
        $inbox->smi_subject = $this->smo_subject;
        $inbox->smi_sender = $this->smo_sender;
        $inbox->smi_recipient = $recipient;
        $inbox->smi_receiving_dt = date('Y-m-d H:i:s');
        $inbox->smi_text = $this->smo_text;
        $inbox->smi_read = 0;
        $inbox->smi_created_dt = date('Y-m-d H:i:s');

        $inbox->save();
    }

    public static function findByCode($code) {
        return self::findFirst(array(
            'smo_code = :code:',
            'bind' => array(
                'code' => $code
            )
        ));
    }

    public static function generateCode($loop = 0) {

        if ($loop > 5) {
            $max = self::maximum(array('column' => 'smo_id'));
            $max = 'outbox-'.((int)$max + 1);
            return $max;
        }

        $code = \Micro\App::getDefault()->security->getRandom()->base64safe();
        $find = self::findFirst(array('smo_code = :code:', 'bind' => array('code' => $code)));

        if ($find) {
            $loop = ($loop + 1);
            $code = self::generateCode($loop);
        }

        return $code;
    }

}