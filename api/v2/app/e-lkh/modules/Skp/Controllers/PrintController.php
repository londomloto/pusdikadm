<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Skp;
use App\Skp\Models\Task;
use App\Skp\Models\SkpItem;
use App\Skp\Models\SkpBehavior;
use Micro\Office\Spreadsheet;
use Micro\Helpers\Date;
use Micro\Helpers\Text;

class PrintController extends \Micro\Controller {

    public function documentAction($format, $id) {
        $method = '__document'.ucfirst(strtolower($format));
        $this->$method($id);
    }

    private function __documentXls($id) {
        $skp = Skp::get($id)->data;

        if ( ! $skp) {
            throw new \Phalcon\Exception("Not Found", 404);
        }   

        $arr = $skp->toArray();
        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/document.xlsx');

        $formatted = array(
            'skp_report_dt' => Date::format($arr['skp_report_dt'], 'd F Y'),
            'skp_objection_dt' => Date::format($arr['skp_objection_dt'], 'd F Y'),
            'skp_response_dt' => Date::format($arr['skp_response_dt'], 'd F Y'),
            'skp_resolution_dt' => Date::format($arr['skp_resolution_dt'], 'd F Y'),
            'skp_receive_dt' => Date::format($arr['skp_receive_dt'], 'd F Y'),
            'skp_disposition_dt' => Date::format($arr['skp_disposition_dt'], 'd F Y')
        );


        // DATA SKP
        $sheet = $xls->getSheet(0);
        $sheet
            ->setCellValue('E4', $arr['skp_su_fullname'])
            ->setCellValue('E5', $arr['skp_su_no'])
            ->setCellValue('E6', $arr['skp_su_sg_name'])
            ->setCellValue('E7', $arr['skp_su_sj_name'])
            ->setCellValue('E8', $arr['skp_su_sdp_name']);

        if ($skp->evaluator) {
            $sheet
                ->setCellValue('E10', $arr['evaluator_su_fullname'])
                ->setCellValue('E11', $arr['evaluator_su_no'])
                ->setCellValue('E12', $arr['evaluator_su_sg_name'])
                ->setCellValue('E13', $arr['evaluator_su_sj_name'])
                ->setCellValue('E14', $arr['evaluator_su_sdp_name']);    
        }

        if ($skp->examiner) {
            $sheet
                ->setCellValue('E16', $arr['examiner_su_fullname'])
                ->setCellValue('E17', $arr['examiner_su_no'])
                ->setCellValue('E18', $arr['examiner_su_sg_name'])
                ->setCellValue('E19', $arr['examiner_su_sj_name'])
                ->setCellValue('E20', $arr['examiner_su_sdp_name']);    
        }

        // COVER
        $sheet = $xls->getSheet(1);
        $sheet
            ->setCellValue('F18', $arr['skp_su_fullname'])
            ->setCellValue('F19', $arr['skp_su_no'])
            ->setCellValue('F20', $arr['skp_su_sg_name'])
            ->setCellValue('F21', $arr['skp_su_sj_name'])
            ->setCellValue('F22', $arr['skp_su_sdp_name']);    

        $sheet
            ->setCellValue('A8', $arr['skp_cover_header_1'])
            ->setCellValue('A9', $arr['skp_cover_header_2'])
            ->setCellValue('A39', $arr['skp_cover_footer_1'])
            ->setCellValue('A40', $arr['skp_cover_footer_2']);

        // FORM SKP
        $sheet = $xls->getSheet(2);
        $sheet->setCellValue('A3', $arr['skp_cover_footer_2']);

        if ($skp->evaluator) {
            $sheet
                ->setCellValue('C5', $arr['evaluator_su_fullname'])
                ->setCellValue('C6', $arr['evaluator_su_no'])
                ->setCellValue('C7', $arr['evaluator_su_sg_name'])
                ->setCellValue('C8', $arr['evaluator_su_sj_name'])
                ->setCellValue('C9', $arr['evaluator_su_sdp_name']);    
        }

        $sheet
            ->setCellValue('H5', $arr['skp_su_fullname'])
            ->setCellValue('H6', $arr['skp_su_no'])
            ->setCellValue('H7', $arr['skp_su_sg_name'])
            ->setCellValue('H8', $arr['skp_su_sj_name'])
            ->setCellValue('H9', $arr['skp_su_sdp_name']);

        $row = 12;
        $num = 1;

        $items = $skp->getItems('ski_extra = 0')->filter(function($item){ return $item; });
        $count = count($items);
        $insert = $count > 2 ? ($count - 2) : 0;

        if ($count > 0) {

            if ($insert > 0) {
                $sheet->insertNewRowBefore(14, $insert);
            }

            foreach($items as $item) {
                $sheet->mergeCells('B'.$row.':C'.$row);

                $sheet
                    ->setCellValue('A'.$row, $num)
                    ->setCellValue('B'.$row, $item->ski_desc)
                    ->setCellValue('E'.$row, $item->ski_ak)
                    ->setCellValue('F'.$row, $item->ski_volume)
                    ->setCellValue('G'.$row, $item->ski_unit)
                    ->setCellValue('H'.$row, $item->ski_quality)
                    ->setCellValue('I'.$row, $item->ski_duration)
                    ->setCellValue('J'.$row, $item->ski_duration_unit)
                    ->setCellValue('K'.$row, $item->ski_cost);
                $row++;
                $num++;
            }
        } else {
            $row = 14;
        }

        $sheet
            ->setCellValue('G'.($row + 1), $arr['skp_report_addr'].', '.$formatted['skp_report_dt']);

        if ($skp->evaluator) {
            $sheet
                ->setCellValue('A'.($row + 6), $arr['evaluator_su_fullname'])
                ->setCellValue('A'.($row + 7), $arr['evaluator_su_no']);
        }

        $sheet
            ->setCellValue('G'.($row + 6), $arr['skp_su_fullname'])
            ->setCellValue('G'.($row + 7), $arr['skp_su_no']);
        
        // PENGUKURAN
        $sheet = $xls->getSheet(3);
        $sheet->setCellValue('A5', $arr['skp_period']);

        $row = 9;
        $num = 1;

        if ($count > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(11, $insert);
            }

            foreach($items as $item) {
                $sheet
                    ->setCellValue('A'.$row, $num)
                    ->setCellValue('B'.$row, $item->ski_desc)
                    ->setCellValue('C'.$row, $item->ski_ak)
                    ->setCellValue('D'.$row, $item->ski_volume)
                    ->setCellValue('E'.$row, $item->ski_unit)
                    ->setCellValue('F'.$row, $item->ski_quality)
                    ->setCellValue('G'.$row, $item->ski_duration)
                    ->setCellValue('H'.$row, $item->ski_duration_unit)
                    ->setCellValue('I'.$row, $item->ski_cost)
                    ->setCellValue('J'.$row, $item->ski_ak_real)
                    ->setCellValue('K'.$row, $item->ski_volume_real)
                    ->setCellValue('L'.$row, $item->ski_unit)
                    ->setCellValue('M'.$row, $item->ski_quality_real)
                    ->setCellValue('N'.$row, $item->ski_duration_real)
                    ->setCellValue('O'.$row, $item->ski_duration_unit)
                    ->setCellValue('P'.$row, $item->ski_cost_real)
                    ->setCellValue('Q'.$row, $item->ski_total)
                    ->setCellValue('R'.$row, $item->ski_performance);

                $row++;
                $num++;
            }
        } else {
            $row = 11;
        }

