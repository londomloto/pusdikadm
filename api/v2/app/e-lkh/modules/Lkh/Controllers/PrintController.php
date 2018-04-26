<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\Lkh;
use App\Lkh\Models\LkhItem;
use App\Lkh\Models\Task;
use App\Users\Models\User;
use Micro\Office\Spreadsheet;
use Micro\Helpers\Text;

class PrintController extends \Micro\Controller {

    public function documentAction($id, $format) {
        $method = '__document'.ucfirst(strtolower($format));
        if (method_exists($this, $method)) {
            $this->{$method}($id);
        }
    }

    private function __documentXls($id) {
        $lkh = Lkh::get($id)->data;

        if ( ! $lkh) {
            throw new \Phalcon\Exception("Not Found", 404);
        } 

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/document.xlsx');
        $data = $lkh->toArray();

        $sheet = $xls->getSheet(0);
        $sheet
            ->setCellValue('A2', 'Bulan '.$data['lkh_period'])
            ->setCellValue('C5', ': '.$data['lkh_su_fullname'])
            ->setCellValue('C6', ': '.$data['lkh_su_sj_name'])
            ->setCellValue('C7', ': '.$data['lkh_su_sdp_name']);

        $items = $lkh->fetchItems();
        $total = count($items);
        $insert = $total > 2 ? ($total - 2) : 0;

        $line = 10;

        if ($total > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(12, $insert);
            }

            $group = array();

            foreach($items as $item) {
                $sheet->mergeCells('C'.$line.':D'.$line);

                // set row height
                $z = Text::rows($item['lki_desc']);
                $h = $z * 14.25 + 2.25;
                $sheet->getRowDimension($line)->setRowHeight($h);

                $sheet
                    ->setCellValue('A'.$line, $item['lki_index'])
                    ->setCellValue('B'.$line, $item['lki_group'])
                    ->setCellValue('C'.$line, $item['lki_desc'])
                    ->setCellValue('E'.$line, $item['lki_volume'])
                    ->setCellValue('F'.$line, $item['lki_unit']);

                $token = $item['lki_lkd_date'];

                if ( ! isset($group[$token])) {
                    $group[$token] = array(
                        'start' => $line,
                        'count' => 0
                    );
                }

                $group[$token]['count']++;

                $line++;
            }

            // merging rows
            $group = array_values($group);

            foreach($group as $item) {
                if ($item['count'] > 1) {
                    $start = $item['start'];
                    $end = ($item['start'] + ($item['count'] - 1));

                    $sheet->mergeCells('A'.$start.':A'.$end);
                    $sheet->mergeCells('B'.$start.':B'.$end);

                }
            }
        } else {
            $line = 12;
        }

        $sheet
            ->setCellValue('D'.($line + 2), $data['lkh_su_sj_name'])
            ->setCellValue('D'.($line + 6), $data['lkh_su_fullname'])
            ->setCellValue('D'.($line + 7), $data['lkh_su_no']);

        if ($lkh->evaluator) {
            $sheet
                ->setCellValue('A'.($line + 2), $data['evaluator_su_sj_name'])
                ->setCellValue('A'.($line + 6), $data['evaluator_su_fullname'])
                ->setCellValue('A'.($line + 7), $data['evaluator_su_no']);    
        }

        $xls->setActiveSheetIndex(0);

        $file = strtoupper($data['lkh_su_fullname'].'_LKH_'.$data['lkh_period']);
        $file = preg_replace('/[^a-z0-9]+/i', '_', $file).'.xlsx';

