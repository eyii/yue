<?php


namespace common\lib\rest;
use Yii;
use yii\base\InvalidArgumentException;
use yii\base\InvalidConfigException;
use yii\helpers\FileHelper;
use yii\helpers\Inflector;
use yii\helpers\StringHelper;
use yii\helpers\Url;
use yii\web\CookieCollection;
use yii\web\HeaderCollection;
use yii\web\HeadersAlreadySentException;
use yii\web\HttpException;
use yii\web\RangeNotSatisfiableHttpException;
use yii\web\ResponseFormatterInterface;

class Response extends \yii\web\Response{

    const EVENT_BEFORE_SEND = 'beforeSend';

    const EVENT_AFTER_SEND = 'afterSend';

    const EVENT_AFTER_PREPARE = 'afterPrepare';
    const FORMAT_RAW = 'raw';
    const FORMAT_HTML = 'html';
    const FORMAT_JSON = 'json';
    const FORMAT_JSONP = 'jsonp';
    const FORMAT_XML = 'xml';


    public $format = self::FORMAT_HTML;

    public $acceptMimeType;

    public $acceptParams = [];

    public $formatters = [];

    public $data;

    public $content;

    public $stream;

    public $charset;

    public $statusText = 'OK';

    public $version;

    public $isSent = false;

    public static $httpStatuses = [
        100 => 'Continue',
        101 => 'Switching Protocols',
        102 => 'Processing',
        118 => 'Connection timed out',
        200 => 'OK',
        201 => 'Created',
        202 => 'Accepted',
        203 => 'Non-Authoritative',
        204 => 'No Content',
        205 => 'Reset Content',
        206 => 'Partial Content',
        207 => 'Multi-Status',
        208 => 'Already Reported',
        210 => 'Content Different',
        226 => 'IM Used',
        300 => 'Multiple Choices',
        301 => 'Moved Permanently',
        302 => 'Found',
        303 => 'See Other',
        304 => 'Not Modified',
        305 => 'Use Proxy',
        306 => 'Reserved',
        307 => 'Temporary Redirect',
        308 => 'Permanent Redirect',
        310 => 'Too many Redirect',
        400 => 'Bad Request',
        401 => 'Unauthorized',
        402 => 'Payment Required',
        403 => 'Forbidden',
        404 => 'Not Found',
        405 => 'Method Not Allowed',
        406 => 'Not Acceptable',
        407 => 'Proxy Authentication Required',
        408 => 'Request Time-out',
        409 => 'Conflict',
        410 => 'Gone',
        411 => 'Length Required',
        412 => 'Precondition Failed',
        413 => 'Request Entity Too Large',
        414 => 'Request-URI Too Long',
        415 => 'Unsupported Media Type',
        416 => 'Requested range unsatisfiable',
        417 => 'Expectation failed',
        418 => 'I\'m a teapot',
        421 => 'Misdirected Request',
        422 => 'Unprocessable entity',
        423 => 'Locked',
        424 => 'Method failure',
        425 => 'Unordered Collection',
        426 => 'Upgrade Required',
        428 => 'Precondition Required',
        429 => 'Too Many Requests',
        431 => 'Request Header Fields Too Large',
        449 => 'Retry With',
        450 => 'Blocked by Windows Parental Controls',
        451 => 'Unavailable For Legal Reasons',
        500 => 'Internal Server Error',
        501 => 'Not Implemented',
        502 => 'Bad Gateway or Proxy Error',
        503 => 'Service Unavailable',
        504 => 'Gateway Time-out',
        505 => 'HTTP Version not supported',
        507 => 'Insufficient storage',
        508 => 'Loop Detected',
        509 => 'Bandwidth Limit Exceeded',
        510 => 'Not Extended',
        511 => 'Network Authentication Required',
    ];


    private $_statusCode = 200;
    /**
     * @var HeaderCollection
     */
    private $_headers;



    public function init()
    {
        if ($this->version === null) {
            if (isset($_SERVER['SERVER_PROTOCOL']) && $_SERVER['SERVER_PROTOCOL'] === 'HTTP/1.0') $this->version = '1.0';
             else $this->version = '1.1';

        }
       $this->charset === null&& $this->charset = Yii::$app->charset;

        $this->formatters = array_merge($this->defaultFormatters(), $this->formatters);
    }


