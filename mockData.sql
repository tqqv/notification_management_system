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

INSERT INTO `post` (`content`, `thumbnail`, `owner`) VALUES 
('Nội dung bài viết 1', 'thumb1.jpg', 1),
('Nội dung bài viết 2', 'thumb2.jpg', 2),
('Nội dung bài viết 3', 'thumb3.jpg', 3),
('Nội dung bài viết 4', 'thumb4.jpg', 4),
('Nội dung bài viết 5', 'thumb5.jpg', 5);


INSERT INTO `comment` (`post_id`, `content`, `owner`) VALUES 
(1, 'Nội dung comment từ người dùng 2', 2),
(1, 'Nội dung comment từ người dùng 3', 3);
