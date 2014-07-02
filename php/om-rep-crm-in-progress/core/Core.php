<?php
error_reporting(E_ALL); // TODO: error reporting based on configuration
// TODO: default timezone

// Set locale to standard "en_US" UTF-8
setLocale(LC_CTYPE, 'en_US.UTF-8');

// Error messages of fatal errors
    // Server
    const ERROR_SERVER_DEFAULT_MAIN_SERVER_NOT_SET      = 'Default main server is not set';
    const ERROR_SERVER_DEFAULT_CURRENT_SERVER_NOT_SET   = 'Default current server is not set';
    const ERROR_SERVER_SERVER_VALUE_UNKNOWN             = 'Server value "{{{}}}" is unknown';
    // Connection
    const ERROR_CONNECTION_ARGUMENTS                    = 'Connection - insufficient arguments';

// Fundamental constants
define("PHP_INT_MIN", -PHP_INT_MAX);
define("PHP_FLOAT_MIN", __getMinFloat());
define("PHP_FLOAT_MAX", __getMaxFloat());
define("PHP_RAND_MAX", mt_getrandmax());
define("PHP_RAND_MIN", -mt_getrandmax());
define("IS_WINDOWS", PHP_OS == "Windows" || PHP_OS == "WINNT" ? true : false);
const STOP_HERE = 1;

// Constants for function options
    // Development/Production overrides
    const DEVELOPMENT           = 'development';
        const ON_LOCAL          = 'onLocal';
        const ON_SERVER         = 'onServer';
    const PRODUCTION            = 'production';

    // Server options
    const MAIN_SERVER           = 'mainServer';
    const CURRENT_SERVER        = 'currentServer';
    const CORE                  = 1;
    const OM                    = 2;
    const REP                   = 3;
    const CRM                   = 4;

    // Database options
    const HOST                  = 'host';
    const PORT                  = 'port';
    const NAME                  = 'name';
    const DATABASE              = NAME;
    const DATABASE_NAME         = NAME;
    const USER                  = 'user';
    const PASS                  = 'pass';

    // String options
    const LENGTH                = "length";
    const MIN_LENGTH            = "minLength";
    const MAX_LENGTH            = "maxLength";

    const LETTERS               = "letters";
    const NUMBERS               = "numbers";
    const SYMBOLS               = "symbols";
    const ALPHANUMERICS         = "alphanumerics";
    /*
    const NO_LETTERS            = "noLetters";
    const NO_NUMBERS            = "noNumbers";
    const NO_SYMBOLS            = "noSymbols";
    const NO_ALPHANUMERICS      = "noAlphanumerics";

    const ONLY_LETTERS          = "onlyLetters";
    const ONLY_NUMBERS          = "onlyNumbers";
    const ONLY_SYMBOLS          = "onlySymbols";
    const ONLY_ALPHANUMERICS    = "onlyAlphanumerics";

    // String modifiers
    const UPPER_CASE            = "upperCase";
    const LOWER_CASE            = "lowerCase";
    const MIXED_CASE            = "mixedCase";
    const DISTINCT              = "distinct";
    */
    const TRIM                  = "trim";
    const STRIP_TAGS            = "stripTags";
    const CONVERT_ENTITIES      = "convertEntities";
    const REMOVE_WHITESPACE     = "removeWhitespace";
    /*
    // Include, exclude
    const INC                   = "include";
    const EXC                   = "exclude";
    */

    // Organisation options
    const DESCRIPTION           = 'description';

    // User options
    const ROLE                  = 'role';
    const ACTIVE                = 'active';
    const UID                   = 'uid';
    // const PASS               = 'pass';
    const PASSWORD              = 'password';
    const TYPE                  = 'type';
    const FIRST_NAME            = 'firstName';
    const LAST_NAME             = 'lastName';
    const AVATAR                = 'avatar';
    const LANGUAGE              = 'language';
    const ORGANISATION          = 'org';
    const ADDRESS               = 'address';
    const CONTACT               = 'contact';
    const PRIMARY               = 1;

    // For 'DateTime' filed in database
    const DATETIME              = 'datetime';
    const SIGNED_UP             = 'signedUp';
    const REGISTERED            = 'registered';


class Configuration {
    // Production/Development Settings
    const DEVELOPMENT        = true; // true - Production settings, no debug information
    // false - Development settings, debugging enabled
    // Session Configurations
    const SESSION_NAME 		= "___UID"; // change the default PHPSESSID
    const SESSION_USER		= "ID"; // in $_SESSION["ID"] - user ID
    const SESSION_TOKEN 	= "token"; // in $_SESSION["token"]
    const SESSION_HTTP_ONLY = false; // Whether use "httponly" or not

    // Cookie Configurations
    const COOKIE_NAME		= "___hash";
    const COOKIE_EXPIRATION	= 604800; // 1 week
    const COOKIE_DEFAULT_EXPIRATION	= 604800; // 1 week

    const COMPANY_NAME      = 'Felix Martin';

    public static function isDevelopment() {
        return self::DEVELOPMENT;
    }
    public static function isProduction() {
        return !self::DEVELOPMENT;
    }
    public static function getRootPath() {
        return realpath(__DIR__ . DIRECTORY_SEPARATOR . '..');
    }
    public static function getPaths() {
        static $PATHS = [
            '/core/',      // Core directory - "/core/{className}.php"
            '/om/',     // OM directory - "/om/{className}.php"
            '/rep/',    // REP directory - "/rep/{className}.php"
            '/crm/'     // CRM directory - "/crm/{className}.php"
        ];
        return $PATHS;
    }
}

class System {
    use singletonTrait;

    private static
        $__development      = Configuration::DEVELOPMENT,
        $__onLocal          = false,
        $__onServer         = false,
        $__isInitialized    = false;

    public static function initialize( array $options = null ) {
        if( !is_null($options) ) {
            if( isset($options[PRODUCTION]) ) {
                self::$__development = false;
            }
            if( isset($options[DEVELOPMENT]) ) {
                self::$__development = true;
                if( $options[DEVELOPMENT] === ON_LOCAL ) {
                    self::$__onLocal = true;
                } else if( $options[DEVELOPMENT] === ON_SERVER ) {
                    self::$__onServer = true;
                } else {
                    //die('Development is only allowed either on local or on server');
                    LogSystem::addError('Development is only allowed either on local or on server');
                }
            }
            if( isset($options[MAIN_SERVER]) ) {
                Server::setMainServer($options[MAIN_SERVER]);
            }
        }

        Server::checkMainServer();
        Database::initializeLinks();

        self::$__isInitialized = true;
    }
    public static function isInitialized() {
        return self::$__isInitialized;
    }
    public static function isDevelopment() {
        return self::$__development;
    }
    public static function onLocal() {
        return self::$__development === true && self::$__onLocal === true;
    }
    public static function onServer() {
        return self::$__development === true && self::$__onServer === true;
    }
    public static function isProduction() {
        return !self::$__development;
    }
}

class Server {
    use singletonTrait;

    const NONE =    0;
    const OM =      OM;
    const REP =     REP;
    const CRM =     CRM;

    private static $__mainServer = self::NONE;

    // Main server
    public static function checkMainServer() {
        if( !self::mainServerSet() ) {
            //die(ERROR_SERVER_DEFAULT_MAIN_SERVER_NOT_SET);
            LogSystem::addError(ERROR_SERVER_DEFAULT_MAIN_SERVER_NOT_SET);
        }
        return self::$__mainServer;
    }
    public static function getMainServer() {
        self::checkMainServer();
        return self::$__mainServer;
    }
    public static function setMainServer($mainServer) {
        switch($mainServer) {
            case OM:
            case REP:
            case CRM:
                self::$__mainServer = $mainServer;
                break;
            default:
                //die(ERROR_SERVER_SERVER_VALUE_UNKNOWN);
                LogSystem::addError(ERROR_SERVER_SERVER_VALUE_UNKNOWN);
        }
    }
    public static function mainServerSet() {
        return self::$__mainServer !== self::NONE;
    }
}

