<?php
namespace rep\Configuration {

    class Configuration {
        use \singletonTrait;

        private static
            // Development
            // On local
            // For CORE
            $__local_CORE_Host = 'localhost',
            $__local_CORE_Port = 3306,
            $__local_CORE_Name = 'ss14-bdl2-fst-2',
            $__local_CORE_User = 'root',
            $__local_CORE_Pass = 'root',

            // For OM
            $__local_OM_Host = 'localhost',
            $__local_OM_Port = 3306,
            $__local_OM_Name = 'ss14-bdl2-fst-1',
            $__local_OM_User = 'root',
            $__local_OM_Pass = 'root',

            // For REP
            $__local_REP_Host = 'localhost',
            $__local_REP_Port = 3306,
            $__local_REP_Name = 'ss14-bdl2-fst-3',
            $__local_REP_User = 'root',
            $__local_REP_Pass = 'root',

            // For CRM
            $__local_CRM_Host = 'localhost',
            $__local_CRM_Port = 3306,
            $__local_CRM_Name = 'ss14-bdl2-fst-2',
            $__local_CRM_User = 'root',
            $__local_CRM_Pass = 'root',

            // On server
            // For CORE
            $__server_CORE_Host = 'localhost',
            $__server_CORE_Port = 3306,
            $__server_CORE_Name = 'ss14-bdl2-fst-2',
            $__server_CORE_User = 'root',
            $__server_CORE_Pass = 'root',

            // For OM
            $__server_OM_Host = 'localhost',
            $__server_OM_Port = 3306,
            $__server_OM_Name = 'ss14-bdl2-fst-1',
            $__server_OM_User = 'root',
            $__server_OM_Pass = 'root',

            // For REP
            $__server_REP_Host = 'localhost',
            $__server_REP_Port = 3306,
            $__server_REP_Name = 'ss14-bdl2-fst-3',
            $__server_REP_User = 'root',
            $__server_REP_Pass = 'root',

            // For CRM
            $__server_CRM_Host = 'localhost',
            $__server_CRM_Port = 3306,
            $__server_CRM_Name = 'ss14-bdl2-fst-2',
            $__server_CRM_User = 'root',
            $__server_CRM_Pass = 'root',

            // Production
            // For CORE
            $__prod_CORE_Host = 'wi-projectdb.technikum-wien.at',
            $__prod_CORE_Port = 3306,
            $__prod_CORE_Name = 'ss14-bdl2-fst-2',
            $__prod_CORE_User = 'ss14-bdl2-fst-2',
            $__prod_CORE_Pass = 'DbPass4BDL2-2',

            // For OM
            $__prod_OM_Host = 'localhost',
            $__prod_OM_Port = 3306,
            $__prod_OM_Name = 'ss14-bdl2-fst-1',
            $__prod_OM_User = 'root',
            $__prod_OM_Pass = 'root',

            // For REP
            $__prod_REP_Host = 'localhost',
            $__prod_REP_Port = 3306,
            $__prod_REP_Name = 'ss14-bdl2-fst-3',
            $__prod_REP_User = 'root',
            $__prod_REP_Pass = 'root',

            // For CRM
            $__prod_CRM_Host = 'wi-projectdb.technikum-wien.at',
            $__prod_CRM_Port = 3306,
            $__prod_CRM_Name = 'ss14-bdl2-fst-2',
            $__prod_CRM_User = 'ss14-bdl2-fst-2',
            $__prod_CRM_Pass = 'DbPass4BDL2-2';

        // Development
        // On local
        // For CORE
        public static function getLocalCoreAccess() {
            return [    HOST => self::$__local_CORE_Host,
                PORT => self::$__local_CORE_Port,
                NAME => self::$__local_CORE_Name,
                USER => self::$__local_CORE_User,
                PASS => self::$__local_CORE_Pass ];
        }
        // For OM
        public static function getLocalOMAccess() {
            return [    HOST => self::$__local_OM_Host,
                PORT => self::$__local_OM_Port,
                NAME => self::$__local_OM_Name,
                USER => self::$__local_OM_User,
                PASS => self::$__local_OM_Pass ];
        }
        // For REP
        public static function getLocalREPAccess() {
            return [    HOST => self::$__local_REP_Host,
                PORT => self::$__local_REP_Port,
                NAME => self::$__local_REP_Name,
                USER => self::$__local_REP_User,
                PASS => self::$__local_REP_Pass ];
        }
        // For CRM
        public static function getLocalCRMAccess() {
            return [    HOST => self::$__local_CRM_Host,
                PORT => self::$__local_CRM_Port,
                NAME => self::$__local_CRM_Name,
                USER => self::$__local_CRM_User,
                PASS => self::$__local_CRM_Pass ];
        }
        // On server
        // For CORE
        public static function getServerCoreAccess() {
            return [    HOST => self::$__server_CORE_Host,
                PORT => self::$__server_CORE_Port,
                NAME => self::$__server_CORE_Name,
                USER => self::$__server_CORE_User,
                PASS => self::$__server_CORE_Pass ];
        }
        // For OM
        public static function getServerOMAccess() {
            return [    HOST => self::$__server_OM_Host,
                PORT => self::$__server_OM_Port,
                NAME => self::$__server_OM_Name,
                USER => self::$__server_OM_User,
                PASS => self::$__server_OM_Pass ];
        }
        // For REP
        public static function getServerREPAccess() {
            return [    HOST => self::$__server_REP_Host,
                PORT => self::$__server_REP_Port,
                NAME => self::$__server_REP_Name,
                USER => self::$__server_REP_User,
                PASS => self::$__server_REP_Pass ];
        }
        // For CRM
        public static function getServerCRMAccess() {
            return [    HOST => self::$__server_CRM_Host,
                PORT => self::$__server_CRM_Port,
                NAME => self::$__server_CRM_Name,
                USER => self::$__server_CRM_User,
                PASS => self::$__server_CRM_Pass ];
        }

        // Production
        // For CORE
        public static function getProdCoreAccess() {
            return [    HOST => self::$__prod_CORE_Host,
                PORT => self::$__prod_CORE_Port,
                NAME => self::$__prod_CORE_Name,
                USER => self::$__prod_CORE_User,
                PASS => self::$__prod_CORE_Pass ];
        }
        // For OM
        public static function getProdOMAccess() {
            return [    HOST => self::$__prod_OM_Host,
                PORT => self::$__prod_OM_Port,
                NAME => self::$__prod_OM_Name,
                USER => self::$__prod_OM_User,
                PASS => self::$__prod_OM_Pass ];
        }
        // For REP
        public static function getProdREPAccess() {
            return [    HOST => self::$__prod_REP_Host,
                PORT => self::$__prod_REP_Port,
                NAME => self::$__prod_REP_Name,
                USER => self::$__prod_REP_User,
                PASS => self::$__prod_REP_Pass ];
        }
        // For CRM
        public static function getProdCRMAccess() {
            return [    HOST => self::$__prod_CRM_Host,
                PORT => self::$__prod_CRM_Port,
                NAME => self::$__prod_CRM_Name,
                USER => self::$__prod_CRM_User,
                PASS => self::$__prod_CRM_Pass ];
        }
    }
}
