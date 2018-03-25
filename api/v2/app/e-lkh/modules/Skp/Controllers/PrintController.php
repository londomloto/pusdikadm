<?php
namespace App\Skp\Controllers;

use App\Skp\Models\Skp;
use App\Skp\Models\SkpBehavior;
use Micro\Office\Spreadsheet;
use Micro\Helpers\Date as DateHelper;

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
        $xls = new Spreadsheet(dirname(__DIR__).'/Templates/skp.xlsx');
        $today = DateHelper::today();

        // DATA SKP
        $sheet = $xls->getSheet(0);
        $sheet
            ->setCellValue('E4', $arr['skp_su_fullname'])
            ->setCellValue('E5', $arr['skp_su_no'])
            ->setCellValue('E6', $arr['skp_su_grade'])
            ->setCellValue('E7', $arr['skp_su_sj_name'])
            ->setCellValue('E8', $arr['skp_su_sdp_name']);

        if ($skp->evaluator) {
            $sheet
                ->setCellValue('E10', $arr['evaluator_su_fullname'])
                ->setCellValue('E11', $arr['evaluator_su_no'])
                ->setCellValue('E12', $arr['evaluator_su_grade'])
                ->setCellValue('E13', $arr['evaluator_su_sj_name'])
                ->setCellValue('E14', $arr['evaluator_su_sdp_name']);    
        }

        if ($skp->superior) {
            $sheet
                ->setCellValue('E16', $arr['superior_su_fullname'])
                ->setCellValue('E17', $arr['superior_su_no'])
                ->setCellValue('E18', $arr['superior_su_grade'])
                ->setCellValue('E19', $arr['superior_su_sj_name'])
                ->setCellValue('E20', $arr['superior_su_sdp_name']);    
        }

        // COVER
        $sheet = $xls->getSheet(1);
        $sheet
            ->setCellValue('F18', $arr['skp_su_fullname'])
            ->setCellValue('F19', $arr['skp_su_no'])
            ->setCellValue('F20', $arr['skp_su_grade'])
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
                ->setCellValue('C7', $arr['evaluator_su_grade'])
                ->setCellValue('C8', $arr['evaluator_su_sj_name'])
                ->setCellValue('C9', $arr['evaluator_su_sdp_name']);    
        }

        $sheet
            ->setCellValue('H5', $arr['skp_su_fullname'])
            ->setCellValue('H6', $arr['skp_su_no'])
            ->setCellValue('H7', $arr['skp_su_grade'])
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
        }

        if ($insert == 0) {
            $row += 2;
        }

        $sheet
            ->setCellValue('G'.($row + 1), 'Jakarta, '.$today->format('d F Y'));

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
        }

        if ($insert == 0) {
            $row += 2;
        }

        $row += 1;
        $num = 1;

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

        }

        if ($insert == 0) {
            $row += 2;
        }

        $sheet->setCellValue('R'.($row + 1), $arr['skp_performance']);
        $sheet->setCellValue('R'.($row + 2), $arr['skp_performance_criteria_text']);
        $sheet->setCellValue('M'.($row + 4), 'Jakarta, '.$today->format('d F Y'));

        if ($skp->evaluator) {
            $sheet->setCellValue('M'.($row + 8), $arr['evaluator_su_fullname']);
            $sheet->setCellValue('M'.($row + 9), $arr['evaluator_su_no']);    
        }

        // PERILAKU
        $end = DateHelper::create($arr['skp_end_date']);

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
        }

        if ($insert == 0) {
            $row += 2;
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
            ->setCellValue('G16', $arr['skp_su_grade'])
            ->setCellValue('G17', $arr['skp_su_sj_name'])
            ->setCellValue('G18', $arr['skp_su_sdp_name']);

        if ($skp->evaluator) {
            $sheet
                ->setCellValue('G20', $arr['evaluator_su_fullname'])
                ->setCellValue('G21', $arr['evaluator_su_no'])
                ->setCellValue('G22', $arr['evaluator_su_grade'])
                ->setCellValue('G23', $arr['evaluator_su_sj_name'])
                ->setCellValue('G24', $arr['evaluator_su_sdp_name']);    
        }

        if ($skp->superior) {
            $sheet
                ->setCellValue('G26', $arr['superior_su_fullname'])
                ->setCellValue('G27', $arr['superior_su_no'])
                ->setCellValue('G28', $arr['superior_su_grade'])
                ->setCellValue('G29', $arr['superior_su_sj_name'])
                ->setCellValue('G30', $arr['superior_su_sdp_name']);    
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
        }

        if ($insert == 0) {
            $row += 2;
        }

        $sheet->setCellValue('H'.$row, $arr['skp_behavior_total']);
        $sheet->setCellValue('H'.($row + 1), $arr['skp_behavior_average']);
        $sheet->setCellValue('I'.($row + 1), $arr['skp_behavior_criteria_text']);
        $sheet->setCellValue('H'.($row + 2), $arr['skp_behavior_average']);
        $sheet->setCellValue('I'.($row + 2), ' X '.$arr['skp_behavior_portion'].'%');
        $sheet->setCellValue('J'.($row + 2), $arr['skp_behavior_value']);
        $sheet->setCellValue('J'.($row + 3), $arr['skp_value']);
        $sheet->setCellValue('J'.($row + 4), $arr['skp_criteria_text']);

        if ( ! empty($arr['skp_report_dt'])) {
            $date = DateHelper::create($arr['skp_report_dt']);
            $sheet->setCellValue('H'.($row + 87), 'DIBUAT TANGGAL, '.strtoupper($date->format('d F Y')));
        }

        if ( ! empty($arr['skp_receive_dt'])) {
            $date = DateHelper::create($arr['skp_receive_dt']);
            $sheet->setCellValue('B'.($row + 96), 'DITERIMA TANGGAL, '.strtoupper($date->format('d F Y')));
            $sheet->setCellValue('H'.($row + 106), 'DITERIMA TANGGAL, '.strtoupper($date->format('d F Y')));
        }

        if ($skp->evaluator) {
            $sheet->setCellValue('H'.($row + 93), $arr['evaluator_su_fullname']);
            $sheet->setCellValue('H'.($row + 94), $arr['evaluator_su_no']);
        }

        $sheet->setCellValue('B'.($row + 103), $arr['skp_su_fullname']);
        $sheet->setCellValue('B'.($row + 104), $arr['skp_su_no']);

        if ($skp->superior) {
            $sheet->setCellValue('H'.($row + 112), $arr['superior_su_fullname']);
            $sheet->setCellValue('H'.($row + 113), $arr['superior_su_no']);
        }

        $xls->setActiveSheetIndex(0);

        $file = strtolower($skp->getTitle());
        $file = preg_replace('/[^a-z0-9]+/i', '_', $file).'.xlsx';

        $xls->stream($file);
    }

}