class Database {
    use singletonTrait;

    private static
        $__isInitialized = false,
        $__CORELink = null,
        $__OMLink = null,
        $__REPLink = null,
        $__CRMLink = null;

    public static function initializeLinks() {
        $mainServer = Server::getMainServer();

        $accessCore = null;
        $accessOM = null;
        $accessREP = null;
        $accessCRM = null;

        if( System::isDevelopment() ) {
            $onLocal = System::onLocal();

            // Prepare connection to main server - it serves the core tables
            switch( Server::getMainServer() ) {
                case OM:
                    $accessCore = $onLocal ? \om\Configuration\Configuration::getLocalCoreAccess() : \om\Configuration\Configuration::getServerCoreAccess();
                    break;
                case REP:
                    $accessCore = $onLocal ? \rep\Configuration\Configuration::getLocalCoreAccess() : \rep\Configuration\Configuration::getServerCoreAccess();
                    break;
                case CRM:
                    $accessCore = $onLocal ? \crm\Configuration\Configuration::getLocalCoreAccess() : \crm\Configuration\Configuration::getServerCoreAccess();
                    break;
                default:
                    //die(ERROR_SERVER_SERVER_VALUE_UNKNOWN);
                    LogSystem::addError(ERROR_SERVER_SERVER_VALUE_UNKNOWN);
            }

            if( $onLocal ) {
                $accessOM = \crm\Configuration\Configuration::getLocalOMAccess();
                $accessREP = \crm\Configuration\Configuration::getLocalREPAccess();
                $accessCRM = \crm\Configuration\Configuration::getLocalCRMAccess();
            } else { // onServer
                $accessOM = \om\Configuration\Configuration::getServerOMAccess();
                $accessREP = \rep\Configuration\Configuration::getServerREPAccess();
                $accessCRM = \crm\Configuration\Configuration::getServerCRMAccess();
            }

        } else { // System::isProduction()

            // Prepare connection to main server - it serves the core tables
            switch( Server::getMainServer() ) {
                case OM:
                    $accessCore = \om\Configuration\Configuration::getProdCoreAccess();
                    break;
                case REP:
                    $accessCore = \rep\Configuration\Configuration::getProdCoreAccess();
                    break;
                case CRM:
                    $accessCore = \crm\Configuration\Configuration::getProdCoreAccess();
                    break;
                default:
                    //die(ERROR_SERVER_SERVER_VALUE_UNKNOWN);
                    LogSystem::addError(ERROR_SERVER_SERVER_VALUE_UNKNOWN);
            }

            $accessOM = \om\Configuration\Configuration::getProdOMAccess();
            $accessREP = \rep\Configuration\Configuration::getProdREPAccess();
            $accessCRM = \crm\Configuration\Configuration::getProdCRMAccess();

        }

        self::$__CORELink   = new Connection($accessCore);
        //self::$__CORELink   = new Connection(\crm\Configuration\Configuration::getProdCRMAccess());
        self::$__OMLink     = new Connection($accessOM);
        self::$__REPLink    = new Connection($accessREP);
        self::$__CRMLink    = new Connection($accessCRM);

        self::$__isInitialized = true;
    }
    public static function getCoreLink() {
        return self::$__CORELink;
    }
    public static function getOMLink() {
        return self::$__OMLink;
    }
    public static function getREPLink() {
        return self::$__REPLink;
    }
    public static function getCRMLink() {
        return self::$__CRMLink;
    }
    public static function isInitialized() {
        return self::$__isInitialized;
    }
}

// Helper function to determine min and max float values
function __getMinFloat() {
    $_32bit = 1.175494351E-38;          // standard 32bit float minimum
    $_64bit = 2.2250738585072014E-308;  // standard 64bit float minimum
    return ( $_64bit !== 0 ) ? $_64bit : $_32bit;
}
function __getMaxFloat() {
    $_32bit = 3.4028234E38;             // standard 32bit float minimum
    $_64bit = 1.7976931348623158E308;   // standard 64bit float minimum
    return ( $_64bit !== INF ) ? $_64bit : $_32bit;
}
// Helper function to swap values
function swap( &$a, &$b ) {
    $t = $a;
    $a = $b;
    $b = $t;
}
// Helper function for "string" to duration
function durationFrom( $value ) {
    if( is_string($value) ) {
        $months = 0;
        $weeks = 0;
        $days = 0;
        $hours = 0;
        $minutes = 0;
        $seconds = 0;

        $pattern = "/(?P<value>[\d\.]{1,})\s{0,}(?P<key>\w{0,})/";
        $matches = null;
        preg_match_all( $pattern, $value, $matches );

        if( isset($matches["key"]) ) {
            foreach( $matches["key"] as $key => $value ) {
                foreach(["month","months","mon"] as $subKey) {
                    if( $value === $subKey ) { $months = floatval($matches["value"][$key]) * 2592000; break; }
                }
                foreach(["week","weeks","w"] as $subKey) {
                    if( $value === $subKey ) { $weeks = floatval($matches["value"][$key]) * 604800; break; }
                }
                foreach(["days","day","d"] as $subKey) {
                    if( $value === $subKey ) { $days = floatval($matches["value"][$key]) * 86400; break; }
                }
                foreach(["hours","hour","h"] as $subKey) {
                    if( $value === $subKey ) { $hours = floatval($matches["value"][$key]) * 3600; break; }
                }
                foreach(["min","minutes","m","minute"] as $subKey) {
                    if( $value === $subKey ) { $minutes = floatval($matches["value"][$key]) * 60; break; }
                }
                foreach(["sec","seconds","s","second"] as $subKey) {
                    if( $value === $subKey ) { $seconds = floatval($matches["value"][$key]); break; }
                }
            }
        }
        return round($months + $weeks + $days + $hours + $minutes + $seconds);

    } else if( is_array($value) ) {
        $months = 0;
        $weeks = 0;
        $days = 0;
        $hours = 0;
        $minutes = 0;
        $seconds = 0;

        foreach(["month","months","mon"] as $key) {
            if( isset($value[$key]) ) { $months = floatval($value[$key]) * 2592000; break; }
        }
        foreach(["week","weeks","w"] as $key) {
            if( isset($value[$key]) ) { $weeks = floatval($value[$key]) * 604800; break; }
        }
        foreach(["days","day","d"] as $key) {
            if( isset($value[$key]) ) { $days = floatval($value[$key]) * 86400; break; }
        }
        foreach(["hours","hour","h"] as $key) {
            if( isset($value[$key]) ) { $hours = floatval($value[$key]) * 3600; break; }
        }
        foreach(["min","minutes","m","minute"] as $key) {
            if( isset($value[$key]) ) { $minutes = floatval($value[$key]) * 60; break; }
        }
        foreach(["sec","seconds","s","second"] as $key) {
            if( isset($value[$key]) ) { $seconds = floatval($value[$key]); break; }
        }

        return round($months + $weeks + $days + $hours + $minutes + $seconds);
    }
    return 0;
}
// Helper trait for singleton pattern enforcement
trait singletonTrait {
    // Singleton pattern enforcements
    private function __construct() {}
    public function __clone() {
        trigger_error('Cloning is not allowed.', E_USER_ERROR);
    }
    public function __wakeup() {
        trigger_error('Unserializing is not allowed.', E_USER_ERROR);
    }
}
// Class autoloading with namespaces
spl_autoload_register(function ( $className ) {
    $root = Configuration::getRootPath();
    $paths = Configuration::getPaths();

    $pos = strrpos( $className, '\\' );
    if( $pos !== false ) {
        $fileName = substr( $className, $pos+1 );
    } else {
        $fileName = $className;
    }

    foreach( $paths as $path ) {
        $file = $root . $path . $fileName . ".php";
        if( is_readable($file) ) {
            require_once $file;
        }
    }
});

