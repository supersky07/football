#encoding:utf-8

require 'mysql2'
local_date='20120212'
location='old teraford'
home='man utd'
away='west brom'
home_goals=[{"Mikel Arteta"=>"26 pen, 64 pen"}]
away_goals=[]
temp_home_goals=[]
temp_away_goals=[]

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
home_goals=divide(home_goals,temp_home_goals)
away_goals=divide(away_goals,temp_away_goals)
begin
	con=Mysql2::Client.new(:host=>'localhost',:username=>'root',:password=>'abc123',:database=>'football')
	query="INSERT INTO matches (home_team,away_team,home_goals_count,away_goals_count,time,location) VALUES ('#{home}','#{away}','#{home_goals.count}','#{away_goals.count}','#{local_date}','#{location}')"
	puts query
	#result=con.query(query)
	id=con.query("SELECT id FROM matches where home_team='#{home}' and away_team='#{away}'").first.values[0]
	puts "id is :"+id.to_s
	(home_goals+away_goals).each do |goal|
		if goal.values[0].include?"pen"
			is_penalty=1
			time=goal.values[0].match(/\d+/)
			puts time
		else
			is_penalty=0
		end
		player=goal.keys[0]
		query="INSERT INTO goals (player,time,is_penalty,match_id)VALUES('#{player}','#{time}','#{is_penalty}','#{id}')"
		puts query
		con.query(query)
	end
rescue Mysql2::Error=>e
	puts e.errno
	puts e.error
ensure
	con.close if con
end
