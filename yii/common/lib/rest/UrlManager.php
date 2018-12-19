<?php
/**
 * Created by IntelliJ IDEA.
 * User: root
 * Date: 18-12-18
 * Time: 下午2:05
 */

namespace common\lib\rest;
use Yii;
use yii\base\Component;
use yii\base\InvalidConfigException;
use yii\caching\CacheInterface;
use yii\helpers\Url;
use yii\web\Request;
use yii\web\UrlNormalizer;
use yii\web\UrlRuleInterface;

class UrlManager extends \yii\web\UrlManager
{
    public $enablePrettyUrl = false;

    public $enableStrictParsing = false;

    public $rules = [];

    public $suffix;

    public $showScriptName = true;

    public $routeParam = 'r';

    public $cache = 'cache';

    public $ruleConfig = ['class' => 'yii\web\UrlRule'];

    public $normalizer = false;

    protected $cacheKey = __CLASS__;

    private $_baseUrl;
    private $_scriptUrl;
    private $_hostInfo;
    private $_ruleCache;



    public function init()
    {
        parent::init();

        if ($this->normalizer !== false) {
            $this->normalizer = Yii::createObject($this->normalizer);
            if (!$this->normalizer instanceof UrlNormalizer) throw new InvalidConfigException('`' . get_class($this) . '::normalizer` should be an instance of `' . UrlNormalizer::className() . '` or its DI compatible configuration.');

        }

        if (!$this->enablePrettyUrl) return;

        if (is_string($this->cache)) $this->cache = Yii::$app->get($this->cache, false);

        if (empty($this->rules)) return;

        $this->rules = $this->buildRules($this->rules);
    }


    public function addRules($rules, $append = true)
    {
        if (!$this->enablePrettyUrl) return;

        $rules = $this->buildRules($rules);
        if ($append) $this->rules = array_merge($this->rules, $rules);
         else $this->rules = array_merge($rules, $this->rules);

    }

    protected function buildRules($ruleDeclarations)
    {
        $builtRules = $this->getBuiltRulesFromCache($ruleDeclarations);
        if ($builtRules !== false) return $builtRules;


        $builtRules = [];
        $verbs = 'GET|HEAD|POST|PUT|PATCH|DELETE|OPTIONS';
        foreach ($ruleDeclarations as $key => $rule) {
            if (is_string($rule)) {
                $rule = ['route' => $rule];
                if (preg_match("/^((?:($verbs),)*($verbs))\\s+(.*)$/", $key, $matches)) {
                    $rule['verb'] = explode(',', $matches[1]);

                    if (!in_array('GET', $rule['verb'], true)) $rule['mode'] = UrlRule::PARSING_ONLY;

                    $key = $matches[4];
                }
                $rule['pattern'] = $key;
            }
            if (is_array($rule)) $rule = Yii::createObject(array_merge($this->ruleConfig, $rule));

            if (!$rule instanceof UrlRuleInterface) throw new InvalidConfigException('URL rule class must implement UrlRuleInterface.');

            $builtRules[] = $rule;
        }

        $this->setBuiltRulesCache($ruleDeclarations, $builtRules);

        return $builtRules;
    }


    protected function setBuiltRulesCache($ruleDeclarations, $builtRules)
    {
        if (!$this->cache instanceof CacheInterface) return false;


        return $this->cache->set([$this->cacheKey, $this->ruleConfig, $ruleDeclarations], $builtRules);
    }


    protected function getBuiltRulesFromCache($ruleDeclarations)
    {
        if (!$this->cache instanceof CacheInterface) return false;


        return $this->cache->get([$this->cacheKey, $this->ruleConfig, $ruleDeclarations]);
    }


    public function parseRequest($request)
    {
        if ($this->enablePrettyUrl) {
            /* @var $rule UrlRule */
            foreach ($this->rules as $rule) {
                $result = $rule->parseRequest($this, $request);
                if (YII_DEBUG) {
                    Yii::debug([
                        'rule' => method_exists($rule, '__toString') ? $rule->__toString() : get_class($rule),
                        'match' => $result !== false,
                        'parent' => null,
                    ], __METHOD__);
                }
                if ($result !== false) return $result;

            }

            if ($this->enableStrictParsing) return false;


            Yii::debug('No matching URL rules. Using default URL parsing logic.', __METHOD__);

            $suffix = (string) $this->suffix;
            $pathInfo = $request->getPathInfo();
            $normalized = false;
            if ($this->normalizer !== false) $pathInfo = $this->normalizer->normalizePathInfo($pathInfo, $suffix, $normalized);

            if ($suffix !== '' && $pathInfo !== '') {
                $n = strlen($this->suffix);
                if (substr_compare($pathInfo, $this->suffix, -$n, $n) === 0) {
                    $pathInfo = substr($pathInfo, 0, -$n);
                    if ($pathInfo === '') return false;

                } else {
                    // suffix doesn't match
                    return false;
                }
            }

            if ($normalized) {
                // pathInfo was changed by normalizer - we need also normalize route
                return $this->normalizer->normalizeRoute([$pathInfo, []]);
            }

            return [$pathInfo, []];
        }

        Yii::debug('Pretty URL not enabled. Using default URL parsing logic.', __METHOD__);
        $route = $request->getQueryParam($this->routeParam, '');
        if (is_array($route)) $route = '';


        return [(string) $route, []];
    }


