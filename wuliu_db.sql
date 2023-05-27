/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : wuliu_db

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-11-19 22:47:53
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `username` varchar(20) NOT NULL default '',
  `password` varchar(32) default NULL,
  PRIMARY KEY  (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('a', 'a');

-- ----------------------------
-- Table structure for `t_car`
-- ----------------------------
DROP TABLE IF EXISTS `t_car`;
CREATE TABLE `t_car` (
  `carNo` varchar(20) NOT NULL COMMENT 'carNo',
  `carPhoto` varchar(60) NOT NULL COMMENT '车辆照片',
  `carColor` varchar(20) NOT NULL COMMENT '车辆颜色',
  `chejiahao` varchar(20) NOT NULL COMMENT '车架号',
  `dunwei` varchar(20) NOT NULL COMMENT '吨位',
  `buyDate` varchar(20) default NULL COMMENT '购买日期',
  `driverName` varchar(20) NOT NULL COMMENT '驾驶员姓名',
  `cardNumber` varchar(20) NOT NULL COMMENT '驾驶员身份证',
  `telephone` varchar(20) NOT NULL COMMENT '驾驶员电话',
  `carState` varchar(20) NOT NULL COMMENT '车辆状态',
  `memo` varchar(500) default NULL COMMENT '备注信息',
  PRIMARY KEY  (`carNo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_car
-- ----------------------------
INSERT INTO `t_car` VALUES ('川A-2031A8', 'upload/8c8aad78-c700-414a-bd2c-283e77dab7c2.jpg', '白色', '201', '10吨', '2018-11-15', '李凯明', '513030196210112953', '13950850834', '运输中', '驾驶员技术娴熟');
INSERT INTO `t_car` VALUES ('川B-9853B6', 'upload/b32b64b2-fe22-48a6-9777-303669c80a65.jpg', '蓝色', '302', '15吨', '2018-11-01', '黄小马', '514042198810243985', '13950820842', '运输中', '车辆稳定运行');

-- ----------------------------
-- Table structure for `t_carroute`
-- ----------------------------
DROP TABLE IF EXISTS `t_carroute`;
CREATE TABLE `t_carroute` (
  `routeId` int(11) NOT NULL auto_increment COMMENT '调度id',
  `carObj` varchar(20) NOT NULL COMMENT '调度车辆',
  `startPlace` varchar(80) NOT NULL COMMENT '出发地',
  `startLongitude` float NOT NULL COMMENT '起点经度',
  `startLatitude` float NOT NULL COMMENT '起点纬度',
  `endPlace` varchar(80) NOT NULL COMMENT '终到地',
  `endLongitude` float NOT NULL COMMENT '终点经度',
  `endLatitude` float NOT NULL COMMENT '终点纬度',
  `currenPlace` varchar(20) NOT NULL COMMENT '当前位置',
  `startTime` varchar(20) default NULL COMMENT '出发时间',
  `endTime` varchar(20) default NULL COMMENT '抵达时间',
  `routeState` varchar(20) NOT NULL COMMENT '调度状态',
  `costMoney` float NOT NULL COMMENT '运输成本',
  PRIMARY KEY  (`routeId`),
  KEY `carObj` (`carObj`),
  CONSTRAINT `t_carroute_ibfk_1` FOREIGN KEY (`carObj`) REFERENCES `t_car` (`carNo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_carroute
-- ----------------------------
INSERT INTO `t_carroute` VALUES ('1', '川A-2031A8', '成都转运中心', '104.07', '30.67', '长沙转运中心', '112.59', '28.12', '重庆市', '2018-11-15 18:52:44', '2018-11-15 18:53:08', '运输中', '2500');
INSERT INTO `t_carroute` VALUES ('2', '川B-9853B6', '成都转运中心', '104.07', '30.67', '南充转运中心', '106.08', '30.78', '成都起点站', '2018-11-19 22:37:40', '2018-11-27 22:37:57', '待调度', '680');

-- ----------------------------
-- Table structure for `t_news`
-- ----------------------------
DROP TABLE IF EXISTS `t_news`;
CREATE TABLE `t_news` (
  `newsId` int(11) NOT NULL auto_increment COMMENT '新闻id',
  `title` varchar(80) NOT NULL COMMENT '标题',
  `content` varchar(5000) NOT NULL COMMENT '公告内容',
  `publishDate` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`newsId`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_news
-- ----------------------------
INSERT INTO `t_news` VALUES ('1', '物流网站系统成立了', '<p>同志们可以来这里寄送货物，实时查看货物状态哈Q!</p>', '2018-11-15 18:53:34');

-- ----------------------------
-- Table structure for `t_orderinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderinfo`;
CREATE TABLE `t_orderinfo` (
  `orderId` int(11) NOT NULL auto_increment COMMENT '订单id',
  `sendName` varchar(20) NOT NULL COMMENT '寄件人姓名',
  `sendTelephone` varchar(20) NOT NULL COMMENT '寄件人电话',
  `sendAddress` varchar(500) NOT NULL COMMENT '寄件人地址',
  `getName` varchar(20) NOT NULL COMMENT '收件方电话',
  `getTelephone` varchar(20) NOT NULL COMMENT '收件方电话',
  `getAddress` varchar(500) NOT NULL COMMENT '收件方地址',
  `productName` varchar(50) NOT NULL COMMENT '货物名称',
  `productPhoto` varchar(60) NOT NULL COMMENT '货物照片',
  `productPrice` float NOT NULL COMMENT '货物价格',
  `weight` varchar(20) NOT NULL COMMENT '货物重量',
  `userObj` varchar(30) NOT NULL COMMENT '发布用户',
  `orderStateObj` int(11) NOT NULL COMMENT '订单状态',
  `addTime` varchar(20) default NULL COMMENT '发布时间',
  PRIMARY KEY  (`orderId`),
  KEY `userObj` (`userObj`),
  KEY `orderStateObj` (`orderStateObj`),
  CONSTRAINT `t_orderinfo_ibfk_1` FOREIGN KEY (`userObj`) REFERENCES `t_userinfo` (`user_name`),
  CONSTRAINT `t_orderinfo_ibfk_2` FOREIGN KEY (`orderStateObj`) REFERENCES `t_orderstate` (`orderStateId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderinfo
-- ----------------------------
INSERT INTO `t_orderinfo` VALUES ('1', '李明珠', '13958342342', '四川成都红星路13号', '李明涛', '13598083501', '长沙市晋安区13号', '苹果8手机', 'upload/5cfab40a-0790-48b6-b282-a8e3752226f8.jpg', '8000', '100克', 'user1', '2', '2018-11-15 18:51:02');
INSERT INTO `t_orderinfo` VALUES ('2', '李明珠', '13958342342', '四川成都红星路12号', '张晓霞', '13085085083', '四川南充市滨江路10号', '金士顿固态硬盘', 'upload/18f1c8b4-9d22-43c9-8d6a-d8ee4db012a3.jpg', '388', '88克', 'user1', '1', '2018-11-19 15:47:20');

-- ----------------------------
-- Table structure for `t_orderstate`
-- ----------------------------
DROP TABLE IF EXISTS `t_orderstate`;
CREATE TABLE `t_orderstate` (
  `orderStateId` int(11) NOT NULL auto_increment COMMENT '订单状态id',
  `orderStateName` varchar(20) NOT NULL COMMENT '订单状态名称',
  PRIMARY KEY  (`orderStateId`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_orderstate
-- ----------------------------
INSERT INTO `t_orderstate` VALUES ('1', '待调度');
INSERT INTO `t_orderstate` VALUES ('2', '运输中');
INSERT INTO `t_orderstate` VALUES ('3', '已签收');

-- ----------------------------
-- Table structure for `t_ordertrans`
-- ----------------------------
DROP TABLE IF EXISTS `t_ordertrans`;
CREATE TABLE `t_ordertrans` (
  `transId` int(11) NOT NULL auto_increment COMMENT '运输id',
  `orderObj` int(11) NOT NULL COMMENT '运输订单',
  `carRouteObj` int(11) NOT NULL COMMENT '加入调度',
  `joinTime` varchar(20) default NULL COMMENT '加入时间',
  `memo` varchar(500) default NULL COMMENT '备注',
  PRIMARY KEY  (`transId`),
  KEY `orderObj` (`orderObj`),
  KEY `carRouteObj` (`carRouteObj`),
  CONSTRAINT `t_ordertrans_ibfk_1` FOREIGN KEY (`orderObj`) REFERENCES `t_orderinfo` (`orderId`),
  CONSTRAINT `t_ordertrans_ibfk_2` FOREIGN KEY (`carRouteObj`) REFERENCES `t_carroute` (`routeId`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_ordertrans
-- ----------------------------
INSERT INTO `t_ordertrans` VALUES ('1', '1', '1', '2018-11-15 18:53:22', 'test');
INSERT INTO `t_ordertrans` VALUES ('2', '2', '2', '2018-11-19 22:41:07', '开始运货了！');

-- ----------------------------
-- Table structure for `t_userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `t_userinfo`;
CREATE TABLE `t_userinfo` (
  `user_name` varchar(30) NOT NULL COMMENT 'user_name',
  `password` varchar(30) NOT NULL COMMENT '登录密码',
  `name` varchar(20) NOT NULL COMMENT '姓名',
  `gender` varchar(4) NOT NULL COMMENT '性别',
  `birthDate` varchar(20) default NULL COMMENT '出生日期',
  `userPhoto` varchar(60) NOT NULL COMMENT '用户照片',
  `telephone` varchar(20) NOT NULL COMMENT '联系电话',
  `email` varchar(50) NOT NULL COMMENT '邮箱',
  `address` varchar(80) default NULL COMMENT '家庭地址',
  `regTime` varchar(20) default NULL COMMENT '注册时间',
  PRIMARY KEY  (`user_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_userinfo
-- ----------------------------
INSERT INTO `t_userinfo` VALUES ('user1', '123', '李明珠', '女', '2018-11-15', 'upload/ebb2094d-fef1-45e8-868e-efbae77139c4.jpg', '13958342342', 'xiaofen@163.com', '四川成都红星路13号', '2018-11-15 18:50:13');
INSERT INTO `t_userinfo` VALUES ('user2', '123', '张小凤', '女', '2018-11-13', 'upload/82daba53-3102-467c-9544-d881c3e3cd37.jpg', '13508350853', 'xiaofeng@163.com', '成都红星路15号', '2018-11-19 22:20:15');
