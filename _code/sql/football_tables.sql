create table football_clubs(
	id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name CHAR(30) NOT NULL,
	league ENUM("yingchao","xijia","dejia","fajia","yijia","zhongchao")
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

create table football_matches(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	season char(9),	
	home_club_id SMALLINT,
	home_goals TINYINT NOT NULL,
	home_points TINYINT NOT NULL,
	home_position TINYINT NOT NULL,
	host_club_id SMALLINT,
	host_goals TINYINT NOT NULL,
        host_points TINYINT NOT NULL,
	host_position TINYINT NOT NULL,
	round TINYINT NOT NULL,
	first_half_score char(5),
	second_half_score char(5),
	add_time_score CHAR(5),
	penalty_shootout CHAR(5),
	CONSTRAINT fk_match_host_club FOREIGN KEY (host_club_id) REFERENCES football_clubs(id) ON UPDATE CASCADE ON DELETE SET NULL,
	CONSTRAINT fk_match_home_club FOREIGN KEY (home_club_id) REFERENCES football_clubs(id) ON UPDATE CASCADE ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;	

CREATE TABLE football_players(
	id SMALLINT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	firstname VARCHAR(20) NOT NULL,
	lastname VARCHAR(20) NOT NULL,
	country VARCHAR(30) NOT NULL,
	birthday DATE NOT NULL,
	club_id SMALLINT,
   	CONSTRAINT fk_player_club FOREIGN KEY (club_id) REFERENCES football_clubs(id) ON UPDATE CASCADE ON DELETE SET NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE football_goals(
       id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	match_id INT NOT NULL,
       shoot_player_id SMALLINT NOT NULL,
       assist_player_id SMALLINT,
       type ENUM("normal","own","penalty") NOT NULL,
	time TIME NOT NULL,
   	CONSTRAINT fk_goal_shoot FOREIGN KEY (shoot_player_id) REFERENCES football_players(id) ON UPDATE CASCADE ON DELETE CASCADE,
   	CONSTRAINT fk_goal_assist FOREIGN KEY (assist_player_id) REFERENCES football_players(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_goal_match FOREIGN KEY (match_id) REFERENCES football_matches(id) ON UPDATE CASCADE ON DELETE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8;
