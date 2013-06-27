#encoding:utf-8
require './match_result.rb'
require 'mysql2'
begin

		clubs=[]
		matches=[]
		con=Mysql2::Client.new(:host=>'localhost',:username=>'root',:password=>'abc123',:database=>'football')
		query="select * from clubs"
		con.query(query).each do |club|
			short_name=club["short_name"]
			clubs.push short_name
		end
		puts clubs
		clubs.each do |club|
			clubs.each {|another_club| matches.push(club+'-vs-'+another_club) if club!=another_club}
		end	
		matches.each {|match| match.gsub!(/\s/,'-')}
			#puts matches

		url='http://www.premierleague.com/en-gb/matchday/matches/2012-2013/epl.match-stats.html/'
		matches.each do |match|
			home,away=match.split('-vs-')
			#home=home.gsub!(/-/,' ') if home.include?('-')
		#	away=away.gsub!(/-/,' ') if away.include?('-')
			#puts"home is "+ home
			#puts "away is "+away
			query="SELECT count(*) as total FROM matches WHERE home_team='#{home}' and away_team='#{away}'"
			puts query
			result=con.query(query)
		#	puts query
			if result.first['total']!=0
				puts "find and already exisited match"+"home team is "+home+", away team is "+away
			else
				parse_match_result(url+match)
			end
		end

rescue 	Mysql2::Error=>e
	puts e.error
	puts "***************************************retry**************************************"
	retry
ensure
	con.close if con
end
