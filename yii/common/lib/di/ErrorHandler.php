<?php
namespace common\lib\di;


use Yii;
use yii\base\ErrorException;
use yii\base\Exception;
use yii\base\UserException;
use yii\helpers\VarDumper;
use yii\web\HttpException;
use yii\web\Response;

class ErrorHandler extends \yii\web\ErrorHandler
{


    public $maxSourceLines = 19;

    public $maxTraceSourceLines = 13;

    public $errorAction;

    public $errorView = '@yii/views/errorHandler/error.php';

    public $exceptionView = '@yii/views/errorHandler/exception.php';

    public $callStackItemView = '@yii/views/errorHandler/callStackItem.php';

    public $previousExceptionView = '@yii/views/errorHandler/previousException.php';

    public $displayVars = ['_GET', '_POST', '_FILES', '_COOKIE', '_SESSION'];

    public $traceLine = '{html}';



    protected function renderException($exception)
    {
        if (Yii::$app->has('response')) {
            $response = Yii::$app->getResponse();

            $response->isSent = false;
            $response->stream = null;
            $response->data = null;
            $response->content = null;
        } else $response = new Response();


        $response->setStatusCodeByException($exception);

        $useErrorView = $response->format === Response::FORMAT_HTML && (!YII_DEBUG || $exception instanceof UserException);

        if ($useErrorView && $this->errorAction !== null) {
            $result = Yii::$app->runAction($this->errorAction);
             ($result instanceof Response)?  $response = $result:$response->data = $result;

        } elseif ($response->format === Response::FORMAT_HTML) {
            if ($this->shouldRenderSimpleHtml()) $response->data = '<pre>' . $this->htmlEncode(static::convertExceptionToString($exception)) . '</pre>';
             else {

                if (YII_DEBUG) ini_set('display_errors', 1);

                $file = $useErrorView ? $this->errorView : $this->exceptionView;
                $response->data = $this->renderFile($file, ['exception' => $exception,]);
            }
        } elseif ($response->format === Response::FORMAT_RAW) $response->data = static::convertExceptionToString($exception);
         else$response->data = $this->convertExceptionToArray($exception);


        $response->send();
    }


    protected function convertExceptionToArray($exception)
    {
        if (!YII_DEBUG && !$exception instanceof UserException && !$exception instanceof HttpException) $exception = new HttpException(500, Yii::t('yii', 'An internal server error occurred.'));


        $array = [
            'data' => ($exception instanceof Exception || $exception instanceof ErrorException) ? $exception->getName() : 'Exception',
            'msg' => $exception->getMessage(),
            'code' => $exception->getCode(),
        ];
        ($exception instanceof HttpException)&& $array['code'] = $exception->statusCode;

        if (YII_DEBUG) {
            $array['type'] = get_class($exception);
            if (!$exception instanceof UserException) {
                $array['file'] = $exception->getFile();
                $array['line'] = $exception->getLine();
                $array['stack-trace'] = explode("\n", $exception->getTraceAsString());
                if ($exception instanceof \yii\db\Exception) $array['error-info'] = $exception->errorInfo;

            }
        }
       ($prev = $exception->getPrevious()) !== null&& $array['previous'] = $this->convertExceptionToArray($prev);


        return $array;
    }

     function htmlEncode($text){
        return htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
    }

    function addTypeLinks($code)
    {
        if (preg_match('/(.*?)::([^(]+)/', $code, $matches)) {
            $class = $matches[1];
            $method = $matches[2];
            $text = $this->htmlEncode($class) . '::' . $this->htmlEncode($method);
        } else {
            $class = $code;
            $method = null;
            $text = $this->htmlEncode($class);
        }

        $url = null;

        $shouldGenerateLink = true;
        if ($method !== null && substr_compare($method, '{closure}', -9) !== 0) {
            $reflection = new \ReflectionClass($class);
            if ($reflection->hasMethod($method)) {
                $reflectionMethod = $reflection->getMethod($method);
                $shouldGenerateLink = $reflectionMethod->isPublic() || $reflectionMethod->isProtected();
            } else $shouldGenerateLink = false;

        }

       $shouldGenerateLink&& $url = $this->getTypeUrl($class, $method);


        if ($url === null) return $text;


        return '<a href="' . $url . '" target="_blank">' . $text . '</a>';
    }


    protected function getTypeUrl($class, $method)
    {
        if (strncmp($class, 'yii\\', 4) !== 0) return null;


        $page = $this->htmlEncode(strtolower(str_replace('\\', '-', $class)));
        $url = "http://www.yiiframework.com/doc-2.0/$page.html";
        if ($method) $url .= "#$method()-detail";


        return $url;
    }
   function renderFile($_file_, $_params_)
    {
        $_params_['handler'] = $this;
        if ($this->exception instanceof ErrorException || !Yii::$app->has('view')) {
            ob_start();
            ob_implicit_flush(false);
            extract($_params_, EXTR_OVERWRITE);
            require Yii::getAlias($_file_);

            return ob_get_clean();
        }

        return Yii::$app->getView()->renderFile($_file_, $_params_, $this);
    }

