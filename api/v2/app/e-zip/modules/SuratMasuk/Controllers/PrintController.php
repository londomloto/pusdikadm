<?php
namespace App\SuratMasuk\Controllers;

use App\SuratMasuk\Models\Task;
use App\SuratMasuk\Models\Disposition;
use App\Company\Models\Company;
use App\Categories\Models\Category;
use App\Shipments\Models\Shipment;
use App\Priorities\Models\Priority;

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

        $xls = new Spreadsheet(PUBPATH.'resources/templates/surat-masuk/document.xlsx');

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

        $sheet->setCellValue('D'.$line, $data['tsm_agenda']);
        $sheet->setCellValue('G'.$line, $data['tsm_register_date_formatted']);
        $sheet->setCellValue('J'.$line, $data['classification_scl_code']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsm_subject']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsm_attachments']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsm_from']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['tsm_date_formatted']);
        $sheet->setCellValue('G'.$line, $data['tsm_no']);
        $line++;
        $sheet->setCellValue('D'.$line, $data['registrar_su_fullname']);
        
        $xls->stream('KENDALI_SURAT_MASUK.xlsx');
    }

    public function documentDistributionsAction($format, $id) {
        $method = '__documentDistributions'.ucfirst(strtolower($format));
        $this->$method($id);
    }

    private function __documentDistributionsXls($id) {
        $task = Task::get($id)->data;

        if ( ! $task) {
            throw new \Phalcon\Exception("Dokumen tidak ditemukan", 404);
        }

        $xls = new Spreadsheet(PUBPATH.'resources/templates/surat-masuk/document-distributions.xlsx');
        $sheet = $xls->getSheet(0);

        $data = $task->toArray();

        $line = 4;
        
        $headers = self::__createHeaders();
        $chunked = $headers[0];
        $insert = $chunked['total'] > 1 ? $chunked['total'] - 1 : 0;

        if ($chunked['total'] > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);
            }

            $offset = $line;

            foreach($chunked['names'] as $text) {
                $sheet->mergeCells('G'.$offset.':K'.$offset);
                $sheet->setCellValue('G'.$offset, $text);
                $offset++;
            }
        }

        if ($insert > 0) {
            $line += $insert;
        }

        $line++;
        $sheet->setCellValue('G'.$line, $headers[1]);
        $line++;
        $sheet->setCellValue('G'.$line, $headers[2]);
        $line++;
        $sheet->setCellValue('G'.$line, $headers[3]);

        $line += 3;
        $sheet->setCellValue('F'.$line, $data['tsm_no']);
        $line++;
        $sheet->setCellValue('F'.$line, $data['tsm_date_formatted']);
        $line++;
        $sheet->setCellValue('F'.$line, $data['tsm_attachments']);
        $line++;
        $sheet->setCellValue('F'.$line, $data['tsm_register_date_formatted']);
        $line++;
        $sheet->setCellValue('F'.$line, $data['tsm_from']);
        $line++;
        $sheet->setCellValue('F'.$line, $data['tsm_subject']);

        $line += 3;

        $distribustions = $task->getDistributions(); 
        $total = count($distribustions);
        $insert = $total > 2 ? $total - 2 : 0;

        if ($total > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);
            }

            $offset = $line;
            $number = 1;

            foreach($distribustions as $dist) {
                $sending = $dist['sending']->toArray();
                $receiving = $dist['receiving']->toArray();

                $sheet->mergeCells('B'.$offset.':C'.$offset);
                $sheet->mergeCells('D'.$offset.':F'.$offset);
                $sheet->mergeCells('G'.$offset.':H'.$offset);
                $sheet->mergeCells('L'.$offset.':M'.$offset);

                $sheet
                    ->setCellValue('B'.$offset, $number)
                    ->setCellValue('D'.$offset, $sending['tdp_sending_date_formatted'])
                    ->setCellValue('G'.$offset, $sending['responsible_label'])
                    ->setCellValue('I'.$offset, $receiving['responsible_label'])
                    ->setCellValue('J'.$offset, $receiving['tdp_receiving_date_formatted'])
                    ->setCellValue('K'.$offset, self::__nulled($receiving, 'receiver_su_fullname'));

                if ( ! empty($receiving['tdp_signature'])) {
                    $sign = PUBPATH.'resources/signatures/'.$receiving['tdp_signature'];
                    $sign = Spreadsheet::createImage($sign);

                    if ($sign) {
                        $sign->setWidth(48);
                        $sign->setHeight(48);
                        $sign->setOffsetX(3);
                        $sign->setOffsetY(3);
                        $sign->setWorksheet($sheet);
                        $sign->setCoordinates('L'.$offset);
                    }
                }

                $offset++;
                $number++;
            }
        }

        
        $xls->stream('DISTRIBUSI_SURAT_MASUK.xlsx');
    }

    public function dispositionAction($format, $id) {
        $method = '__disposition'.ucfirst(strtolower($format));
        $this->$method($id);
    }

    private function __dispositionXls($id) {
        $node = Disposition::get($id)->data;
        $task = $node ? $node->getTask() : FALSE;

        if ( ! $node && ! $task) {
            throw new \Phalcon\Exception("Disposisi tidak ditemukan", 404);
        }

        $nodes = array();

        if ($node->isRoot()) {
            $nodes = array($node);
        } else{
            $step = 0;
            $node->bubble(function($curr) use (&$nodes){
                $nodes[] = $curr;
            });
        }

        $nodes = array_reverse($nodes);
        $root = array_shift($nodes);
        $from = $node->getSendingNode();

        $arrayTask = $task->toArray();
        $arrayRoot = $root->toArray();
        $arrayNode = $node->toArray();
        $arrayFrom = $from ? $from->toArray() : FALSE;

        $xls = new Spreadsheet(PUBPATH.'resources/templates/surat-masuk/disposition.xlsx');

        $sheet = $xls->getSheet(0);

        // SETUP TEMPLATE
        if (($template = $root->getReportTemplate())) {
            $arrayTemplate = $template->toArray();
            
            $flows = $arrayTemplate['flows'];
            $total = count($flows);

            if ($total > 0) {
                $line = 27;
                $tail = $total % 2 != 0 ? array_pop($flows) : FALSE;

                if (count($flows) > 0) {
                    
                    $chunked = array_chunk($flows, 2);
                    $groups = count($chunked);
                    $index = 0;

                    foreach($chunked as $items) {

                        $L = $items[0];
                        $R = $items[1];

                        $sheet->setCellValue('B'.$line, $L['sdp_name']);
                        $sheet->setCellValue('B'.($line + 1), $L['sdp_to']);
                        $sheet->setCellValue('B'.($line + 2), 'Petunjuk / Catatan :');
                        $sheet->setCellValue('B'.($line + 4), 'Tanggal Penyelesaian :');
                        $sheet->setCellValue('B'.($line + 5), 'Penerima :');

                        $sheet->setCellValue('I'.$line, $R['sdp_name']);
                        $sheet->setCellValue('I'.($line + 1), $R['sdp_to']);
                        $sheet->setCellValue('I'.($line + 2), 'Petunjuk / Catatan :');

                        $label = 'Diajukan kembali tanggal :';
                        if ($index == ($groups - 1) && ! $tail) {
                            $label = 'Tanggal Penyelesaian :';
                        }

                        $sheet->setCellValue('I'.($line + 4), $label);
                        $sheet->setCellValue('I'.($line + 5), 'Penerima :');

                        $sheet->getStyle('B'.$line.':H'.$line)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                        $sheet->getStyle('B'.($line + 1).':H'.($line + 3))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                        $sheet->getStyle('B'.($line + 4).':H'.($line + 4))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                        $sheet->getStyle('B'.($line + 5).':H'.($line + 5))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                        $sheet->getStyle('I'.$line.':O'.$line)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                        $sheet->getStyle('I'.($line + 1).':O'.($line + 3))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                        $sheet->getStyle('I'.($line + 4).':O'.($line + 4))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                        $sheet->getStyle('I'.($line + 5).':O'.($line + 5))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));

                        $sheet->getStyle('B'.$line.':O'.$line)->getFont()->setBold(TRUE);
                        $sheet->getStyle('B'.$line.':B'.($line + 5))->getFont()->setSize(10);
                        $sheet->getStyle('I'.$line.':I'.($line + 5))->getFont()->setSize(10);

                        $line += 6;   
                        $index++;
                    }
                }

                if ($tail) {
                    $sheet->setCellValue('B'.$line, $tail['sdp_name']);
                    $sheet->setCellValue('B'.($line + 1), $tail['sdp_to']);
                    $sheet->setCellValue('B'.($line + 2), 'Petunjuk / Catatan :');
                    $sheet->setCellValue('B'.($line + 4), 'Tanggal Penyelesaian :');
                    $sheet->setCellValue('B'.($line + 5), 'Penerima :');

                    $sheet->getStyle('B'.$line.':O'.$line)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                    $sheet->getStyle('B'.($line + 1).':O'.($line + 3))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                    $sheet->getStyle('B'.($line + 4).':O'.($line + 4))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                    $sheet->getStyle('B'.($line + 5).':O'.($line + 5))->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                    $sheet->getStyle('B'.$line)->getFont()->setBold(TRUE);
                    $sheet->getStyle('B'.$line.':O'.($line + 5))->getFont()->setSize(10);
                }
            }

        }

        //exit();

        $line = 4;
        $headers = self::__createHeaders();

        $chunked = $headers[0];
        $insert = $chunked['total'] > 1 ? $chunked['total'] - 1 : 0;

        if ($chunked['total'] > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);
            }

            $offset = $line;

            foreach($chunked['names'] as $text) {
                $sheet->mergeCells('E'.$offset.':M'.$offset);
                $sheet->setCellValue('E'.$offset, $text);
                $offset++;
            }
        }

        if ($insert > 0) {
            $line += $insert;
        }

        $line++;
        $sheet->setCellValue('E'.$line, $headers[1]);
        $line++;
        $sheet->setCellValue('E'.$line, $headers[2]);
        $line++;
        $sheet->setCellValue('E'.$line, $headers[3]);

        $line += 2;
        $sheet->setCellValue('B'.$line, 'LEMBAR '.strtoupper($arrayRoot['tdp_name']));

        $line += 2;
        $sheet->setCellValue('E'.$line, $arrayTask['tsm_no']);
        $sheet->setCellValue('L'.$line, self::__checkbox($arrayNode['tdp_orig']));
        $sheet->setCellValue('N'.$line, self::__checkbox($arrayNode['tdp_copy']));

        $line++;
        $sheet->setCellValue('E'.$line, $arrayTask['tsm_date_formatted']);
        
        $chunked = self::__chunkCategories();
        $insert = $chunked['limit'] > 1 ? ($chunked['limit'] - 1) : 0;

        if ($chunked['total'] > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);
                $range = 'B'.$line.':O'.($line + $insert);
                $sheet->getStyle($range)->applyFromArray(array(
                    'borders' => array(
                        'horizontal' => array(
                            'borderStyle' => 'none'
                        )
                    )
                ));
            }

            $offset = $line;

            foreach($chunked['pages'][0] as $category) {
                $selected = $category->sct_id == $arrayTask['tsm_category'];
                $sheet->setCellValue('L'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('M'.$offset, $category->sct_name);
                $offset++;
            }

            $offset = $line;

            foreach($chunked['pages'][1] as $category) {
                $selected = $category->sct_id == $arrayTask['tsm_category'];
                $sheet->setCellValue('N'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('O'.$offset, $category->sct_name);
                $offset++;
            }
        }

        if ($insert > 0) {
            $line += $insert;
        }

        $line++;
        $sheet->setCellValue('E'.$line, $arrayTask['tsm_attachments']);
        $line++;
        // $sheet->setCellValue('E'.$line, $arrayTask['tsm_agenda_date_formatted']);
        $line++;
        $sheet->setCellValue('E'.$line, $arrayTask['tsm_agenda']);

        $chunked = self::__chunkShipments();
        $insert = $chunked['limit'] > 1 ? $chunked['limit'] - 1 : 0;

        if ($chunked['total'] > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);
                $range = 'B'.$line.':O'.($line + $insert);
                $sheet->getStyle($range)->applyFromArray(array(
                    'borders' => array(
                        'horizontal' => array(
                            'borderStyle' => 'none'
                        )
                    )
                ));
            }

            $offset = $line;

            foreach($chunked['pages'][0] as $shipment) {
                $selected = $shipment->sdt_id == $arrayTask['tsm_shipment'];
                $sheet->setCellValue('L'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('M'.$offset, $shipment->sdt_name);
                $offset++;
            }

            $offset = $line;

            foreach($chunked['pages'][1] as $shipment) {
                $selected = $shipment->sdt_id == $arrayTask['tsm_shipment'];
                $sheet->setCellValue('N'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('O'.$offset, $shipment->sdt_name);
                $offset++;
            }
        }

        $line++;

        if ($insert > 0) {
            $line = $line + $insert;
        }

        $sheet->setCellValue('E'.$line, $arrayTask['tsm_from']);
        $line++;
        $sheet->setCellValue('E'.$line, $arrayTask['tsm_subject']);
        $line++;

        $chunked = self::__chunkPriorities();
        $insert = $chunked['limit'] > 1 ? $chunked['limit'] - 1 : 0;

        if ($chunked['total'] > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);

                $range = 'B'.$line.':O'.($line + $insert);
                
                $sheet->getStyle($range)->applyFromArray(array(
                    'borders' => array(
                        'horizontal' => array(
                            'borderStyle' => 'none'
                        )
                    )
                ));
            }

            $offset = $line;

            foreach($chunked['pages'][0] as $priority) {
                $selected = $priority->spt_id == $arrayTask['tsm_priority'];
                $sheet->setCellValue('B'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('C'.$offset, strtoupper($priority->spt_name));
                $offset++;
            }

            $offset = $line;

            foreach($chunked['pages'][1] as $priority) {
                $selected = $priority->spt_id == $arrayTask['tsm_priority'];
                $sheet->setCellValue('F'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('G'.$offset, strtoupper($priority->spt_name));
                $offset++;
            }

            $offset = $line;

            foreach($chunked['pages'][2] as $priority) {
                $selected = $priority->spt_id == $arrayTask['tsm_priority'];
                $sheet->setCellValue('L'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('M'.$offset, strtoupper($priority->spt_name));
                $offset++;
            }
        }

        if ($insert > 0) {
            $line += $insert;
        }

        $line++;
        $sheet->setCellValue('B'.$line, strtoupper($arrayRoot['tdp_name']).' Kepada:');
        $line++;

        $subordinates = $arrayRoot['subordinates'];
        $subordinates[] = array(
            'su_position' => '',
            'su_checked' => '0'
        );

        $instructions = $arrayRoot['instructions'];

        $chunked = self::__chunkInstructions($instructions);
        
        $limit = max(array( count($subordinates), ($chunked['limit'] + 1) ));
        $total = max(array( count($subordinates), ($chunked['total'] + 2) ));
        $insert = $limit > 2 ? $limit - 2 : 0;

        $branch = isset($nodes[0]) ? $nodes[0] : FALSE;

        if ($total > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(($line + 1), $insert);
            }

            $offset = $line;

            foreach($subordinates as $sub) {
                $sheet->setCellValue('B'.$offset, self::__checkbox($sub['su_checked']));
                $sheet->setCellValue('C'.$offset, $sub['su_position']);
                $offset++;
            }

            $offset = $line;

            $chunked['pages'][0][] = array(
                'sin_checked' => 0,
                'sin_name' => ''
            );

            foreach($chunked['pages'][0] as $ins) {
                $selected = $ins['sin_checked'] == 1;
                $sheet->setCellValue('H'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('I'.$offset, $ins['sin_name']);
                $offset++;
            }

            $offset = $line;

            $chunked['pages'][1][] = array(
                'sin_checked' => 0,
                'sin_name' => ''
            );

            foreach($chunked['pages'][1] as $ins) {
                $selected = $ins['sin_checked'] == 1;
                $sheet->setCellValue('L'.$offset, self::__checkbox($selected));
                $sheet->setCellValue('M'.$offset, $ins['sin_name']);
                $offset++;
            }

        }

        if ($insert > 0) {
            $line += $insert;
        }

        $line += 3;
        $sheet->setCellValue('B'.$line, 'CATATAN '.strtoupper($arrayRoot['responsible_su_sj_acronym']).':');
        $line++;
        $sheet->setCellValue('B'.$line, $arrayRoot['tdp_notes']);
        self::__autoHeightRow($sheet, $line, $arrayRoot['tdp_notes'], $width = 150);
        
        $line++;

        if ($branch) {
            $arrayBranch = $branch->toArray();
            $sheet->setCellValue('B'.$line, 'Tanggal penyelesaian: '.$arrayBranch['tdp_finish_date_formatted']);
            $sheet->setCellValue('B'.($line + 1), 'Penerima: '.self::__resolveReceiver($arrayBranch));
        }
        
        // if ($from && ! $from->isRoot()) {
        //     if ( ! empty($arrayFrom['tdp_sending_date_formatted'])) {
        //         $sheet->setCellValue('I'.$line, 'Tanggal diajukan kembali: '.$arrayFrom['tdp_sending_date_formatted']);
        //         $sheet->setCellValue('I'.($line + 1), 'Penerima: '.self::__resolveReceiver($arrayFrom));
        //     }
        // }

        $line += 2;

        $chunked = self::__chunkDispositions($nodes);

        if ($chunked['total'] > 0) {

            $offset = $line;
            $page = 1;

            foreach($chunked['pages'] as $items) {

                if ($page > 1) {
                    $sheet->setCellValue('B'.($offset), 'DISPOSISI STAFF');
                    $sheet->setCellValue('B'.($offset + 1), 'Kepada Staff:');
                    $sheet->setCellValue('B'.($offset + 2), 'Petunjuk:');
                    $sheet->setCellValue('B'.($offset + 4), 'Tanggal penyelesaian:');
                    $sheet->setCellValue('B'.($offset + 5), 'Penerima:');

                    $sheet->setCellValue('I'.($offset), 'DISPOSISI STAFF');
                    $sheet->setCellValue('I'.($offset + 1), 'Kepada Staff:');
                    $sheet->setCellValue('I'.($offset + 2), 'Petunjuk:');
                    $sheet->setCellValue('I'.($offset + 4), 'Tanggal penyelesaian:');
                    $sheet->setCellValue('I'.($offset + 5), 'Penerima:');

                    $sheet->getStyle('B'.($offset).':I'.$offset)->getFont()->setBold(TRUE);

                    $range = 'B'.$offset.':H'.$offset;
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));

                    $range = 'B'.($offset + 1).':H'.($offset + 3);
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));

                    $range = 'B'.($offset + 4).':H'.($offset + 4);
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                    
                    $range = 'B'.($offset + 5).':H'.($offset + 5);
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));

                    $range = 'I'.$offset.':O'.$offset;
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));

                    $range = 'I'.($offset + 1).':O'.($offset + 3);
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));

                    $range = 'I'.($offset + 4).':O'.($offset + 4);
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                    
                    $range = 'I'.($offset + 5).':O'.($offset + 5);
                    $sheet->getStyle($range)->applyFromArray(array('borders' => array('outline' => array('borderStyle' => 'thin'))));
                }

                $A = $items[0];
                $B = $items[1];
                $C = $items[2];
                $D = $items[3];

                $notesA = '';
                $notesC = '';

                if ($A) {
                    $arrayA = $A->toArray();

                    if ($A->isThread()) {

                        $sheet->setCellValue('B'.$offset, strtoupper($arrayA['tdp_name']));
                        $sheet->setCellValue('B'.($offset + 3), $arrayA['tdp_notes']);
                        $notesA = $arrayA['tdp_notes'];
                    }

                }

                if ($B) {
                    $arrayB = $B->toArray();

                    $sheet->setCellValue('B'.($offset + 4), 'Tanggal penyelesaian: '.$arrayB['tdp_finish_date_formatted']);
                    $sheet->setCellValue('B'.($offset + 5), 'Penerima: '.self::__resolveReceiver($arrayB));
                }

                if ($C) {
                    $arrayC = $C->toArray();

                    if ($C->isThread()) {
                        $sheet->setCellValue('I'.$offset, strtoupper($arrayC['tdp_name']));
                        $sheet->setCellValue('I'.($offset + 3), $arrayC['tdp_notes']);

                        $notesC = $arrayC['tdp_notes'];

                    }
                }

                if ($D) {
                    $arrayD = $D->toArray();

                    $sheet->setCellValue('I'.($offset + 4), 'Tanggal penyelesaian: '.$arrayD['tdp_finish_date_formatted']);
                    $sheet->setCellValue('I'.($offset + 5), 'Penerima: '.self::__resolveReceiver($arrayD));
                }

                if (strlen($notesA) > strlen($notesC)) {
                    $notes = $notesA;
                } else {
                    $notes = $notesC;
                }

                self::__autoHeightRow($sheet, ($offset + 3), $notes, $width = 60);

                $page++;
                $offset += 6;
            }
        }

        $xls->stream($node->getReportTitle().'.xlsx');
    }

    private static function __resolveReceiver($disposition) {
        $result = isset($disposition['responsible_su_fullname']) 
            ? $disposition['responsible_su_fullname'] 
            : '(anonim)';

        return $result;
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

    private static function __createCompanyLogo($company) {
        $logo = Spreadsheet::createImage(PUBPATH.'resources/company/'.$company->getLogo());

        if ($logo) {
            $logo->setWidth(112);
            $logo->setHeight(117);
        }

        return $logo;
    }

    private static function __autoHeightRow($sheet, $line, $text, $width = 60) {
        $row = $sheet->getRowDimension($line);
        $rowHeight = $row->getRowHeight();

        $r = Text::rows($text, $width);
        $h = $r * $rowHeight; // + 2.25;

        $row->setRowHeight($h);
    }

    private static function __chunkCategories() {
        $items = Category::find()->filter(function($category){ return $category; });

        // add extra item
        // $extra = new \stdClass();
        // $extra->sct_id = -1;
        // $extra->sct_name = '......';

        // $items[] = $extra;

        $total = count($items);
        $limit = ceil($total / 2);

        if ($limit <= 3) {
            $limit = 3;
        }

        $pages = array_chunk($items, $limit);
        $pages = array_pad($pages, 2, array());

        return array(
            'pages' => $pages,
            'total' => $total,
            'limit' => $limit
        );
    }

    private static function __chunkInstructions($items) {
        $total = count($items);
        $limit = ceil($total / 2);

        $pages = array_chunk($items, $limit);
        $pages = array_pad($pages, 2, array());

        return array(
            'pages' => $pages,
            'total' => $total,
            'limit' => $limit
        );
    }

    private static function __chunkShipments() {
        $items = Shipment::find()->filter(function($shipment){ return $shipment; });
        $total = count($items);

        $pages = array_pad(array(), 2, array());

        $index = 1;

        foreach($items as $item) {
            if ($index % 2 == 0) {
                $pages[1][] = $item;
            } else {
                $pages[0][] = $item;
            }

            $index++;
        }

        $count = array_map(function($page){ return count($page); }, $pages);
        $limit = max($count);

        return array(
            'pages' => $pages,
            'total' => $total,
            'limit' => $limit
        );
    }

    private static function __chunkDispositions($items) {
        $total = count($items);
        $paths = array();

        for($i = 0; $i < $total; $i++) {
            $paths[] = $items[$i];

            if (isset($items[$i + 1])) {
                $paths[] = $items[$i + 1];
            } else {
                $paths[] = FALSE;
            }
        }

        $pages = array_chunk($paths, 4);

        foreach($pages as $idx => $page) {
            $pages[$idx] = array_pad($page, 4, FALSE);
        }

        return array(
            'pages' => $pages,
            'total' => $total
        );
    }

    private static function __chunkPriorities() {
        $items = Priority::find()->filter(function($priority){ return $priority; });
        $total = count($items);

        $pages = array_pad(array(), 3, array());

        $index = 1;

        foreach($items as $item) {
            if ($index % 3 == 0) {
                $pages[2][] = $item;
            } else if ($index % 2 == 0) {
                $pages[1][] = $item;
            } else {
                $pages[0][] = $item;
            }
            $index++;
        }

        $count = array_map(function($page){ return count($page); }, $pages);
        $limit = max($count);

        return array(
            'pages' => $pages,
            'total' => $total,
            'limit' => $limit
        );
    }

    private static function __nulled($stack, $key) {
        if ( ! isset($stack[$key])) {
            return NULL;
        }
        return $stack[$key];
    }

    private static function __checkbox($value) {
        $value = $value == 1 ? TRUE : FALSE;
        return $value === TRUE ? '☑' : '☐';
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
