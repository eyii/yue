<?php


namespace frontend\modules\v1\controllers;


use common\controllers\ActiveController;
use common\lib\result\MsgAbort;
use common\lib\result\MsgOk;
use common\models\UploadForm;

use PhpOffice\PhpSpreadsheet\IOFactory;

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use Yii;


class UploadController extends ActiveController
{
    public $modelClass = 'common\models\Goods';



     function actionUpload(){
         $model = new UploadForm();
        if (!Yii::$app->request->isPost)                         return  new MsgAbort('非法访问',-20);
         if ($model->getFIle()||!$model->validate())            return new MsgAbort('非法文件',-20);
         $model->getFilePath($fileName);
         $model->file->saveAs($fileName);
         $result=  $this->actionRead($fileName);
         return !empty($result)?  new MsgOk("上传成功",200,$result):new MsgAbort('保存文件失败');

    }

    function actionWrite(){
        $spreadsheet = new Spreadsheet();
        $spreadsheet->getProperties()->setCreator('Yue')
            ->setLastModifiedBy('Yue')
            ->setTitle('Office 2007 XLSX Test Document')
            ->setSubject('Office 2007 XLSX Test Document')
            ->setKeywords('office 2007 openxml php')
            ->setCategory('Test result file');

        // Add some data
        $spreadsheet->setActiveSheetIndex(0)
            ->setCellValue('A1', 'Hello')
            ->setCellValue('B2', 'world!')
            ->setCellValue('C1', 'Hello')
            ->setCellValue('D2', 'world!');

        // Miscellaneous glyphs, UTF-8
        $spreadsheet->setActiveSheetIndex(0)->setCellValue('A4', 'Miscellaneous glyphs')->setCellValue('A5', 'éàèùâêîôûëïüÿäöüç');

        // Rename worksheet
        $spreadsheet->getActiveSheet()->setTitle('Simple');

        // Set active sheet index to the first sheet, so Excel opens this as the first sheet
        $spreadsheet->setActiveSheetIndex(0);

        // Redirect output to a client’s web browser (Xlsx)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="01simple.xlsx"');
        header('Cache-Control: max-age=0');

        header('Cache-Control: max-age=1');

        header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
        header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT');
        header('Cache-Control: cache, must-revalidate');
        header('Pragma: public');

        $writer = IOFactory::createWriter($spreadsheet, 'Xlsx');
        $writer->save('php://output');
    }

    function actionRead($fileName =  'uploads/data.xls',$type= 'Xls'){

        $reader = IOFactory::createReader($type);
        $reader->setReadDataOnly(true);
        $spreadsheet = $reader->load($fileName);
        $data = $spreadsheet->getActiveSheet()->toArray(null, true, true, true);
        if (!is_array($data))return false;
       // array_pop($data);
        return $data;
    }
}