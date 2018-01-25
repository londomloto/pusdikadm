<?php
namespace App\Kanbansetting\Models;

class Kanban_setting extends \Micro\Model 
{
    public function getSource() 
    {
        return  'kanban_setting';
    }

    public static function fetchData()
    {
    	return $this->db->query("select * from kanban_setting");
    }

    public static function lastId()
    {
    	return $this->db->query("select LAST_INSERT_ID(ks_id) as last_id from kanban_setting");
    }

}	