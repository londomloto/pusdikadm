<?php
namespace App\Jobs\Models;

use App\Dispositions\Models\Disposition;

class Job extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'sj_superior',
            'App\Jobs\Models\Job',
            'sj_id',
            array(
                'alias' => 'Superior'
            )
        );

        $this->hasMany(
            'sj_id',
            'App\Jobs\Models\Job',
            'sj_superior',
            array(
                'alias' => 'Subordinates'
            )
        );

        $this->hasMany(
            'sj_id',
            'App\Dispositions\Models\Disposition',
            'stp_job',
            array(
                'alias' => 'Dispositions',
                'foreignKey' => array(
                    'action' => \Phalcon\Mvc\Model\Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'sys_jobs';
    }

    public function beforeSave() {
        $this->nulled(array(
            'sj_superior'
        ));
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['sj_superior_name'] = $this->getSuperiorName();
        return $data;
    }

    public function getSuperiorName() {
        if (($superior = $this->superior)) {
            return $superior->sj_name;
        }
        return NULL;
    }

    public function setupDisposition() {
        if ($this->getDispositions()->count() === 0) {
            $template = new Disposition();

            $template->stp_job = $this->sj_id;

            $template->stp_name = 'DISPOSISI '.strtoupper($this->sj_acronym);
            $template->stp_subordinates = '[]';
            $template->stp_flows = '[]';
            $template->save();
        }
    }

    public function fetchSubordinates() {
        
        $subs = array();
        
        foreach($this->subordinates as $item) {
            $subs[] = array(
                'sj_id' => $item->sj_id,
                'sj_name' => $item->sj_name
            );
        }

        return $subs;
    }

}