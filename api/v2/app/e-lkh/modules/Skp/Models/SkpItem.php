<?php
namespace App\Skp\Models;

use App\System\Models\Constant;

class SkpItem extends \Micro\Model {

    public function getSource() {
        return 'trx_skp_items';
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['ski_text'] = $data['ski_desc'];
        $data['ski_expand'] = FALSE;
        $data['ski_cost_formatted'] = number_format($data['ski_cost'], 0, ',', '.');

        $data['calculation'] = $this->getCalculation();

        if ($data['ski_extra'] == 0) {
            $data['ski_total'] = round($data['calculation']['total']);
            $data['ski_performance'] = round($data['calculation']['performance'], 2);    
        } else {
            $data['ski_total'] = (double)$data['ski_total'] > 0 ? $data['ski_total'] : NULL;
            $data['ski_performance'] = (double)$data['ski_performance'] > 0 ? $data['ski_performance'] : NULL;
        }

        return $data;
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
            'performance' => $performance
        );
    }

}