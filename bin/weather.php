#!/usr/bin/php
<?php

function errOut($msg = 'No Weather Data') {
	echo "$msg\n";
	exit;
}

$zip = '46220';
if ( isset($argc) && $argc > 2 ) {
	$zip = intval($argv[1]);
}
$url = "http://xml.weather.yahoo.com/forecastrss?p=$zip&u=f";

$xmlstr = @file_get_contents($url);

if ( !$xmlstr ) {
	errOut();
}

$xml = new SimpleXMLElement($xmlstr);
if ( !is_object($xml) ) {
	errOut();
}
$ns = $xml->getNamespaces(true);
if ( !isset($ns['yweather']) ) {
	errOut();
}

// item 0
$i0 = $xml->channel->item[0];
if ( !is_object($i0) ) {
	errOut();
}

$weather = $i0->children($ns['yweather']);

if (!is_object($weather)) {
	errOut();
}

$results = array();
foreach ( $weather AS $type => $item ) {
	$write = array();
	foreach ( $item->attributes() AS $k => $v ) {
		$write[$k] = (string)$v;
	}
	if ( $type == 'forecast' ) {
		$results['forecast'][] = $write;
	} else {
		$results[$type] = $write;
	}
}

$c = $results['condition'];
$f0 = $results['forecast'][0];
$f0['avg'] = ($f0['low'] + $f0['high'])/2;
$f1 = $results['forecast'][1];
$f1['avg'] = ($f1['low'] + $f1['high'])/2;

$out_str =<<<EOD
Current: {$c['temp']}F, {$c['text']}
{$f0['day']}    : {$f0['avg']}F, {$f0['text']}
{$f1['day']}    : {$f1['avg']}F, {$f1['text']}
EOD;

echo $out_str;
?>
