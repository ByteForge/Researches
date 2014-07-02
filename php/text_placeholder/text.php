<?php
const OUTPUT_HTML = 1;
const OUTPUT_FILE = 2;
const OUTPUT_BOTH = 3;
// const OUTPUT = OUTPUT_BOTH;
// const OUTPUT = OUTPUT_HTML;
const OUTPUT = OUTPUT_FILE;
// const OUTPUT = OUTPUT_BOTH;

function ilog_argToString($arg) {
	if( is_int($arg) ) { // int
		return (string)$arg;
	} else if( is_float($arg) ) { // float
		return (string)$arg;
	} else if( is_bool($arg) ) { // boolean
		return ( $arg === true ? "true" : "false" );
	} else if( is_string($arg) ) { // string
		// return '"'.$arg.'"';
		return $arg;
	} else if( is_array($arg) ) { // array
		$output = "[";
		for($j=0,$jL=count($arg),$jB=$jL-1; $j<$jL; ++$j) {
			$output .= ilog_argToString($arg[$j]);
			if($j<$jB) {
				$output .= ", ";
			}
		}
		$output .= "]";
		return $output;
	} else if( is_object($arg) ) { // object
		return "{...}";
	} else if( is_null($arg) ) { // null
		return "null";
	}
}

function ilog_outputToHTML($output) {
	echo $output."<br>";	
}
function ilog_outputToFile($output) {
	$filename = "log_".date("Y-m-d_H-i-s").".txt";
	if( !file_exists($filename) ) {
		$file = fopen($filename, "w");
	} else {
		$file = fopen($filename, "a");	
	}	
	fwrite($file, $output.PHP_EOL);
	fclose($file);	
}

function ilog() {
	$length = func_num_args();
	$arguments = func_get_args();
	$output = "";
	
	for($i=0, $B=$length-1; $i<$length; ++$i) {
		$arg = $arguments[$i];
		$output .= ilog_argToString($arg);		
		
		if($i<$B) {
			$output .= ", ";
		}
	}
	
	switch (OUTPUT) {
		case OUTPUT_HTML:
			ilog_outputToHTML($output);			
			break;
						
		case OUTPUT_FILE:
			ilog_outputToFile($output);
			break;
		
		case OUTPUT_BOTH:
			ilog_outputToHTML($output);
			ilog_outputToFile($output);
			break;
		
		default: // output both
			ilog_outputToHTML($output);
			ilog_outputToFile($output);			
			break;
	}
};

ilog("script start");

$raw = urldecode($_SERVER['QUERY_STRING']);
ilog("raw query string:", $raw);

echo "default text";

ilog("script end");
?>