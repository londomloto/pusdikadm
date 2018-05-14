<?php
namespace App\SuratMasuk\Models;

use Micro\Helpers\Date;
use Phalcon\Mvc\Model\Relation;

class SuratMasuk extends \Micro\Model {

    private $__period;

    public function initialize() {
        
        $this->hasOne(
            'tsm_register_user',
            'App\Users\Models\User',
            'su_id',
            array(
                'alias' => 'Registrar'
            )
        );

        $this->hasOne(
            'tsm_class',
            'App\Classifications\Models\Classification',
            'scl_id',
            array(
                'alias' => 'Classification'
            )
        );

        $this->hasOne(
            'tsm_priority',
            'App\Priorities\Models\Priority',
            'spt_id',
            array(
                'alias' => 'Priority'
            )
        );

        $this->hasOne(
            'tsm_secrecy',
            'App\Secrecy\Models\Secrecy',
            'sst_id',
            array(
                'alias' => 'Secrecy'
            )
        );

        $this->hasOne(
            'tsm_category',
            'App\Categories\Models\Category',
            'sct_id',
            array(
                'alias' => 'Category'
            )
        );

        $this->hasOne(
            'tsm_shipment',
            'App\Shipments\Models\Shipment',
            'sdt_id',
            array(
                'alias' => 'Shipment'
            )
        );

        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\SuratMasukFile',
            'tsmf_tsm_id',
            array(
                'alias' => 'Files',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\SuratMasukExpedition',
            'tsme_tsm_id',
            array(
                'alias' => 'Expeditions',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );

        $this->hasMany(
            'tsm_id',
            'App\SuratMasuk\Models\Disposition',
            'tdp_tsm_id',
            array(
                'alias' => 'Dispositions',
                'foreignKey' => array(
                    'action' => Relation::ACTION_CASCADE
                )
            )
        );
    }

    public function getSource() {
        return 'trx_masuk';
    }

    public function beforeSave() {
        $this->nulled(array(
            'tsm_no',
            'tsm_date',
            'tsm_register_user',
            'tsm_priority',
            'tsm_category',
            'tsm_secrecy',
            'tsm_shipment',
            'tsm_storing_date'
        ));
    }

    public function getTitle() {
        return $this->tsm_no;
    }

    public function toArray($columns = NULL) {
        $data = parent::toArray($columns);

        $data['tsm_role'] = NULL;
        $data['tsm_title'] = $this->getTitle();
        $data['tsm_date_formatted'] = Date::format($this->tsm_date, 'd M Y');
        $data['tsm_register_date_formatted'] = Date::format($this->tsm_register_date, 'd M Y');
        
        if (($registrar = $this->registrar)) {
            $data['registrar_su_fullname'] = $registrar->getName();
            $data['registrar_su_no'] = $registrar->su_no;
        }

        if (($classification = $this->classification)) {
            foreach($classification->toArray() as $key => $val) {
                $data['classification_'.$key] = $val;
            }
        }

        if (($category = $this->category)) {
            foreach($category->toArray() as $key => $val) {
                $data['category_'.$key] = $val;
            }
        }

        if (($priority = $this->priority)) {
            foreach($priority->toArray() as $key => $val) {
                $data['priority_'.$key] = $val;
            }
        }

        if (($shipment = $this->shipment)) {
            foreach($shipment->toArray() as $key => $val) {
                $data['shipment_'.$key] = $val;
            }
        }

        if (($secrecy = $this->secrecy)) {
            foreach($secrecy->toArray() as $key => $val) {
                $data['secrecy_'.$key] = $val;
            }
        }

        return $data;
    }
    
    public function saveFiles($post) {
        $created = array();
        $updated = array();
        $current = array();

        foreach($this->getFiles() as $file) {
            $current[$file->tsmf_id] = $file;
        }

        foreach($post as $item) { 
            if ( ! isset($item['tsmf_id'])) {
                $created[] = $item;
            } else if (isset($current[$item['tsmf_id']])) {
                $updated[] = array(
                    'file' => $current[$item['tsmf_id']],
                    'data' => $item
                );

                unset($current[$item['tsmf_id']]);
            }
        }

        foreach($current as $key => $file) {
            $file->delete();
        }

        if (count($created) > 0) {
            foreach($created as $item) {
                $file = new SuratMasukFile();
                $item['tsmf_tsm_id'] = $this->tsm_id;
                $file->save($item);
            }
        }
    }

    public function getDistributions() {

        $parents = $this->getDispositions(array(
            'tdp_parent = 0'
        ));

        $data = array();

        foreach($parents as $parent) {
            self::__distributionCascade($parent, $data);
            
        }

        return $data;
    }

    private static function __distributionCascade($node, &$result = array()) {
        foreach($node->getReceivingNodes() as $child) {
            $result[] = array(
                'sending' => $node,
                'receiving' => $child
            );

            self::__distributionCascade($child, $result);
        }
    }

    public function getDispositionsCascade() {
        $parents = $this->getDispositions(array(
            'tdp_type = :type: AND tdp_parent = 0',
            'bind' => array(
                'type' => 'DISPOSITION'
            )
        ));

        $data = array();

        foreach($parents as $parent) {
            self::__dispositionCascade($parent, 0, $data);
        }

        return $data;
    }

    private static function __dispositionCascade($node, $level, &$result = array()) {
        $children = $node->getChildren();
        $node->tdp_level = $level;
        
        $result[] = $node;

        if ($children->count() > 0) {
            $level++;
            foreach($children as $child) {
                self::__dispositionCascade($child, $level, $result);
            }
        }
    }
}