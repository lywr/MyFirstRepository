DROP TABLE IF EXISTS `master_card`;
CREATE TABLE `master_card` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`user_id` BIGINT(20) NOT NULL DEFAULT '0',
	`car_license` VARCHAR(32) NULL DEFAULT NULL COMMENT '车牌号',
	`order_id` BIGINT(20) NULL DEFAULT NULL COMMENT '订单Id',
	`card_status` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '车主卡状态 1-已激活，0-未激活',
	`card_type` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '车主卡类型 0-普通 1-vip',
	`oil_card_id` VARCHAR(32) NULL DEFAULT NULL COMMENT '加油卡id',
	`oil_batch_id` VARCHAR(64) NULL DEFAULT NULL COMMENT '油卡批次id',
	`oil_card_company` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '油卡公司',
	`sku_id` BIGINT(20) NOT NULL DEFAULT '0' COMMENT 'sku_id',
	`rescue_status` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '救援状态1-已购买，0未购买',
	`maintain_used_count` INT(8) NOT NULL DEFAULT '0' COMMENT '保养使用次数',
	`maintain_total_count` INT(8) NOT NULL DEFAULT '0' COMMENT '保养次数',
	`wash_used_count` INT(8) NOT NULL DEFAULT '0' COMMENT '洗车使用次数',
	`wash_total_count` INT(8) NOT NULL DEFAULT '0' COMMENT '洗车总次数',
	`oil_used_count` INT(8) NOT NULL DEFAULT '0' COMMENT '加油使用次数',
	`oil_total_count` INT(8) NOT NULL DEFAULT '0' COMMENT '加油总次数',
	`ad_code` INT(12) NOT NULL DEFAULT '0' COMMENT '地区码',
	`activate_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '激活时间',
	`expire_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`version` INT(4) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	UNIQUE INDEX `user_id` (`user_id`)
)
COMMENT='车主卡'
COLLATE='utf8mb4_general_ci';

DROP TABLE IF EXISTS `rescue_info`;
CREATE TABLE `rescue_info` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`car_license` VARCHAR(32) NOT NULL,
	`user_id` BIGINT(20) NOT NULL DEFAULT '0',
	`phone` VARCHAR(32) NOT NULL DEFAULT '0',
	`order_id` BIGINT(20) NOT NULL DEFAULT '0' COMMENT '订单id',
	`service_status` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '1-保障中，0-等待系统确认 2-已过期',
	`expire_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '过期时间',
	`create_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`update_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `user_id` (`user_id`)
)
COMMENT='救援信息'
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
