<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-11
 * Time: 下午12:05
 */

namespace common\models;

use yii\base\Model;
use yii\web\UploadedFile;


class UploadForm extends Model{



    public $file;



    public function rules()
    {
        return [
            [['file'], 'file'],
        ];
    }

     function upload(){
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

}