    public function createUrl($params)
    {
        $params = (array) $params;
        $anchor = isset($params['#']) ? '#' . $params['#'] : '';
        unset($params['#'], $params[$this->routeParam]);

        $route = trim($params[0], '/');
        unset($params[0]);

        $baseUrl = $this->showScriptName || !$this->enablePrettyUrl ? $this->getScriptUrl() : $this->getBaseUrl();

        if ($this->enablePrettyUrl) {
            $cacheKey = $route . '?';
            foreach ($params as $key => $value) if ($value !== null) $cacheKey .= $key . '&';



            $url = $this->getUrlFromCache($cacheKey, $route, $params);
            if ($url === false) {
                /* @var $rule UrlRule */
                foreach ($this->rules as $rule) {
                    if (in_array($rule, $this->_ruleCache[$cacheKey], true)) continue;

                    $url = $rule->createUrl($this, $route, $params);
                    if ($this->canBeCached($rule)) $this->setRuleToCache($cacheKey, $rule);

                    if ($url !== false) break;

                }
            }

            if ($url !== false) {
                if (strpos($url, '://') !== false) {
                    if ($baseUrl !== '' && ($pos = strpos($url, '/', 8)) !== false) return substr($url, 0, $pos) . $baseUrl . substr($url, $pos) . $anchor;
                    return $url . $baseUrl . $anchor;
                } elseif (strncmp($url, '//', 2) === 0) {
                    if ($baseUrl !== '' && ($pos = strpos($url, '/', 2)) !== false) return substr($url, 0, $pos) . $baseUrl . substr($url, $pos) . $anchor;


                    return $url . $baseUrl . $anchor;
                }

                $url = ltrim($url, '/');
                return "$baseUrl/{$url}{$anchor}";
            }
            if ($this->suffix !== null) $route .= $this->suffix;

            if (!empty($params) && ($query = http_build_query($params)) !== '') $route .= '?' . $query;


            $route = ltrim($route, '/');
            return "$baseUrl/{$route}{$anchor}";
        }

        $url = "$baseUrl?{$this->routeParam}=" . urlencode($route);
        if (!empty($params) && ($query = http_build_query($params)) !== '') {
            $url .= '&' . $query;
        }

        return $url . $anchor;
    }


    protected function canBeCached(UrlRuleInterface $rule)
    {
        return
            !method_exists($rule, 'getCreateUrlStatus') || ($status = $rule->getCreateUrlStatus()) === null
            || $status === UrlRule::CREATE_STATUS_SUCCESS
            || $status & UrlRule::CREATE_STATUS_PARAMS_MISMATCH;
    }

    protected function getUrlFromCache($cacheKey, $route, $params)
    {
        if (!empty($this->_ruleCache[$cacheKey])) {
            foreach ($this->_ruleCache[$cacheKey] as $rule) if (($url = $rule->createUrl($this, $route, $params)) !== false) return $url;


        } else $this->_ruleCache[$cacheKey] = [];


        return false;
    }


    protected function setRuleToCache($cacheKey, UrlRuleInterface $rule)
    {
        $this->_ruleCache[$cacheKey][] = $rule;
    }


    public function createAbsoluteUrl($params, $scheme = null)
    {
        $params = (array) $params;
        $url = $this->createUrl($params);
        if (strpos($url, '://') === false) {
            $hostInfo = $this->getHostInfo();
            if (strncmp($url, '//', 2) === 0) $url = substr($hostInfo, 0, strpos($hostInfo, '://')) . ':' . $url;
             else $url = $hostInfo . $url;

        }

        return Url::ensureScheme($url, $scheme);
    }


    public function getBaseUrl()
    {
        if ($this->_baseUrl === null) {
            $request = Yii::$app->getRequest();
            if ($request instanceof Request)
                $this->_baseUrl = $request->getBaseUrl();
             else throw new InvalidConfigException('Please configure UrlManager::baseUrl correctly as you are running a console application.');
        }

        return $this->_baseUrl;
    }

    public function setBaseUrl($value)
    {
        $this->_baseUrl = $value === null ? null : rtrim(Yii::getAlias($value), '/');
    }


    public function getScriptUrl()
    {
        if ($this->_scriptUrl === null) {
            $request = Yii::$app->getRequest();
            if ($request instanceof Request) {
                $this->_scriptUrl = $request->getScriptUrl();
            } else {
                throw new InvalidConfigException('Please configure UrlManager::scriptUrl correctly as you are running a console application.');
            }
        }

        return $this->_scriptUrl;
    }


    public function setScriptUrl($value)
    {
        $this->_scriptUrl = $value;
    }


    public function getHostInfo()
    {
        if ($this->_hostInfo === null) {
            $request = Yii::$app->getRequest();
            if ($request instanceof \yii\web\Request) {
                $this->_hostInfo = $request->getHostInfo();
            } else {
                throw new InvalidConfigException('Please configure UrlManager::hostInfo correctly as you are running a console application.');
            }
        }

        return $this->_hostInfo;
    }


     function setHostInfo($value){
        $this->_hostInfo = $value === null ? null : rtrim($value, '/');
    }
}