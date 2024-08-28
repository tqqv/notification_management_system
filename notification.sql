CREATE DATABASE IF NOT EXISTS `notification_management_system`;
USE `notification_management_system`;


CREATE TABLE `notifications`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `entity_type` INT UNSIGNED NOT NULL,
    `actor_id` INT UNSIGNED NOT NULL,
    `url` VARCHAR(255) NOT NULL,
    `room_id` INT NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP());
CREATE TABLE `users`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_name` VARCHAR(255) NOT NULL,
    `dob` DATE NOT NULL,
    `role` INT NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP());
CREATE TABLE `notification_visits`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `notifier_id` INT UNSIGNED NOT NULL,
    `notification_id` INT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP NOT NULL,
    `updated_at` TIMESTAMP NOT NULL
);
CREATE TABLE `posts`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `content` VARCHAR(255) NOT NULL,
    `thumbnail` VARCHAR(255) NULL,
    `owner_id` INT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP());
CREATE TABLE `notification_entity_types`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `type_name` VARCHAR(255) NOT NULL,
    `entity_id` INT UNSIGNED NOT NULL,
    `description` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP());
CREATE TABLE `notification_entities`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `entity_name` VARCHAR(255) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP());
CREATE TABLE `notification_room_settings`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `notifier_id` INT UNSIGNED NOT NULL,
    `room_id` INT NOT NULL,
    `is_on` BOOLEAN NOT NULL DEFAULT '1',
    `entity_id` INT UNSIGNED NOT NULL,
    `is_owner` BOOLEAN NOT NULL DEFAULT '0'
);
CREATE TABLE `comments`(
    `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `post_id` INT UNSIGNED NOT NULL,
    `content` VARCHAR(255) NOT NULL,
    `parent_comment` INT UNSIGNED NULL,
    `level` INT NULL,
    `owner_id` INT UNSIGNED NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(), `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP());
    
    ALTER TABLE
    `notification_entity_types` ADD CONSTRAINT `notification_entity_types_entity_id_foreign` FOREIGN KEY(`entity_id`) REFERENCES `notification_entities`(`id`);
    ALTER TABLE
    `comments` ADD CONSTRAINT `comments_parent_comment_foreign` FOREIGN KEY(`parent_comment`) REFERENCES `comments`(`id`);
	ALTER TABLE
    `comments` ADD CONSTRAINT `comments_owner_id_foreign` FOREIGN KEY(`owner_id`) REFERENCES `users`(`id`);
    ALTER TABLE
    `posts` ADD CONSTRAINT `posts_owner_id_foreign` FOREIGN KEY(`owner_id`) REFERENCES `users`(`id`);
	ALTER TABLE
    `notifications` ADD CONSTRAINT `notifications_entity_type_foreign` FOREIGN KEY(`entity_type`) REFERENCES `notification_entity_types`(`id`);
    ALTER TABLE
    `notifications` ADD CONSTRAINT `notifications_actor_id_foreign` FOREIGN KEY(`actor_id`) REFERENCES `users`(`id`);
    ALTER TABLE
    `notification_visits` ADD CONSTRAINT `notification_visits_notifier_id_foreign` FOREIGN KEY(`notifier_id`) REFERENCES `users`(`id`);
    ALTER TABLE
    `notification_room_settings` ADD CONSTRAINT `notification_room_settings_notifier_id_foreign` FOREIGN KEY(`notifier_id`) REFERENCES `users`(`id`);
    ALTER TABLE
    `comments` ADD CONSTRAINT `comments_post_id_foreign` FOREIGN KEY(`post_id`) REFERENCES `posts`(`id`);
    ALTER TABLE
    `notification_visits` ADD CONSTRAINT `notification_visits_notification_id_foreign` FOREIGN KEY(`notification_id`) REFERENCES `notifications`(`id`);
	ALTER TABLE
    `notification_room_settings` ADD CONSTRAINT `notification_entities_entity_name_foreign` FOREIGN KEY(`entity_id`) REFERENCES `notification_entities`(`id`);
