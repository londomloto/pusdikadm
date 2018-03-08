<?php
namespace App\Presence\Models;

use App\Calendar\Models\Calendar;
use Micro\Helpers\Date as DateHelper;

class Presence extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'tpr_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'User'
            )
        );
    }

    public function getSource() {
        return 'trx_presence';
    }

    public function getTitle() {
        $title  = $this->user ? $this->user->getName() : '(dihapus)';
        $title .= ' - '.DateHelper::format($this->tpr_date, 'd M Y');
        return $title;
    }

    public function getIcon() {
        switch($this->tpr_type) {
            case 'Masuk':
                return 'social:mood';
            default:
                return 'social:mood';
        }
    }

    public function getFileUrl() {
        if ( ! empty($this->tpr_filename)) {
            return \Micro\App::getDefault()->url->getBaseUrl().'public/resources/attachments/'.$this->tpr_filename;
        }
        return '';;
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['tpr_title'] = $this->getTitle();
        $data['tpr_date_formatted'] = DateHelper::format($this->tpr_date, 'd M Y');
        $data['tpr_has_file'] = !empty($this->tpr_filename);
        $data['tpr_has_time'] = $this->tpr_type == 'Masuk';

        if ($this->user) {
            $data['tpr_su_fullname'] = $this->user->getName();
            $data['tpr_su_sj_name'] = $this->user->job ? $this->user->job->sj_name : '';
            $data['tpr_su_sdp_name'] = $this->user->department ? $this->user->department->sdp_name : '';
            $data['tpr_su_avatar_thumb'] = $this->user->getAvatarThumb();
        }

        return $data;
    }

    public static function reportMonthly($user, $month, $year) {
        $range = Calendar::fill($month, $year);
        $from = $range['start'];
        $to = $range['end'];

        return self::report($user, $from, $to);
    }

    public static function reportDaily($user, $from, $to) {
        Calendar::fillRange($from, $to);
        return self::report($user, $from, $to);
    }

    public static function report($user, $from, $to) {
        $query = Calendar::get()
            ->alias('a')
            ->columns(array(
                'b.tpr_id',
                'a.sdt_date AS tpr_date',
                "IFNULL(b.tpr_type, '-') as tpr_type",
                'b.tpr_checkin',
                'b.tpr_desc',
                'b.tpr_filename',
                'b.tpr_filetype'
            ))
            ->join('App\Presence\Models\Presence', 'a.sdt_date = b.tpr_date AND b.tpr_su_id = '.$user, 'b', 'left')
            ->andWhere('a.sdt_date BETWEEN :from: AND :to:', array(
                'from' => $from,
                'to' => $to
            ));

        $result = $query->paginate();

        $result->map(function($row){
            $data = $row->toArray();
            
            $data['tpr_date_formatted'] = DateHelper::format($data['tpr_date'], 'd M Y');
            $data['tpr_has_file'] = !empty($data['tpr_filename']);
            $data['tpr_filepath'] = !empty($data['tpr_filename'])
                ? \Micro\App::getDefault()->url->getBaseUrl().'public/resources/attachments/'.$data['tpr_filename'] 
                : '';

            return $data;
        });

        return $result;
    }
}