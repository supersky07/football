#encoding:utf-8
require 'nokogiri'
require 'open-uri'
require 'mysql2'
#定义一个函数，用于当一个人进了多个球的情况
def divide (goals,temp_array)
	goals.each do |goal| #goal like      {"Mikel Arteta"=>"26 pen, 64 pen"}
		if goal.values[0].include? ","
			key=goal.keys[0]
			goal.values[0].split(",").each {|each_goal| temp_array.push({key=>each_goal})}
		else
			temp_array.push(goal)
		end
	end
	return temp_array
end

#把时间格式化为可以填入数据库的Date类型的字符串 初始字符串的格式为 Sunday 12 May 2013
def formate_date (s)
	s=s.split(" ")
	day=s[1]
	month=s[2]
	year=s[3]
	months=["january","february","march","april","may","june","july","august","september","october","november","december"]
	if month=months.index(month.downcase)
		month+=1
	end
	month="0"+month.to_s if month<10
	day="0"+day if day.to_i<10
	return year+month.to_s+day
end

#url='http://www.premierleague.com/en-gb/matchday/matches/2012-2013/epl.match-stats.html/arsenal-vs-west-brom'
#获取比赛结果，包括队名，比分，进球队员，进球时间，比赛地点
def parse_match_result(url)
	doc=Nokogiri::HTML(open(url))
	match_table=doc.xpath("//div[@class='header clearfix post_match']").first
	#比赛时间，是timestamp格式
	local_date=match_table.xpath("p/span").text
	local_date = formate_date(local_date)
	#比赛地点
	location=match_table.xpath("p").text.split('|')[1]
	#主队名，客队名
	home_vs_away=/[^\/]*$/.match(url)[0]
	home,away=home_vs_away.split(/-vs-/)
	#主队进球，客人进球
	away_goals=[]
	home_goals=[]
	#用于进球队员的正则表达式
	reg_player=/\w+\s?\w*(?=\s\()/
	#用于进球时间的正则表达式
	reg_goal_time =/(?<=\().+(?=\))/ 
	match_table.xpath("div[@class='home goals']//li").each do |goal|
		goal=goal.text
		#主队进球队员
		player=reg_player.match(goal).to_s
		#主队进球时间
		goal_time = reg_goal_time.match(goal).to_s
		home_goals.push({player=>goal_time})
	end
	match_table.xpath("div[@class='away goals']//li").each do |goal|
		goal=goal.text
		#客队进球队员
		player=reg_player.match(goal).to_s
		goal_time = reg_goal_time.match(goal).to_s
		away_goals.push({player=>goal_time})
	end
		
	#puts "home goals is :"+home_goals.to_s
	#puts "away goals is :"+away_goals.to_s
	temp_array=[]
	home_goals=divide(home_goals,temp_array)
	temp_array=[]
	away_goals=divide(away_goals,temp_array)
	begin
		con=Mysql2::Client.new(:host=>'localhost',:username=>'root',:password=>'abc123',:database=>'football')
		location=con.escape(location)
		query="INSERT INTO matches (home_team,away_team,home_goals_count,away_goals_count,time,location) VALUES ('#{home}','#{away}','#{home_goals.count}','#{away_goals.count}','#{local_date}','#{location}')"
		puts query
		result=con.query(query)
		id=con.query("SELECT id FROM matches where home_team='#{home}' and away_team='#{away}'").first.values[0]
	#	puts "id is :"+id.to_s
		(home_goals+away_goals).each do |goal|
	#		puts "each goal in the game is "+goal.to_s
			if goal.values[0].include?"Pen"
				is_penalty=1
			else
				is_penalty=0
			end
			time=goal.values[0].match(/\d+/)
			player=goal.keys[0]
			query="INSERT INTO goals (player,time,is_penalty,match_id)VALUES('#{player}','#{time}','#{is_penalty}','#{id}')"
			puts query
			con.query(query)
		end
	rescue 	Mysql2::Error=>e
		puts e.errno
		puts e.error
	ensure
	con.close if con
	end
end
#parse_match_result(url)