// Log Functions TODO: improve functionalities
// Trace out directly to page
function trace() {
    $ac = func_num_args();
    $av = func_get_args();
    $r = '';
    for($i = 0, $B = $ac-1, $e = null; $i < $ac; ++$i) {
        $e = $av[$i];
        if( is_bool($e) ) {
            $r .= $e === true ? 'true' : 'false';
        } else {
            $r .= (string)$av[$i];
        }
        if($i < $B) {
            $r .= ', ';
        }
    }
    echo $r. "\n";
};

class LogSystem {
    use singletonTrait;

    private static $__errors = [];

    public static function addError( $data ) {
        self::$__errors[] = $data;
    }
    public static function hasErrors() {
        return count(self::$__errors) > 0;
    }public static function getErrors() {
        return self::$__errors;
    }
    public static function echoErrors() {
        $containerStart = '<div id="logError"><ul>';
        $containerEnd = '</ul></div>';
        $content = '';
        foreach( self::$__errors as $error ) {
            $content .= "<li>{$error}</li>";
        }
        if( self::hasErrors() ) {
            echo $containerStart . $content . $containerEnd;
        }
    }
}
function L() {
    L::__writeToLogFile( 0, func_num_args(), func_get_args() );
};
function IL( $indentation = 0 ) {
    $ac = func_num_args() - 1;
    $av = func_get_args();
    array_shift( $av );
    L::__writeToLogFile( $indentation, $ac, $av );
};
function T() {
    L::__writeToLogFile( 0, func_num_args(), func_get_args(), true );
}
function IT( $indentation ) {
    $ac = func_num_args() - 1;
    $av = func_get_args();
    array_shift( $av );
    L::__writeToLogFile( $indentation, $ac, $av, true );
}

class L {
    use singletonTrait;

    const DEFAULT_PATH      = "logs";
    const DEFAULT_LOG       = "log";
    const DEFAULT_ERROR     = "[ERROR]";

    private static $isInitialized = false;
    private static $path = null;
    private static $logFile = self::DEFAULT_LOG;
    private static $logFileOpened = false;
    private static $logFileHandler = null;
    private static $errorFile = self::DEFAULT_ERROR;
    private static $errorFileOpened = false;
    private static $errorFileHandler = null;

    private static function initialize() {
        if( self::$isInitialized ) {
            return;
        }
        self::$path = Configuration::getRootPath() .'\\'. self::DEFAULT_PATH;
    }

    private static function __openLogFile() {
        self::initialize();
        if( self::$logFileOpened ) {
            return;
        }

        if( !file_exists( self::$path ) ) {
            mkdir( self::$path, 0777, true );
        }

        $f = self::$path ."/". date("Y-m-d_H-i-s") . "-". self::$logFile . ".txt";
        self::$logFileHandler = fopen( $f, "w" );

        if( self::$logFileHandler ) {
            self::$logFileOpened = true;
        }

        trace( $f, self::$logFileHandler, self::$logFileOpened );
    }
    private static function __openErrorFile() {
        self::initialize();
        if( self::$errorFileOpened ) {
            return;
        }

        if( !file_exists( self::$path ) ) {
            mkdir( self::$path, 0777, true );
        }

        $f = self::$path ."/". date("Y-m-d_H-i-s") . "-". self::$errorFile . ".txt";
        self::$errorFileHandler = fopen( $f, "w" );
        if( self::$errorFileHandler ) {
            self::$errorFileOpened = true;
        }
    }
    private static function isPrimitive( $variable ) {
        return ( is_numeric($variable) || is_string($variable) || is_bool($variable) || is_null($variable) );
    }
    private static function isContainer( $variable ) {
        return ( is_array($variable) || is_object($variable) );
    }
    private static function logPrimitive( $variable ) {
        if( is_numeric($variable) ) {
            return $variable;
        } else if( is_bool($variable) ) {
            return $variable === true ? "true" : "false";
        } else if( is_string($variable) ) {
            return $variable;
        } else if( is_null($variable) ) {
            return "null";
        }
        return "";
    }
    private static function logContainer( &$variable ) {
        return self::getContainer( $variable );
    }
    private static function tracePrimitive( $variable ) {
        if( is_int($variable) ) {
            return "int( {$variable} )";
        } else if( is_float($variable) ) {
            return "float( {$variable} )";
        } else if( is_bool($variable) ) {
            return $variable === true ? "boolean( TRUE )" : "boolean( FALSE )";
        } else if( is_string($variable) ) {
            $length = mb_strlen($variable);
            return "string({$length}) \"{$variable}\"";
        } else if( is_null($variable) ) {
            return "NULL";
        }
        return "";
    }
    private static function traceContainer( &$variable ) {
        return self::getContainer( $variable, true );
    }
    private static function getKey( &$key ) {
        if( is_numeric($key) ) {
            return "[{$key}] => ";
        } else {
            return "[\"{$key}\"] => ";
        }
    }
    private static function getContainer( &$var, $trace = false, $indentation = 0 ) {
        if( !$trace ) { // regular Log
            $isArray = is_array($var);

            $i = 0;
            $B = count((array)$var) - 1; // boundary
            $result = "";

            foreach( $var as $key => $value ) {
                if( self::isPrimitive($value) ) {
                    if( is_numeric($key) ) {
                        $result .= self::logPrimitive($value);
                    } else {
                        $result .=  self::getKey($key). self::logPrimitive($value);
                    }
                } else if( self::isContainer($value) ) {
                    if( is_numeric($key) ) {
                        $result .= self::getContainer($value);
                    } else {
                        $result .=  self::getKey($key). self::getContainer($value);
                    }
                } else {
                    $result .= gettype($value);
                }

                if( $i++ < $B ) { $result .= ", "; }
            }

            if( $isArray ) {
                return "[ {$result} ]";
            } else { // is_object(...)
                return "{ {$result} }";
            }

        } else { // "Trace out"
            $isArray = is_array($var);

            $endInd = "";
            for( $i=$indentation; $i--; ) { $endInd .= "\t"; }
            $ind = $endInd."\t";

            $i = 0;
            $L = count((array)$var); // length
            $B = $L - 1; // boundary
            $result = "";

            foreach( $var as $key => $value ) {
                if( self::isPrimitive($value) ) {
                    $result .=  $ind. self::getKey($key). self::tracePrimitive($value);
                } else if( self::isContainer($value) ) {
                    $result .=  $ind. self::getKey($key). self::getContainer($value, true, ++$indentation);
                    $indentation = 0;
                } else {
                    $result .= gettype($value);
                }

                if( $i++ < $B ) { $result .= PHP_EOL; }
            }

            if( $isArray ) {
                return "Array({$L}) [" .PHP_EOL. "{$result}" .PHP_EOL. "{$endInd}]";
            } else { // is_object(...)
                return "Object({$L}) {" .PHP_EOL. "{$result}" .PHP_EOL. "{$endInd}}";
            }

        }

    }

