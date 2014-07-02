<?php
// Production/Development Settings
const PRODUCTION        = false; // true - Production settings, no debug information
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

// Paths to PHP Classes
$PATHS = [
    // Main directory - "/{className}.php"
    DIRECTORY_SEPARATOR,

    // OM directory - "/om/{className}.php"
    DIRECTORY_SEPARATOR . "om" . DIRECTORY_SEPARATOR,

    // REP directory - "/rep/{className}.php"
    DIRECTORY_SEPARATOR . "rep" . DIRECTORY_SEPARATOR,

    // CRM directory - "/crm/{className}.php"
    DIRECTORY_SEPARATOR . "crm" . DIRECTORY_SEPARATOR,
];

// Set locale to standard "en_US" UTF-8
setLocale(LC_CTYPE, 'en_US.UTF-8');

// Fundamental constants
define("PHP_INT_MIN", -PHP_INT_MAX); // declared with "define(...)" instead of "const ..." because of expressions
define("PHP_FLOAT_MIN", __getMinFloat());
define("PHP_FLOAT_MAX", __getMaxFloat());

// Constants for function options
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
    // Singleton pattern enforcements, 3 function below.
    private function __construct() {}
    public function __clone() {
        trigger_error('Cloning is not allowed.',E_USER_ERROR);
    }
    public function __wakeup() {
        trigger_error('Unserializing is not allowed.',E_USER_ERROR);
    }
}
// Class autoloading with namespaces
spl_autoload_register(function ( $className ) {
    global $PATHS;

    $pos = strrpos( $className, DIRECTORY_SEPARATOR );
    if( $pos !== false ) {
        $fileName = substr( $className, $pos+1 );
    } else {
        $fileName = $className;
    }

    foreach( $PATHS as $path ) {
        $file = __DIR__ . $path . $fileName . ".php";
        if( is_readable($file) ) {
            require_once $file;
        }
    }
});

