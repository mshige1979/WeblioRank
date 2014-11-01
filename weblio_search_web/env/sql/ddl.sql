CREATE DATABASE `sample_db2`;
USE `sample_db2`;

DROP TABLE `rank`;

CREATE TABLE `rank` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `rank` INTEGER NOT NULL,
  `category` varchar(50) DEFAULT NULL,
  `word` varchar(256) DEFAULT NULL,
  `date` DATE DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
