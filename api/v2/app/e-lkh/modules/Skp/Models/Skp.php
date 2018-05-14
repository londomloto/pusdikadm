<?php
namespace App\Skp\Models;

use App\System\Models\Constant;
use Micro\Helpers\Date;

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
        $this->nulled(array(
            'skp_examiner',
            'skp_evaluator',
            'skp_report_dt',
            'skp_receive_dt',
            'skp_objection_dt',
            'skp_response_dt',
            'skp_resolution_dt',
            'skp_disposition_dt'
        ));

        // create period
        if (isset($this->skp_start_date, $this->skp_end_date)) {
            $this->skp_period = Date::formatPeriod($this->skp_start_date, $this->skp_end_date);
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

    public function getYear() {
        if ( ! empty($this->skp_start_date)) {
            return date('Y', strtotime($this->skp_start_date));
        }
        return NULL;
    }

    public function hasEvaluator() {
        return $this->evaluator !== FALSE;
    }

    public function hasExaminer() {
        return $this->examiner !== FALSE;
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        
        $data['skp_title'] = $this->getTitle();
        $data['skp_year'] = $this->getYear();
        $data['skp_start_date_formatted'] = Date::format($this->skp_start_date, 'd M Y');
        $data['skp_end_date_formatted'] = Date::format($this->skp_end_date, 'd M Y');
        $data['skp_created_dt_formatted'] = Date::format($this->skp_created_dt, 'd M Y');
        $data['skp_performance_criteria_text'] = !empty($this->skp_performance_criteria) ? '('.$this->skp_performance_criteria.')' : '';
        $data['skp_behavior_criteria_text'] = !empty($this->skp_behavior_criteria) ? '('.$this->skp_behavior_criteria.')' : '';
        $data['skp_criteria_text'] = !empty($this->skp_criteria) ? '('.$this->skp_criteria.')' : '';
        
        $data['company_scp_name'] = NULL;
        $data['company_scp_parent'] = NULL;
        
        if (($user = $this->user)) {
            foreach($user->toSimpleArray() as $key => $val) {
                $data['skp_'.$key] = $val;
            }

            if (($company = $user->company)) {
                $data['company_scp_name'] = $company->scp_name;
                $data['company_scp_parent'] = $company->scp_parent;
            }
        }

        $data['skp_has_evaluator'] = FALSE;
        $data['skp_has_examiner'] = FALSE;

        if (($evaluator = $this->evaluator)) {
            $data['skp_has_evaluator'] = TRUE;
            
            foreach($evaluator->toSimpleArray() as $key => $val) {
                $data['evaluator_'.$key] = $val;
            }
        }

        if (($examiner = $this->examiner)) {
            $data['skp_has_examiner'] = TRUE;

            foreach($examiner->toSimpleArray() as $key => $val) {
                $data['examiner_'.$key] = $val;
            }
        }

        $data['skp_performance_portion'] = Constant::valueOf('PERFORMANCE_PORTION');
        $data['skp_behavior_portion'] = Constant::valueOf('BEHAVIOR_PORTION');
        $data['skp_value_formatted'] = self::__format($data['skp_value'], 2);
        $data['skp_performance_formatted'] = self::__format($data['skp_performance'], 2);
        $data['skp_performance_value_formatted'] = self::__format($data['skp_performance_value'], 2);
        $data['skp_behavior_total_formatted'] = self::__format($data['skp_behavior_total'], 2);
        $data['skp_behavior_value_formatted'] = self::__format($data['skp_behavior_value'], 2);
        $data['skp_behavior_average_formatted'] = self::__format($data['skp_behavior_average'], 2);
        
        return $data;
    }

    private static function __format($value, $decimal = 0) {
        return is_null($value) ? NULL : number_format($value, $decimal, ',', '.');
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

    public static function flags() {

        return array(
            'EXAM' => array(
                'name' => 'EXAM',
                'text' => 'Tidak ada tindakan'
            ),
            'REVISION' => array(
                'name' => 'REVISION',
                'text' => 'Dikembalikan untuk diperbaiki'
            ),
            'DONE' => array(
                'name' => 'DONE',
                'text' => 'Diteruskan untuk disahkan'
            )
        );

    }
}