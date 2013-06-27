
php_scripts里的文件用来在数据库中生成一个有所有英超球队名称的表
即clubs表，ruby脚本会从这个表中读取球队名称的简写，从而构造用于抓取网页的URL，即man－city-vs-man-utd这种

statistics.rb
用来分析单场比赛的详细技术统计，现在并没有集成自动抓取功能中，即现在自动获取的数据中并不包括每场比赛的详细技术统计。

match_result.rb
用来获取单场比赛的数据，例如时间，比分，进球队员，地点等

entire_season.rb
用来自动抓取整个赛季的比赛信息，它调用了match_result.rb中的方法
*** LOCAL GEMS ***

bundler (1.3.5)
bundler-unload (1.0.1)
mini_portile (0.5.0)
mysql2 (0.3.11)
nokogiri (1.6.0)
rake (10.0.4)
rubygems-bundler (1.2.0)
rvm (1.11.3.8)
