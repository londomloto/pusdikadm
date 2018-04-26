<?php
namespace App\Skp\Models;

use App\System\Models\Constant;

class SkpItem extends \Micro\Model {

    public function initialize() {
        $this->belongsTo(
            'ski_skp_id',
            'App\Skp\Models\Task',
            'skp_id',
            array(
                'alias' => 'Task'
            )
        );
    }

    public function getSource() {
        return 'trx_skp_items';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['ski_text'] = $data['ski_desc'];
        $data['ski_expand'] = FALSE;
        
        $data['calculation'] = $this->getCalculation();

        if ($data['ski_extra'] == 0) {
            $data['ski_total'] = $data['calculation']['total_fixed'];
            $data['ski_performance'] = $data['calculation']['performance_fixed'];
        } else {
            $data['ski_total'] = (double)$data['ski_total'] > 0 ? $data['ski_total'] : NULL;
            $data['ski_performance'] = (double)$data['ski_performance'] > 0 ? $data['ski_performance'] : NULL;
        }

        // report
        $data['ski_ak_formatted'] = self::__format($data['ski_ak'], 2);
        $data['ski_ak_real_formatted'] = self::__format($data['ski_ak_real'], 2);
        $data['ski_ak_factor_formatted'] = self::__format($data['ski_ak_factor'], 2);
        $data['ski_volume_formatted'] = self::__format($data['ski_volume']);
        $data['ski_volume_real_formatted'] = self::__format($data['ski_volume_real']);
        $data['ski_duration_formatted'] = self::__format($data['ski_duration']);
        $data['ski_duration_real_formatted'] = self::__format($data['ski_duration_real']);
        $data['ski_cost_formatted'] = self::__format($data['ski_cost']);
        $data['ski_cost_real_formatted'] = self::__format($data['ski_cost_real']);
        $data['ski_quality_formatted'] = self::__format($data['ski_quality'], 2);
        $data['ski_quality_real_formatted'] = self::__format($data['ski_quality_real'], 2);

        $data['ski_total_formatted'] = self::__format($data['ski_total']);
        $data['ski_performance_formatted'] = self::__format($data['ski_performance'], 2);

        return $data;
    }

    private static function __format($value, $decimal = 0) {
        return is_null($value) ? NULL : number_format($value,  $decimal, ',', '.');
    }

    public function getCalculation() {
        $volumeCounter = (int)$this->ski_volume > 0 ? 1 : 0;
        
        $durationPercentage = 100;
        $duration = (int)$this->ski_duration;
        $durationReal = (int)$this->ski_duration_real;

        if ($duration > 0) {
            $durationPercentage = 100 - ($durationReal / $duration * 100);
        }

        $costPercentage = 100;
        $cost = (double)$this->ski_cost;
        $costReal = (double)$this->ski_cost_real;

        if ($cost > 0) {
            $costPercentage = 100 - ($costReal / $cost * 100);
        }

        $volumeTotal = 0;
        $volume = (double)$this->ski_volume;
        $volumeReal = (double)$this->ski_volume_real;

        if ($volume > 0) {
            $volumeTotal = ($volumeReal / $volume * 100);
        }

        $qualityTotal = 0;
        $quality = (double)$this->ski_quality;
        $qualityReal = (double)$this->ski_quality_real;

        if ($quality > 0) {
            $qualityTotal = ($qualityReal / $quality * 100);
        }

        $durationTolerance = (double)Constant::valueOf('DURATION_TOLERANCE');
        $durationLimit = (double)Constant::valueOf('DURATION_LIMIT');
        $durationFactor = (double)Constant::valueOf('DURATION_FACTOR');
        $costTolerance = (double)Constant::valueOf('COST_TOLERANCE');
        $costLimit = (double)Constant::valueOf('COST_LIMIT');
        $costFactor = (double)Constant::valueOf('COST_FACTOR');

        $durationLower = 0;
        $durationUpper = ($durationLimit - 100);

        if ($duration > 0) {
            $durationLower = (($durationFactor * $duration - $durationReal) / $duration) * 100; 
            $durationUpper = ($durationLimit - ($durationLower - 100));
        }

        $durationTotal = $durationPercentage > $durationTolerance ? $durationUpper : $durationLower;

        $costLower = 0;
        $costUpper = ($costLimit - 100);

        if ($cost > 0) {
            $costLower = (($costFactor * $cost - $costReal) / $cost) * 100;
            $costUpper = ($costLimit - ($costLower - 100));
        }

        $costTotal = $costPercentage > $costTolerance ? $costUpper : $costLower;

        if (is_null($this->ski_cost_real)) {
            $total = ($volumeTotal + $qualityTotal + $durationTotal);
            $performance = ($total / 3);
        } else {
            $total = ($volumeTotal + $qualityTotal + $durationTotal + $costTotal);
            $performance = ($total / 4);
        }

        $totalFixed = round($total);
        $performanceFixed = round($performance, 2);

        if ($volumeCounter === 0) {
            $totalFixed = NULL;
            $performanceFixed = NULL;
        }

        // initial calculation
        return array(
            'volume_counter' => $volumeCounter,
            'duration_tolerance' => $durationTolerance,
            'duration_limit' => $durationLimit,
            'duration_percentage' => $durationPercentage,
            'duration_factor' => $durationFactor,
            'cost_tolerance' => $costTolerance,
            'cost_limit' => $costLimit,
            'cost_percentage' => $costPercentage,
            'cost_factor' => $costFactor,
            'volume_total' => $volumeTotal,
            'quality_total' => $qualityTotal,
            'duration_total' => $durationTotal,
            'duration_lower' => $durationLower,
            'duration_upper' => $durationUpper,
            'cost_total' => $costTotal,
            'cost_lower' => $costLower,
            'cost_upper' => $costUpper,
            'total' => $total,
            'total_fixed' => $totalFixed,
            'performance' => $performance,
            'performance_fixed' => $performanceFixed
        );
    }

}