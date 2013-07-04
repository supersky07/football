<?php
require_once BASEPATH.'db/connect.php';
function matches_result($team_name){
	$mysqli=load_db();
	$team_name=$mysqli->real_escape_string($team_name);
	echo $team_name;
	$query="SELECT m.round,m.home_rank,m.away_rank,m.home_goal,m.away_goal,home.short_name AS home_name, away.short_name AS away_name, m.date AS date, p.full_name AS player_name, g.time AS goal_time
	        FROM matches m
		INNER JOIN team home ON m.home_team = home.tid
		INNER JOIN team away ON m.away_team = away.tid
		INNER JOIN goals g ON g.mid = m.mid
		INNER JOIN players p ON p.pid = g.pid
		WHERE home.short_name = 'man utd'
		OR away.short_name = '$team_name'
		ORDER BY m.round,g.time";

	$result=$mysqli->query($query);
	if($mysqli->errno){
		echo "path.php function matches_result error\n";
		echo $mysqli->error;
		exit();
	}
	//var_dump($result->fetch_object());
	$matches=array();
	while($match_per_goal=$result->fetch_object()){
		$round=$match_per_goal->round;
		$player_name=$match_per_goal->player_name;
		$goal_time = $match_per_goal->goal_time;
		if(!isset($matches[$round])){
			$home_name=$match_per_goal->home_name;
			$away_name=$match_per_goal->away_name;
			$home_goal=$match_per_goal->home_goal;
			$away_goal=$match_per_goal->away_goal;
			$home_rank=$match_per_goal->home_rank;
			$away_rank=$match_per_goal->away_rank;
			$date=$match_per_goal->date;
			$matches[$round]=array("home"=>$home_name, "away"=>$away_name, "home_goal"=>$home_goal, "away_goal"=>$away_goal,"home_rank"=>$home_rank, "away_rank"=>$away_rank, "date"=>$date);
			$matches[$round]["goals"]=array();
			array_push($matches[$round]["goals"],array("player"=>$player_name,"time"=>$goal_time));
		}else{
			array_push($matches[$round]["goals"],array("player"=>$player_name,"time"=>$goal_time));
		}
	}
	//var_dump($matches);
	$matches=array_values($matches);
	$json["data"]=$matches;
	return json_encode($json);
}
?>