     function getStatusCode(){
        return $this->_statusCode;
    }


     function setStatusCode($value, $text = null){
      $value === null&& $value = 200;

        $this->_statusCode = (int) $value;
        if ($this->getIsInvalid()) throw new InvalidArgumentException("The HTTP status code is invalid: $value");

        if ($text === null) $this->statusText = isset(static::$httpStatuses[$this->_statusCode]) ? static::$httpStatuses[$this->_statusCode] : '';
         else $this->statusText = $text;


        return $this;
    }


     function setStatusCodeByException($e){
       $e instanceof HttpException? $this->setStatusCode($e->statusCode): $this->setStatusCode(500);


        return $this;
    }


     function getHeaders(){
        $this->_headers === null&&$this->_headers = new HeaderCollection();


        return $this->_headers;
    }


    public function send()
    {
        if ($this->isSent) return;

        $this->trigger(self::EVENT_BEFORE_SEND);
        $this->prepare();
        $this->trigger(self::EVENT_AFTER_PREPARE);
        $this->sendHeaders();
        $this->sendContent();
        $this->trigger(self::EVENT_AFTER_SEND);
        $this->isSent = true;
    }


     function clear(){
        $this->_headers = null;
        $this->_cookies = null;
        $this->_statusCode = 200;
        $this->statusText = 'OK';
        $this->data = null;
        $this->stream = null;
        $this->content = null;
        $this->isSent = false;
    }


    protected function sendHeaders()
    {
        if (headers_sent($file, $line)) throw new HeadersAlreadySentException($file, $line);

        if ($this->_headers) {
            foreach ($this->getHeaders() as $name => $values) {
                $name = str_replace(' ', '-', ucwords(str_replace('-', ' ', $name)));
                $replace = true;
                foreach ($values as $value) {
                    header("$name: $value", $replace);
                    $replace = false;
                }
            }
        }
        $statusCode = $this->getStatusCode();
        header("HTTP/{$this->version} {$statusCode} {$this->statusText}");
        $this->sendCookies();
    }


    protected function sendCookies()
    {
        if ($this->_cookies === null) return;

        $request = Yii::$app->getRequest();
        if ($request->enableCookieValidation) {
            if ($request->cookieValidationKey == '') throw new InvalidConfigException(get_class($request) . '::cookieValidationKey must be configured with a secret key.');

            $validationKey = $request->cookieValidationKey;
        }
        foreach ($this->getCookies() as $cookie) {
            $value = $cookie->value;
          ($cookie->expire != 1 && isset($validationKey))&& $value = Yii::$app->getSecurity()->hashData(serialize([$cookie->name, $value]), $validationKey);

            setcookie($cookie->name, $value, $cookie->expire, $cookie->path, $cookie->domain, $cookie->secure, $cookie->httpOnly);
        }
    }


    protected function sendContent()
    {
        if ($this->stream === null) {
            echo $this->content;

            return;
        }

        set_time_limit(0); // Reset time limit for big files
        $chunkSize = 8 * 1024 * 1024; // 8MB per chunk

        if (is_array($this->stream)) {
            list($handle, $begin, $end) = $this->stream;
            fseek($handle, $begin);
            while (!feof($handle) && ($pos = ftell($handle)) <= $end) {
                if ($pos + $chunkSize > $end) $chunkSize = $end - $pos + 1;
                echo fread($handle, $chunkSize);
                flush();
            }
            fclose($handle);
        } else {
            while (!feof($this->stream)) {
                echo fread($this->stream, $chunkSize);
                flush();
            }
            fclose($this->stream);
        }
    }

    public function sendFile($filePath, $attachmentName = null, $options = [])
    {
        if (!isset($options['mimeType'])) $options['mimeType'] = FileHelper::getMimeTypeByExtension($filePath);

        if ($attachmentName === null) $attachmentName = basename($filePath);

        $handle = fopen($filePath, 'rb');
        $this->sendStreamAsFile($handle, $attachmentName, $options);

        return $this;
    }