        $xls->stream($file);
    }

    private function __documentPdf($id) {

    }

    public function reportAction($format) {
        $method = '__report'.ucfirst(strtolower($format));
        if (method_exists($this, $method)) {
            $this->{$method}();
        }
    }

    private function __reportXls() {
        $post = $this->request->getJson();
        $user = User::findFirst($post['user']);

        if ( ! $user) {
            throw new \Phalcon\Exception("Pembuat dokumen tidak valid");
        }

        $sheets = $post['sheets'];
        $sheetNames = array();

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/document.xlsx');
        $loop = 0;

        foreach($sheets as $id) {
            $lkh = Lkh::findFirst($id);

            if ($lkh) {
                $sheet = clone $xls->getSheetByName('MASTER');
                $title = $lkh->lkh_period;

                if (isset($sheetNames[$title])) {
                    $title .= ' ('.$loop.')';
                }

                $sheet->setTitle($title);
                $sheetNames[$title] = TRUE;

                $xls->addSheet($sheet);

                $data = $lkh->toArray();

                $sheet
                    ->setCellValue('A2', 'Bulan '.$data['lkh_period'])
                    ->setCellValue('C5', ': '.$data['lkh_su_fullname'])
                    ->setCellValue('C6', ': '.$data['lkh_su_sj_name'])
                    ->setCellValue('C7', ': '.$data['lkh_su_sdp_name']);

                $items = $lkh->fetchItems();
                $total = count($items);
                $insert = $total > 2 ? ($total - 2) : 0;

                $line = 10;

                if ($total > 0) {
                    if ($insert > 0) {
                        $sheet->insertNewRowBefore(12, $insert);
                    }

                    $group = array();

                    foreach($items as $item) {
                        $sheet->mergeCells('C'.$line.':D'.$line);

                        // set row height
                        $z = Text::rows($item['lki_desc']);
                        $h = $z * 14.25 + 2.25;
                        $sheet->getRowDimension($line)->setRowHeight($h);

                        $sheet
                            ->setCellValue('A'.$line, $item['lki_index'])
                            ->setCellValue('B'.$line, $item['lki_group'])
                            ->setCellValue('C'.$line, $item['lki_desc'])
                            ->setCellValue('E'.$line, $item['lki_volume'])
                            ->setCellValue('F'.$line, $item['lki_unit']);

                        $token = $item['lki_lkd_date'];

                        if ( ! isset($group[$token])) {
                            $group[$token] = array(
                                'start' => $line,
                                'count' => 0
                            );
                        }

                        $group[$token]['count']++;

                        $line++;
                    }

                    // merging rows
                    $group = array_values($group);

                    foreach($group as $item) {
                        if ($item['count'] > 1) {
                            $start = $item['start'];
                            $end = ($item['start'] + ($item['count'] - 1));

                            $sheet->mergeCells('A'.$start.':A'.$end);
                            $sheet->mergeCells('B'.$start.':B'.$end);

                        }
                    }
                } else {
                    $line = 12;
                }

                $sheet
                    ->setCellValue('D'.($line + 2), $data['lkh_su_sj_name'])
                    ->setCellValue('D'.($line + 6), $data['lkh_su_fullname'])
                    ->setCellValue('D'.($line + 7), $data['lkh_su_no']);

                if ($lkh->evaluator) {
                    $sheet
                        ->setCellValue('A'.($line + 2), $data['evaluator_su_sj_name'])
                        ->setCellValue('A'.($line + 6), $data['evaluator_su_fullname'])
                        ->setCellValue('A'.($line + 7), $data['evaluator_su_no']);    
                }
            }

            $loop++;
        }

        // delete master sheet
        if ($loop > 0) {
            $sheetIndex = $xls->getIndex($xls->getSheetByName('MASTER'));
            $xls->removeSheetByIndex($sheetIndex);
        }

        $xls->setActiveSheetIndex(0);

        $file = strtoupper($user->getName().'_LKH_'.date('Y', strtotime($post['start_date'])));
        $file = preg_replace('/[^a-z0-9]+/i', '_', $file).'.xlsx';
        
        $xls->stream($file);
    }

    private function __reportPdf() {

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
                'task.lkh_id'
            ))
            ->join('App\Users\Models\User', 'user.su_id = task.lkh_su_id', 'user')
            ->filterable($payload)
            ->sortable($payload)
            ->groupBy('task.lkh_id');

        if (isset($payload['params'])) {
            $params = json_decode($payload['params'], TRUE);
            if (isset($params['status']) && ! empty($params['status'])) {
                $query->join('App\Lkh\Models\TaskStatus', 'task_status.lks_lkh_id = task.lkh_id AND task_status.lks_deleted = 0', 'task_status', 'LEFT');
                $query->join('App\Kanban\Models\KanbanStatus', 'kst.kst_status = task_status.lks_status', 'kst', 'LEFT');
                $query->join('App\Kanban\Models\KanbanPanel', 'kp.kp_id = kst.kst_kp_id', 'kp', 'LEFT');
                $query->inWhere('kp.kp_id', $params['status'][1]);        
            }
        }

        if ( ! $this->role->can('manage@lkh')) {
            $auth = $this->auth->user();
            $query
                ->join('App\Lkh\Models\TaskUser', 'task_user.lku_lkh_id = task.lkh_id', 'task_user', 'LEFT')
                ->andWhere('task_user.lku_su_id = :user:', array('user' => $auth['su_id']));
        }

        if (isset($payload['start'], $payload['limit'])) {
            $query->limit($payload['limit'], $payload['start']);
            $result = $query->paginate(FALSE);
        } else {
            $result = $query->paginate();    
        }

        $items = $result->data->filter(function($row){
            $task = Task::findFirst($row->lkh_id);
            $data = $task->toArray();
            $data['lkh_link'] = $task->getLink();
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
                ->setCellValue('B'.$line, $item['lkh_period'])
                ->setCellValue('C'.$line, $item['lkh_su_fullname'])
                ->setCellValue('D'.$line, $item['lkh_su_no']);

            if (isset($item['evaluator_su_fullname'])) {
                $sheet->setCellValue('E'.$line, $item['evaluator_su_fullname']);
            }

            if (isset($item['evaluator_su_no'])) {
                $sheet->setCellValue('F'.$line, $item['evaluator_su_no']);
            }

            $statuses = array_map(function($s){
                return $s['status_text'];
            }, $item['statuses']);

            $statuses = implode(', ', $statuses);
            $sheet->setCellValue('G'.$line, $statuses);

            $sheet->getStyle('A'.$line.':G'.$line)->applyFromArray(array(
                'borders' => array(
                    'bottom' => array(
                        'borderStyle' => 'thin'
                    )
                )
            ));

            $line++;
            $index++;
        }

        $column = 'A';
        $bottom = $line - 1;

        for($i = 0; $i < 6; $i++) {
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
        $xls->stream('DOKUMEN_LKH.xlsx');
    }

    private function __databasePdf() {

    }

    public function databaseItemsAction($format) {
        $method = '__databaseItems'.ucfirst(strtolower($format));
        if (method_exists($this, $method)) {
            $this->{$method}();
        }
    }

    private function __databaseItemsXls() {
        $payload = $this->request->getJson();

        $query = LkhItem::get()
            ->columns(array('lki_id'))
            ->join('App\Lkh\Models\LkhDay', 'lkd_id = lki_lkd_id')
            ->join('App\Lkh\Models\Task', 'lkh_id = lkd_lkh_id')
            ->join('App\Users\Models\User', 'su_id = lkh_su_id')
            ->filterable($payload)
            ->sortable($payload);

        if ( ! $this->role->can('manage@lkh')) {
            $auth = $this->auth->user();
            $query
                ->columns(array('lki_id'))
                ->join('App\Lkh\Models\TaskUser', 'task_user.lku_lkh_id = lkh_id', 'task_user', 'LEFT')
                ->andWhere('task_user.lku_su_id = :user:', array('user' => $auth['su_id']))
                ->groupBy('lki_id');
        }

        if ( ! isset($payload['sort'])) {
            $query->orderBy('lkd_date DESC');
        }

        if (isset($payload['start'], $payload['limit'])) {
            $query->limit($payload['limit'], $payload['start']);
        }
        $result = $query->paginate(FALSE);

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/database-items.xlsx');
        $sheet = $xls->getSheet(0);

        $line = 4;
        $index = 1;

        foreach($result->data as $row) {
            $item = LkhItem::findFirst($row->lki_id);
            $data = $item->toArray();

            $date = date('d-M-Y', strtotime($data['lki_date']));

            $sheet
                ->setCellValue('A'.$line, $index)
                ->setCellValue('B'.$line, $date)
                ->setCellValue('C'.$line, $data['lki_desc'])
                ->setCellValue('D'.$line, $data['lki_volume'])
                ->setCellValue('E'.$line, $data['lki_unit'])
                ->setCellValue('F'.$line, $data['lki_cost'])
                ->setCellValue('G'.$line, $data['lki_period'])
                ->setCellValue('H'.$line, $data['lki_su_fullname'])
                ->setCellValue('I'.$line, $data['lki_su_no']);

            $sheet->getStyle('F'.$line)->getNumberFormat()->setFormatCode('#,###');
            //$sheet->getRowDimension($line)->setRowHeight(-1);


            $sheet->getStyle('A'.$line.':I'.$line)->applyFromArray(array(
                'borders' => array(
                    'bottom' => array(
                        'borderStyle' => 'thin'
                    )
                )
            ));

            $line++;
            $index++;
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
        $xls->stream('KEGIATAN_LKH.xlsx');
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
        $xls->stream('DASHBOARD_SKP.xlsx');
    }
}