    public static function __writeToLogFile( $indentation, $ac, array $av, $trace = false ) {
        if( !self::$logFileOpened ) {
            self::__openLogFile();
        }

        $i = 0;
        $B = $ac - 1; // boundary
        $result = "";

        if( $indentation < 0 ) { $indentation = 0; }
        while( $indentation-- ) { $result .= "\t"; }

        if( !$trace ) { // just "Log out"
            foreach( $av as $element ) {
                if( self::isPrimitive($element) ) {
                    $result .= self::logPrimitive($element);
                } else if( self::isContainer($element) ) {
                    $result .= self::logContainer($element);
                } else {
                    $result .= gettype($element);
                }

                if( $i++ < $B ) { $result .= ", "; }
            }

        } else { // "Trace out"
            foreach( $av as $element ) {
                if( self::isPrimitive($element) ) {
                    $result .= self::tracePrimitive($element);
                } else if( self::isContainer($element) ) {
                    $result .= self::traceContainer($element);
                } else {
                    $result .= gettype($element);
                }

                if( $i++ < $B ) { $result .= ", "; }
            }
        }
        $result .= PHP_EOL;
        //echo $result;
        fwrite( self::$logFileHandler, $result );
    }
    public static function __closeLogFile() {
        if( !self::$logFileOpened ) {
            return;
        }
        fclose( self::$logFileHandler );
        self::$logFileOpened = false;
    }
    public static function __writeAndCloseErrorFile() {
        // Error file
        if( LogSystem::hasErrors() ) {
            if( !self::$errorFileOpened ) {
                self::__openErrorFile();
            }
            $result = '';

            foreach(LogSystem::getErrors() as $error) {
                $result .=  $error. PHP_EOL;
            }
            fwrite( self::$errorFileHandler, $result );
        }
    }
}
register_shutdown_function(function(){
    L::__closeLogFile();
    L::__writeAndCloseErrorFile();
});

// GET
function Get( $item = null ) {
    if( is_string($item) ) {
        return isset($_GET[$item]) ? $_GET[$item] : "";
    }
    return $_GET;
}

class Get {
    use singletonTrait;

    public static function exists( $item = null ) {
        if( is_string($item) ) {
            return isset($_GET[$item]);
        }
        return !empty($_GET);
    }
}

// POST
function Post( $item ) {
    if( is_string($item) ) {
        return isset($_POST[$item]) ? $_POST[$item] : "";
    }
    return $_POST;
};

class Post {
    use singletonTrait;

    public static function exists( $item = null ) {
        if( is_string($item) ) {
            return isset($_POST[$item]);
        }
        return !empty($_POST);
    }
}

// SESSION
function Session( $item, $delete = false ) {
    if( is_string($item) ) {
        if( $delete === true ) {
            if( isset($_SESSION[$item]) ) {
                $retVal = $_SESSION[$item];
                $_SESSION[$item] = array();
                unset($_SESSION[$item]);
                return $retVal;
            }
            return "";
        }
        return isset($_SESSION[$item]) ? $_SESSION[$item] : "";
    }
    return $_SESSION;
};

class Session {
    use singletonTrait;

    public static function start( $name = null ) {
        if( !is_string($name) ) {
            $name = Configuration::SESSION_NAME;
        }
        if( Configuration::SESSION_HTTP_ONLY === true ) {
            ini_set( 'session.cookie_httponly', 1 );
        }
        session_name( $name );
        session_start( $name );
    }
    public static function startAndRegenerate( $name = null, $deleteOldSession = false ) {
        self::start( $name );
        self::regenerate( $deleteOldSession );
    }
    public static function destroy() {
        $_SESSION = array();
        session_unset();
        session_destroy();
    }
    public static function restart() {
        self::destroy();
        self::start();
    }
    public static function regenerate( $deleteOldSession = false ) {
        session_regenerate_id( $deleteOldSession );
    }
    public static function exist( $item = null ) {
        if( is_string($item) ) {
            return isset($_SESSION) && isset($_SESSION[$item]);
        }
        return !empty($_SESSION);
    }
    public static function delete( $item = null ) {
        if( is_string($item) ) {
            if( isset($_SESSION) ) {
                unset($_SESSION[$item]);
            }
        }
    }
}

class Page {
    use singletonTrait;

    const MAIN      = "main.php";
    const SIGN_IN   = "sign_in.php";
    const SIGN_OUT  = "sign_out.php";
    const SIGN_ON   = "sign_on.php";

    // Order Management
        const OM        = "om.php"; // Main site

    // Reporting
        const REP       = "rep.php"; // Main site

    // Customer Relationship Management
        const CRM       = "crm.php"; // Main site

    public static function echoCurrentTitle() {
        echo self::getCurrentTitle();
    }
    public static function getCurrentTitle() {
        $scriptName = basename($_SERVER['PHP_SELF']);
        $pageName = self::getTitle($scriptName);

        return Configuration::COMPANY_NAME .' - '. $pageName;
    }
    public static function getTitle($page) {
        switch($page) {
            case self::MAIN:        return 'Main';
            case self::SIGN_IN:     return 'Sign In';
            case self::SIGN_OUT:    return 'Sign Out';
            case self::SIGN_ON:     return 'Sign On';

            case self::OM:          return 'Order Management';
            case self::REP:         return 'Reporting';
            case self::CRM:         return 'Customer Relationship Management';

            default: return 'Unknown';
        }
    }
}

// REDIRECT
function Redirect( $to ) {
    header( "Location: " . $to );
    die();
};

// COOKIE
function Cookie( $name = null, $delete = false ) {
    if( is_string($name) ) {
        return isset($_COOKIE[$name]) ? $_COOKIE[$name] : null ;
    }
    return isset($_COOKIE) ? $_COOKIE : null ;
};

class Cookie {
    use singletonTrait;

    public static function exists( $name = null, $value = null ) {
        if( is_string($name) ) {
            if( isset($_COOKIE[$name]) ) {
                return true;
            }
        }
        return self::numCookies() > 0 ? true : false;
    }
    public static function get( $name ) {
        if( is_string($name) ) {
            return isset($_COOKIE[$name]) ? $_COOKIE[$name] : "";
        }
        return "";
    }
    public static function set( $name, $value = null, $expiration = null, $path = null, $domain = null, $secure = false, $httponly = false ) {
        if( is_string($name) ) {
            if( is_numeric($expiration) ) {
                $expiration = time() + $expiration;
            } else if( is_string($expiration) ) {
                $expiration = time() + durationFrom($expiration);
            } else {
                $expiration = time() + Configuration::COOKIE_DEFAULT_EXPIRATION;
            }
            setcookie($name, $value, $expiration, $path, $domain, $secure, $httponly);
        }
    }
    public static function delete( $name ) {
        if( is_string($name) ) {
            if( isset($_COOKIE[$name]) ) {
                $_COOKIE[$name] = [];
                unset($_COOKIE[$name]);
            }
            setcookie( $name, "", time()-3600 );
        }
    }

    public static function numCookies() {
        return isset($_COOKIE) ? count((array)$_COOKIE) : 0;
    }
    public static function getCookies() {
        $result = [];
        if( isset($_COOKIE) ) {
            foreach( $_COOKIE as $key => $value ) {
                $result[$key] = $value;
            }
        }
        return $result;
    }
    public static function deleteCookies() {
        if( isset($_COOKIE) ) {
            foreach( $_COOKIE as $key => $value ) {
                self::delete($key);
            }
            $_COOKIE = [];
            unset($_COOKIE);
        }
    }
}

// VALIDATION
function validBoolean( $value ) {
    if( !is_null($value) ) {
        if( is_string($value) ) { $value = trim($value); }
        return filter_var($value, FILTER_VALIDATE_BOOLEAN) !== false;
    }
    return false;
}
function validInt( $value ) {}
function validFloat( $value ) {}
function validString( $value ) {}

function validEmail() {}
function validPhone() {}

