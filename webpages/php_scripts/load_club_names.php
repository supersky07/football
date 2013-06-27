<?php
$clubs=file('england');
$mysqli=new mysqli('localhost','root','abc123','football');
if($mysqli->errno)
	echo $mysqli->error;
$stmt = $mysqli->stmt_init();
$query="INSERT INTO clubs SET full_name=?,short_name=?";
$stmt->prepare($query);
$stmt->bind_param('ss',$full_name,$short_name);
foreach($clubs as $club){
	//echo $club;
	list($full_name,$short_name)=explode('~',$club);
	$full_name=trim($full_name);
	$full_name=substr($full_name,2);
	$full_name=trim($full_name);
	$short_name=trim($short_name);
	$stmt->execute();
//	$query="insert into clubs(full_name,short_name)values('$full_name','$short_name')";
//	echo $query;
//	echo "\n";
	//echo $short_name;
//	$result=$mysqli->query($query);
//	echo $mysqli->error;
//	echo $result;
}
$mysqli->close();
?>
