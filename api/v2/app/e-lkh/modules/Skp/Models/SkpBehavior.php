<?php
namespace App\Skp\Models;

use App\Behaviors\Models\Behavior;

class SkpBehavior extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'tsb_tbh_id',
            'App\Behaviors\Models\Behavior',
            'tbh_id',
            array(
                'alias' => 'Behavior'
            )
        );
    }

    public function getSource() {
        return 'trx_skp_behaviors';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        $data['tsb_criteria_text'] = !empty($data['tsb_criteria']) ? '('.$data['tsb_criteria'].')' : '';
        $data['tsb_dirty'] = FALSE;
        $data['tsb_tbh_name'] = NULL;
        $data['tsb_tbh_mandatory'] = 1;
        $data['tsb_value_formatted'] = is_null($data['tsb_value']) ? NULL : number_format($data['tsb_value'], 2, ',', '.');

        if (($behavior = $this->behavior)) {
            $data['tsb_tbh_name'] = $behavior->tbh_name;
            $data['tsb_tbh_mandatory'] = $behavior->tbh_mandatory;
        }
        
        return $data;
    }
    
    public static function fetch($skp) {
        $query = Behavior::get()
            ->alias('a')
            ->columns(array(
                'b.tsb_id',
                'b.tsb_skp_id',
                'a.tbh_id AS tsb_tbh_id',
                'a.tbh_name AS tsb_tbh_name',
                'a.tbh_mandatory as tsb_tbh_mandatory',
                'b.tsb_value',
                'b.tsb_criteria'
            ));

        if (empty($skp)) {
            $query->join('App\Skp\Models\SkpBehavior', 'a.tbh_id = b.tsb_tbh_id AND b.tsb_skp_id IS NULL ', 'b', 'LEFT');
        } else {
            $query->join('App\Skp\Models\SkpBehavior', 'a.tbh_id = b.tsb_tbh_id AND b.tsb_skp_id = '.$skp, 'b', 'LEFT');
        }

        $result = $query->execute()->toArray();

        foreach($result as &$row) {
            $row['tsb_criteria_text'] = empty($row['tsb_criteria']) ? '' : '('.$row['tsb_criteria'].')';
            $row['tsb_dirty'] = FALSE;
        }

        return $result;
    }
}