// FILTER
function filterBoolean( $value, array $options = null ) {
    if( !is_null($value) && !empty($value) ) {
        if( is_string($value) ) { $value = trim($value); }
        return filter_var($value, FILTER_VALIDATE_BOOLEAN);
    }
    return false;
}
function filterInt( $value, array $options = null ) {
    /*
    if( !is_null($value) && !empty($value) ) {
        if( is_string($value) ) { $value = trim($value); }
        if( $minimum > $maximum ) { swap($minimum, $maximum); }
        $value = filter_var($value, FILTER_VALIDATE_INT);
        if( $value === false ) { return 0; }
        return ( $value >= $minimum && $value <= $maximum ) ? $value : 0;
    }
    */
    return 0;
}
function filterFloat( $value, array $options = null ) {
    /*
    if( !is_null($value) && !empty($value) ) {
        if( is_string($value) ) { $value = trim($value); }
        if( $minimum > $maximum ) { swap($minimum, $maximum); }
        $value = filter_var($value, FILTER_VALIDATE_FLOAT);
        if( $value === false ) { return 0; }
        return ( $value >= $minimum && $value <= $maximum ) ? $value : 0;
    }
    */
    return 0;
}
function filterString( $value, array $options = null ) {
    if( is_string($value) && !empty($value) ) {
        $length = mb_strlen($value);

        // Check for options
        if( !is_null($options) ) {
            $minLength = 0;
            $maxLength = PHP_INT_MAX; // Maximum size of a "string" in PHP (2GBs)

            $letters = (array_search(LETTERS, $options, true) !== false) ? true : false;
            $numbers = (array_search(NUMBERS, $options, true) !== false) ? true : false;
            $symbols = (array_search(SYMBOLS, $options, true) !== false) ? true : false;
            if(array_search(ALPHANUMERICS, $options, true) !== false) { $letters = $numbers = true; }

            // Check for modifiers
            if( array_search(STRIP_TAGS, $options, true) !== false ) { $value = strip_tags($value); }
            if( array_search(CONVERT_ENTITIES, $options, true) !== false ) { $value = htmlentities($value, ENT_QUOTES, "UTF-8"); }
            if( array_search(TRIM, $options, true) !== false ) { $value = trim($value); }
            if( array_search(REMOVE_WHITESPACE, $options, true) !== false ) { $value = preg_replace('/\s/', '', $value); }

            // Check for length options
            if( isset($options[LENGTH]) ) {
                $minLength = $maxLength = (int)$options[LENGTH];
            } else { // looking for $options[MIN_LENGTH] and $options[MAX_LENGTH]
                if( isset($options[MIN_LENGTH]) ) { $minLength = (int)$options[MIN_LENGTH]; }
                if( isset($options[MAX_LENGTH]) ) { $maxLength = (int)$options[MAX_LENGTH]; }
                if( $minLength > $maxLength ) { swap($minLength, $maxLength); }
            }

            $pattern = "";
            if( $letters ) { $pattern .= "a-z\\s"; }
            if( $numbers ) { $pattern .= "0-9\\s"; }
            if( $symbols ) { $pattern .= "\\x{20}-\\x{2F}\\x{3A}-\\x{40}\\x{5B}-\\x{60}\\x{7B}-\\x{7E}\\s\\t\\n\\r"; }
            if( $pattern !== "" ) {
                $pattern = "/[^". $pattern ."]/i";
                $value = preg_replace($pattern, "", $value);
            }
            T( $value );

            $length = mb_strlen($value);
            if( $length >= $maxLength ) { $value = mb_substr($value, 0, $maxLength); }

            return ( $minLength <= $length ) ? $value : "";
        }


        return $value;
    }
    return "";
}

function filterHTML( $value, array $options = null ) {
    /*
    if( is_string($value) ) {
        if( $onlySpecialChars ) {
            return htmlspecialchars( $value, ENT_QUOTES, "UTF-8" );
        } else {
            return htmlentities( $value, ENT_QUOTES, "UTF-8" );
        }
    }
    */
    return "";
}

// Generators
class Generate {
    use singletonTrait;

    public static function hash( $string, $salt = "" ) {
        return hash( "sha512", $string . $salt );
    }
    public static function salt( $length = 64 ) {
        return mcrypt_create_iv( $length );
    }
    public static function UID() {
        return self::hash( uniqid() );
    }
}

// DATABASE CONNECTION
class Connection {

    private
        $_databaseHost,
        $_databasePort,
        $_databaseUser,
        $_databasePass,
        $_databaseName,

        $_pdo,
        $_numResults,
        $_success,
        $_stmt;

    public function __construct( array $options = null ) {

        if( is_null($options) || empty($options) ) {
            //die(ERROR_CONNECTION_ARGUMENTS);
            LogSystem::addError(ERROR_CONNECTION_ARGUMENTS);
        }

        if( isset($options[HOST]) ) {
            $this->_databaseHost = $options[HOST];
        }
        if( isset($options[PORT]) ) {
            $this->_databasePort = $options[PORT];
        }
        if( isset($options[USER]) ) {
            $this->_databaseUser = $options[USER];

        }
        if( isset($options[PASS]) ) {
            $this->_databasePass = $options[PASS];
        }
        if( isset($options[NAME]) ) {
            $this->_databaseName = $options[NAME];
        }

        try {
            $str = "mysql:host={$this->_databaseHost};dbname={$this->_databaseName};port={$this->_databasePort}";
            L( $str );

            $this->_pdo = new PDO($str, $this->_databaseUser, $this->_databasePass);
            $this->_pdo->setAttribute( PDO::ATTR_EMULATE_PREPARES, false );
            $this->_pdo->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );

            $this->_pdo->exec("SET NAMES UTF8");
            //$this->_pdo->exec("SET OPTION SQL_SELECT_LIMIT=DEFAULT"); - MySQL bug
            //T( $this->_pdo );

        } catch( PDOException $e ) {
            //die( $e->getCode() ."\n". $e->getMessage() );
            LogSystem::addError( 'code:['.$e->getCode()."]; message:[".$e->getMessage().']; str:['.$str.']' );
        }
    }
    public function __destruct() {
        $this->_pdo = null;
    }

    // get "raw" PDO object for custom usage
    public function getPDO() {
        return $this->_pdo;
    }
    // Single queries
    // TODO: production error handling
    public function query( $queryString, array $bindings = null ) {
        $this->_success = false;
        $this->_numResults = 0;
        $this->_stmt = null;

        if( $this->_pdo ) {
            try {
                $statement = $this->_pdo->prepare($queryString);
                $statement->setFetchMode(PDO::FETCH_OBJ); // TODO: ability to change fetch mode
                if( !is_null($bindings) ) {
                    $this->_success = $statement->execute($bindings);
                } else {
                    $this->_success = $statement->execute();
                }

            } catch( PDOException $e ) {
                die( $e->getCode() ."\n". $e->getMessage() );
                LogSystem::addError( 'code:['.$e->getCode()."]; message:[".$e->getMessage().']; str:['.$str.']' );
            }
        } else {
            LogSystem::addError( 'PDO is null' );
        }

        if( $this->_success ) {
            $this->_numResults = $statement->rowCount();
            $this->_stmt = $statement;
        } else {
            $this->_numResults = 0;
        }
        return $this->_success;
    }
    public function succeeded() {
        return $this->_success === true;
    }
    public function numResults() {
        return $this->_numResults;
    }
    public function getResults() {
        if( $this->_success ) {
            return $this->_stmt->fetchAll();
        }
        return null;
    }
    public function getFirst() {
        if( $this->_success ) {
            return $this->_stmt->fetch();
        }
        return null;
    }
    public function getLast() {
        if( $this->_success ) {
            $r = $this->_stmt->fetchAll(); // TODO: improve this
            return end($r);
        }
        return null;
    }
    public function getLastInsertID() {
        if( $this->_success ) {
            return intval($this->_pdo->lastInsertId());
        }
        return 0;
    }
}

