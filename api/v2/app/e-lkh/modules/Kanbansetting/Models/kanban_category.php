<?php
namespace App\Kanbansetting\Models;

class Kanban_category extends \Micro\Model 
{
    public function getSource() 
    {
        return 'kanban_category';
    }

    public static function fetchData()
    {
    	return $this->db->query("select * from kanban_category");
    }

}