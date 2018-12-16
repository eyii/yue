<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-11
 * Time: 下午12:05
 */

namespace common\models;

use Yii;
use yii\base\Model;
use yii\web\UploadedFile;



class UploadForm extends Model{


    /**
     * @var UploadedFile
     */
    public $file;



    public function rules()
    {
        return [
            [['file'], 'file','extensions' => 'xls,xlsx','checkExtensionByMimeType' => false],
        ];
    }

     function upload(){
       $this->file = UploadedFile::getInstance($this, 'file');
        if (!$this->validate())return false;
        $newName = 'uploads/' . $this->file->baseName . '.' . $this->file->extension;
        $this->file->saveAs($newName);
        return true;


    }


     function uploadMultiple()
    {
        if (!$this->validate())return false;

        foreach ($this->multiple as $file) {

            $newName = 'uploads/' . $file->baseName . '.' . $file->extension;
            $file->saveAs($newName);
        }
       return true;

    }

    function getFilePath(&$fileName,$ext='xls'){
        $ext=   $this->fileIsNull()?$ext:$this->file->extension;
        $baseName =Yii::$app->request->post('filename');
        $fileName='uploads/' . $baseName . '.'. $ext;
        return $fileName;
    }


    function  fileIsNull(){
        $this->file = UploadedFile::getInstance($this, 'file');
        return $this->file==null;
    }
}