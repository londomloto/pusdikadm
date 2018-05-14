<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\Task;
use App\SuratMasuk\Models\Disposition;
use App\Activities\Models\Activity;

class DispositionsController extends \Micro\Controller {

    public function findAction() {
        $payload = $this->request->getParams();

        if (isset($payload['task'])) {
            $task = Task::get($payload['task'])->data;
            $data = array();

            if ($task) {
                $data = array();

                foreach($task->getDispositionsCascade() as $disp) {
                    $item = $disp->toArray();
                    $item['tdp_leaf'] = $disp->isLeaf();
                    $item['tdp_root'] = $disp->isRoot();
                    $data[] = $item;
                }
            }

            return array(
                'success' => TRUE,
                'data' => $data
            );    
        } else {
            return Disposition::get()->filterable()->sortable()->paginate();
        }
        
    }

    public function createAction() {

        $post = $this->request->getJson();
        
        $instructions = $post['instructions'];
        $subordinates = $post['subordinates'];

        unset($post['instructions'], $post['subordinates']);

        $post['tdp_parent'] = 0;
        $post['tdp_type'] = 'DISPOSITION';
        $post['tdp_flag'] = 'DRAFT';
        $post['tdp_instructions'] = json_encode($instructions);

        $sending = new Disposition();

        if ($sending->save($post)) {
            $sending = $sending->refresh();

            $subordinatesJson = array();

            foreach($subordinates as $sub) {
                if ($sub['su_checked'] == 1) {
                    $payload = array(
                        'tdp_tsm_id' => $sending->tdp_tsm_id,
                        'tdp_parent' => $sending->tdp_id,
                        'tdp_type' => $sending->tdp_type,
                        'tdp_flag' => 'DRAFT',
                        'tdp_copy' => $sub['su_copy'],
                        'tdp_orig' => $sub['su_orig'],
                        'tdp_responsible' => $sub['su_id'],
                        'tdp_position' => $sub['su_position']
                    );

                    $receiving = new Disposition();
                    $receiving->save($payload);
                    $receiving = $receiving->refresh();

                    $sub['su_link'] = $receiving->tdp_id;
                }

                $subordinatesJson[] = $sub;
            }

            $sending->tdp_subordinates = json_encode($subordinatesJson);
            $sending->save();

            return array(
                'success' => TRUE,
                'data' => $sending->toArray()
            );
        }

        return array(
            'success' => FALSE
        );

    }
    
    public function updateAction($id) {
        $post = $this->request->getJson();
        $subordinates = isset($post['subordinates']) ? $post['subordinates'] : FALSE;
        
        unset(
            $post['instructions'], 
            $post['subordinates'], 
            $post['tdp_stubs']
        );

        $query = Disposition::get($id);

        if (($sending = $query->data)) {
            if ($sending->save($post)) {
                // update subordinates

                if ($subordinates !== FALSE) {
                    $removed = array();
                    $updated = array();
                    $current = array();

                    foreach($sending->getReceivingNodes() as $node) {
                        $current[$node->tdp_id] = $node;
                    }

                    $subordinatesJson = array();

                    foreach($subordinates as $sub) {
                        $token = isset($sub['su_link']) ? $sub['su_link'] : -1;
                        if (isset($current[$token])) {
                            if ($sub['su_checked']) {
                                $updated[] = array(
                                    'node' => $current[$token],
                                    'data' => $sub
                                );
                                unset($current[$token]);
                            }
                        } else if ($sub['su_checked'] == 1) {
                            $payload = array(
                                'tdp_tsm_id' => $sending->tdp_tsm_id,
                                'tdp_parent' => $sending->tdp_id,
                                'tdp_type' => $sending->tdp_type,
                                'tdp_flag' => 'DRAFT',
                                'tdp_copy' => $sub['su_copy'],
                                'tdp_orig' => $sub['su_orig'],
                                'tdp_responsible' => $sub['su_id'],
                                'tdp_position' => $sub['su_position']
                            );

                            $receiving = new Disposition();
                            $receiving->save($payload);
                            $receiving = $receiving->refresh();

                            $sub['su_link'] = $receiving->tdp_id;
                        }

                        $subordinatesJson[] = $sub;
                    }

                    $sending->tdp_subordinates = json_encode($subordinatesJson);
                    $sending->save();
                    
                    $removed = array_values($current);

                    if (count($removed) > 0) {
                        foreach($removed as $node) {
                            $node->delete();
                        }
                    }

                    if (count($updated) > 0) {
                        foreach($updated as $spec) {
                            $node = $spec['node'];
                            $data = $spec['data'];

                            $node->save(array(
                                'tdp_copy' => $data['su_copy'],
                                'tdp_orig' => $data['su_orig'],
                                'tdp_responsible' => $data['su_id'],
                                'tdp_position' => $data['su_position']
                            ));
                        }
                    }

                    $sending->broadcastUpdate();
                }
            }
        }
        return $query;
    }

    public function deleteAction($id) {
        $data = Disposition::get($id)->data;
        $done = FALSE;

        if ($data) {
            if ($data->isRoot() || $data->isLeaf()) {
                $done = $data->delete();
            } else {
                $update = array(
                    'tdp_sending_date' => NULL,
                    'tdp_name' => NULL,
                    'tdp_template' => NULL
                );

                if ($data->save($update)) {
                    $done = TRUE;
                    foreach($data->getChildren() as $node) {
                        $node->delete();
                    }
                }
            }
        }

        return array(
            'success' => $done
        );
    }
}