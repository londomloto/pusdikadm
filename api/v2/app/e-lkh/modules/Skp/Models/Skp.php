<?php
namespace App\Skp\Models;

use Micro\Helpers\Date as DateHelper;

class Skp extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'skp_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'User'
            )
        );

        $this->hasOne(
            'skp_examiner',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Examiner'
            )
        );

        $this->hasOne(
            'skp_superior',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Superior'
            )
        );

        $this->hasMany(
            'skp_id',
            'App\Skp\Models\SkpItem',
            'ski_skp_id',
            array(
                'alias' => 'Items'
            )
        );
    }

    public function getSource() {
        return 'trx_skp';
    }

    public function beforeSave() {
        if (isset($this->skp_exam_id) && $this->skp_exam_id == '') {
            $this->skp_exam_id = NULL;
        }
    }

    public function getTitle() {
        $user = $this->user;

        return sprintf(
            '%s (%s s.d %s)',
            $user ? $user->getName() : '(dihapus)',
            DateHelper::format($this->skp_start_date, 'd M Y'),
            DateHelper::format($this->skp_end_date, 'd M Y')
        );

    }

    public function getPeriod() {
        static $period;

        if (is_null($period)) {
            $start = DateHelper::create($this->skp_start_date);
            $end = DateHelper::create($this->skp_end_date);

            $m1 = $start->format('F');
            $m2 = $end->format('F');
            $y1 = $start->format('Y');
            $y2 = $end->format('Y');    

            if ($y1 == $y2) {
                if ($m1 == $m2) {
                    $period = $m1.' '.$y1;
                } else {
                    $period = $m1.' s/d '.$m2.' '.$y1;
                }
            } else {
                $period = $m1.' '.$y1.' s/d '.$m1.' '.$y2;
            }
        }

        return 'Periode ' . $period;
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        $data['skp_title'] = $this->getTitle();
        $data['skp_period'] = $this->getPeriod();
        $data['skp_start_date_formatted'] = DateHelper::format($this->skp_start_date, 'd M Y');
        $data['skp_end_date_formatted'] = DateHelper::format($this->skp_end_date, 'd M Y');
        $data['skp_created_dt_formatted'] = DateHelper::format($this->skp_created_dt, 'd M Y');

        if (($user = $this->user)) {
            $data['skp_su_fullname'] = $user->getName();
            $data['skp_su_no'] = $user->su_no;
            $data['skp_su_grade'] = $user->su_grade;
            $data['skp_su_sj_name'] = $user->job ? $user->job->sj_name : '';
            $data['skp_su_sdp_name'] = $user->department ? $user->department->sdp_name : '';
            $data['skp_su_avatar_thumb'] = $user->getAvatarThumb();
        }

        if (($examiner = $this->examiner)) {
            $data['examiner_su_fullname'] = $examiner->getName();
            $data['examiner_su_no'] = $examiner->su_no;
            $data['examiner_su_grade'] = $examiner->su_grade;
            $data['examiner_su_sj_name'] = $examiner->job ? $examiner->job->sj_name : '';
            $data['examiner_su_sdp_name'] = $examiner->department ? $examiner->department->sdp_name : '';
        }

        if (($superior = $this->superior)) {
            $data['superior_su_fullname'] = $superior->getName();
            $data['superior_su_no'] = $superior->su_no;
            $data['superior_su_grade'] = $superior->su_grade;
            $data['superior_su_sj_name'] = $superior->job ? $superior->job->sj_name : '';
            $data['superior_su_sdp_name'] = $superior->department ? $superior->department->sdp_name : '';
        }

        $data['items'] = array();

        foreach($this->items as $item) {
            $data['items'][] = $item->toArray();
        }

        return $data;
    }

    public function getSortedItems() {
        $items = $this->getItems(array('order' => 'ski_id DESC'));
        $array = array();
        $count = count($items);
        $index = 0;

        foreach($items as $item) {
            $data = $item->toArray();
            $data['ski_seq'] = $count - $index;

            $array[] = $data;
            $index++;
        }

        return $array;
    }

    public function saveItems($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->items as $elem) {
            $current[$elem->ski_id] = TRUE;
        }

        foreach($post as $elem) {
            if ( ! isset($elem['ski_id'])) {
                $created[] = $elem;
            } else if (isset($current[$elem['ski_id']])) {
                $updated[] = $elem;
                unset($current[$elem['ski_id']]);
            }
        }

        $current = array_values(array_keys($current));

        if (count($current) > 0) {
            SkpItem::get()->inWhere('ski_id', $current)->execute()->delete();
        }

        if (count($created) > 0) {
            foreach($created as $elem) {
                if ( ! empty($elem['ski_desc'])) {
                    $item = new SkpItem();
                    $elem['ski_skp_id'] = $this->skp_id;
                    $item->save($elem);
                }
            }
        }
        
    }

}