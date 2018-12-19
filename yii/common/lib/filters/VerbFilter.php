<?php



namespace common\lib\filters;
use Yii;
use yii\base\ActionEvent;
use yii\base\Behavior;
use yii\web\Controller;
use yii\web\MethodNotAllowedHttpException;


class VerbFilter extends \yii\filters\VerbFilter
{

    public $actions = [];



     function events(){
        return [Controller::EVENT_BEFORE_ACTION => 'beforeAction'];
    }

    function beforeAction($event){
        $action = $event->action->id;
        if (isset($this->actions[$action]))  $verbs = $this->actions[$action];
         elseif (isset($this->actions['*'])) $verbs = $this->actions['*'];
         else                                return $event->isValid;


        $verb = Yii::$app->getRequest()->getMethod();
        $allowed = array_map('strtoupper', $verbs);
        if (in_array($verb, $allowed))  return $event->isValid;
        $event->isValid = false;
        Yii::$app->getResponse()->getHeaders()->set('Allow', implode(', ', $allowed));
        throw new MethodNotAllowedHttpException('Method Not Allowed. This URL can only handle the following request methods: ' . implode(', ', $allowed) . '.');

    }
}
