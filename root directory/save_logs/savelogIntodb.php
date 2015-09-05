<?php
global $couchUrl;
$couchUrl = 'http://127.0.0.1:5984';
///error_reporting(E_ERROR);
include "lib/couch.php";
include "lib/couchClient.php";
include "lib/couchDocument.php";
if(isset($argv[2]))
{
	//Display all available args
	//print_r($argv);

	$faci_ID = $argv[3];
	$status = $argv[2];
	$statusType= $argv[1];

	$carrentStatus = new stdClass();
	$carrentStatus-> systemtime = date('Y-m-d H:i:s');
	$carrentStatus-> status = $status;
	$system = new couchClient($couchUrl, "system");
	$doc = $system->getDoc($faci_ID);
	// get data from form and save it to couch
	$doc->kind ="Server_Status_Log";
	$doc->lastUpdate = date('y-m-d');
	if(!isset($doc->$statusType)){
		$doc->$statusType = array();
                array_push($doc->$statusType,$carrentStatus);

	}else if($doc->$statusType != null){
		array_push($doc->$statusType,$carrentStatus);

	}else{
	 	$doc->$statusType = array();
	 	array_push($doc->$statusType,$carrentStatus);

	}
	// save doc to couch and for responce->id
	$response = $system ->storeDoc($doc);
}