        $row += 1;
        $num  = 1;

        // extra
        $extra = $skp->getItems('ski_extra = 1')->filter(function($item){ return $item; });
        $count = count($extra);
        $insert = $count > 2 ? ($count - 2) : 0;

        if ($count > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($row + 1), $insert);
            }

            foreach($extra as $item) {
                $sheet->mergeCells('D'.$row.':I'.$row);
                $sheet->mergeCells('K'.$row.':P'.$row);

                $sheet
                    ->setCellValue('A'.$row, $num)
                    ->setCellValue('B'.$row, $item->ski_desc)
                    ->setCellValue('Q'.$row, $item->ski_total)
                    ->setCellValue('R'.$row, $item->ski_performance);

                $row++;
                $num++;
            }

        } else {
            $row = 14;
        }

        $sheet->setCellValue('R'.($row + 1), $arr['skp_performance']);
        $sheet->setCellValue('R'.($row + 2), $arr['skp_performance_criteria_text']);
        $sheet->setCellValue('M'.($row + 4), $arr['skp_report_addr'].', '.$formatted['skp_report_dt']);

        if ($skp->evaluator) {
            $sheet->setCellValue('M'.($row + 8), $arr['evaluator_su_fullname']);
            $sheet->setCellValue('M'.($row + 9), $arr['evaluator_su_no']);    
        }

        // PERILAKU
        $end = Date::create($arr['skp_end_date']);

        $sheet = $xls->getSheet(4);
        $sheet->setCellValue('D3', $arr['skp_su_fullname']);
        $sheet->setCellValue('D4', $arr['skp_su_no']);
        $sheet->setCellValue('B9', $arr['skp_period']);
        $sheet->setCellValue('E9', 'Penilaian SKP sampai akhir '.$end->format('F Y').' =');
        $sheet->setCellValue('E10', $arr['skp_performance']);

        $behaviors = SkpBehavior::fetch($skp->skp_id);
        $count = count($behaviors);
        $insert = $count > 2 ? ($count - 2) : 0;

        $row = 12;

        if ($count > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(13, $insert);
            }

            foreach($behaviors as $item) {
                $sheet
                    ->setCellValue('E'.$row, $item['tsb_tbh_name'])
                    ->setCellValue('G'.$row, '=')
                    ->setCellValue('H'.$row, $item['tsb_value'])
                    ->setCellValue('I'.$row, $item['tsb_criteria_text']);

                $row++;
            }    
        } else {
            $row = 14;
        }

        $sheet->setCellValue('H'.($row), $arr['skp_behavior_total']);
        $sheet->setCellValue('H'.($row + 1), $arr['skp_behavior_average']);
        $sheet->setCellValue('I'.($row + 1), $arr['skp_behavior_criteria_text']);

        $sheet->mergeCells('J12:J13');

        if ($skp->evaluator) {
            $sheet->setCellValue('J12', $arr['evaluator_su_sj_name']);
            $sheet->setCellValue('J16', $arr['evaluator_su_fullname']);
            $sheet->setCellValue('J17', $arr['evaluator_su_no']);
        }

        // PENILAIAN
        $sheet = $xls->getSheet(5);
        $sheet->setCellValue('H11', $arr['skp_period']);

        $sheet
            ->setCellValue('G14', $arr['skp_su_fullname'])
            ->setCellValue('G15', $arr['skp_su_no'])
            ->setCellValue('G16', $arr['skp_su_sg_name'])
            ->setCellValue('G17', $arr['skp_su_sj_name'])
            ->setCellValue('G18', $arr['skp_su_sdp_name']);

        if ($skp->evaluator) {
            $sheet
                ->setCellValue('G20', $arr['evaluator_su_fullname'])
                ->setCellValue('G21', $arr['evaluator_su_no'])
                ->setCellValue('G22', $arr['evaluator_su_sg_name'])
                ->setCellValue('G23', $arr['evaluator_su_sj_name'])
                ->setCellValue('G24', $arr['evaluator_su_sdp_name']);    
        }

        if ($skp->examiner) {
            $sheet
                ->setCellValue('G26', $arr['examiner_su_fullname'])
                ->setCellValue('G27', $arr['examiner_su_no'])
                ->setCellValue('G28', $arr['examiner_su_sg_name'])
                ->setCellValue('G29', $arr['examiner_su_sj_name'])
                ->setCellValue('G30', $arr['examiner_su_sdp_name']);    
        }

        $sheet
            ->setCellValue('H32', $arr['skp_performance'])
            ->setCellValue('I32', ' X '.$arr['skp_performance_portion'].'%')
            ->setCellValue('J32', $arr['skp_performance_value']);

        $row = 34;
        $num = 1;

        if ($count > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(36, $insert);
            }

            foreach($behaviors as $item) {
                $sheet
                    ->setCellValue('E'.$row, $num)
                    ->setCellValue('F'.$row, $item['tsb_tbh_name'])
                    ->setCellValue('H'.$row, $item['tsb_value'])
                    ->setCellValue('I'.$row, $item['tsb_criteria_text']);

                $row++;
                $num++;
            }    

            // merge 
            $merge = (34 + $count + 3 - 1);
            $sheet->mergeCells('B34:B'.$merge);
            $sheet->mergeCells('C34:C'.$merge);
        } else {
            $row = 36;
        }

        $sheet->setCellValue('H'.$row, $arr['skp_behavior_total']);
        $sheet->setCellValue('H'.($row + 1), $arr['skp_behavior_average']);
        $sheet->setCellValue('I'.($row + 1), $arr['skp_behavior_criteria_text']);
        $sheet->setCellValue('H'.($row + 2), $arr['skp_behavior_average']);
        $sheet->setCellValue('I'.($row + 2), ' X '.$arr['skp_behavior_portion'].'%');
        $sheet->setCellValue('J'.($row + 2), $arr['skp_behavior_value']);
        $sheet->setCellValue('J'.($row + 3), $arr['skp_value']);
        $sheet->setCellValue('J'.($row + 4), $arr['skp_criteria_text']);

        $row += 4;

        $sheet->setCellValue('B'.($row + 4), $arr['skp_objection']);
        $sheet->setCellValue('I'.($row + 18), 'Tanggal '.$formatted['skp_objection_dt']);

        $row += 18;

        $sheet->setCellValue('B'.($row + 4), $arr['skp_response']);
        $sheet->setCellValue('I'.($row + 23), 'Tanggal '.$formatted['skp_response_dt']);

        $row += 23;

        $sheet->setCellValue('B'.($row + 5), $arr['skp_resolution']);
        $sheet->setCellValue('I'.($row + 23), 'Tanggal '.$formatted['skp_resolution_dt']);

        $row += 23;

        $sheet->setCellValue('B'.($row + 4), $arr['skp_recommendation']);

        $row += 16;

        $sheet->setCellValue('H'.($row + 3), '9. DIBUAT TANGGAL, '.strtoupper($formatted['skp_report_dt']));

        if ($skp->evaluator) {
            $sheet->setCellValue('H'.($row + 9), $arr['evaluator_su_fullname']);
            $sheet->setCellValue('H'.($row + 10), $arr['evaluator_su_no']);
        }

        $row += 10;
        
        $sheet->setCellValue('B'.($row + 2), 'DITERIMA TANGGAL, '.strtoupper($formatted['skp_receive_dt']));
        $sheet->setCellValue('B'.($row + 9), $arr['skp_su_fullname']);
        $sheet->setCellValue('B'.($row + 10), $arr['skp_su_no']);

        $row += 10;

        $sheet->setCellValue('H'.($row + 2), '11. DITERIMA TANGGAL, '.strtoupper($formatted['skp_disposition_dt']));

        if ($skp->examiner) {
            $sheet->setCellValue('H'.($row + 8), $arr['examiner_su_fullname']);
            $sheet->setCellValue('H'.($row + 9), $arr['examiner_su_no']);
        }

        $xls->setActiveSheetIndex(1);

        $file = strtoupper($arr['skp_su_fullname'].'_SKP_'.$arr['skp_period']);
        $file = preg_replace('/[^a-z0-9]+/i', '_', $file).'.xlsx';

        $xls->stream($file);
    }

    public function databaseAction($format) {
        $method = '__database'.ucfirst(strtolower($format));
        if (method_exists($this, $method)) {
            $this->{$method}();
        }
    }

    private function __databaseXls() {
        $payload = $this->request->getJson();

        $query = Task::get()
            ->alias('task')
            ->columns(array(
                'task.skp_id'
            ))
            ->join('App\Users\Models\User', 'user.su_id = task.skp_su_id', 'user')
            ->filterable($payload)
            ->sortable($payload)
            ->groupBy('task.skp_id');

        if (isset($payload['params'])) {
            $params = json_decode($payload['params'], TRUE);
            if (isset($params['status']) && ! empty($params['status'])) {
                $query->join('App\Skp\Models\TaskStatus', 'task_status.sks_skp_id = task.skp_id AND task_status.sks_deleted = 0', 'task_status', 'LEFT');
                $query->join('App\Kanban\Models\KanbanStatus', 'kst.kst_status = task_status.sks_status', 'kst', 'LEFT');
                $query->join('App\Kanban\Models\KanbanPanel', 'kp.kp_id = kst.kst_kp_id', 'kp', 'LEFT');
                $query->inWhere('kp.kp_id', $params['status'][1]);        
            }
        }

        if ( ! $this->role->can('manage@skp')) {
            $auth = $this->auth->user();
            $query
                ->join('App\Skp\Models\TaskUser', 'task_user.sku_skp_id = task.skp_id', 'task_user', 'LEFT')
                ->andWhere('task_user.sku_su_id = :user:', array('user' => $auth['su_id']));
        }

        if (isset($payload['start'], $payload['limit'])) {
            $query->limit($payload['limit'], $payload['start']);
            $result = $query->paginate(FALSE);
        } else {
            $result = $query->paginate();    
        }

        $items = $result->data->filter(function($row){
            $task = Task::findFirst($row->skp_id);
            $data = $task->toArray();
            $data['skp_link'] = $task->getLink();
            $data['statuses'] = $task->getCurrentStatuses()->filter(function($status){
                return $status->toArray();
            });
            return $data;
        });

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/database.xlsx');

        $sheet = $xls->getSheet(0);
        $index = 1;
        $line = 4;

        foreach($items as $item) {
            $sheet
                ->setCellValue('A'.$line, $index)
                ->setCellValue('B'.$line, $item['skp_period'])
                ->setCellValue('C'.$line, $item['skp_su_fullname'])
                ->setCellValue('C'.($line + 1), $item['skp_su_no']);


            if ($item['skp_has_evaluator']) {
                $sheet
                    ->setCellValue('D'.$line, $item['evaluator_su_fullname'])
                    ->setCellValue('D'.($line + 1), $item['evaluator_su_no']);
            }

            if ($item['skp_has_examiner']) {
                $sheet
                    ->setCellValue('E'.$line, $item['examiner_su_fullname'])
                    ->setCellValue('E'.($line + 1), $item['examiner_su_no']);
            }

            $sheet
                ->setCellValue('F'.$line, $item['skp_performance'])
                ->setCellValue('G'.$line, $item['skp_behavior_average'])
                ->setCellValue('H'.$line, $item['skp_value']);

            $statuses = array_map(function($s){
                return $s['status_text'];
            }, $item['statuses']);

            $statuses = implode(', ', $statuses);
            $sheet->setCellValue('I'.$line, $statuses);

            $sheet->getStyle('A'.($line + 1).':I'.($line + 1))->applyFromArray(array(
                'borders' => array(
                    'bottom' => array(
                        'borderStyle' => 'thin'
                    )
                )
            ));

            $index++;
            $line += 2;
        }

        $column = 'A';
        $bottom = $line - 1;

        for($i = 0; $i < 8; $i++) {
            $coords = $column.'4:'.$column.$bottom;

            $sheet->getStyle($coords)->applyFromArray(array(
                'borders' => array(
                    'right' => array(
                        'borderStyle' => 'thin'
                    )
                )
            ));

            $column++;
        }

        $xls->setActiveSheetIndex(0);
        $xls->stream('DOKUMEN_SKP.xlsx');
    }

    public function databaseItemsAction($format) {
        $method = '__databaseItems'.ucfirst(strtolower($format));
        if (method_exists($this, $method)) {
            $this->{$method}();
        }
    }

    private function __databaseItemsXls() {
        $payload = $this->request->getJson();

        $query = SkpItem::get()
            ->columns(array('ski_id'))
            ->join('App\Skp\Models\Task', 'skp_id = ski_skp_id')
            ->join('App\Users\Models\User', 'su_id = skp_su_id')
            ->filterable($payload)
            ->sortable($payload);

        if ( ! $this->role->can('manage@skp')) {
            $auth = $this->auth->user();
            $query
                ->columns(array('ski_id'))
                ->join('App\Skp\Models\TaskUser', 'task_user.sku_skp_id = skp_id', 'task_user', 'LEFT')
                ->andWhere('task_user.sku_su_id = :user:', array('user' => $auth['su_id']))
                ->groupBy('ski_id');
        }

        if ( ! isset($payload['sort'])) {
            $query->orderBy('ski_date DESC');
        }

        if (isset($payload['start'], $payload['limit'])) {
            $query->limit($payload['limit'], $payload['start']);
        }
        $result = $query->paginate(FALSE);

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/database-items.xlsx');
        $sheet = $xls->getSheet(0);

        $line = 5;
        $index = 1;

        foreach($result->data as $row) {
            $item = SkpItem::findFirst($row->ski_id);
            $task = $item->getTask();

            $data = $item->toArray();

            $sheet->setCellValue('A'.$line, $index);

            if ($task) {
                if (($user = $task->user)) {
                    $sheet->setCellValue('B'.$line, $user->getName()."\n".$user->su_no);
                }
                $sheet->setCellValue('C'.$line, $task->skp_period);
            }

            $sheet
                ->setCellValue('D'.$line, $data['ski_desc'])
                ->setCellValue('E'.$line, $data['ski_ak_factor'])
                ->setCellValue('F'.$line, $data['ski_ak'])
                ->setCellValue('G'.$line, $data['ski_volume'])
                ->setCellValue('H'.$line, $data['ski_unit'])
                ->setCellValue('I'.$line, $data['ski_quality'])
                ->setCellValue('J'.$line, $data['ski_duration'])
                ->setCellValue('K'.$line, $data['ski_duration_unit'])
                ->setCellValue('L'.$line, $data['ski_cost'])
                ->setCellValue('M'.$line, $data['ski_ak_real'])
                ->setCellValue('N'.$line, $data['ski_volume_real'])
                ->setCellValue('O'.$line, $data['ski_unit'])
                ->setCellValue('P'.$line, $data['ski_quality_real'])
                ->setCellValue('Q'.$line, $data['ski_duration_real'])
                ->setCellValue('R'.$line, $data['ski_duration_unit'])
                ->setCellValue('S'.$line, $data['ski_cost_real'])
                ->setCellValue('T'.$line, $data['ski_total'])
                ->setCellValue('U'.$line, $data['ski_performance']);

            $sheet->getStyle('A'.$line.':U'.$line)->applyFromArray(array(
                'borders' => array(
                    'bottom' => array(
                        'borderStyle' => 'thin'
                    )
                )
            ));

            $index++;
            $line++;
        }

        $column = 'A';
        $bottom = $line - 1;

        for($i = 0; $i < 20; $i++) {
            $coords = $column.'5:'.$column.$bottom;

            $sheet->getStyle($coords)->applyFromArray(array(
                'borders' => array(
                    'right' => array(
                        'borderStyle' => 'thin'
                    )
                )
            ));

            $column++;
        }

        $xls->setActiveSheetIndex(0);
        $xls->stream('KEGIATAN_SKP.xlsx');
    }

    public function dashboardAction($format) {
        $method = '__dashboard'.ucfirst(strtolower($format));
        if (method_exists($this, $method)) {
            $this->{$method}();
        }
    }

    private function __dashboardXls() {
        $payload = $this->request->getJson();
        $xls = new Spreadsheet();

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/dashboard.xlsx');
        $sheet = $xls->getSheet(0);

        $line = 5;

        $charts = isset($payload['charts']) ? $payload['charts'] : array();

        foreach($charts as $chart) {
            if ( ! empty($chart)) {
                $image = Spreadsheet::createImage(PUBPATH.'resources/charts/'.$chart);
                @unlink(PUBPATH.'resources/charts/'.$chart);

                if ($image) {
                    $image->setCoordinates('A'.$line);
                    $image->setWorksheet($sheet);
                    //$image->getShadow()->setVisible(TRUE);

                    $line += 24;
                }
            }
        }

        $xls->setActiveSheetIndex(0);
        $xls->stream('DASHBOARD_LKH.xlsx');
    }

}
