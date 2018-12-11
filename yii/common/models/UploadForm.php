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

    public $single;


    public $multiple;


     function rules(){
        return [
            [['single'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png, jpg'],
            [['multiple'], 'file', 'skipOnEmpty' => false, 'extensions' => 'png, jpg','maxFiles' => 4],
        ];
    }

     function upload(){
        if (!$this->validate())return false;
        $newName = 'uploads/' . $this->single->baseName . '.' . $this->single->extension;
        $this->single->saveAs($newName);
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