class Auth {
    public static function authenticate( $uid, $password ) {}

    public static function signInUser( $uid, $password ) {}
    public static function signOutUser( $userID = null ) {}
}

class Activity {

    // Sign in/out on the 'main site'
    const SIGN_IN       = 1;
    const SIGN_OUT      = 2;
    // Navigate from the 'main site'
    const GO_TO_OM      = 3;
    const GO_TO_REP     = 4;
    const GO_TO_CRM     = 5;

    public static function addActivity( $userID, $activityType, $activityData = null ) {
        $core = Database::getCoreLink();
        $query = 'INSERT INTO `activity` (`type`, `data`, `datetime`, `userID`)
                                  VALUES (:type,  :data,  :datetime,  :userID)';
        $core->query($query, [
            ':type' => $activityType,
            ':data' => $activityData,
            ':datetime' => date("Y-m-d H:i:s"),
            ':userID' => $userID
        ]);
    }
}

class Role {
    const CUSTOMER          = 1;
    const EMPLOYEE          = 2;
    const MANAGER           = 3;
    const ADMINISTRATOR     = 4;
}

class Type {
    const EMPLOYEE      = 1;
    const MANAGER       = 2;
    const CLIENT        = 3;
    const SUPPLIER      = 4;
}

class User {

    const ACTIVE    = 1;
    const INACTIVE  = 0;

    // Add / Sign up / register user
    public static function addUser( array $users = null ) {
        if( !is_null($users) && !empty($users) ) {
            $core = Database::getCoreLink();
            $queryInsertUser = 'INSERT INTO `user` (`roleID`, `active`, `uid`, `hash`, `salt`, `type`, `firstName`, `lastName`, `avatar`, `signedUp`)
                                            VALUES (:roleID,  :active,  :uid,  :hash,  :salt,  :type,  :firstName,  :lastName,  :avatar,  :signedUp);';
            foreach($users as $user) {

                $roleID = $user[ROLE];
                //$active = $user[ACTIVE] === User::ACTIVE ? User::ACTIVE : User::INACTIVE;
                $active = isset($user[ACTIVE]) ? $user[ACTIVE] : User::ACTIVE;
                $uid = $user[UID];
                $pass = $user[PASS];
                $salt = Generate::salt();
                $hash = Generate::hash( $pass, $salt );
                $salt = base64_encode( $salt );
                $type = $user[TYPE];
                $firstName = $user[FIRST_NAME];
                $lastName = $user[LAST_NAME];
                $avatar = (isset($user[AVATAR]) && is_string($user[AVATAR])) ? $user[AVATAR] : null;
                $signedUp = (isset($user[SIGNED_UP]) && is_string($user[SIGNED_UP])) ? $user[SIGNED_UP] : date("Y-m-d H:i:s");

                $core->query($queryInsertUser, [
                    ':roleID'       => $roleID,
                    ':active'       => $active,
                    ':uid'          => $uid,
                    ':hash'         => $hash,
                    ':salt'         => $salt,
                    ':type'         => $type,
                    ':firstName'    => $firstName,
                    ':lastName'     => $lastName,
                    ':avatar'       => $avatar,
                    ':signedUp'     => $signedUp
                ]);
                $userID = $core->getLastInsertID(); // get the userID of the user previously inserted

                if( isset($user[ORGANISATION]) ) {
                    Organisation::addOrganisationToUser($userID, $user[ORGANISATION]);
                }
                if( isset($user[LANGUAGE]) ) {
                    Language::addLanguageToUser($userID, $user[LANGUAGE]);
                }
                if( isset($user[ADDRESS]) ) {
                    Address::addAddressToUser($userID, $user[ADDRESS]);
                }
                if( isset($user[CONTACT]) ) {
                    Contact::addContactToUser($userID, $user[CONTACT]);
                }
            }
        }
    }

    public static function isSignedIn() {}
    public static function getCurrentUser() {
        //return new User();
    }
    public static function signOutCurrentUser() {}

    public static function getUserByName( array $options = null ) {
        return null;
    }
    public static function getUserByID( $userID ) {
        if( !is_null($userID) ) {
            $core = Database::getCoreLink();
            $query = 'SELECT * FROM `user` WHERE :userID = 1001 LIMIT 1;';
            $core->query($query, [':userID' => $userID]);
            if( $core->numResults() === 1 ) {
                return new User($core->getFirst());
            }
        }
        return null;
    }
    public static function getUserIDByName( array $options = null ) {
        if(is_array($options)) {
            $core = Database::getCoreLink();
            $query = null;
            $bindigs = null;

            $firstName = (isset($options[FIRST_NAME]) && is_string($options[FIRST_NAME])) ? $options[FIRST_NAME] : null;
            $lastName = (isset($options[LAST_NAME]) && is_string($options[LAST_NAME])) ? $options[LAST_NAME] : null;

            if( $firstName !== null && $lastName !== null ) { // FIRST_NAME and LAST_NAME was given too
                $query = 'SELECT `userID` FROM `user` WHERE `firstName` LIKE :firstName AND `lastName` LIKE :lastName LIMIT 1;';
                $bindigs = [':firstName' => $firstName, ':lastName' => $lastName];

            } else if( $firstName !== null ) { // only FIRST_NAME was given
                $query = 'SELECT `userID` FROM `user` WHERE `firstName` LIKE :firstName LIMIT 1;';
                $bindigs = [':firstName' => $firstName];

            } else if( $lastName !== null ) { // only LAST_NAME was given
                $query = 'SELECT `userID` FROM `user` WHERE `lastName` LIKE :lastName LIMIT 1;';
                $bindigs = [':lastName' => $lastName];
            }

            $core->query($query, $bindigs);
            if( $core->numResults() === 1 ) {
                return $core->getFirst()->userID;
            }
        }
        return 0;
    }

    private
        $_userID,
        $_roleID,

        $_active,
        $_uid,

        $_type,
        $_firstName,
        $_lastName,
        $_avatar,
        $_signedUp,

        $_organisations,
        $_languages,
        $_addresses,
        $_contacts;

    protected function __construct( $user ) {
        $this->_userID  = $user->userID;
        $this->_roleID  = $user->roleID;
        $this->_active  = $user->active === 1 ? 1 : 0;
        $this->_uid     = $user->uid;
        $this->_type    = $user->type;
        $this->_firstName   = $user->firstName;
        $this->_lastName    = $user->lastName;
        $this->_avatar      = !is_null($user->avatar) ? $user->avatar : null;
        $this->_signedUp    = $user->signedUp;


    }

    public function getID() {
        return $this->_userID;
    }
    public function getRoleID() {
        return $this->_roleID;
    }
    public function is( $role ) {
        return $this->_role === $role;
    }
    public function isActive() {
        return $this->_active === 1;
    }
    public function getUID() {
        return $this->_uid;
    }
    public function getType() {
        return $this->_type;
    }
    public function getName() {
        return $this->_firstName ." ". $this->_lastName;
    }
    public function getFirstName() {
        return $this->_firstName;
    }
    public function getLastName() {
        return $this->_lastName;
    }
    public function hasAvatar() {
        return $this->_avatar === null;
    }
    public function getAvatar() {
        return $this->_avatar;
    }
    public function getSignedUp() {
        return $this->_signedUp;
    }

