<?php
function load_db(){
	$host="";
	$username="";
	$password="";
	$db_name="";
	$football = new mysqli("$host","$username","$password","$db_name");
	if($football->errno){
		$football->error;
		echo " failed to connect to db :"."\n".$football->error;
		exit();
	}else{
		echo "load db success";
	}
	return $football;
}
