<?php
namespace App\Messages\Models;

use Micro\Helpers\Date as DateHelper;
use Micro\Helpers\Text as TextHelper;

class Inbox extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'smi_sender',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Sender'
            )
        );
    }

    public function getSource() {
        return 'sys_inbox';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['smi_receiving_dt_formatted'] = DateHelper::format($this->smi_receiving_dt);
        $data['smi_receiving_dt_relative'] = DateHelper::formatRelative($this->smi_receiving_dt);
        $data['smi_has_sender'] = FALSE;
        $data['smi_summary'] = strip_tags($this->smi_text);
        $data['smi_summary'] = empty($data['smi_summary']) ? '(kosong)' : TextHelper::limitWords($data['smi_summary'], 20);
        $data['smi_subject'] = empty($data['smi_subject']) ? '(kosong)' : $data['smi_subject'];

        $data['smi_checked'] = 0;

        if (($sender = $this->sender)) {
            $data['smi_has_sender'] = TRUE;
            $data['sender_su_fullname'] = $sender->getName();
            $data['sender_su_avatar_thumb'] = $sender->getAvatarThumb();
            $data['sender_su_email'] = $sender->su_email;
        }

        return $data;
    }

    public static function findByCode($code) {
        return self::findFirst(array(
            'smi_code = :code:',
            'bind' => array(
                'code' => $code
            )
        ));
    }

    public static function generateCode($loop = 0) {

        if ($loop > 5) {
            $max = self::maximum(array('column' => 'smo_id'));
            $max = 'inbox-'.((int)$max + 1);
            return $max;
        }

        $code = \Micro\App::getDefault()->security->getRandom()->base64safe();
        $find = self::findFirst(array('smi_code = :code:', 'bind' => array('code' => $code)));

        if ($find) {
            $loop = ($loop + 1);
            $code = self::generateCode($loop);
        }

        return $code;
    }
}