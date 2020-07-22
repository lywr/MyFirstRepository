DROP TABLE IF EXISTS `driver_info`;
CREATE TABLE `driver_info`
(
  `id`                      BIGINT(20)    NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn`                      VARCHAR(20)   NOT NULL COMMENT '车机sn',
  `path_id`                 VARCHAR(32)   NULL     DEFAULT NULL COMMENT '路径ID',
  `start_time`              TIMESTAMP     NULL     DEFAULT NULL COMMENT '开始时间',
  `end_time`                TIMESTAMP     NULL     DEFAULT NULL COMMENT '结束时间',
  `distance`                double(16, 2) NOT NULL DEFAULT 0 COMMENT '行驶距离',
  `avg_speed`               double(16, 2) NOT NULL DEFAULT 0 COMMENT '平均速度',
  `total_mileage`           double(16, 2) NULL     DEFAULT 0 COMMENT '总里程',
  `use_oil`                 double(16, 2) NULL     DEFAULT 0 COMMENT '行程油耗总耗油量',
  `min_oil_instant100`      double(16, 2) NULL     DEFAULT 0 COMMENT '最低油耗 L/100KM',
  `max_oil_instant100`      double(16, 2) NULL     DEFAULT 0 COMMENT '最高油耗 L/100KM',
  `average_oil100`          double(16, 2) NULL     DEFAULT 0 COMMENT '行程平均油耗  L/100KM',
  `max_instant_speed`       double(16, 2) NULL     DEFAULT 0 COMMENT '最高瞬时速度',
  `count_urgent_accelerate` INT(8)        NOT NULL DEFAULT 0 COMMENT '急加速次数',
  `count_sharp_slowdown`    INT(8)        NOT NULL DEFAULT 0 COMMENT '急减速次数',
  `count_sharp_turn`        INT(8)        NOT NULL DEFAULT 0 COMMENT '急转弯次数',
  `from_addr`               VARCHAR(100)   NULL     DEFAULT NULL COMMENT '起点',
  `to_addr`                 VARCHAR(100)   NULL     DEFAULT NULL COMMENT '终点',
  `create_time`             TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_time`             TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version`                 INT(4)        NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `driver_info_sn_start_time` (`sn`, `start_time`)
) ENGINE = `InnoDB`
  DEFAULT CHARSET = utf8 COMMENT ='驾驶信息详情';


DROP TABLE IF EXISTS `car_butler_user`;
CREATE TABLE `car_butler_user`
(
  `id`                BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn`                varchar(20)  NOT NULL COMMENT '车机sn',
  `user_id`           bigint(20)   NOT NULL COMMENT '用户id',
  `user_name`         varchar(32)  NOT NULL COMMENT '用户姓名',
  `head_image`        varchar(256) NULL COMMENT '用户头像',
  `user_type`         int(4)                DEFAULT 1 COMMENT '用户类型：1-未参与省钱，2-参与省钱用户',
  `brake_update_time` TIMESTAMP    NULL     DEFAULT NULL COMMENT '刹车片更新时间',
  `tyre_update_time`  TIMESTAMP    NULL     DEFAULT NULL COMMENT '轮胎更新时间',
  `create_time`       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_time`       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version`           INT(4)       NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `car_butler_user_user_type` (`user_type`),
  INDEX `car_butler_user_sn_userid` (`sn`, `user_id`)
) ENGINE = `InnoDB`
  DEFAULT CHARSET = utf8 COMMENT ='车管家参与省钱活动用户';


