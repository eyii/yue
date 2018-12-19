<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-10
 * Time: 下午5:30
 */

namespace frontend\models;


use Yii;
use yii\behaviors\TimestampBehavior;
use yii\db\ActiveRecord;
use yii\web\IdentityInterface;

/**
 * This is the model class for table "member".
 *
 * @property int $id
 * @property string $username
 * @property string $auth_key
 * @property string $passwor_hash
 * @property string $passwor_reset_token
 * @property string $email
 * @property int $status
 * @property string $access_token
 * @property int $created_at
 * @property int $updated_at
 */


class User extends ActiveRecord implements IdentityInterface
{

    const STATUS_DELETED = 0;
    const STATUS_ACTIVE = 10;


    /**
     * @inheritdoc
     */
    public static function tableName()
    {
        return '{{%user}}';
    }

    /**
     * @inheritdoc
     */
    public function behaviors()
    {
        return [
            TimestampBehavior::className(),
        ];
    }

    # 生成access_token
    public function generateAccessToken()
    {
        $this->access_token = Yii::$app->security->generateRandomString();
    }

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            ['status', 'default', 'value' => self::STATUS_ACTIVE],
            ['status', 'in', 'range' => [self::STATUS_ACTIVE, self::STATUS_DELETED]],
        ];
    }

    /**
     * @inheritdoc
     */
    public static function findIdentity($id)
    {
        return static::findOne(['id' => $id, 'status' => self::STATUS_ACTIVE]);
    }




    public static function findIdentityByAccessToken($token, $type = null)
    {

        return static::findOne(['access_token' => $token]);
    }


    public static function findByUsername($username)
    {
        return static::findOne(['username' => $username, 'status' => self::STATUS_ACTIVE]);
    }


     static function findByPasswordResetToken($token)
    {
        if (!static::isPasswordResetTokenValid($token)) return null;
        return static::findOne(['password_reset_token' => $token, 'status' => self::STATUS_ACTIVE,]);
    }


     static function isPasswordResetTokenValid($token){
        if (empty($token)) return false;
        $timestamp = (int) substr($token, strrpos($token, '_') + 1);
        $expire = Yii::$app->params['user.tokenExpire'];
        return $timestamp + $expire >= time();
    }


     function getId(){
        return $this->getPrimaryKey();
    }

     function getAuthKey(){
        return $this->auth_key;
    }
    function validateAuthKey($authKey){
        return $this->getAuthKey() === $authKey;
    }

    function validatePassword($password){
          return Yii::$app->security->validatePassword($password, $this->password_hash);
    }

     function setPassword($password){
        $this->password_hash = Yii::$app->security->generatePasswordHash($password);
    }

     function generateAuthKey(){
        $this->auth_key = Yii::$app->security->generateRandomString();
    }
    function generatePasswordResetToken(){
        $this->password_reset_token = Yii::$app->security->generateRandomString() . '_' . time();
    }
     function removePasswordResetToken(){
        $this->password_reset_token = null;
    }

    public function beforeSave($insert)
    {
        if (!parent::beforeSave($insert))  return false;
         if ($this->isNewRecord) {
             $this->generateAuthKey();
             $this->generateAccessToken();
         }
         return true;
    }
    static function loginByAccessToken($token,$type){
        return   static::findIdentityByAccessToken($token,$type);
    }
}




