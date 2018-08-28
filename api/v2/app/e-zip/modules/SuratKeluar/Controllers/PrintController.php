<?php
namespace App\SuratKeluar\Controllers;

use App\SuratKeluar\Models\Task;
use App\Company\Models\Company;

use Micro\Office\Spreadsheet;
use Micro\Helpers\Date;
use Micro\Helpers\Text;

class PrintController extends \Micro\Controller {

    public function documentAction($format, $id){
        $method = '__document'.ucfirst(strtolower($format));
        $this->$method($id);
    }

    private function __documentXls($id) {
        $task = Task::get($id)->data;

        if ( ! $task) {
            throw new \Phalcon\Exception("Dokumen tidak ditemukan", 404);
        }

        $xls = new Spreadsheet(PUBPATH.'resources/templates/surat-keluar/document.xlsx');

        $sheet = $xls->getSheet(0);
        $data = $task->toArray();

        $headers = self::__createHeaders();

        // headers
        $chunked = $headers[0];
        $insert = $chunked['total'] > 1 ? $chunked['total'] - 1 : 0;

        $line = 3;

        if ($chunked['total'] > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);
            }
            
            $offset = $line;

            foreach($chunked['names'] as $name) {
                $sheet->setCellValue('B'.$offset, $name);
                $offset++;
            }
        }

        if ($insert > 0) {
            $line += $insert;
        }

        $line += 3;

        $sheet->setCellValue('D'.$line, $data['tsk_agenda']);
        $sheet->setCellValue('J'.$line, self::__nulled($data, 'class_scl_code'));
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsk_subject']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsk_attachments']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsk_to']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsk_date_formatted']);
        $sheet->setCellValue('G'.$line, $data['tsk_no']);
        $line++;
        $sheet->setCellValue('D'.$line, self::__nulled($data, 'conceptor_su_fullname'));
        
        $xls->stream('KENDALI_SURAT_KELUAR.xlsx');
    }

    private static function __createHeaders() {
        $company = Company::getDefault();
        return array(
            self::__chunkCompanyName($company),
            $company->scp_address,
            sprintf('Telp. %s, Fax. %s', $company->scp_phone, $company->scp_fax),
            sprintf('Email: %s, website: %s', $company->scp_email, $company->scp_homepage)
        );
    }

    private static function __chunkCompanyName($company) {
        $value = trim(strtoupper($company->scp_parent));
        $count = strlen($value);
        $chunk = Text::limitChars($value, 40, '');
        $limit = strlen($chunk);

        $names = array();

        if ($count > $limit) {
            $names[] = trim(substr($value, 0, $limit));
            $names[] = trim(substr($value, $limit));
        } else {
            $names[] = $value;
        }

        $total = count($names);

        return array(
            'names' => $names,
            'total' => $total
        );
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
                'task.tsk_id',
                'category.sct_weight AS sct_weight'
            ))
            ->join('App\Categories\Models\Category', 'category.sct_id = task.tsk_category', 'category', 'LEFT')
            ->groupBy('task.tsk_id')
            ->filterable()
            ->sortable();

        $params = isset($payload['params']) ? $payload['params'] : array();

        if ( ! empty($params)) {
            $params = json_decode($params, TRUE);
            if (isset($params['status']) && ! empty($params['status'])) {
                $query->join('App\SuratKeluar\Models\TaskStatus', 'task_status.tsks_tsk_id = task.tsk_id AND task_status.tsks_deleted = 0', 'task_status', 'LEFT');
                $query->join('App\Kanban\Models\KanbanStatus', 'kst.kst_status = task_status.tsks_status', 'kst', 'LEFT');
                $query->join('App\Kanban\Models\KanbanPanel', 'kp.kp_id = kst.kst_kp_id', 'kp', 'LEFT');
                $query->inWhere('kp.kp_id', $params['status'][1]);
            }
        }

        $result = $query->paginate();

        $result->filter(function($row){
            $task = Task::findFirst($row->tsk_id);
            
            $data = $task->toArray();
            
            $data['tsk_link'] = $task->getLink();
            $data['statuses'] = $task->getCurrentStatuses()->filter(function($status){
                return $status->toArray();
            });

            return $data;
        });

        $xls = new Spreadsheet(PUBPATH.'resources/templates/surat-keluar/database.xlsx');

        $sheet = $xls->getSheet(0);
        $index = 1;
        $line = 4;

        foreach($result->data as $item) {

            $sheet
                ->setCellValue('A'.$line, $index)
                ->setCellValue('B'.$line, $item['tsk_agenda'])
                ->setCellValue('C'.$line, $item['tsk_delivery_date_formatted'])
                ->setCellValue('D'.$line, $item['tsk_no'])
                ->setCellValue('E'.$line, $item['tsk_date_formatted'])
                ->setCellValue('F'.$line, $item['tsk_from'])
                ->setCellValue('G'.$line, $item['tsk_to'])
                ->setCellValue('H'.$line, $item['tsk_subject'])
                ->setCellValue('I'.$line, $item['tsk_attachments'])
                ->setCellValue('J'.$line, self::__nulled($item, 'class_scl_label'))
                ->setCellValue('K'.$line, self::__nulled($item, 'category_sct_name'))
                ->setCellValue('L'.$line, self::__nulled($item, 'shipment_sdt_name'))
                ->setCellValue('M'.$line, self::__nulled($item, 'secrecy_sst_name'));

            $index++;
            $line++;
        }

        if (count($result->data) > 2) {
            $sheet->getStyle('A6:M'.$line)->applyFromArray(array(
                'borders' => array(
                    'allBorders' => array(
                        'borderStyle' => 'thin'
                    )
                )
            ));

            $sheet->getStyle('A6:M'.$line)->applyFromArray(array(
                'borders' => array(
                    'left' => array(
                        'borderStyle' => 'none'
                    ),
                    'right' => array(
                        'borderStyle' => 'none'
                    )
                )
            ));
        }

        // echo '<pre>';
        // echo json_encode($result, JSON_PRETTY_PRINT);

        $xls->setActiveSheetIndex(0);
        $xls->stream('DATABSE-SURAT-KELUAR.xlsx');
    }

    private static function __nulled($stack, $key) {
        if ( ! isset($stack[$key])) {
            return NULL;
        }
        return $stack[$key];
    }
}