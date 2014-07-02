<?php
const LIMIT = 32;

function trace( $v ) {
	echo "<pre>";
	var_dump($v);
	echo "</pre>";
	echo "<br/>";
};

$queryString = $_SERVER['QUERY_STRING'];
	echo "raw query string:";
	trace( $queryString );

$parameters = urldecode($queryString);
	echo "parameters:";
	trace( $parameters );

$patterns = array(
	'/\s-/', /* -param */
	'/\s\s+/', /* whitespace */			
);
$replacements = array(
	' ',
	' ',	
);

$parameters = preg_replace($patterns, $replacements, $parameters);
	echo "parameters:";
	trace( $parameters );

$parameters = explode(" ", $parameters, LIMIT);
	echo "parameters:";
	trace( $parameters );

echo "<br/>";

echo '<a href="http://localhost/php_experiments/index.php? 350 240">link</a>';
echo "<br/>";


