    public function sendContentAsFile($content, $attachmentName, $options = [])
    {
        $headers = $this->getHeaders();

        $contentLength = StringHelper::byteLength($content);
        $range = $this->getHttpRange($contentLength);

        if ($range === false) {
            $headers->set('Content-Range', "bytes */$contentLength");
            throw new RangeNotSatisfiableHttpException();
        }

        list($begin, $end) = $range;
        if ($begin != 0 || $end != $contentLength - 1) {
            $this->setStatusCode(206);
            $headers->set('Content-Range', "bytes $begin-$end/$contentLength");
            $this->content = StringHelper::byteSubstr($content, $begin, $end - $begin + 1);
        } else {
            $this->setStatusCode(200);
            $this->content = $content;
        }

        $mimeType = isset($options['mimeType']) ? $options['mimeType'] : 'application/octet-stream';
        $this->setDownloadHeaders($attachmentName, $mimeType, !empty($options['inline']), $end - $begin + 1);

        $this->format = self::FORMAT_RAW;

        return $this;
    }


    public function sendStreamAsFile($handle, $attachmentName, $options = [])
    {
        $headers = $this->getHeaders();
        if (isset($options['fileSize'])) $fileSize = $options['fileSize'];
         else {
            fseek($handle, 0, SEEK_END);
            $fileSize = ftell($handle);
        }

        $range = $this->getHttpRange($fileSize);
        if ($range === false) {
            $headers->set('Content-Range', "bytes */$fileSize");
            throw new RangeNotSatisfiableHttpException();
        }

        list($begin, $end) = $range;
        if ($begin != 0 || $end != $fileSize - 1) {
            $this->setStatusCode(206);
            $headers->set('Content-Range', "bytes $begin-$end/$fileSize");
        } else $this->setStatusCode(200);


        $mimeType = isset($options['mimeType']) ? $options['mimeType'] : 'application/octet-stream';
        $this->setDownloadHeaders($attachmentName, $mimeType, !empty($options['inline']), $end - $begin + 1);

        $this->format = self::FORMAT_RAW;
        $this->stream = [$handle, $begin, $end];

        return $this;
    }

    public function setDownloadHeaders($attachmentName, $mimeType = null, $inline = false, $contentLength = null)
    {
        $headers = $this->getHeaders();

        $disposition = $inline ? 'inline' : 'attachment';
        $headers->setDefault('Pragma', 'public')
            ->setDefault('Accept-Ranges', 'bytes')
            ->setDefault('Expires', '0')
            ->setDefault('Cache-Control', 'must-revalidate, post-check=0, pre-check=0')
            ->setDefault('Content-Disposition', $this->getDispositionHeaderValue($disposition, $attachmentName));

        ($mimeType !== null)  && $headers->setDefault('Content-Type', $mimeType);


       ($contentLength !== null)&& $headers->setDefault('Content-Length', $contentLength);


        return $this;
    }


    protected function getHttpRange($fileSize)
    {
        $rangeHeader = Yii::$app->getRequest()->getHeaders()->get('Range', '-');
        if ($rangeHeader === '-') return [0, $fileSize - 1];

        if (!preg_match('/^bytes=(\d*)-(\d*)$/', $rangeHeader, $matches)) return false;

        if ($matches[1] === '') {
            $start = $fileSize - $matches[2];
            $end = $fileSize - 1;
        } elseif ($matches[2] !== '') {
            $start = $matches[1];
            $end = $matches[2];
            if ($end >= $fileSize) $end = $fileSize - 1;

        } else {
            $start = $matches[1];
            $end = $fileSize - 1;
        }
        if ($start < 0 || $start > $end) return false;


        return [$start, $end];
    }


    public function xSendFile($filePath, $attachmentName = null, $options = [])
    {
        if ($attachmentName === null) $attachmentName = basename($filePath);

        if (isset($options['mimeType'])) $mimeType = $options['mimeType'];
        elseif (($mimeType = FileHelper::getMimeTypeByExtension($filePath)) === null) $mimeType = 'application/octet-stream';

        $xHeader =  isset($options['xHeader'])? $options['xHeader']: 'X-Sendfile';


        $disposition = empty($options['inline']) ? 'attachment' : 'inline';
        $this->getHeaders()
            ->setDefault($xHeader, $filePath)
            ->setDefault('Content-Type', $mimeType)
            ->setDefault('Content-Disposition', $this->getDispositionHeaderValue($disposition, $attachmentName));

        $this->format = self::FORMAT_RAW;

        return $this;
    }

