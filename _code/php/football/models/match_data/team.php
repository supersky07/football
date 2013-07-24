<?php
require_once BASEPATH.'db/connect.php';
function matches_result($team_name){
	$mysqli=load_db();
	$team_name=$mysqli->real_escape_string($team_name);
	$query="SELECT  m.home_rank,
			m.away_rank,
			m.home_point,
			m.away_point,
			m.home_goal,
			m.away_goal,
			m.date,
			home.short_name AS home_name,
			away.short_name AS away_name
		FROM matches m
		INNER JOIN team home
			ON m.home_team = home.tid
		INNER JOIN team away
			ON m.away_team = away.tid
		WHERE home.short_name = '$team_name'
			OR away.short_name = '$team_name'
			ORDER BY m.date ASC";
	$result = $mysqli->query($query);
	if($mysqli->errno){
		echo "team.php failed in query\n";
		echo $mysqli->error;
		exit();
	}
	$matches = array();
	while($match = $result->fetch_object()){
		if($team_name==$match->home_name){
			$ishome = 1;
			$rank = $match->home_rank;
			$point = $match->home_point;
			$opponent = $match->away_name;
		 }else{
			 $ishome = 0;
			 $rank = $match->away_rank;
			 $point = $match->away_point;
			 $opponent = $match->home_name;
		 }
		$score = "$match->home_goal : $match->away_goal";
		$date = $match->date;
		$e=array("rank"=>$rank, "score"=>$score, "opponent"=>$opponent, "ishome"=>$ishome, "date"=>$date, "point"=>$point);
		array_push($matches,$e);
	}
	$json["data"] = $matches;
	return json_encode($json);
}
//$team_name = 'arsenal';
//define("BASEPATH", "/home/bran/projects/football/");
//require_once BASEPATH.'db/connect.php';
//echo matches_result($team_name);
?>

