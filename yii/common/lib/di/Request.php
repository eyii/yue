<?php
namespace common\lib\di;
use Yii;
use yii\base\InvalidConfigException;
use yii\validators\IpValidator;
use yii\web\CookieCollection;
use yii\web\HeaderCollection;
use yii\web\NotFoundHttpException;
use yii\web\RequestParserInterface;

class Request extends \yii\web\Request
{

    const CSRF_HEADER = 'X-CSRF-Token';

    const CSRF_MASK_LENGTH = 8;


    public $enableCsrfValidation = true;

    public $csrfParam = '_csrf';

    public $csrfCookie = ['httpOnly' => true];

    public $enableCsrfCookie = true;

    public $enableCookieValidation = true;

    public $cookieValidationKey;

    public $methodParam = '_method';

    public $parsers = [];

    public $trustedHosts = [];

    public $secureHeaders = [

        'X-Forwarded-For',
        'X-Forwarded-Host',
        'X-Forwarded-Proto',

        // Microsoft:
        'Front-End-Https',
        'X-Rewrite-Url',
    ];

    public $ipHeaders = [
        'X-Forwarded-For',
    ];

    public $secureProtocolHeaders = [
        'X-Forwarded-Proto' => ['https'],
        'Front-End-Https' => ['on'],
    ];

    /**
     * @var CookieCollection
     */
    private $_cookies;
    /**
     * @var HeaderCollection Collection of request headers.
     */
    private $_headers;


     function resolve(){
        $result = Yii::$app->getUrlManager()->parseRequest($this);
        if ($result !== false) {
            list($route, $params) = $result;
            if ($this->_queryParams === null)   $_GET = $params + $_GET; // preserve numeric keys
            else                                $this->_queryParams = $params + $this->_queryParams;

            return [$route, $this->getQueryParams()];
        }

        throw new NotFoundHttpException(Yii::t('yii', 'Page not found.'));
    }


    protected function filterHeaders(HeaderCollection $headerCollection)
    {
        // do not trust any of the [[secureHeaders]] by default
        $trustedHeaders = [];


        if (!empty($this->trustedHosts)) {
            $validator = $this->getIpValidator();
            $ip = $this->getRemoteIP();
            foreach ($this->trustedHosts as $cidr => $headers) {
                if (!is_array($headers)) {
                    $cidr = $headers;
                    $headers = $this->secureHeaders;
                }
                $validator->setRanges($cidr);
                if ($validator->validate($ip)) {
                    $trustedHeaders = $headers;
                    break;
                }
            }
        }

        // filter all secure headers unless they are trusted
        foreach ($this->secureHeaders as $secureHeader) if (!in_array($secureHeader, $trustedHeaders)) $headerCollection->remove($secureHeader);


    }


    protected function getIpValidator()
    {
        return new IpValidator();
    }

