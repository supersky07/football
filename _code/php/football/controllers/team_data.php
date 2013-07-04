<?php
require_once "path.php";
require_once BASEPATH."models/match_data/team.php";

$team_name=$_GET["team_name"];
if(!$team_name){
	exit("empty team name");
}
echo matches_result($team_name);
?>