    function renderPreviousExceptions($exception)
    {
        if (($previous = $exception->getPrevious()) !== null) return $this->renderFile($this->previousExceptionView, ['exception' => $previous]);


        return '';
    }
   function renderCallStackItem($file, $line, $class, $method, $args, $index)
    {
        $lines = [];
        $begin = $end = 0;
        if ($file !== null && $line !== null) {
            $line--;
            $lines = @file($file);
            if ($line < 0 || $lines === false || ($lineCount = count($lines)) < $line) return '';


            $half = (int) (($index === 1 ? $this->maxSourceLines : $this->maxTraceSourceLines) / 2);
            $begin = $line - $half > 0 ? $line - $half : 0;
            $end = $line + $half < $lineCount ? $line + $half : $lineCount - 1;
        }

        return $this->renderFile($this->callStackItemView, [
            'file' => $file,
            'line' => $line,
            'class' => $class,
            'method' => $method,
            'index' => $index,
            'lines' => $lines,
            'begin' => $begin,
            'end' => $end,
            'args' => $args,
        ]);
    }
  function renderCallStack($exception)
    {
        $out = '<ul>';
        $out .= $this->renderCallStackItem($exception->getFile(), $exception->getLine(), null, null, [], 1);
        for ($i = 0, $trace = $exception->getTrace(), $length = count($trace); $i < $length; ++$i) {
            $file = !empty($trace[$i]['file']) ? $trace[$i]['file'] : null;
            $line = !empty($trace[$i]['line']) ? $trace[$i]['line'] : null;
            $class = !empty($trace[$i]['class']) ? $trace[$i]['class'] : null;
            $function = null;
            if (!empty($trace[$i]['function']) && $trace[$i]['function'] !== 'unknown') $function = $trace[$i]['function'];

            $args = !empty($trace[$i]['args']) ? $trace[$i]['args'] : [];
            $out .= $this->renderCallStackItem($file, $line, $class, $function, $args, $i + 2);
        }
        $out .= '</ul>';
        return $out;
    }

     function renderRequest(){
        $request = '';
        foreach ($this->displayVars as $name) if (!empty($GLOBALS[$name])) $request .= '$' . $name . ' = ' . VarDumper::export($GLOBALS[$name]) . ";\n\n";

        return '<pre>' . $this->htmlEncode(rtrim($request, "\n")) . '</pre>';
    }

   function isCoreFile($file){
        return $file === null || strpos(realpath($file), YII2_PATH . DIRECTORY_SEPARATOR) === 0;
    }

    function createHttpStatusLink($statusCode, $statusDescription){
        return '<a href="http://en.wikipedia.org/wiki/List_of_HTTP_status_codes#' . (int) $statusCode . '" target="_blank">HTTP ' . (int) $statusCode . ' &ndash; ' . $statusDescription . '</a>';
    }

    function createServerInformationLink(){
        $serverUrls = [
            'http://httpd.apache.org/' => ['apache'],
            'http://nginx.org/' => ['nginx'],
            'http://lighttpd.net/' => ['lighttpd'],
            'http://gwan.com/' => ['g-wan', 'gwan'],
            'http://iis.net/' => ['iis', 'services'],
            'http://php.net/manual/en/features.commandline.webserver.php' => ['development'],
        ];
        if (isset($_SERVER['SERVER_SOFTWARE'])) {
            foreach ($serverUrls as $url => $keywords) {
                foreach ($keywords as $keyword) if (stripos($_SERVER['SERVER_SOFTWARE'], $keyword) !== false) return '<a href="' . $url . '" target="_blank">' . $this->htmlEncode($_SERVER['SERVER_SOFTWARE']) . '</a>';


            }
        }

        return '';
    }


     function createFrameworkVersionLink(){
        return '<a href="http://github.com/yiisoft/yii2/" target="_blank">' . $this->htmlEncode(Yii::getVersion()) . '</a>';
    }


     function argumentsToString($args){
        $count = 0;
        $isAssoc = $args !== array_values($args);

        foreach ($args as $key => $value) {
            $count++;
            if ($count >= 5) {
                if ($count > 5) unset($args[$key]);
                 else $args[$key] = '...';

                continue;
            }

            if (is_object($value)) $args[$key] = '<span class="title">' . $this->htmlEncode(get_class($value)) . '</span>';
             elseif (is_bool($value)) $args[$key] = '<span class="keyword">' . ($value ? 'true' : 'false') . '</span>';
            elseif (is_string($value)) {
                                                    $fullValue = $this->htmlEncode($value);
                                                    if (mb_strlen($value, 'UTF-8') > 32) {
                                                        $displayValue = $this->htmlEncode(mb_substr($value, 0, 32, 'UTF-8')) . '...';
                                                        $args[$key] = "<span class=\"string\" title=\"$fullValue\">'$displayValue'</span>";
                                                    } else $args[$key] = "<span class=\"string\">'$fullValue'</span>";

            } elseif (is_array($value))             $args[$key] = '[' . $this->argumentsToString($value) . ']';
              elseif ($value === null)              $args[$key] = '<span class="keyword">null</span>';
              elseif (is_resource($value))          $args[$key] = '<span class="keyword">resource</span>';
              else                                  $args[$key] = '<span class="number">' . $value . '</span>';


             if (is_string($key))                   $args[$key] = '<span class="string">\'' . $this->htmlEncode($key) . "'</span> => $args[$key]";
             elseif ($isAssoc)                      $args[$key] = "<span class=\"number\">$key</span> => $args[$key]";

        }

        return implode(', ', $args);
    }


     function getExceptionName($exception){
        if ($exception instanceof \yii\base\Exception || $exception instanceof \yii\base\InvalidCallException || $exception instanceof \yii\base\InvalidParamException || $exception instanceof \yii\base\UnknownMethodException) {
            return $exception->getName();
        }

        return null;
    }

    protected function shouldRenderSimpleHtml(){
        return YII_ENV_TEST || Yii::$app->request->getIsAjax();
    }
}