<?php
$backend_folder="/var/www/front/football";
if(is_dir($backend_folder)){
	define('BASEPATH',$backend_folder."/");
}else{
	echo "Error 111";
	exit();
}
?>
