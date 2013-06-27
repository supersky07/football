# encoding: utf-8
require 'nokogiri'
require 'open-uri'

url = 'http://www.premierleague.com/en-gb/matchday/matches/2012-2013/epl.match-stats.html/norwich-vs-man-utd'
doc=Nokogiri::HTML(open(url))

#获取比赛的技术统计 结果存入一个Hash
#doc=Nokogiri::HTML(open(url))
def statsTable(doc)
	path="//div[@class='statsTable']/table[@class='contentTable']"
	table=doc.xpath(path)
	#stats是一个HASH，用来存放比赛统计数据，它有三个键 heads，队伍1名，队伍2名
	stats=Hash.new
	#获取队伍的名字
	team1_name = table.first.xpath("tbody/tr[1]/th").text
	team2_name = table.first.xpath("tbody/tr[2]/th").text
	stats["stats_type"]=[]#统计类型
	stats[team1_name]=[]
	stats[team2_name]=[]
	table.each do |single_table|
		table_heads=single_table.xpath("thead/tr/th[not(@class='ignore')]")
	#	p table_heads
		table_heads.each{|head| stats["stats_type"].push(head.text)}
		#对每一个小表，获取第一个队的统计数据
		this_team_name1=single_table.xpath("tbody/tr[1]/th[1]").text
		this_team_name2=single_table.xpath("tbody/tr[2]/th[1]").text
		single_table.xpath("tbody/tr[1]//td").each{|td| stats[this_team_name1].push(td.text)}
		
		single_table.xpath("tbody/tr[2]//td").each{|td| stats[this_team_name2].push(td.text)}
	end
	raise "抓取技术统计错误，名字个数和统计数字个数不匹配" unless ( stats["stats_type"].length==stats[team1_name].length and stats["stats_type"].length==stats[team2_name].length)
	#查看抓取分析的结果
	puts stats
	return stats
end
statsTable doc
