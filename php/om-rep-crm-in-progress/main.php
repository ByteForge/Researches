<?php
require_once 'core/Core.php';
System::initialize([
    DEVELOPMENT => ON_LOCAL,
    MAIN_SERVER => CRM
]);

Session::start();

//\om\Configuration\Configuration::getDevelopmentDatabaseAccess();
//\rep\Configuration\Configuration::getDevelopmentDatabaseAccess();
//\crm\Configuration\Configuration::getDevelopmentDatabaseAccess();

STOP_HERE;

?><!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <title><?php Page::echoCurrentTitle(); ?></title>
    </head>
    <body>
        fuck
    </body>
</html>