DROP TABLE IF EXISTS `reward_name_list`;
CREATE TABLE `reward_name_list`
(
  `id`            BIGINT(20)    NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn`            varchar(20)   NOT NULL COMMENT '车机sn',
  `user_name`     varchar(20)   NOT NULL COMMENT '奖励人',
  `head_image`    varchar(256)  NULL COMMENT '奖励人头像',
  `reward_name`   varchar(20)   NOT NULL COMMENT '奖品名称',
  `current_order` INT(10)       NOT NULL DEFAULT 0 COMMENT '排名(第几名)',
  `save_oil`      double(16, 2) NULL     DEFAULT 0 COMMENT '节省油量',
  `save_money`    double(16, 2) NULL     DEFAULT 0 COMMENT '节省钱数',
  `recive_type`   INT(8)        NOT NULL DEFAULT 1 COMMENT '是否已领取：1未领取，2已领取，3已过期',
  `bag_id`        BIGINT(20)    NOT NULL DEFAULT 0 COMMENT '福袋id',
  `create_time`   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_time`   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version`       INT(4)        NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `recive_type_create_time` (`recive_type`, `create_time`)
) ENGINE = `InnoDB`
  DEFAULT CHARSET = utf8 COMMENT ='排行榜奖励名单';


DROP TABLE IF EXISTS `rank_list`;
CREATE TABLE `rank_list`
(
  `id`            BIGINT(20)    NOT NULL AUTO_INCREMENT COMMENT 'id',
  `sn`            varchar(20)   NOT NULL COMMENT '车机sn',
  `user_id`       bigint(20)    NOT NULL COMMENT '用户id',
  `user_name`     VARCHAR(32)   NULL     DEFAULT NULL COMMENT '用户名称',
  `head_image`    varchar(256)  NULL COMMENT '用户头像',
  `yestday_order` INT(10)       NOT NULL DEFAULT 0 COMMENT '昨天的排名',
  `current_order` INT(10)       NOT NULL DEFAULT 0 COMMENT '今天的排名',
  `save_oil`      double(16, 2) NULL     DEFAULT 0 COMMENT '节省油量',
  `save_money`    double(16, 2) NULL     DEFAULT 0 COMMENT '节省钱数',
  `create_time`   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_time`   TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version`       INT(4)        NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `rank_list_user_id` (`user_id`),
  INDEX `rank_list_sn_create_time` (`sn`, `create_time`)
) ENGINE = `InnoDB`
  DEFAULT CHARSET = utf8 COMMENT ='排名表';


DROP TABLE IF EXISTS `point_flow`;
CREATE TABLE `point_flow`
(
  `id`               BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT 'id',
  `be_sn`            varchar(20)  NOT NULL COMMENT '被点赞车机sn',
  `be_user_id`       bigint(20)   NULL     DEFAULT NULL COMMENT '被点赞用户id',
  `be_user_name`     VARCHAR(32)  NULL     DEFAULT NULL COMMENT '被点赞用户名称',
  `be_head_image`    varchar(256) NULL COMMENT '被点赞用户头像',
  `open_id`          VARCHAR(32)  NULL     DEFAULT NULL COMMENT '微信用户唯一标示',
  `point_sn`         varchar(20)  NOT NULL COMMENT '点赞车机sn',
  `point_user_id`    bigint(20)   NOT NULL COMMENT '点赞用户id',
  `point_user_name`  VARCHAR(32)  NULL     DEFAULT NULL COMMENT '点赞用户名称',
  `point_head_image` varchar(256) NULL COMMENT '点赞用户头像',
  `point_desc`       varchar(32)  NULL COMMENT '点赞描述',
  `reward_count`     INT(8)       NOT NULL DEFAULT 0 COMMENT '奖励金币数',
  `create_time`      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
  `update_time`      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `version`          INT(4)       NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `point_flow_sn` (`be_sn`, `point_sn`),
  INDEX `point_flow_user_id` (`be_user_id`, `point_user_id`)
) ENGINE = `InnoDB`
  DEFAULT CHARSET = utf8 COMMENT ='点赞流水';

DROP TABLE IF EXISTS `coin_flow`;
CREATE TABLE `coin_flow`
(
  `id`          BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `flow_code`   VARCHAR(32)         NOT NULL DEFAULT '' COMMENT '流水编号',
  `flow_desc`   VARCHAR(99)         NULL     DEFAULT '' COMMENT '流水描述',
  `sn`          VARCHAR(20)         NOT NULL COMMENT '车机编号',
  `flow_status` TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '流水状态：0-正常 1-回退',
  `biz_id`      TINYINT(1) UNSIGNED NOT NULL DEFAULT '0' COMMENT '业务分类：1-驾驶详情 2-其他',
  `user_id`     BIGINT(20)          NOT NULL COMMENT '用户id',
  `user_name`   VARCHAR(32)         NOT NULL DEFAULT '' COMMENT '用户名称',
  `coin_count`  BIGINT(20)          NOT NULL DEFAULT '0' COMMENT '金币数量：正数-进账;负数-支出',
  `create_time` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  INDEX `idx_sn` (`sn`)
) ENGINE = INNODB
  AUTO_INCREMENT = 100000
  DEFAULT CHARSET = utf8 COMMENT ='金币流水表';


ALTER TABLE coin_flow
DROP INDEX idx_sn;
CREATE UNIQUE INDEX uk_sn ON coin_flow (sn);
