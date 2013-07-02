-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- 主机: localhost
-- 生成日期: 2013 年 07 月 02 日 03:11
-- 服务器版本: 5.1.41
-- PHP 版本: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- 数据库: `football`
--

-- --------------------------------------------------------

--
-- 表的结构 `coach`
--

CREATE TABLE IF NOT EXISTS `coach` (
  `cid` int(10) NOT NULL,
  `tid` int(10) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `short_name` varchar(32) DEFAULT NULL,
  `chinese_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `birthday` date DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `photo` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `coach`
--


-- --------------------------------------------------------

--
-- 表的结构 `goals`
--

CREATE TABLE IF NOT EXISTS `goals` (
  `gid` varchar(64) NOT NULL,
  `mid` varchar(64) NOT NULL,
  `time` time NOT NULL,
  `pid` varchar(64) NOT NULL,
  `tid` int(10) NOT NULL,
  `type` int(2) NOT NULL DEFAULT '0',
  `assists` varchar(64) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`gid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `goals`
--


-- --------------------------------------------------------

--
-- 表的结构 `league`
--

CREATE TABLE IF NOT EXISTS `league` (
  `lid` int(2) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `short_name` varchar(32) DEFAULT NULL,
  `chinese_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `country` varchar(32) NOT NULL,
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`lid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `league`
--


-- --------------------------------------------------------

--
-- 表的结构 `matches`
--

CREATE TABLE IF NOT EXISTS `matches` (
  `mid` varchar(64) NOT NULL,
  `home_team` int(10) NOT NULL,
  `away_team` int(10) NOT NULL,
  `date` datetime NOT NULL,
  `home_goal` int(2) NOT NULL,
  `away_goal` int(2) NOT NULL,
  `home_point` int(3) NOT NULL,
  `away_point` int(3) NOT NULL,
  `home_rank` int(2) NOT NULL,
  `away_rank` int(2) NOT NULL,
  `lid` int(2) NOT NULL,
  `round` int(2) NOT NULL,
  `rid` int(10) NOT NULL,
  `season` varchar(32) NOT NULL,
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `matches`
--


-- --------------------------------------------------------

--
-- 表的结构 `match_detail`
--

CREATE TABLE IF NOT EXISTS `match_detail` (
  `seq` int(255) NOT NULL AUTO_INCREMENT,
  `mid` varchar(64) NOT NULL,
  `pid` varchar(64) NOT NULL,
  `on_time` int(3) NOT NULL,
  `minutes` int(3) NOT NULL,
  `yellow` int(1) DEFAULT NULL,
  `red` int(1) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`seq`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `match_detail`
--


-- --------------------------------------------------------

--
-- 表的结构 `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `pid` varchar(64) NOT NULL,
  `tid` int(10) NOT NULL,
  `number` int(2) NOT NULL,
  `full_name` varchar(64) DEFAULT NULL,
  `short_name` varchar(32) DEFAULT NULL,
  `chinese_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `birthday` date DEFAULT NULL,
  `country` varchar(64) NOT NULL,
  `photo` varchar(128) DEFAULT NULL,
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `players`
--


-- --------------------------------------------------------

--
-- 表的结构 `referee`
--

CREATE TABLE IF NOT EXISTS `referee` (
  `rid` int(10) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `short_name` varchar(32) DEFAULT NULL,
  `chinese_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `birthday` date DEFAULT NULL,
  `country` varchar(64) DEFAULT NULL,
  `photo` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`rid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `referee`
--


-- --------------------------------------------------------

--
-- 表的结构 `team`
--

CREATE TABLE IF NOT EXISTS `team` (
  `tid` int(10) NOT NULL COMMENT '球队id',
  `name` varchar(128) DEFAULT NULL COMMENT '球队全称',
  `short_name` varchar(32) DEFAULT NULL,
  `chinese_name` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `lid` int(2) NOT NULL,
  `coach` int(10) NOT NULL,
  `remark` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`tid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- 转存表中的数据 `team`
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
