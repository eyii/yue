<?php

namespace common\models;

use Yii;

/**
 * This is the model class for table "{{%menu}}".
 *
 * @property int $id
 * @property int $parent
 * @property string $path
 * @property string $component
 * @property resource $name
 * @property string $icon
 * @property int $hidden
 * @property string $redirect
 */
class Menu extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return '{{%menu}}';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['parent', 'hidden'], 'integer'],
            [['path', 'redirect'], 'string', 'max' => 255],
            [['component', 'name'], 'string', 'max' => 200],
            [['icon'], 'string', 'max' => 100],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => Yii::t('app', 'ID'),
            'parent' => Yii::t('app', 'Parent'),
            'path' => Yii::t('app', 'Path'),
            'component' => Yii::t('app', 'Component'),
            'name' => Yii::t('app', 'Name'),
            'icon' => Yii::t('app', 'Icon'),
            'hidden' => Yii::t('app', 'Hidden'),
            'redirect' => Yii::t('app', 'Redirect'),
        ];
    }
}