    protected function getDispositionHeaderValue($disposition, $attachmentName)
    {
        $fallbackName = str_replace(
            ['%', '/', '\\', '"'],
            ['_', '_', '_', '\\"'],
            Inflector::transliterate($attachmentName, Inflector::TRANSLITERATE_LOOSE)
        );
        $utfName = rawurlencode(str_replace(['%', '/', '\\'], '', $attachmentName));

        $dispositionHeader = "{$disposition}; filename=\"{$fallbackName}\"";
        if ($utfName !== $fallbackName) $dispositionHeader .= "; filename*=utf-8''{$utfName}";


        return $dispositionHeader;
    }


    public function redirect($url, $statusCode = 302, $checkAjax = true)
    {
        if (is_array($url) && isset($url[0])) $url[0] = '/' . ltrim($url[0], '/');

        $url = Url::to($url);
        if (strncmp($url, '/', 1) === 0 && strncmp($url, '//', 2) !== 0) $url = Yii::$app->getRequest()->getHostInfo() . $url;


        if ($checkAjax) {
            if (Yii::$app->getRequest()->getIsAjax()) {
                if (Yii::$app->getRequest()->getHeaders()->get('X-Ie-Redirect-Compatibility') !== null && $statusCode === 302) $statusCode = 200;

                Yii::$app->getRequest()->getIsPjax()? $this->getHeaders()->set('X-Pjax-Url', $url): $this->getHeaders()->set('X-Redirect', $url);

            } else $this->getHeaders()->set('Location', $url);

        } else $this->getHeaders()->set('Location', $url);


        $this->setStatusCode($statusCode);

        return $this;
    }


     function refresh($anchor = ''){
        return $this->redirect(Yii::$app->getRequest()->getUrl() . $anchor);
    }

    private $_cookies;


     function getCookies(){
       $this->_cookies === null && $this->_cookies = new CookieCollection();


        return $this->_cookies;
    }


     function getIsInvalid(){
        return $this->getStatusCode() < 100 || $this->getStatusCode() >= 600;
    }

     function getIsInformational(){
        return $this->getStatusCode() >= 100 && $this->getStatusCode() < 200;
    }


     function getIsSuccessful(){
        return $this->getStatusCode() >= 200 && $this->getStatusCode() < 300;
    }


     function getIsRedirection(){
        return $this->getStatusCode() >= 300 && $this->getStatusCode() < 400;
    }


     function getIsClientError(){
        return $this->getStatusCode() >= 400 && $this->getStatusCode() < 500;
    }


     function getIsServerError(){
        return $this->getStatusCode() >= 500 && $this->getStatusCode() < 600;
    }


     function getIsOk(){
        return $this->getStatusCode() == 200;
    }


     function getIsForbidden(){
        return $this->getStatusCode() == 403;
    }


     function getIsNotFound(){
        return $this->getStatusCode() == 404;
    }


    public function getIsEmpty()
    {
        return in_array($this->getStatusCode(), [201, 204, 304]);
    }


    protected function defaultFormatters()
    {
        return [
            self::FORMAT_HTML => ['class' => 'yii\web\HtmlResponseFormatter',],
            self::FORMAT_XML => ['class' => 'yii\web\XmlResponseFormatter',],
            self::FORMAT_JSON => ['class' => 'yii\web\JsonResponseFormatter',],
            self::FORMAT_JSONP => ['class' => 'yii\web\JsonResponseFormatter', 'useJsonp' => true,],
        ];
    }


    protected function prepare()
    {
        if ($this->stream !== null) return;


        if (isset($this->formatters[$this->format])) {
            $formatter = $this->formatters[$this->format];
            if (!is_object($formatter))                                         $this->formatters[$this->format] = $formatter = Yii::createObject($formatter);

            if ($formatter instanceof ResponseFormatterInterface)                   $formatter->format($this);
            else                                                                throw new InvalidConfigException("The '{$this->format}' response formatter is invalid. It must implement the ResponseFormatterInterface.");

        } elseif ($this->format === self::FORMAT_RAW) {
           $this->data !== null&& $this->content = $this->data;

        } else throw new InvalidConfigException("Unsupported response format: {$this->format}");


        if (is_array($this->content)) throw new InvalidArgumentException('Response content must not be an array.');
         elseif (is_object($this->content)) {
             if (method_exists($this->content, '__toString')) $this->content = $this->content->__toString();
             else throw new InvalidArgumentException('Response content must be a string or an object implementing __toString().');

        }
    }
}