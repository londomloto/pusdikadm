<?php
namespace App\Skp\Models;

use App\System\Models\Constant;
use Micro\Helpers\Date as DateHelper;

class Skp extends \Micro\Model {

    private $__period;

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
            'skp_evaluator',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Evaluator'
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
                'alias' => 'Items',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'skp_id',
            'App\Skp\Models\SkpBehavior',
            'tsb_skp_id',
            array(
                'alias' => 'Behaviors',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_skp';
    }

    public function beforeSave() {
        if (isset($this->skp_examiner) && $this->skp_examiner == '') {
            $this->skp_examiner = NULL;
        }

        if (isset($this->skp_superior) && $this->skp_superior == '') {
            $this->skp_superior = NULL;
        }

        if (isset($this->skp_evaluator) && $this->skp_evaluator == '') {
            $this->skp_evaluator = NULL;
        }

        // create period
        if (isset($this->skp_start_date, $this->skp_end_date)) {
            $this->skp_period = DateHelper::formatPeriod($this->skp_start_date, $this->skp_end_date);
        }
    }

    public function getTitle() {
        $user = $this->user;

        return sprintf(
            '%s (%s)',
            $user ? $user->getName() : '(dihapus)', 
            $this->skp_period
        );

    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        
        $data['skp_title'] = $this->getTitle();
        $data['skp_start_date_formatted'] = DateHelper::format($this->skp_start_date, 'd M Y');
        $data['skp_end_date_formatted'] = DateHelper::format($this->skp_end_date, 'd M Y');
        $data['skp_created_dt_formatted'] = DateHelper::format($this->skp_created_dt, 'd M Y');
        $data['skp_performance_criteria_text'] = !empty($this->skp_performance_criteria) ? '('.$this->skp_performance_criteria.')' : '';
        $data['skp_behavior_criteria_text'] = !empty($this->skp_behavior_criteria) ? '('.$this->skp_behavior_criteria.')' : '';
        $data['skp_criteria_text'] = !empty($this->skp_criteria) ? '('.$this->skp_criteria.')' : '';
        
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

        if (($evaluator = $this->evaluator)) {
            $data['evaluator_su_fullname'] = $evaluator->getName();
            $data['evaluator_su_no'] = $evaluator->su_no;
            $data['evaluator_su_grade'] = $evaluator->su_grade;
            $data['evaluator_su_sj_name'] = $evaluator->job ? $evaluator->job->sj_name : '';
            $data['evaluator_su_sdp_name'] = $evaluator->department ? $evaluator->department->sdp_name : '';
        }

        if (($superior = $this->superior)) {
            $data['superior_su_fullname'] = $superior->getName();
            $data['superior_su_no'] = $superior->su_no;
            $data['superior_su_grade'] = $superior->su_grade;
            $data['superior_su_sj_name'] = $superior->job ? $superior->job->sj_name : '';
            $data['superior_su_sdp_name'] = $superior->department ? $superior->department->sdp_name : '';
        }

        $data['skp_authorized'] = FALSE;
        $auth = \Micro\App::getDefault()->auth->user();

        if ($auth['su_id'] == $this->skp_su_id) {
            $data['skp_authorized'] = TRUE;
        }

        $data['skp_performance_portion'] = Constant::valueOf('PERFORMANCE_PORTION');
        $data['skp_behavior_portion'] = Constant::valueOf('BEHAVIOR_PORTION');

        return $data;
    }

    public function getSortedItems() {
        return $this->getItems()->filter(function($item){
            return $item->toArray();
        });
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

    public function saveBehaviors($items) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->behaviors as $e) {
            $current[$e->tsb_id] = $e;
        }

        foreach($items as $e) {
            if (empty($e['tsb_id'])) {
                $created[] = $e;
            } else if (isset($current[$e['tsb_id']])) {
                $updated[] = array(
                    'item' => $current[$e['tsb_id']],
                    'data' => $e
                );
                unset($current[$e['tsb_id']]);
            }
        }

        foreach($created as $e) {
            $item = new SkpBehavior();
            $item->save($e);
        }

        foreach($updated as $e) {
            $e['item']->save($e['data']);
        }

        foreach($current as $e) {
            $e->delete();
        }
    }
}