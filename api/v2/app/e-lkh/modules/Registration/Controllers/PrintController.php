<?php
namespace App\Registration\Controllers;

use App\Registration\Models\Task;
use Micro\Office\Spreadsheet;

class PrintController extends \Micro\Controller {

    public function documentAction($id, $format) {
        $method = '__document'.ucfirst(strtolower($format));
        if (method_exists($this, $method)) {
            $this->{$method}($id);
        }
    }

    private function __documentXls($id) {
        $user = Task::get($id)->data;

        if ( ! $user) {
            throw new \Phalcon\Exception("Document not found", 404);
        }

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/document.xlsx');
        $data = $user->toArray();

        $photo = new \Micro\Image(PUBPATH.'resources/avatars/'.$user->getAvatar());
        $photo = $photo->thumb(150, 180, TRUE);
        $photo = Spreadsheet::createImageFromResource($photo);

        $sheet = $xls->getSheet(0);
        $photo->setCoordinates('B4');
        $photo->setWorksheet($sheet);

        $sheet->setCellValue('G6', $data['su_fullname']);
        $sheet->setCellValue('G7', $data['su_sex']);
        $sheet->setCellValue('G8', $data['su_pob'].', '.$data['su_dob_formatted']);
        $sheet->setCellValue('G9', $data['su_no']);
        $sheet->setCellValue('G10', $data['su_sg_name']);
        $sheet->setCellValue('G11', $data['su_sj_name']);
        $sheet->setCellValue('G12', $data['su_sdp_name']);
        $sheet->setCellValue('G13', $data['su_scp_name']);
        $sheet->setCellValue('G17', $data['su_email']);
        $sheet->setCellValue('G18', $data['sr_name']);

        $file = strtoupper($data['su_fullname'].'_'.$data['su_no']);
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
            ->columns(array('task.su_id'))
            ->join('App\Registration\Models\TaskStatus', 'task_status.tus_su_id = task.su_id AND task_status.tus_deleted = 0', 'task_status', 'LEFT')
            ->groupBy('task.su_id')
            ->filterable($payload)
            ->andWhere('task_status.tus_id IS NOT NULL')
            ->sortable($payload);

        if (isset($payload['params'])) {
            $params = json_decode($payload['params'], TRUE);
            if (isset($params['status']) && ! empty($params['status'])) {
                $query
                    ->join('App\Kanban\Models\KanbanStatus', 'kanban_status.kst_status = task_status.tus_status', 'kanban_status', 'LEFT')
                    ->join('App\Kanban\Models\KanbanPanel', 'kanban_status.kst_kp_id = kanban_panel.kp_id', 'kanban_panel', 'LEFT')
                    ->inWhere('kanban_panel.kp_id', $params['status'][1]);
            }
        }

        if ( ! isset($payload['sort'])) {
            $query->orderBy('task.su_fullname ASC');
        }


        if (isset($payload['start'], $payload['limit'])) {
            $query->limit($payload['limit'], $payload['start']);
        }

        $result = $query->paginate(FALSE);
        $items = $result->data->filter(function($row){
            $user = Task::findFirst($row->su_id);
            $item = $user->toArray();
            return $item;
        });

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/database.xlsx');
        $sheet = $xls->getSheet(0);
        $line = 4;
        $index = 1;

        foreach($items as $item) {
            $sheet
                ->setCellValue('A'.$line, $index)
                ->setCellValue('B'.$line, $item['su_fullname'])
                ->setCellValue('C'.$line, $item['su_sex'])
                ->setCellValue('D'.$line, $item['su_no'])
                ->setCellValue('E'.$line, $item['su_sg_name'])
                ->setCellValue('F'.$line, $item['su_sj_name'])
                ->setCellValue('G'.$line, $item['su_sdp_name'])
                ->setCellValue('H'.$line, $item['su_email'])
                ->setCellValue('I'.$line, $item['su_phone'])
                ->setCellValue('J'.$line, $item['sr_name']);

            $sheet->getStyle('A'.$line.':J'.$line)->applyFromArray(array(
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

        for($i = 0; $i < 9; $i++) {
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

        $xls->stream('DATABASE_PENDAFTARAN.xlsx');   
    }

}