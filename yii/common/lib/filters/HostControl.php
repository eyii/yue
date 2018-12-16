<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace yii\filters;

use Yii;
use yii\base\ActionFilter;
use yii\helpers\StringHelper;
use yii\web\NotFoundHttpException;


class HostControl extends ActionFilter
{

    public $allowedHosts;

    public $denyCallback;

    public $fallbackHostInfo = '';


    /**
     * {@inheritdoc}
     */
    public function beforeAction($action)
    {
        $allowedHosts = $this->allowedHosts;
        if ($allowedHosts instanceof \Closure) {
            $allowedHosts = call_user_func($allowedHosts, $action);
        }
        if ($allowedHosts === null) {
            return true;
        }

        if (!is_array($allowedHosts) && !$allowedHosts instanceof \Traversable) {
            $allowedHosts = (array) $allowedHosts;
        }

        $currentHost = Yii::$app->getRequest()->getHostName();

        foreach ($allowedHosts as $allowedHost) {
            if (StringHelper::matchWildcard($allowedHost, $currentHost)) {
                return true;
            }
        }

        // replace invalid host info to prevent using it in further processing
        if ($this->fallbackHostInfo !== null) {
            Yii::$app->getRequest()->setHostInfo($this->fallbackHostInfo);
        }

        if ($this->denyCallback !== null) {
            call_user_func($this->denyCallback, $action);
        } else {
            $this->denyAccess($action);
        }

        return false;
    }

    /**
     * Denies the access.
     * The default implementation will display 404 page right away, terminating the program execution.
     * You may override this method, creating your own deny access handler. While doing so, make sure you
     * avoid usage of the current requested host name, creation of absolute URL links, caching page parts and so on.
     * @param \yii\base\Action $action the action to be executed.
     * @throws NotFoundHttpException
     */
    protected function denyAccess($action)
    {
        $exception = new NotFoundHttpException(Yii::t('yii', 'Page not found.'));

        // use regular error handling if $this->fallbackHostInfo was set
        if (!empty(Yii::$app->getRequest()->hostName)) {
            throw $exception;
        }

        $response = Yii::$app->getResponse();
        $errorHandler = Yii::$app->getErrorHandler();

        $response->setStatusCode($exception->statusCode, $exception->getMessage());
        $response->data = $errorHandler->renderFile($errorHandler->errorView, ['exception' => $exception]);
        $response->send();

        Yii::$app->end();
    }
}
