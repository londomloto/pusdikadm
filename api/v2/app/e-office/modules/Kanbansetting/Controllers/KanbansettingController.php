<?php
namespace App\Kanbansetting\Controllers;

use App\Kanbansetting\Models\kanban_setting;
use App\Kanbansetting\Models\kanban_category;
use App\Kanbansetting\Models\kanban_status;

class KanbansettingController extends \Micro\Controller 
{

    public function findAction() 
    {
        $result = Kanban_setting::find();
        $result = $result->toArray();

        return array('success' => true, 'data' => $result);
    }

    public function findByIdAction($id)
    {
        $ks_name = kanban_setting::findByKsId($id)->toArray();
        $kanban_name = $ks_name[0]['ks_name'];

        $kc = kanban_category::find(['conditions' => 'kc_ks_id = '.$id])->toArray();

        if(!empty($kc))
        {
            foreach ($kc as $key => $value) 
            {
                $kst = kanban_status::find(['conditions' => 'kst_kc_id = '.$value['kc_id']])->toArray();
                $kc[$key]['status'] = $kst; 
            }

            $data = array(
                'kanban_name' => $kanban_name,
                'kanban_category' => $kc
            );

            return array('success' => true, 'msg' => 'data found!', 'data' => $data);
        }

        return array('success' => false, 'msg' => 'data not found!');
    }   

    public function createAction() 
    {
    	$data = array();
    	$post = $this->request->getJsonRawBody(TRUE);
    	$ks = new Kanban_setting;
    	
    	$data = array(
    		'ks_name' => $post['kanban_name']
    	);

    	if($ks->save($data))
    	{
    		$ks_last_id = $this->db->lastInsertId(); 
    		$c = 0;

    		foreach($post['kanban_category'] as $key => $value)
    		{
                $data2 = array(
                    'kc_title' => $value['kc_title'],
                    'kc_ks_id' => $ks_last_id
                );

                $kc = new kanban_category;
                if($kc->save($data2))
                {
                    if(!empty($value['status']))
                    {
                        $kc_last_id = $this->db->lastInsertId();
    
        				foreach ($value['status'] as $key2 => $value2) 
        				{
                            $kst = new kanban_status;
                            $data3 = array(
                                'kst_status' => $value2['kst_status'],
                                'kst_kc_id'  => $kc_last_id,
                                'kst_ks_id'  => $ks_last_id
                            );

                            $kst->save($data3);
        				}
        			}
                }
    		}

   			return Array('success' => TRUE);
    	}
    }

    public function updateAction($id)
    {
        $query = Kanban_setting::queryFirst($id);
        
        if($query->data)
        {
            $post = $this->request->getJsonRawBody(TRUE); 
            $update_ks_name = array('ks_name' => $post['kanban_name']);
            
            if($query->data->save($update_ks_name))
            {
                $kc = kanban_category::find([
                    "conditions" => "kc_ks_id = ".$id 
                ]);

                $kst = kanban_status::find([
                    "conditions" => "kst_ks_id = ".$id
                ]);

                if(!empty($kc->toArray()))
                {
                    if($kc->delete())
                    {
                        if(!empty($kst->toArray))
                        {
                            $kst->delete();
                        }
                    }
                }

                foreach($post['kanban_category'] as $key => $value)
                {
                    $data2 = array(
                        'kc_title' => $value['kc_title'],
                        'kc_ks_id' => $id
                    );

                    $kc = new kanban_category;
                    
                    if($kc->save($data2))
                    {
                        if(!empty($value['status']))
                        {
                            $kc_last_id = $this->db->lastInsertId();
        
                            foreach ($value['status'] as $key2 => $value2) 
                            {
                                $kst = new kanban_status;
                                $data3 = array(
                                    'kst_status' => $value2['kst_status'],
                                    'kst_kc_id'  => $kc_last_id,
                                    'kst_ks_id'  => $id
                                );

                                $kst->save($data3);
                            }
                        }
                    }
                }
                
            }
            
            return $query;
        }
    }

    public function deleteAction($id)
    {
        $query = Kanban_setting::queryFirst($id);

        if($query->data)
        {
            if($query->data->delete()) 
            {
                $kc = kanban_category::find([
                    "conditions" => "kc_ks_id = ".$id
                ]);

                if(!empty($kc->toArray()))
                {
                    if($kc->delete())
                    {
                        $kst = kanban_status::find([
                            "conditions" => "kst_ks_id = ".$id 
                        ]);

                        if(!empty($kst->toArray()))
                        {
                            if($kst->delete())
                                return array('success' => TRUE);
                        }

                    }
                }
            }
        } 
        else
        {
            return array(
                'success' => FALSE
            );
        }
    }
}