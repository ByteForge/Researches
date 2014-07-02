<?php

const FONT = "OpenSans-Bold.ttf";

$width = 100;
$height = 100;

// const SPLIT_LIMIT = 32;
// $queryString = urldecode($_SERVER['QUERY_STRING']);
// var_dump($queryString);

$img = imagecreatetruecolor($width, $height);
$backgroundColor = imagecolorallocate($img, 204, 204, 204);
$fontColor = imagecolorallocate($img, 150, 150, 150);

imagefill($img, 0, 0, $backgroundColor);
$bounds = imagettfbbox(12, 0, FONT, $width." x ".$height);
$textWidth = $bounds[2];
$textHeight = abs($bounds[7]);

echo $textWidth .' - '.$textHeight;

imagettftext($img, 10, 0, 25, 100, $fontColor, FONT, $width." x ".$height);

// header("Content-Type: image/png");
// imagepng($img);
imagedestroy($img);

// $im = @imagecreate(500, 500) or die("Cannot Initialize new GD image stream");
// $background_color = imagecolorallocate($im, 0, 0, 0);
// $text_color = imagecolorallocate($im, 233, 14, 91);

// imagestring($im, 1, 5, 5,  "A Simple Text String", $text_color);
// imagettftext($im, 20, 0, 0, 100, $text_color, FONT, "The quick FOX jumpst over the grumpy old DOG.");

// imagepng($im);
// imagedestroy($im);
?>