    public function hasOrganisations() {
        return $this->numOrganisations() > 0;
    }
    public function numOrganisations() {
        count($this->_organisations);
    }
    public function getOrganisations() {
        $this->_organisations;
    }
    public function hasLanguages() {
        return $this->numLanguages() > 0;
    }
    public function numLanguages() {
        count($this->_languages);
    }
    public function getLanguages() {
        $this->_languages;
    }
    public function hasAddresses() {
        return $this->numAddresses() > 0;
    }
    public function numAddresses() {
        count($this->_addresses);
    }
    public function getAddresses() {
        $this->_addresses;
    }
    public function hasContacts() {
        return $this->numContacts() > 0;
    }
    public function numContacts() {
        count($this->_contacts);
    }
    public function getContacts() {
        $this->_contacts;
    }
}

class Language {

    public static function getLanguageIDByCode( $code ) {
        $connCore = Database::getCoreLink();
        $query = 'SELECT `languageID` FROM `language` WHERE `code` = :code LIMIT 1';
        $connCore->query($query, [':code' => $code]);
        if( $connCore->numResults() === 1 ) {
            return $connCore->getFirst()->languageID;
        }
        return 0;
    }

    public static function addLanguageToUser($userID, array $language = null) {
        $core = Database::getCoreLink();
        $queryInsertUserLanguage = 'INSERT INTO `user_language` (`userID`, `languageID`, `primary`)
                                                         VALUES (:userID,  :languageID,  :primary )';
        foreach($language as $lang) {
            $langID = self::getLanguageIDByCode($lang[0]);
            $primary = (isset($lang[1]) && $lang[1] === PRIMARY) ? PRIMARY : 0;

            if( $langID > 0 ) {
                $core->query($queryInsertUserLanguage, [
                    ':userID'       => $userID,
                    ':languageID'   => $langID,
                    ':primary'      => $primary,
                ]);
            }
        }
    }
    public static function getLanguagesByUserID( $userID ) {
        /*
        $connCore = Database::getCoreLink();
        $query = 'SELECT `languageID` FROM `language` WHERE `code` = :code';
        return [];
        */
    }

    protected
        $_languageID,
        $_code,
        $_name,
        $_primary;

    protected function __construct( $languageID, $code, $name, $primary ) {
        $this->_languageID = $languageID;
        $this->_code = $code;
        $this->_name = $name;
        $this->_primary = $primary;
    }

    public function getID() {
        $this->_languageID;
    }
    public function getCode() {
        return $this->_code;
    }
    public function getName() {
        return $this->_name;
    }
    public function isPrimary() {
        return $this->_primary === 1;
    }
}
class Country {

    public static function getCountryIDByCode( $code ) {
        $connCore = Database::getCoreLink();
        $query = 'SELECT `countryID` FROM `country` WHERE `code` = :code LIMIT 1';
        $connCore->query($query, [':code' => $code]);
        if( $connCore->numResults() === 1 ) {
            return $connCore->getFirst()->countryID;
        }
        return 0;
    }

    protected
        $_countryID,
        $_code,
        $_name,
        $_primary;

    protected function __construct( $countryID, $code, $name, $primary ) {
        $this->_countryID = $countryID;
        $this->_code = $code;
        $this->_name = $name;
        $this->_primary = $primary;
    }

    public function getCode() {
        return $this->_code;
    }
    public function getName() {
        return $this->_name;
    }
    public function isPrimary() {
        return $this->_primary === 1;
    }
}
class Address {

    public static function addAddressToUser( $userID, array $address ) {
        $core = Database::getCoreLink();
        $queryInsertAddress = 'INSERT INTO `address` (`line1`, `line2`, `city`, `zip`, `countryID`)
                                              VALUES (:line1,  :line2,  :city,  :zip,  :countryID );';
        $queryInsertUserAddress = 'INSERT INTO `user_address` (`userID`, `addressID`, `primary`)
                                                       VALUES (:userID,  :addressID,  :primary )';
        foreach($address as $addr) {
            $zip        = $addr[0];
            $city       = $addr[1];
            $line1      = $addr[2];
            $line2      = $addr[3];
            $countryID  = Country::getCountryIDByCode($addr[4]);
            $primary = (isset($addr[5]) && $addr[5] === PRIMARY) ? PRIMARY : 0;

            $core->query($queryInsertAddress, [
                ':line1'        => $line1,
                ':line2'        => $line2,
                ':city'         => $city,
                ':zip'          => $zip,
                ':countryID'    => $countryID
            ]);
            $addrID = $core->getLastInsertID(); // get the addressID of the address previously inserted

            $core->query($queryInsertUserAddress, [
                ':userID'       => $userID,
                ':addressID'    => $addrID,
                ':primary'      => $primary
            ]);

            if( isset($addr[CONTACT]) ) {
                Contact::addContactToAddress($addrID, $addr[CONTACT]);
            }
        }
    }

    public static function addAddressToOrganisation( $orgID, array $address ) {
        $core = Database::getCoreLink();
        $queryInsertAddress = 'INSERT INTO `address` (`line1`, `line2`, `city`, `zip`, `countryID`)
                                              VALUES (:line1,  :line2,  :city,  :zip,  :countryID );';
        $queryInsertOrgAddress = 'INSERT INTO `org_address` (`orgID`, `addressID`, `primary`)
                                                     VALUES (:orgID,  :addressID,  :primary )';
        foreach($address as $addr) {
            $zip        = $addr[0];
            $city       = $addr[1];
            $line1      = $addr[2];
            $line2      = $addr[3];
            $countryID  = Country::getCountryIDByCode($addr[4]);
            $primary = (isset($addr[5]) && $addr[5] === PRIMARY) ? PRIMARY : 0;

            $core->query($queryInsertAddress, [
                ':line1'        => $line1,
                ':line2'        => $line2,
                ':city'         => $city,
                ':zip'          => $zip,
                ':countryID'    => $countryID
            ]);
            $addrID = $core->getLastInsertID(); // get the addressID of the address previously inserted

            $core->query($queryInsertOrgAddress, [
                ':orgID'        => $orgID,
                ':addressID'    => $addrID,
                ':primary'      => $primary
            ]);

            if( isset($addr[CONTACT]) ) {
                Contact::addContactToAddress($addrID, $addr[CONTACT]);
            }
        }
    }

    public static function getAddressOfUser( $userID ) {

    }

    private
        $_addressID,
        $_line1,
        $_line2,
        $_city,
        $_zip,
        $_primary,
        $_contacts;

    protected function __construct() {

    }

    public function getID() {
        return $this->_addressID;
    }
    public function isPrimary() {
        return $this->_primary === 1;
    }
    public function getLine1() {
        return $this->_line1;
    }
    public function getLine2() {
        return $this->_line2;
    }
    public function getCity() {
        return $this->_city;
    }
    public function getZip() {
        return $this->_zip;
    }
    public function hasContacts() {
        return $this->numContacts() > 0;
    }
    public function numContacts() {
        return count($this->_contacts);
    }
    public function getContacts() {
        return $this->_contacts;
    }
}
class Contact {
    // Contact types
    const WEB_WORK          = 1;
    const WEB_PERSONAL      = 2;
    const WEB_OTHER         = 3;

    const EMAIL_WORK        = 11;
    const EMAIL_PERSONAL    = 12;
    const EMAIL_OTHER       = 13;

    const PHONE_WORK        = 21;
    const PHONE_PERSONAL    = 22;
    const PHONE_HOME        = 23;
    const PHONE_OTHER       = 24;

    const FAX_WORK          = 31;
    const FAX_PERSONAL      = 32;
    const FAX_HOME          = 33;
    const FAX_OTHER         = 34;

