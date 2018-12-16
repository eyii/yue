<?php
/**
 * @link http://www.yiiframework.com/
 * @copyright Copyright (c) 2008 Yii Software LLC
 * @license http://www.yiiframework.com/license/
 */

namespace yii\filters;

use Yii;
use yii\base\ActionFilter;
use yii\web\Request;
use yii\web\Response;
use yii\web\TooManyRequestsHttpException;

class RateLimiter extends ActionFilter
{

    public $enableRateLimitHeaders = true;

    public $errorMessage = 'Rate limit exceeded.';
    /**
     * @var RateLimitInterface the user object that implements the RateLimitInterface.
     * If not set, it will take the value of `Yii::$app->user->getIdentity(false)`.
     */
    public $user;
    /**
     * @var Request the current request. If not set, the `request` application component will be used.
     */
    public $request;
    /**
     * @var Response the response to be sent. If not set, the `response` application component will be used.
     */
    public $response;


    /**
     * {@inheritdoc}
     */
    public function init()
    {
        if ($this->request === null) $this->request = Yii::$app->getRequest();

        if ($this->response === null) $this->response = Yii::$app->getResponse();

    }

    /**
     * {@inheritdoc}
     */
    public function beforeAction($action)
    {
        if ($this->user === null && Yii::$app->getUser()) $this->user = Yii::$app->getUser()->getIdentity(false);


        if ($this->user instanceof RateLimitInterface) {
            Yii::debug('Check rate limit', __METHOD__);
            $this->checkRateLimit($this->user, $this->request, $this->response, $action);
        } elseif ($this->user) Yii::info('Rate limit skipped: "user" does not implement RateLimitInterface.', __METHOD__);
        else Yii::info('Rate limit skipped: user not logged in.', __METHOD__);


        return true;
    }


    public function checkRateLimit($user, $request, $response, $action)
    {
        list($limit, $window) = $user->getRateLimit($request, $action);
        list($allowance, $timestamp) = $user->loadAllowance($request, $action);

        $current = time();

        $allowance += (int) (($current - $timestamp) * $limit / $window);
        if ($allowance > $limit) $allowance = $limit;


        if ($allowance < 1) {
            $user->saveAllowance($request, $action, 0, $current);
            $this->addRateLimitHeaders($response, $limit, 0, $window);
            throw new TooManyRequestsHttpException($this->errorMessage);
        }

        $user->saveAllowance($request, $action, $allowance - 1, $current);
        $this->addRateLimitHeaders($response, $limit, $allowance - 1, (int) (($limit - $allowance + 1) * $window / $limit));
    }


     function addRateLimitHeaders($response, $limit, $remaining, $reset){
        if ($this->enableRateLimitHeaders)
            $response->getHeaders()
            ->set('X-Rate-Limit-Limit', $limit)
            ->set('X-Rate-Limit-Remaining', $remaining)
            ->set('X-Rate-Limit-Reset', $reset);

    }
}
