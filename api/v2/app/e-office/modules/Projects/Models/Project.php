<?php
namespace App\Projects\Models;

use Phalcon\Mvc\Model\Relation;

class Project extends \Micro\Model {

    public function initialize() {
        $this->hasOne(
            'sp_creator_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Creator'
            )
        );

        $this->hasOne(
            'sp_worksheet_id',
            'App\Kanban\Models\KanbanSetting',
            'ks_id',
            array(
                'alias' => 'Worksheet'
            )
        );

        $this->hasMany(
            'sp_id',
            'App\Projects\Models\ProjectUser',
            'spu_sp_id',
            array(
                'alias' => 'ProjectUsers',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasManyToMany(
            'sp_id',
            'App\Projects\Models\ProjectUser',
            'spu_sp_id',
            'spu_su_id',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Users'
            )
        );

        $this->hasMany(
            'sp_id',
            'App\Tasks\Models\Task',
            'tt_sp_id',
            array(
                'alias' => 'Tasks',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );
        
    }

	function getSource() {
		return 'sys_projects';
	}

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);
        $data['sp_logo'] = strtoupper(substr($this->sp_name, 0, 1));
        $data['sp_accent'] = self::__computeAccent();
        $data['sp_created_date_formatted'] = date('d M Y', strtotime($this->sp_created_date));
        $data['sp_end_date_formatted'] = $this->sp_end_date ? date('d M Y', strtotime($this->sp_end_date)) : '';
        
        if ($this->creator) {
            $data['sp_creator_fullname'] = $this->creator->su_fullname;
        }
        
        $data['sp_worksheet_purpose'] = 0;

        if ($this->worksheet) {
            $data['sp_worksheet_name'] = $this->worksheet->ks_name;
            $data['sp_worksheet_purpose'] = $this->worksheet->ks_purpose;
        }

        return $data;
    }

    private static function __computeAccent() {
        $colors = array(
            'var(--paper-indigo-500)',
            'var(--paper-pink-500)',
            'var(--paper-cyan-500)',
            'var(--paper-amber-500)'
        );

        $index = array_rand($colors);
        $accent = $colors[$index];

        return $accent;
    }
}