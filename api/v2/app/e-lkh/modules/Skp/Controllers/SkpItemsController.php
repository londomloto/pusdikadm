<?php
namespace App\Skp\Controllers;

use App\Skp\Models\SkpItem;
use App\Activities\Models\Activity;
use Micro\Helpers\Text;

class SkpItemsController extends \Micro\Controller {

    public function findAction() {
        $display = $this->request->getQuery('display');

        switch($display) {
            case 'database':

                $query = SkpItem::get()
                    ->columns(array('ski_id'))
                    ->join('App\Skp\Models\Task', 'skp_id = ski_skp_id')
                    ->join('App\Users\Models\User', 'su_id = skp_su_id')
                    ->filterable()
                    ->sortable();

                if ( ! $this->role->can('manage@skp')) {
                    $auth = $this->auth->user();
                    $query
                        ->columns(array('ski_id'))
                        ->join('App\Skp\Models\TaskUser', 'task_user.sku_skp_id = skp_id', 'task_user', 'LEFT')
                        ->andWhere('task_user.sku_su_id = :user:', array('user' => $auth['su_id']))
                        ->groupBy('ski_id');
                }

                $sort = $this->request->getQuery('sort');
                
                if (empty($sort)) {
                    $query->orderBy('ski_date DESC');
                }

                $result = $query->paginate();

                $result->data = $result->data->filter(function($row){
                    $item = SkpItem::findFirst($row->ski_id);
                    $task = $item->getTask();
                    $user = $task ? $task->user : NULL;

                    $data = $item->toArray();

                    $data['ski_desc'] = Text::limitChars($data['ski_desc'], 40);
                    $data['ski_period'] = $task ? $task->skp_period : NULL;
                    $data['ski_su_fullname'] = $user ? $user->getName() : NULL;
                    $data['ski_su_no'] = $user ? $user->su_no : NULL;
                    $data['ski_link'] = $task ? $task->getLink() : NULL;

                    $data['ski_volume_formatted'] = self::__autoformat($data['ski_volume']);
                    $data['ski_volume_real_formatted'] = self::__autoformat($data['ski_volume_real']);

                    $data['ski_duration_formatted'] = self::__autoformat($data['ski_duration']);
                    $data['ski_duration_real_formatted'] = self::__autoformat($data['ski_duration_real']);

                    $data['ski_cost_formatted'] = self::__autoformat($data['ski_cost']);
                    $data['ski_cost_real_formatted'] = self::__autoformat($data['ski_cost_real']);
                    
                    $data['ski_ak_formatted'] = self::__autoformat($data['ski_ak'], 2);
                    $data['ski_ak_real_formatted'] = self::__autoformat($data['ski_ak_real'], 2);

                    $data['ski_total_formatted'] = self::__autoformat($data['ski_total']);
                    $data['ski_performance_formatted'] = self::__autoformat($data['ski_performance'], 2);

                    return $data;
                });
                return $result;

            default:
                return SkpItem::get()
                    ->filterable()
                    ->sortable()
                    ->paginate();
        }

    }

    public function findByIdAction($id) {
        return SkpItem::get($id);
    }

    public function createAction() {
        $post = $this->request->getJson();
        $post['ski_date'] = date('Y-m-d');

        $item = new SkpItem();

        if ($item->save($post)) {

            $task = $item->getTask();

            if ($task) {
                $log = Activity::log('create_skp_item', array(
                    'ta_task_ns' => $task->getScope(),
                    'ta_task_id' => $task->skp_id,
                    'ta_sp_id' => $task->skp_task_project,
                    'ta_data' => json_encode(array(
                        'ski_id' => $item->ski_id,
                        'ski_extra' => $item->ski_extra
                    ))
                ));

                if ($log) {
                    $log->subscribe();
                    $log->broadcast();
                }

                if ($task->skp_warn == 0) {
                    $task->skp_warn = 1;
                    $task->save();

                    // live event broadcast
                    $this->socket->broadcast('live', array(
                        'type' => 'skp_settled',
                        'user' => $task->skp_su_id,
                        'task' => $task->skp_id,
                        'year' => $task->getYear()
                    ));    
                }
                
            }

            return SkpItem::get($item->ski_id);
        }

        return SkpItem::none();
    }

    public function updateAction($id) {
        $post = $this->request->getJson();
        $query = SkpItem::get($id);

        if ($query->data) {
            $item = $query->data;
            $task = $item->getTask();

            if ($task) {
                // notify socket without log
                $this->socket->broadcast('notify', array(
                    'type' => 'update_skp_item',
                    'project' => $task->skp_task_project,
                    'task' => $task->skp_id,
                    'scope' => $task->getScope(),
                    'data' => json_encode(array(
                        'ski_id' => $item->ski_id,
                        'ski_extra' => $item->ski_extra
                    ))
                ));
            }

            $query->data->save($post);
        }

        return $query;
    }

    public function deleteAction($id) {
        $item = SkpItem::get($id)->data;
        if ($item) {
            $task = $item->getTask();

            if ($item->delete() && $task) {
                // notify socket without log
                $this->socket->broadcast('notify', array(
                    'type' => 'remove_skp_item',
                    'task' => $task->skp_id,
                    'scope' => $task->getScope(),
                    'project' => $task->skp_task_project,
                    'data' => json_encode(array(
                        'ski_id' => $item->ski_id,
                        'ski_extra' => $item->ski_extra
                    ))
                ));

                $count = $task->getItems()->count();

                if ($count == 0) {
                    $task->skp_warn = 0;
                    $task->save();

                    // live event broadcast
                    $this->socket->broadcast('live', array(
                        'type' => 'skp_outstanding',
                        'user' => $task->skp_su_id,
                        'task' => $task->skp_id,
                        'year' => $task->getYear()
                    ));    
                }
            }
        }
        return array(
            'success' => TRUE
        );
    }

    public function saveBatchAction() {
        $post = $this->request->getJson();
        $data = array();

        foreach($post['items'] as $elem) {
            $item = new SkpItem();
            if ($item->save($elem)) {
                $data[] = $item->toArray();
            }
        }

        return array(
            'success' => TRUE,
            'data' => $data
        );
    }

    private static function __autoformat($value, $decimal = 0) {
        return !empty($value) ? number_format($value, $decimal, ',', '.') : NULL;
    }
}