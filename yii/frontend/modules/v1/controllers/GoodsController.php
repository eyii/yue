<?php
namespace frontend\modules\v1\controllers;



use common\controllers\ActiveController;
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class GoodsController extends ActiveController
{
    public $modelClass = 'common\models\User';

     function actionSearch(){
         header("Content-type:application/vnd.ms-excel");  //excel头信息
         header("Content-Disposition:attachment;filename=world.xls");
         $spreadsheet = new Spreadsheet();
         $sheet = $spreadsheet->getActiveSheet();
         $sheet->setCellValue('A1', 'Hello World !');

         $writer = new Xlsx($spreadsheet);
        $result =$writer->save('world.xlsx');
       return ['error_code'    => 20, 'msg'=> $result,];
    }
}