// Log Functions
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

    const DEFAULT_PATH = "log";
    const DEFAULT_FILE = "log";

    private static $path = self::DEFAULT_PATH;
    private static $file = self::DEFAULT_FILE;
    private static $opened = false;
    private static $fileHandler = null;

    private static function __openLogFile() {
        if( self::$opened ) {
            return;
        }

        if( !file_exists( self::$path ) ) {
            mkdir( self::$path, 0777, true );
        }

        $f = self::$path ."/". self::$file ."-". date("Y-m-d_H-i-s") . ".txt";
        self::$fileHandler = fopen( $f, "w" );
        if( self::$fileHandler ) {
            self::$opened = true;
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

    public static function __writeToLogFile( $indentation, $ac, array &$av, $trace = false ) {
        if( !self::$opened ) {
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
        echo $result;

        fwrite( self::$fileHandler, $result );
    }
    public static function __closeLogFile() {
        if( !self::$opened ) {
            return;
        }
        fclose( self::$fileHandler );
        self::$opened = false;
    }
}
register_shutdown_function(function(){
    L::__closeLogFile();
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
            $name = SESSION_NAME;
        }
        if( SESSION_HTTP_ONLY ) {
            ini_set( 'session.cookie_httponly', 1 );
        }
        session_name( $name );
        session_start( $name );
    }
    public static function startAndRegenerate( $name = null, $deleteOldSession = true ) {
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
    public static function regenerate( $deleteOldSession = true ) {
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

// Page Constants
const PAGE_SIGN_IN  = "sign_in.php";
const PAGE_SIGN_OUT = "sign_out.php";

const PAGE_OM   = "om.php"; // Order Management
const PAGE_REP    = "rep.php"; // Reporting
const PAGE_CRM  = ""; // Customer Relationship Management

// 3 "Longhand" Constants of "OM", "R" and "CRM" for clearer representation in code
const PAGE_ORDER_MANAGEMENT = PAGE_OM;
const PAGE_REPORTING = PAGE_REP;
const PAGE_CUSTOMER_RELATIONSHIP_MANAGEMENT = PAGE_CRM;

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
                $expiration = time() + COOKIE_DEFAULT_EXPIRATION;
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
function validBoolean( $value ) {}
function validInt( $value ) {}
function validFloat( $value ) {}
function validString( $value ) {}

// FILTER
function filterBoolean( $value ) {
    if( !is_null($value) && !empty($value) ) {
        if( is_string($value) ) { $value = trim($value); }
        return filter_var($value, FILTER_VALIDATE_BOOLEAN);
    }
    return false;
}
function filterInt( $value, $minimum = PHP_INT_MIN, $maximum = PHP_INT_MAX) {
    if( !is_null($value) && !empty($value) ) {
        if( is_string($value) ) { $value = trim($value); }
        if( $minimum > $maximum ) { swap($minimum, $maximum); }
        $value = filter_var($value, FILTER_VALIDATE_INT);
        if( $value === false ) { return 0; }
        return ( $value >= $minimum && $value <= $maximum ) ? $value : 0;
    }
    return 0;
}
function filterFloat( $value, $minimum = PHP_FLOAT_MIN, $maximum = PHP_FLOAT_MAX) {
    if( !is_null($value) && !empty($value) ) {
        if( is_string($value) ) { $value = trim($value); }
        if( $minimum > $maximum ) { swap($minimum, $maximum); }
        $value = filter_var($value, FILTER_VALIDATE_FLOAT);
        if( $value === false ) { return 0; }
        return ( $value >= $minimum && $value <= $maximum ) ? $value : 0;
    }
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

function filterHTML( $value, $onlySpecialChars = true ) {
    if( is_string($value) ) {
        if( $onlySpecialChars ) {
            return htmlspecialchars( $value, ENT_QUOTES, "UTF-8" );
        } else {
            return htmlentities( $value, ENT_QUOTES, "UTF-8" );
        }
    }
    return "";
}

// RANDOM
function getBoolean() {
    return mt_rand(0, 1) === 1;
};
function getInt( $minimum, $maximum ) {};
function getFloat( $minimum, $maximum ) {};
/*
function getString() {

};
*/
/*
function getFromArray( &$array ) {
    if( is_array($array) ) {
        $length = count($array);
        $position = mt_rand(0, $length-1);
        return $array[$position];
    }
    return null;
};
*/

// DATABASE CONNECTION
class Connection {

    private
        $_databaseHost,
        $_databaseUser,
        $_databasePassword,
        $_databaseName,

        $_pdo;

    public function __construct( $host, $name = null, $user = null, $password = null ) {

        if( is_array($host) ) {
            $this->_databaseHost = $host["host"];
            $this->_databaseName = $host["name"];
            $this->_databaseUser = $host["user"];
            $this->_databasePassword = $host["pass"];
        } else {
            $this->_databaseHost = $host;
            $this->_databaseName = $name;
            $this->_databaseUser = $user;
            $this->_databasePassword = $password;
        }

        try {
            $str = "mysql:host={$this->_databaseHost};dbname={$this->_databaseName}";
            T( $str );

            $this->_pdo = new PDO($str, $this->_databaseUser, $this->_databasePassword);
            $this->_pdo->setAttribute( PDO::ATTR_EMULATE_PREPARES, false );
            $this->_pdo->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );

            $this->_pdo->exec("SET NAMES UTF8");
            T( $this->_pdo );

        } catch( PDOException $e ) {
            //die( $e->getMessage() );
            die( $e );
        }
    }
    public function __destruct() {
        $this->_pdo = null;
    }

    // get "raw" PDO object
    public function getPDO() {
        return $this->_pdo;
    }

    // Single queries
    public function query( $queryString, array $bindings = null ) {
        $statement = $this->_pdo->prepare($queryString);
        $statement->setFetchMode(PDO::FETCH_OBJ);
        $r = $statement->execute();
        //L("query done:", $r);
        /*
        if( !is_null($bindings) ) {
            $statement->execute($bindings);
        } else {
            $statement->execute();
        }
        */
    }
    public function select( $queryString, array $bindings = null ) {
        $statement = $this->_pdo->prepare("SELECT ". $queryString);
        if( !is_null($bindings) ) {
            $statement->execute($bindings);
        } else {
            $statement->execute();
        }
    }
    public function insert() {}
    public function update() {}
    public function delete() {}

    public function numResults() {}
    public function getResults() {}
    public function getFirst() {}
    public function getLast() {}

    // Multiple queries
    public function addQuery() {}
    public function addSelect() {}
    public function addInsert() {}
    public function addUpdate() {}
    public function addDelete() {}

    // Transaction handling
    public function begin() {}
    public function commit() {}
    public function rollback() {}
}

// USER
class User {

    public static function currentUserExists() {}
    public static function getCurrentUser() {
        return new User();
    }
    public static function signOutCurrentUser() {}

    public static function getUserByName( $name ) {}
    public static function getUserByFirstName( $firstName ) {}
    public static function getUserByLastName( $lastName ) {}
    public static function getUserByID( $userID ) {}
    public static function getUserIDByName( $name ) {}
    public static function getUserIDByFirstName( $firstName ) {}
    public static function getUserIDByLastName( $lastName ) {}

    public static function authenticate() {}
    public static function signUpUser() {}
    public static function signInUser( $uid, $password ) {}
    public static function signOutUser( $uid, $password ) {}

    protected
        $_userID,
        $_firstName,
        $_lastName,
        $_active,

        $_role,
        $_languages;

    public function getID() {
        return $this->_userID;
    }
    public function isActive() {
        return $this->_active;
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

    public function is( $role ) {
    }
    public function can( $privilege ) {
        return false;
    }
}

class Role {

    public static function addRole( $shortName, $longName, array $privileges = null ) {
        //return 123; // Added role's ID
        return new Role(123, $shortName, $longName);
    }
    public static function getRoleIDByShortName( $shortName ) {
        $role = new Role(123, "admin", "Administrator");
        return $role->getID();
    }

    public static function numRoles() {}
    public static function getRoles() {}

    protected
        $_roleID,
        $_shortName,
        $_longName,
        $_privilege; // array of Privilege

    protected function __construct( $roleID, $shortName, $longName ) {
        $this->_roleID = $roleID;
        $this->_shortName = $shortName;
        $this->_longName = $longName;
    }

    public function getID() {
        return $this->_roleID;
    }
    public function getShortName() {
        return $this->_shortName;
    }
    public function getLongName() {
        return $this->_longName;
    }

    public function can( $privilegeID ) {
        return false;
    }

    public function addPrivilege( $privilegeID ) {}
    public function hasPrivilege() {}
    public function deletePrivilege() {}
    public function numPrivileges() {}
}

class Privilege {

    public static function addPrivilege( $shortName, $longName ) {
    }
    public static function addPrivileges( array $namePairs ) {
    }
    public static function numPrivileges() {}

    protected
        $_privilegeID,
        $_shortName,
        $_longName;

    protected function __construct( $privilegeID, $shortName, $longName ) {
        $this->_privilegeID = $privilegeID;
        $this->_shortName = $shortName;
        $this->_longName = $longName;
    }

    public function getID() {
        return $this->_privilegeID;
    }
    public function getShortName() {
        return $this->_shortName;
    }
    public function getLongName() {
        return $this->_longName;
    }
}

class Language {

    public static function addLanguage( $shortName, $longName ) {
        return new Language(123, $shortName, $longName);
    }
    public static function addLanguages( array $namePairs ) {}
    public static function getLanguageByShortName( $shortName ) {
        return new Language( 123, "EN", "English" );
    }
    public static function getLanguageIDByShortName( $shortName ) {
        return 123;
    }
    public static function getLanguageByName( $name ) {}
    public static function getLanguageIDByName( $name ) {}
    public static function numLanguages() {}
    public static function getLanguages() {}

    protected
        $_languageID,
        $_primary,
        $_shortName,
        $_longName;

    protected function __construct( $languageID, $shortName, $longName ) {
        $this->_languageID = $languageID;
        $this->_shortName = $shortName;
        $this->_longName = $longName;
    }

    public function getID() {
        $this->_languageID;
    }
    public function isPrimary() {
        $this->_primary;
    }
    public function getShortName() {
        return $this->_shortName;
    }
    public function getLongName() {
        return $this->_longName;
    }
}
class Country {

    public static function addCountry( $shortName, $longName ) {
    }
    public static function addCountries( array $namePairs ) {
    }
    public static function numCountries() {}
    public static function getCountries() {}

    protected
        $_countryID,
        $_primary,
        $_shortName,
        $_longName;

    public function isPrimary() {
        $this->_primary;
    }
    public function getShortName() {
        return $this->_shortName;
    }
    public function getLongName() {
        return $this->_longName;
    }
}
class Address {

    public static function addAddress( $line1, $line2, $zip, $city ) {}
    public static function addAddresses( array $addresses ) {}

    protected
        $_addressID,
        $_primary,
        $_line1,
        $_line2,
        $_zip,
        $_city;

    public function __construct() {}

    public function isPrimary() {
        return $this->_primary;
    }
    public function getLine1() {
        return $this->_line1;
    }
    public function getLine2() {
        return $this->_line2;
    }
    public function getZip() {
        return $this->_zip;
    }
    public function getCity() {
        return $this->_city;
    }
}
class Contact {

    protected
        $_contactID,
        $_priority,
        $_type,
        $_value;

    public function getPriority() {
        return $this->_priority;
    }
    public function getType() {
        return $this->_type;
    }
    public function getValue() {
        return $this->_value;
    }
}

class Message {}

class Product {}
class Item {}
class Order {}
