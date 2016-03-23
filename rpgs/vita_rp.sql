/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50610
Source Host           : localhost:3306
Source Database       : vita_rpgs

Target Server Type    : MYSQL
Target Server Version : 50610
File Encoding         : 65001

Date: 2016-01-14 19:00:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `bank`
-- ----------------------------
DROP TABLE IF EXISTS `bank`;
CREATE TABLE `bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 DEFAULT 'Der.Neger',
  `geld` int(40) DEFAULT '0',
  `type` int(11) DEFAULT '0',
  `dispo` int(11) DEFAULT '0',
  `access` varchar(2048) CHARACTER SET utf8 DEFAULT 'Niemand',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=739 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of bank
-- ----------------------------

-- ----------------------------
-- Table structure for `houses`
-- ----------------------------
DROP TABLE IF EXISTS `houses`;
CREATE TABLE `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x` float(30,20) DEFAULT '0.00000000000000000000',
  `y` float(30,20) DEFAULT '0.00000000000000000000',
  `z` float(30,20) DEFAULT '0.00000000000000000000',
  `ix` float(30,20) DEFAULT '0.00000000000000000000',
  `iy` float(30,20) DEFAULT '0.00000000000000000000',
  `iz` float(30,20) DEFAULT '0.00000000000000000000',
  `ii` int(11) DEFAULT '0',
  `idd` int(11) DEFAULT '0',
  `preis` int(30) DEFAULT '0',
  `miete` int(30) DEFAULT '0',
  `owner` varchar(255) CHARACTER SET utf8 DEFAULT 'Hans.Wurst',
  `keys` varchar(255) CHARACTER SET utf8 DEFAULT 'Hans.Wurst',
  `locked` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `lastjoin` int(30) DEFAULT '1448307751',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1476833512 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of houses
-- ----------------------------

-- ----------------------------
-- Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `erstellt` char(255) DEFAULT NULL,
  `laston` char(255) DEFAULT NULL,
  `name` char(255) DEFAULT NULL,
  `aktivated` char(255) DEFAULT NULL,
  `passwort` char(255) DEFAULT NULL,
  `geb` char(255) DEFAULT NULL,
  `skin` char(255) DEFAULT NULL,
  `x` char(255) DEFAULT NULL,
  `y` char(255) DEFAULT NULL,
  `z` char(255) DEFAULT NULL,
  `geschlecht` char(255) DEFAULT NULL,
  `interior` char(255) DEFAULT NULL,
  `dimension` char(255) DEFAULT NULL,
  `geld` char(255) DEFAULT NULL,
  `admin` char(255) DEFAULT NULL,
  `aschein` char(255) DEFAULT NULL,
  `mschein` char(255) DEFAULT NULL,
  `fschein` char(255) DEFAULT NULL,
  `bschein` char(255) DEFAULT NULL,
  `job` char(255) DEFAULT NULL,
  `rank` char(255) DEFAULT NULL,
  `dienst` int(255) DEFAULT NULL,
  `energie` char(255) DEFAULT NULL,
  `hunger` char(255) DEFAULT NULL,
  `harndrang` char(255) DEFAULT NULL,
  `hygiene` char(255) DEFAULT NULL,
  `health` char(255) DEFAULT NULL,
  `armour` char(255) DEFAULT NULL,
  `seat` char(255) DEFAULT NULL,
  `invehicle` char(255) DEFAULT NULL,
  `currentveh` char(255) DEFAULT NULL,
  `wschein` char(255) DEFAULT NULL,
  `pif` char(255) DEFAULT NULL,
  `einsperrzeit` char(255) DEFAULT NULL,
  `gehalt` char(255) DEFAULT NULL,
  `einnahmen` char(255) DEFAULT NULL,
  `dienstzeit` char(255) DEFAULT NULL,
  `items` text,
  `einnahmen2` char(255) DEFAULT NULL,
  `isDead` char(255) DEFAULT NULL,
  `gang` char(255) DEFAULT NULL,
  `gangrank` char(255) DEFAULT NULL,
  `serial` char(255) DEFAULT NULL,
  `promille` char(255) DEFAULT NULL,
  `promillesoll` char(255) DEFAULT NULL,
  `time` char(255) DEFAULT NULL,
  `btime` char(255) DEFAULT '0',
  `cooldown` char(255) DEFAULT '0',
  `sessionkey` varchar(11) DEFAULT 'NULL',
  `exp` char(255) DEFAULT '1',
  `level` char(11) DEFAULT '1',
  `panote` char(11) DEFAULT '0',
  `mail` varchar(255) DEFAULT 'schwanzus.longus@vita-online.eu',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2762 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------

-- ----------------------------
-- Table structure for `vehicles`
-- ----------------------------
DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE `vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isFake` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `inVerwarung` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `model` int(11) DEFAULT NULL,
  `x` float(100,20) DEFAULT NULL,
  `y` float(100,20) DEFAULT NULL,
  `z` float(100,20) DEFAULT NULL,
  `rx` float(100,20) DEFAULT NULL,
  `ry` float(100,20) DEFAULT NULL,
  `rz` float(100,20) DEFAULT NULL,
  `color` varchar(255) CHARACTER SET utf8 DEFAULT 'return {{{2},{3},{4},{5},},{0,0,0,},{0,0,0,},{0,0,0,},{0,0,0,},}--|',
  `var1` int(11) DEFAULT NULL,
  `var2` int(11) DEFAULT NULL,
  `upgrade` varchar(255) CHARACTER SET utf8 DEFAULT 'return {{},}--|',
  `damage` varchar(255) CHARACTER SET utf8 DEFAULT 'return {{},}--|',
  `doors` varchar(255) CHARACTER SET utf8 DEFAULT 'return {{},}--|',
  `wheels` varchar(255) CHARACTER SET utf8 DEFAULT 'return {{},}--|',
  `lights` varchar(255) CHARACTER SET utf8 DEFAULT 'return {{},}--|',
  `health` float(100,20) DEFAULT '1000.00000000000000000000',
  `engine` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `panne` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `km` float(255,30) DEFAULT '0.000000000000000000000000000000',
  `fuel` float(100,30) DEFAULT '100.000000000000000000000000000000',
  `oil` float(100,30) DEFAULT '100.000000000000000000000000000000',
  `battery` float(100,30) DEFAULT '100.000000000000000000000000000000',
  `water` float(100,30) DEFAULT '100.000000000000000000000000000000',
  `locked` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `keys` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `owner` varchar(255) CHARACTER SET utf8 DEFAULT 'false',
  `eingepackt` varchar(20) CHARACTER SET utf8 DEFAULT 'false',
  `vstatus` varchar(20) CHARACTER SET utf8 DEFAULT 'false',
  `preis` int(30) DEFAULT '0',
  `paintjob` int(30) DEFAULT NULL,
  `marked` varchar(20) CHARACTER SET utf8 DEFAULT 'false',
  `herstelldatum` varchar(30) CHARACTER SET utf8 DEFAULT '19.12.2014',
  `reserviert` varchar(30) CHARACTER SET utf8 DEFAULT 'Niemand',
  `tuev` int(30) DEFAULT '0',
  `tuevpreis` int(30) DEFAULT '150',
  `inventory` varchar(2048) CHARACTER SET utf8 DEFAULT 'return {{},}--|',
  `vzeit` int(30) DEFAULT '1448313217',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=161 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of vehicles
-- ----------------------------

-- ----------------------------
-- Table structure for `wanteds`
-- ----------------------------
DROP TABLE IF EXISTS `wanteds`;
CREATE TABLE `wanteds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `wantedLevel` int(11) DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8 DEFAULT '',
  `text` varchar(2048) CHARACTER SET utf8 DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of wanteds
-- ----------------------------
