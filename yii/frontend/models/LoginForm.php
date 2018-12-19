<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-18
 * Time: 上午10:27
 */

namespace frontend\models;



use Yii;
use yii\base\Model;

class LoginForm extends Model
{
    public $username;
    public $password;
    public $rememberMe = true;

    private $_user;


    function rules(){
        return [
            [['username', 'password'], 'required'],
            ['rememberMe', 'boolean'],
            ['password', 'validatePassword'],
        ];
    }

   function validatePassword($attribute, $params){
        if ($this->hasErrors()) return ;
        $user = $this->getUser();
      (!$user || !$user->validatePassword($this->password))&& $this->addError($attribute, 'Incorrect username or password.');


    }

     function login(){
        if (!$this->validate()) return false;
       return Yii::$app->user->login($this->getUser(), $this->rememberMe ? 3600 * 24 * 30 : 0);

    }




     function getUser(){
     $this->_user === null&& $this->_user = User::findByUsername($this->username);
     return $this->_user;
    }


   function getToken(){
    $user= $this->getUser();
    return $user== null ? null: $user->access_token;
   }

}

