CREATE DATABASE IF NOT EXISTS `notification_management`;
USE `notification_management`;


CREATE TABLE IF NOT EXISTS `user` (
 `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
 `user_name` VARCHAR(255) NOT NULL,
 `dob` DATE NOT NULL,
 `role` INT NOT NULL,
 `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`id`)
);

CREATE TABLE IF NOT EXISTS `notification_entity` (
	`entity_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`entity_name` VARCHAR(255) NOT NULL,
	`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
     PRIMARY KEY (`entity_id`)
);

CREATE TABLE IF NOT EXISTS `notification_entity_type` (
  `entity_type_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(255) NOT NULL,
  `entity_id` INT UNSIGNED NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`entity_id`) REFERENCES `notification_entity`(`entity_id`),
  PRIMARY KEY (`entity_type_id`)
);

CREATE TABLE IF NOT EXISTS `notification_object` (
 `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
 `entity_type` INT UNSIGNED NOT NULL,
 `entity_id` INT UNSIGNED NOT NULL,
 `status` TINYINT NOT NULL,
 `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 CONSTRAINT `fk_entity_type` FOREIGN KEY (`entity_type`) REFERENCES `notification_entity_type`(`entity_type_id`),
 CONSTRAINT `fk_entity` FOREIGN KEY (`entity_id`) REFERENCES `notification_entity`(`entity_id`),
 PRIMARY KEY (`id`));

CREATE TABLE IF NOT EXISTS `notification` (
 `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
 `notification_object_id` INT UNSIGNED NOT NULL,
 `notifier_id` INT UNSIGNED NOT NULL,
 `status` TINYINT NOT NULL,
 `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`id`),
 CONSTRAINT `fk_notification_object` FOREIGN KEY (`notification_object_id`) REFERENCES `notification_object` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
 CONSTRAINT `fk_notification_notifier_id` FOREIGN KEY (`notifier_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS `notification_change` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `notification_object_id` INT UNSIGNED NOT NULL,
  `actor_id` INT UNSIGNED NOT NULL,
  `status` TINYINT NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_notification_object_2` FOREIGN KEY (`notification_object_id`) REFERENCES `notification_object` (`id`) ,
  CONSTRAINT `fk_notification_actor_id_idx` FOREIGN KEY (`actor_id`) REFERENCES `user` (`id`));

INSERT INTO `user` (`user_name`, `dob`, `role`) VALUES ('John Doe', '1990-05-15', 1);
INSERT INTO `user` (`user_name`, `dob`, `role`) VALUES ('Jane Smith', '1988-10-20', 2);
INSERT INTO `user` (`user_name`, `dob`, `role`) VALUES ('Michael Johnson', '1995-03-28', 1);
INSERT INTO `user` (`user_name`, `dob`, `role`) VALUES ('Emily Brown', '1992-07-12', 3);
INSERT INTO `user` (`user_name`, `dob`, `role`) VALUES ('William Davis', '1985-12-30', 2);

INSERT INTO `notification_entity` (`entity_name`) VALUES ('comment');
INSERT INTO `notification_entity` (`entity_name`) VALUES ('post');
INSERT INTO `notification_entity` (`entity_name`) VALUES ('livestream');

INSERT INTO `notification_entity_type` (`type_name`, `entity_id`, `description`)
VALUES 
('new comment', (SELECT `entity_id` FROM `notification_entity` WHERE `entity_name`='comment'), 'Có bình luận mới'),
('reply comment', (SELECT `entity_id` FROM `notification_entity` WHERE `entity_name`='comment'), 'Có người phản hồi'),
('react comment', (SELECT `entity_id` FROM `notification_entity` WHERE `entity_name`='comment'), 'Có người tương tác với bình luận');



CREATE TABLE IF NOT EXISTS `post` (
 `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
 `content` VARCHAR(255) NOT NULL,
 `thumbnail` VARCHAR(255),
 `owner` INT UNSIGNED NOT NULL,
 `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`id`),
 CONSTRAINT `fk_user` FOREIGN KEY (`owner`) REFERENCES `user`(`id`)
);

CREATE TABLE IF NOT EXISTS `comment` (
 `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
 `post_id` INT NOT NULL,
 `content` VARCHAR(255) NOT NULL,
 `parentComment` INT UNSIGNED,
 `level` INT, 
 `owner` INT UNSIGNED NOT NULL,
 `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
 `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 PRIMARY KEY (`id`),
 CONSTRAINT `fk_post_comment` FOREIGN KEY (`post_id`) REFERENCES `post` (`id`),
 CONSTRAINT `fk_user_2` FOREIGN KEY (`owner`) REFERENCES `user` (`id`),
 CONSTRAINT `fk_parent_comment` FOREIGN KEY (`parentComment`) REFERENCES `comment` (`id`)
);


