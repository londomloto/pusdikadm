<?php
namespace App\Lkh\Controllers;

use App\Lkh\Models\Lkh;
use Micro\Office\Spreadsheet;
use Micro\Helpers\Date as DateHelper;

class PrintController extends \Micro\Controller {

    public function documentAction($format, $id) {
        $method = '__document'.ucfirst(strtolower($format));
        $this->$method($id);
    }   

    private function __documentXls($id) {
        $lkh = Lkh::get($id)->data;

        if ( ! $lkh) {
            throw new \Phalcon\Exception("Not Found", 404);
        } 

        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/lkh.xlsx');
        $arr = $lkh->toArray();

        $sheet = $xls->getSheet(0);
        $sheet
            ->setCellValue('A2', 'Bulan '.$arr['lkh_period'])
            ->setCellValue('C5', ': '.$arr['lkh_su_fullname'])
            ->setCellValue('C6', ': '.$arr['lkh_su_sj_name'])
            ->setCellValue('C7', ': '.$arr['lkh_su_sdp_name']);

        $days = $lkh->getDays()->filter(function($item){ return $item; });
        $items = array();
        $index = 1;

        foreach($days as $d) {
            $group = $d->lkd_date;


            $dayItems = $d->getItems()->filter(function($item) use ($group, $index){ 
                $array = $item->toArray();
                $array['group'] = $group;
                $array['index'] = $index;

                return $array;
            });

            if (count($dayItems) > 1) {
                $dayItems[0]['merge'] = count($dayItems) - 1;
            }

            $items = array_merge($items, $dayItems);
            $index++;
        }

        $count = count($items);
        $insert = $count > 2 ? ($count - 2) : 0;

        $row = 10;

        if ($count > 0) {
            if ($insert > 0) {
                $sheet->insertNewRowBefore(12, $insert);
            }

            $merge = $row;

            foreach($items as $item) {

                if (isset($item['merge']) && $item['merge'] > 1) {
                    $sheet->mergeCells('A'.$row.':A'.($row + $item['merge']));
                    $sheet->mergeCells('B'.$row.':B'.($row + $item['merge']));
                }

                $sheet->mergeCells('C'.$row.':D'.$row);

                $date = date('d', strtotime($item['group']));

                $sheet
                    ->setCellValue('A'.$row, $item['index'])
                    ->setCellValue('B'.$row, $date)
                    ->setCellValue('C'.$row, $item['lki_desc'])
                    ->setCellValue('E'.$row, $item['lki_volume']);


                $row++;
            }
        }

        if ($insert == 0) {
            $row += 2;
        }

        $sheet->setCellValue('D'.($row + 2), $arr['lkh_su_sj_name']);
        $sheet->setCellValue('D'.($row + 6), $arr['lkh_su_fullname']);
        $sheet->setCellValue('D'.($row + 7), $arr['lkh_su_no']);

        if ($lkh->superior) {
            $sheet->setCellValue('A'.($row + 2), $arr['superior_su_sj_name']);    
            $sheet->setCellValue('A'.($row + 6), $arr['superior_su_fullname']);    
            $sheet->setCellValue('A'.($row + 7), $arr['superior_su_no']);    
        }

        $xls->setActiveSheetIndex(0);

        $file = strtolower($lkh->getTitle());
        $file = preg_replace('/[^a-z0-9]+/i', '_', $file).'.xlsx';

        $xls->stream($file);
    }

}