     function getHeaders(){
        if ($this->_headers !== null)  return $this->_headers;
        $this->_headers = new HeaderCollection();
        if (function_exists('getallheaders')) {
            $headers = getallheaders();
            foreach ($headers as $name => $value) $this->_headers->add($name, $value);

        } elseif (function_exists('http_get_request_headers')) {
            $headers = http_get_request_headers();
            foreach ($headers as $name => $value) $this->_headers->add($name, $value);

        } else {
            foreach ($_SERVER as $name => $value) {
                if (strncmp($name, 'HTTP_', 5) !== 0) continue;
                $name = str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))));
                $this->_headers->add($name, $value);

            }
        }
        $this->filterHeaders($this->_headers);


        return $this->_headers;
    }

     function getMethod(){
        if (isset($_POST[$this->methodParam]))              return strtoupper($_POST[$this->methodParam]);
        if ($this->headers->has('X-Http-Method-Override'))  return strtoupper($this->headers->get('X-Http-Method-Override'));
        if (isset($_SERVER['REQUEST_METHOD']))              return strtoupper($_SERVER['REQUEST_METHOD']);


        return 'GET';
    }


     function getIsGet(){
        return $this->getMethod() === 'GET';
    }


     function getIsOptions(){
        return $this->getMethod() === 'OPTIONS';
    }


     function getIsHead(){
        return $this->getMethod() === 'HEAD';
    }


     function getIsPost(){
        return $this->getMethod() === 'POST';
    }


     function getIsDelete(){
        return $this->getMethod() === 'DELETE';
    }


     function getIsPut(){
        return $this->getMethod() === 'PUT';
    }


     function getIsPatch(){
        return $this->getMethod() === 'PATCH';
    }


     function getIsAjax(){
        return $this->headers->get('X-Requested-With') === 'XMLHttpRequest';
    }


     function getIsPjax(){
        return $this->getIsAjax() && $this->headers->has('X-Pjax');
    }


     function getIsFlash(){
        $userAgent = $this->headers->get('User-Agent', '');
        return stripos($userAgent, 'Shockwave') !== false || stripos($userAgent, 'Flash') !== false;
    }

    private $_rawBody;

     function getRawBody(){
        $this->_rawBody === null&& $this->_rawBody = file_get_contents('php://input');
        return $this->_rawBody;
    }


     function setRawBody($rawBody){
        $this->_rawBody = $rawBody;
    }

    private $_bodyParams;


    public function getBodyParams()
    {
        if ($this->_bodyParams !== null) return $this->_bodyParams;
        if (isset($_POST[$this->methodParam])) {
            $this->_bodyParams = $_POST;
            unset($this->_bodyParams[$this->methodParam]);
            return $this->_bodyParams;
        }

        $rawContentType = $this->getContentType();
        $contentType =  ($pos = strpos($rawContentType, ';')) !== false? substr($rawContentType, 0, $pos): $rawContentType;


        if (isset($this->parsers[$contentType])) {
                                                            $parser = Yii::createObject($this->parsers[$contentType]);
                                                            if (!($parser instanceof RequestParserInterface)) throw new InvalidConfigException("The '$contentType' request parser is invalid. It must implement the yii\\web\\RequestParserInterface.");

                                                              $this->_bodyParams = $parser->parse($this->getRawBody(), $rawContentType);
        } elseif (isset($this->parsers['*'])) {
                                                            $parser = Yii::createObject($this->parsers['*']);
                                                            if (!($parser instanceof RequestParserInterface)) throw new InvalidConfigException('The fallback request parser is invalid. It must implement the yii\\web\\RequestParserInterface.');

                                                            $this->_bodyParams = $parser->parse($this->getRawBody(), $rawContentType);
        } elseif ($this->getMethod() === 'POST')            $this->_bodyParams = $_POST;
        else {
                                                            $this->_bodyParams = [];
                                                            mb_parse_str($this->getRawBody(), $this->_bodyParams);
        }

        return $this->_bodyParams;
    }


     function setBodyParams($values){
        $this->_bodyParams = $values;
    }


     function getBodyParam($name, $defaultValue = null){
        $params = $this->getBodyParams();

        if (is_object($params)) {
            // unable to use `ArrayHelper::getValue()` due to different dots in key logic and lack of exception handling
            try {
                return $params->{$name};
            } catch (\Exception $e) {
                return $defaultValue;
            }
        }

        return isset($params[$name]) ? $params[$name] : $defaultValue;
    }


     function post($name = null, $defaultValue = null){
        if ($name === null) return $this->getBodyParams();
        return $this->getBodyParam($name, $defaultValue);
    }

    private $_queryParams;

    function getQueryParams(){
        if ($this->_queryParams === null) return $_GET;
        return $this->_queryParams;
    }


     function setQueryParams($values){
        $this->_queryParams = $values;
    }


     function get($name = null, $defaultValue = null){
        if ($name === null) return $this->getQueryParams();
        return $this->getQueryParam($name, $defaultValue);
    }


     function getQueryParam($name, $defaultValue = null){
        $params = $this->getQueryParams();
        return isset($params[$name]) ? $params[$name] : $defaultValue;
    }

    private $_hostInfo;
    private $_hostName;


    public function getHostInfo()
    {
        if ($this->_hostInfo !== null)   return $this->_hostInfo;
            $secure = $this->getIsSecureConnection();
            $http = $secure ? 'https' : 'http';

            if ($this->headers->has('X-Forwarded-Host'))                    $this->_hostInfo = $http . '://' . $this->headers->get('X-Forwarded-Host');
             elseif ($this->headers->has('Host'))                           $this->_hostInfo = $http . '://' . $this->headers->get('Host');
             elseif (isset($_SERVER['SERVER_NAME'])) {
                                                                            $this->_hostInfo = $http . '://' . $_SERVER['SERVER_NAME'];
                                                                            $port = $secure ? $this->getSecurePort() : $this->getPort();
                                                                            if (($port !== 80 && !$secure) || ($port !== 443 && $secure)) $this->_hostInfo .= ':' . $port;

            }


        return $this->_hostInfo;
    }

     function setHostInfo($value){
        $this->_hostName = null;
        $this->_hostInfo = $value === null ? null : rtrim($value, '/');
    }


     function getHostName(){
        if ($this->_hostName === null) $this->_hostName = parse_url($this->getHostInfo(), PHP_URL_HOST);
        return $this->_hostName;
    }

    private $_baseUrl;


     function getBaseUrl(){
        if ($this->_baseUrl === null) $this->_baseUrl = rtrim(dirname($this->getScriptUrl()), '\\/');
        return $this->_baseUrl;
    }


     function setBaseUrl($value){
        $this->_baseUrl = $value;
    }

    private $_scriptUrl;


     function getScriptUrl(){
        if ($this->_scriptUrl !== null)  return $this->_scriptUrl;
            $scriptFile = $this->getScriptFile();
            $scriptName = basename($scriptFile);
            if (isset($_SERVER['SCRIPT_NAME']) && basename($_SERVER['SCRIPT_NAME']) === $scriptName)                   $this->_scriptUrl = $_SERVER['SCRIPT_NAME'];
             elseif (isset($_SERVER['PHP_SELF']) && basename($_SERVER['PHP_SELF']) === $scriptName)                   $this->_scriptUrl = $_SERVER['PHP_SELF'];
             elseif (isset($_SERVER['ORIG_SCRIPT_NAME']) && basename($_SERVER['ORIG_SCRIPT_NAME']) === $scriptName)    $this->_scriptUrl = $_SERVER['ORIG_SCRIPT_NAME'];
             elseif (isset($_SERVER['PHP_SELF']) && ($pos = strpos($_SERVER['PHP_SELF'], '/' . $scriptName)) !== false) $this->_scriptUrl = substr($_SERVER['SCRIPT_NAME'], 0, $pos) . '/' . $scriptName;
             elseif (!empty($_SERVER['DOCUMENT_ROOT']) && strpos($scriptFile, $_SERVER['DOCUMENT_ROOT']) === 0)         $this->_scriptUrl = str_replace([$_SERVER['DOCUMENT_ROOT'], '\\'], ['', '/'], $scriptFile);
             else                                                                                                    throw new InvalidConfigException('Unable to determine the entry script URL.');



        return $this->_scriptUrl;
    }

    function setScriptUrl($value){
        $this->_scriptUrl = $value === null ? null : '/' . trim($value, '/');
    }

    private $_scriptFile;


     function getScriptFile(){
        if (isset($this->_scriptFile)) return $this->_scriptFile;


        if (isset($_SERVER['SCRIPT_FILENAME'])) return $_SERVER['SCRIPT_FILENAME'];


        throw new InvalidConfigException('Unable to determine the entry script file path.');
    }
    function setScriptFile($value){
        $this->_scriptFile = $value;
    }

    private $_pathInfo;

   function getPathInfo(){
        if ($this->_pathInfo === null) $this->_pathInfo = $this->resolvePathInfo();
        return $this->_pathInfo;
    }

   function setPathInfo($value){
        $this->_pathInfo = $value === null ? null : ltrim($value, '/');
    }


    protected function resolvePathInfo()
    {
        $pathInfo = $this->getUrl();

        if (($pos = strpos($pathInfo, '?')) !== false) $pathInfo = substr($pathInfo, 0, $pos);


        $pathInfo = urldecode($pathInfo);


        if (!preg_match('%^(?:
            [\x09\x0A\x0D\x20-\x7E]              # ASCII
            | [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
            | \xE0[\xA0-\xBF][\x80-\xBF]         # excluding overlongs
            | [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
            | \xED[\x80-\x9F][\x80-\xBF]         # excluding surrogates
            | \xF0[\x90-\xBF][\x80-\xBF]{2}      # planes 1-3
            | [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
            | \xF4[\x80-\x8F][\x80-\xBF]{2}      # plane 16
            )*$%xs', $pathInfo)
        ) $pathInfo = utf8_encode($pathInfo);


        $scriptUrl = $this->getScriptUrl();
        $baseUrl = $this->getBaseUrl();
        if (strpos($pathInfo, $scriptUrl) === 0) $pathInfo = substr($pathInfo, strlen($scriptUrl));
         elseif ($baseUrl === '' || strpos($pathInfo, $baseUrl) === 0) $pathInfo = substr($pathInfo, strlen($baseUrl));
         elseif (isset($_SERVER['PHP_SELF']) && strpos($_SERVER['PHP_SELF'], $scriptUrl) === 0) $pathInfo = substr($_SERVER['PHP_SELF'], strlen($scriptUrl));
         else throw new InvalidConfigException('Unable to determine the path info of the current request.');


        if (substr($pathInfo, 0, 1) === '/') $pathInfo = substr($pathInfo, 1);

        return (string) $pathInfo;
    }

    function getAbsoluteUrl(){
        return $this->getHostInfo() . $this->getUrl();
    }

    private $_url;

    function getUrl(){
      ($this->_url === null)&&$this->_url = $this->resolveRequestUri();

        return $this->_url;
    }

    function setUrl($value){
        $this->_url = $value;
    }


    protected function resolveRequestUri()
    {
        if ($this->headers->has('X-Rewrite-Url')) $requestUri = $this->headers->get('X-Rewrite-Url');
         elseif (isset($_SERVER['REQUEST_URI'])) {
            $requestUri = $_SERVER['REQUEST_URI'];
            if ($requestUri !== '' && $requestUri[0] !== '/') $requestUri = preg_replace('/^(http|https):\/\/[^\/]+/i', '', $requestUri);

        } elseif (isset($_SERVER['ORIG_PATH_INFO'])) { // IIS 5.0 CGI
            $requestUri = $_SERVER['ORIG_PATH_INFO'];
            if (!empty($_SERVER['QUERY_STRING'])) $requestUri .= '?' . $_SERVER['QUERY_STRING'];

        } else throw new InvalidConfigException('Unable to determine the request URI.');


        return $requestUri;
    }

     function getQueryString(){
        return isset($_SERVER['QUERY_STRING']) ? $_SERVER['QUERY_STRING'] : '';
    }

   function getIsSecureConnection(){
        if (isset($_SERVER['HTTPS']) && (strcasecmp($_SERVER['HTTPS'], 'on') === 0 || $_SERVER['HTTPS'] == 1)) return true;

        foreach ($this->secureProtocolHeaders as $header => $values) {
            if (($headerValue = $this->headers->get($header, null)) !== null) foreach ($values as $value) if (strcasecmp($headerValue, $value) === 0) return true;

        }

        return false;
    }

    function getServerName(){
        return isset($_SERVER['SERVER_NAME']) ? $_SERVER['SERVER_NAME'] : null;
    }

    function getServerPort(){
        return isset($_SERVER['SERVER_PORT']) ? (int) $_SERVER['SERVER_PORT'] : null;
    }

     function getReferrer(){
        return $this->headers->get('Referer');
    }

    function getOrigin(){
        return $this->getHeaders()->get('origin');
    }

    function getUserAgent(){
        return $this->headers->get('User-Agent');
    }

    function getUserIP(){
        foreach ($this->ipHeaders as $ipHeader) if ($this->headers->has($ipHeader)) return trim(explode(',', $this->headers->get($ipHeader))[0]);

        return $this->getRemoteIP();
    }

     function getUserHost()
    {
        foreach ($this->ipHeaders as $ipHeader) if ($this->headers->has($ipHeader)) return gethostbyaddr(trim(explode(',', $this->headers->get($ipHeader))[0]));

        return $this->getRemoteHost();
    }

   function getRemoteIP()
    {
        return isset($_SERVER['REMOTE_ADDR']) ? $_SERVER['REMOTE_ADDR'] : null;
    }

  function getRemoteHost()
    {
        return isset($_SERVER['REMOTE_HOST']) ? $_SERVER['REMOTE_HOST'] : null;
    }

     function getAuthUser(){
        return $this->getAuthCredentials()[0];
    }

   function getAuthPassword()
    {
        return $this->getAuthCredentials()[1];
    }
 function getAuthCredentials()
    {
        $username = isset($_SERVER['PHP_AUTH_USER']) ? $_SERVER['PHP_AUTH_USER'] : null;
        $password = isset($_SERVER['PHP_AUTH_PW']) ? $_SERVER['PHP_AUTH_PW'] : null;
        if ($username !== null || $password !== null) return [$username, $password];



        $auth_token = $this->getHeaders()->get('HTTP_AUTHORIZATION') ?: $this->getHeaders()->get('REDIRECT_HTTP_AUTHORIZATION');
        if ($auth_token !== null && strncasecmp($auth_token, 'basic', 5) === 0) {
            $parts = array_map(function ($value) {
                return strlen($value) === 0 ? null : $value;
            }, explode(':', base64_decode(mb_substr($auth_token, 6)), 2));

            if (count($parts) < 2) return [$parts[0], null];
            return $parts;
        }

        return [null, null];
    }

    private $_port;

   function getPort()
    {
        if ($this->_port !== null)   return $this->_port;
            $serverPort = $this->getServerPort();
            $this->_port = !$this->getIsSecureConnection() && $serverPort !== null ? $serverPort : 80;


        return $this->_port;
    }

     function setPort($value)
    {
        if ($value == $this->_port) return;
            $this->_port = (int) $value;
            $this->_hostInfo = null;

    }

    private $_securePort;

     function getSecurePort()
    {
        if ($this->_securePort !== null) return $this->_securePort;
        $serverPort = $this->getServerPort();
        $this->_securePort = $this->getIsSecureConnection() && $serverPort !== null ? $serverPort : 443;


        return $this->_securePort;
    }
     function setSecurePort($value)
    {
        if ($value == $this->_securePort) return;
        $this->_securePort = (int) $value;
        $this->_hostInfo = null;

    }

    private $_contentTypes;

     function getAcceptableContentTypes()
    {
        if ($this->_contentTypes === null) {
            if ($this->headers->get('Accept') !== null) $this->_contentTypes = $this->parseAcceptHeader($this->headers->get('Accept'));
            else$this->_contentTypes = [];

        }

        return $this->_contentTypes;
    }

    function setAcceptableContentTypes($value){
        $this->_contentTypes = $value;
    }

   function getContentType()
    {
        if (isset($_SERVER['CONTENT_TYPE'])) return $_SERVER['CONTENT_TYPE'];
        return $this->headers->get('Content-Type');
    }

    private $_languages;

    function getAcceptableLanguages()
    {
        if ($this->_languages === null) {
            if ($this->headers->has('Accept-Language')) $this->_languages = array_keys($this->parseAcceptHeader($this->headers->get('Accept-Language')));
            else$this->_languages = [];

        }

        return $this->_languages;
    }

    function setAcceptableLanguages($value){
        $this->_languages = $value;
    }


     function parseAcceptHeader($header){
        $accepts = [];
        foreach (explode(',', $header) as $i => $part) {
            $params = preg_split('/\s*;\s*/', trim($part), -1, PREG_SPLIT_NO_EMPTY);
            if (empty($params)) continue;

            $values = [
                'q' => [$i, array_shift($params), 1],
            ];
            foreach ($params as $param) {
                if (strpos($param, '=') !== false) {
                    list($key, $value) = explode('=', $param, 2);
                    if ($key === 'q') $values['q'][2] = (float) $value;
                     else $values[$key] = $value;

                } else $values[] = $param;

            }
            $accepts[] = $values;
        }

        usort($accepts, function ($a, $b) {
            $a = $a['q']; // index, name, q
            $b = $b['q'];
            if ($a[2] > $b[2]) return -1;


            if ($a[2] < $b[2]) return 1;


            if ($a[1] === $b[1]) return $a[0] > $b[0] ? 1 : -1;


            if ($a[1] === '*/*') return 1;


            if ($b[1] === '*/*') return -1;

            $wa = $a[1][strlen($a[1]) - 1] === '*';
            $wb = $b[1][strlen($b[1]) - 1] === '*';
            if ($wa xor $wb) return $wa ? 1 : -1;

            return $a[0] > $b[0] ? 1 : -1;
        });

        $result = [];
        foreach ($accepts as $accept) {
            $name = $accept['q'][1];
            $accept['q'] = $accept['q'][2];
            $result[$name] = $accept;
        }

        return $result;
    }

   function getPreferredLanguage(array $languages = [])
    {
        if (empty($languages)) return Yii::$app->language;

        foreach ($this->getAcceptableLanguages() as $acceptableLanguage) {
            $acceptableLanguage = str_replace('_', '-', strtolower($acceptableLanguage));
            foreach ($languages as $language) {
                $normalizedLanguage = str_replace('_', '-', strtolower($language));

                if (
                    $normalizedLanguage === $acceptableLanguage // en-us==en-us
                    || strpos($acceptableLanguage, $normalizedLanguage . '-') === 0 // en==en-us
                    || strpos($normalizedLanguage, $acceptableLanguage . '-') === 0 // en-us==en
                ) return $language;

            }
        }

        return reset($languages);
    }

    function getETags(){
        if ($this->headers->has('If-None-Match')) return preg_split('/[\s,]+/', str_replace('-gzip', '', $this->headers->get('If-None-Match')), -1, PREG_SPLIT_NO_EMPTY);


        return [];
    }
 function getCookies(){
        if ($this->_cookies === null) $this->_cookies = new CookieCollection($this->loadCookies(), ['readOnly' => true,]);

        return $this->_cookies;
    }


    protected function loadCookies()
    {
        $cookies = [];
        if ($this->enableCookieValidation) {
            if ($this->cookieValidationKey == '') throw new InvalidConfigException(get_class($this) . '::cookieValidationKey must be configured with a secret key.');

            foreach ($_COOKIE as $name => $value) {
                if (!is_string($value)) {
                    continue;
                }
                $data = Yii::$app->getSecurity()->validateData($value, $this->cookieValidationKey);
                if ($data === false) {
                    continue;
                }
                $data = @unserialize($data);
                if (is_array($data) && isset($data[0], $data[1]) && $data[0] === $name) {
                    $cookies[$name] = Yii::createObject([
                        'class' => 'yii\web\Cookie',
                        'name' => $name,
                        'value' => $data[1],
                        'expire' => null,
                    ]);
                }
            }
        } else {
            foreach ($_COOKIE as $name => $value) {
                $cookies[$name] = Yii::createObject([
                    'class' => 'yii\web\Cookie',
                    'name' => $name,
                    'value' => $value,
                    'expire' => null,
                ]);
            }
        }

        return $cookies;
    }

    private $_csrfToken;


     function getCsrfToken($regenerate = false){
        if ($this->_csrfToken === null || $regenerate) {
            $token = $this->loadCsrfToken();
            if ($regenerate || empty($token)) $token = $this->generateCsrfToken();

            $this->_csrfToken = Yii::$app->security->maskToken($token);
        }

        return $this->_csrfToken;
    }


    protected function loadCsrfToken()
    {
        if ($this->enableCsrfCookie) return $this->getCookies()->getValue($this->csrfParam);


        return Yii::$app->getSession()->get($this->csrfParam);
    }


    protected function generateCsrfToken()
    {
        $token = Yii::$app->getSecurity()->generateRandomString();
        if ($this->enableCsrfCookie) {
            $cookie = $this->createCsrfCookie($token);
            Yii::$app->getResponse()->getCookies()->add($cookie);
        } else Yii::$app->getSession()->set($this->csrfParam, $token);


        return $token;
    }


     function getCsrfTokenFromHeader(){
        return $this->headers->get(static::CSRF_HEADER);
    }


    protected function createCsrfCookie($token){
        $options = $this->csrfCookie;
        return Yii::createObject(array_merge($options, [
            'class' => 'yii\web\Cookie',
            'name' => $this->csrfParam,
            'value' => $token,
        ]));
    }

   function validateCsrfToken($clientSuppliedToken = null){
        $method = $this->getMethod();

        if (!$this->enableCsrfValidation || in_array($method, ['GET', 'HEAD', 'OPTIONS'], true)) return true;

        $trueToken = $this->getCsrfToken();
        if ($clientSuppliedToken !== null) return $this->validateCsrfTokenInternal($clientSuppliedToken, $trueToken);
        return $this->validateCsrfTokenInternal($this->getBodyParam($this->csrfParam), $trueToken)
            || $this->validateCsrfTokenInternal($this->getCsrfTokenFromHeader(), $trueToken);
    }


    private function validateCsrfTokenInternal($clientSuppliedToken, $trueToken)
    {
        if (!is_string($clientSuppliedToken)) return false;
        $security = Yii::$app->security;

        return $security->unmaskToken($clientSuppliedToken) === $security->unmaskToken($trueToken);
    }
}