    const SOCIAL_GOOGLE     = 41;
    const SOCIAL_FACEBOOK   = 42;
    const SOCIAL_TWITTER    = 43;
    const SOCIAL_SKYPE      = 44;
    const SOCIAL_LINKEDIN   = 45;
    const SOCIAL_OTHER      = 46;

    const OTHER             = 100;

    public static function addContactToUser( $userID, array $contact = null ) {
        $core = Database::getCoreLink();
        $queryInsertContact = 'INSERT INTO `contact` (`type`, `value`)
                                              VALUES (:type,  :value );';
        $queryInsertUserContact = 'INSERT INTO `user_contact` (`userID`, `contactID`, `primary`)
                                                       VALUES (:userID,  :contactID,  :primary )';
        foreach($contact as $cont) {
            $type   = $cont[0];
            $value  = $cont[1];
            $primary = (isset($cont[2]) && $cont[2] === PRIMARY) ? PRIMARY : 0;

            $core->query($queryInsertContact, [
                ':type'     => $type,
                ':value'    => $value
            ]);
            $contID = $core->getLastInsertID(); // get the contactID of the contact previously inserted

            $core->query($queryInsertUserContact, [
                ':userID'       => $userID,
                ':contactID'    => $contID,
                ':primary'      => $primary
            ]);
        }
    }

    public static function addContactToAddress( $addressID, array $contact = null ) {
        $core = Database::getCoreLink();
        $queryInsertContact = 'INSERT INTO `contact` (`type`, `value`)
                                              VALUES (:type,  :value );';
        $queryInsertAddressContact = 'INSERT INTO `address_contact` (`addressID`, `contactID`, `primary`)
                                                             VALUES (:addressID,  :contactID,  :primary )';
        foreach($contact as $cont) {
            $type   = $cont[0];
            $value  = $cont[1];
            $primary = (isset($cont[2]) && $cont[2] === PRIMARY) ? PRIMARY : 0;

            $core->query($queryInsertContact, [
                ':type'     => $type,
                ':value'    => $value
            ]);
            $contID = $core->getLastInsertID(); // get the contactID of the contact previously inserted

            $core->query($queryInsertAddressContact, [
                ':addressID'    => $addressID,
                ':contactID'    => $contID,
                ':primary'      => $primary
            ]);
        }
    }

    public static function addContactToOrganisation( $orgID, array $contact ) {
        $core = Database::getCoreLink();
        $queryInsertContact = 'INSERT INTO `contact` (`type`, `value`)
                                              VALUES (:type,  :value );';
        $queryInsertOrgContact = 'INSERT INTO `org_contact` (`orgID`, `contactID`, `primary`)
                                                     VALUES (:orgID,  :contactID,  :primary )';
        foreach($contact as $cont) {
            $type   = $cont[0];
            $value  = $cont[1];
            $primary = (isset($cont[2]) && $cont[2] === PRIMARY) ? PRIMARY : 0;

            $core->query($queryInsertContact, [
                ':type'     => $type,
                ':value'    => $value
            ]);
            $contID = $core->getLastInsertID(); // get the contactID of the contact previously inserted

            $core->query($queryInsertOrgContact, [
                ':orgID'        => $orgID,
                ':contactID'    => $contID,
                ':primary'      => $primary
            ]);
        }
    }

    public static function deleteContactFromUser() {}
    public static function deleteContactFromAddress() {}

    public static function getContactOfUser( $userID ) {
        if( $userID > 0 ) {
            $core = Database::getCoreLink();
            $query = 'SELECT `contact`.*, `user_contact`.`primary` FROM `contact`
                      JOIN `user_contact` ON `user_contact`.`contactID` = `contact`.`contactID`
                      WHERE `user_contact`.`userID` = :userID
                      ORDER BY `primary` DESC, `type` ASC;';

            $core->query($query, [':userID' => $userID]);
            if( $core->numResults() > 0 ) {
                $contacts = [];
                foreach($core->getResults() as $cont) {
                    $contacts[] = new Contact($cont);
                }
                return $contacts;
            }
        }
        return null;
    }
    public static function getContactOfAddress( $addressID ) {
        if( $addressID > 0 ) {
            $core = Database::getCoreLink();
            $query = 'SELECT `contact`.*, `address_contact`.`primary` FROM `contact`
                      JOIN `address_contact` ON `address_contact`.`contactID` = `contact`.`contactID`
                      WHERE `address_contact`.`addressID` = :addressID
                      ORDER BY `primary` DESC, `type` ASC;';

            $core->query($query, [':addressID' => $addressID]);
            if( $core->numResults() > 0 ) {
                $contacts = [];
                foreach($core->getResults() as $cont) {
                    $contacts[] = new Contact($cont);
                }
                return $contacts;
            }
        }
        return null;
    }
    public static function getContactOfOrganisation( $orgID ) {}

    public static function editContactOfUser() {}
    public static function editContactOfAddress() {}

    private
        $_contactID,
        $_type,
        $_value,
        $_primary;

    protected function __construct( $contact ) {
        $this->_contactID = $contact->contactID;
        $this->_type = $contact->type;
        $this->_value = $contact->value;
        $this->_primary = $contact->primary;
    }

    public function getID() {
        return $this->_contactID;
    }
    public function isPrimary() {
        return $this->_primary === 1;
    }
    public function getType() {
        return $this->_type;
    }
    public function getValue() {
        return $this->_value;
    }
}

class Organisation {

    public static function addOrganisationToUser( $userID, array $organisation ) {
        $core = Database::getCoreLink();
        $query = 'INSERT INTO `org_user` (`orgID`, `userID`)
                                      VALUES (:orgID,  :userID );';

        foreach($organisation as $orgID) {
            $core->query($query, [
                ':orgID'    => $orgID,
                ':userID'   => $userID
            ]);
        }
    }

    public static function addOrganisation( array $organisation ) {
        if( !is_null($organisation) && !empty($organisation) ) {
            $core = Database::getCoreLink();
            $queryInsertOrg = 'INSERT INTO `organisation` (`name`, `description`, `registered`)
                                                   VALUES (:name,  :description,  :registered);';
            foreach($organisation as $org) {
                $name = $org[NAME];
                $description = $org[DESCRIPTION];
                $registered = (isset($org[REGISTERED]) && is_string($org[REGISTERED])) ? $org[REGISTERED] : date("Y-m-d H:i:s");

                $core->query($queryInsertOrg, [
                    ':name'         => $name,
                    ':description'  => $description,
                    ':registered'   => $registered
                ]);
                $orgID = $core->getLastInsertID(); // get the orgID of the organisation previously inserted
                if( isset($org[ADDRESS]) ) {
                    Address::addAddressToOrganisation($orgID, $org[ADDRESS]);
                }
                if( isset($org[CONTACT]) ) {
                    Contact::addContactToOrganisation($orgID, $org[CONTACT]);
                }
            }
        }
    }

    public static function getOrganisationIDByName( $name ) {
        if( is_string($name) ) {
            $core = Database::getCoreLink();
            $query = 'SELECT `orgID` FROM `organisation` WHERE `name` LIKE :name LIMIT 1;';
            $core->query($query,[ ':name' => $name ]);
            if( $core->numResults() === 1 ) {
                return $core->getFirst()->orgID;
            }
        }
        return 0;
    }

    public static function getOrganisationByID( $orgID ) {}
    public static function getOrganisationByName( $name ) {}

    private
        $_orgID,
        $_name,
        $_description;

    protected function __construct( $orgID, $name, $description ) {
        $this->_orgID = $orgID;
        $this->_name = $name;
        $this->_description = $description;
    }
    public function getID() {
        return $this->_orgID;
    }
    public function getName() {
        return $this->_name;
    }
    public function getDescription() {
        return $this->_description;
    }
}

class Message {}























