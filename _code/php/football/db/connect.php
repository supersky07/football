<?php
function load_db(){
	$football = new mysqli("localhost","root","abc123","football");
	if($football->errno){
		$football->error;
		echo " failed to connect to db :"."\n".$football->error;
		exit();
	}else{
		echo "load db success";
	}
	return $football;
}
