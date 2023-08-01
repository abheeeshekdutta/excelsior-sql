CREATE DATABASE excelsior;

USE excelsior;

CREATE TABLE `customers` (
	`customer_id` bigint NOT NULL AUTO_INCREMENT,
	`customer_name` varchar(50) NOT NULL,
	`customer_email` varchar(100) NOT NULL,
	`customer_phone_no` varchar(14) NOT NULL,
	`customer_city` varchar(20) NOT NULL,
	PRIMARY KEY (`customer_id`)
);

CREATE TABLE `orders` (
	`order_id` bigint NOT NULL AUTO_INCREMENT,
	`customer_id` bigint NOT NULL,
	`product_id` bigint NOT NULL,
	`order_date` DATETIME NOT NULL,
	`order_status` varchar(15) NOT NULL,
	PRIMARY KEY (`order_id`)
);

CREATE TABLE `inventory` (
	`product_id` bigint NOT NULL,
	`quantity_available` BIGINT NOT NULL CHECK (`quantity_available` >= 0), -- Added check constraint,
	PRIMARY KEY (`product_id`)
);

CREATE TABLE `comic_condition` (
    `condition_id` bigint NOT NULL AUTO_INCREMENT,
    `condition_description` varchar(15) NOT NULL,
    `condition_value` DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (`condition_id`)
);


CREATE TABLE `comic_characters` (
	`character_id` bigint NOT NULL,
	`character_name` varchar(255) NOT NULL,
	PRIMARY KEY (`character_id`)
);

CREATE TABLE `writers` (
	`writer_id` bigint NOT NULL,
	`writer_name` varchar(50) NOT NULL,
	`character_id` bigint NOT NULL,
	PRIMARY KEY (`writer_id`)
);

CREATE TABLE `comic_book_details` (
	`product_id` bigint NOT NULL,
	`comic_book_name` varchar(255) NOT NULL,
	`issue_number` int NOT NULL,
	`condition_id` bigint NOT NULL,
	`price` bigint NOT NULL,
	`genre` varchar(25) NOT NULL,
	`publisher` varchar(100) NOT NULL,
	`writer_id` bigint NOT NULL,
	`year` bigint NOT NULL,
	`main_character1_id` bigint NOT NULL,
  `main_character2_id` bigint NOT NULL
);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk0` FOREIGN KEY (`customer_id`) REFERENCES `customers`(`customer_id`);

ALTER TABLE `orders` ADD CONSTRAINT `orders_fk1` FOREIGN KEY (`product_id`) REFERENCES `inventory`(`product_id`);

ALTER TABLE `writers` ADD CONSTRAINT `fk_writer_character_id` 
FOREIGN KEY (`character_id`) REFERENCES `comic_characters`(`character_id`);


ALTER TABLE `comic_book_details` ADD CONSTRAINT `comic_book_details_fk2` FOREIGN KEY (`writer_id`) REFERENCES `writers`(`writer_id`);


ALTER TABLE `comic_book_details` ADD CONSTRAINT `comic_book_details_fk4` FOREIGN KEY (`main_character2_id`) REFERENCES `comic_characters`(`character_id`);


ALTER TABLE `comic_book_details` ADD CONSTRAINT `comic_book_details_fk3` FOREIGN KEY (`main_character1_id`) REFERENCES `comic_characters`(`character_id`);

ALTER TABLE `comic_book_details` ADD CONSTRAINT `comic_book_details_fk0` FOREIGN KEY (`product_id`) REFERENCES `inventory`(`product_id`);

ALTER TABLE `comic_book_details` ADD CONSTRAINT `fk_condition_lkp`
FOREIGN KEY (`condition_id`)REFERENCES `comic_condition`(`condition_id`);

INSERT INTO customers (customer_name, customer_email, customer_phone_no, customer_city)
VALUES 
  ('Sarah Murphy', 'sarah.murphy@gmail.com', '01-555-9876', 'Dublin'),
  ('Cian O\'Connor', 'cian.oconnor@gmail.com', '086-555-4321', 'Cork'),
  ('Aoife Ryan', 'aoife.ryan@gmail.com', '087-123-4567', 'Limerick'),
  ('David Byrne', 'david.byrne@gmail.com', '085-555-2222', 'Galway'),
  ('Ciara Kelly', 'ciara.kelly@gmail.com', '087-555-1111', 'Dublin'),
  ('Mark Walsh', 'mark.walsh@gmail.com', '087-123-7890', 'Belfast'),
  ('Laura Flynn', 'laura.flynn@gmail.com', '086-555-7777', 'Dublin'),
  ('John O\'Sullivan', 'john.osullivan@gmail.com', '087-555-3333', 'Cork'),
  ('Hannah Kelly', 'hannah.kelly@gmail.com', '083-123-4567', 'Galway'),
  ('Brian Murphy', 'brian.murphy@gmail.com', '087-555-4444', 'Limerick');

INSERT INTO `inventory` (`product_id`, `quantity_available`) VALUES
  (1001, 25),
  (1002, 10),
  (1003, 50),
  (1004, 30),
  (1005, 20),
  (1006, 40),
  (1007, 15),
  (1008, 35),
  (1009, 45),
  (1010, 5);
  
  
 INSERT INTO `orders` (`customer_id`, `product_id`, `order_date`, `order_status`) VALUES
  (1, 1001, '2023-05-03 10:00:00', 'pending'),
  (2, 1002, '2023-04-27 11:00:00', 'shipped'),
  (3, 1003, '2023-05-01 12:00:00', 'delivered'),
  (4, 1004, '2023-05-03 13:00:00', 'pending'),
  (5, 1005, '2023-05-03 14:00:00', 'shipped'),
  (6, 1006, '2023-03-15 15:00:00', 'delivered'),
  (7, 1007, '2023-05-03 16:00:00', 'pending'),
  (8, 1008, '2023-05-01 17:00:00', 'shipped'),
  (9, 1009, '2023-05-02 18:00:00', 'delivered'),
  (10, 1010, '2023-05-03 19:00:00', 'pending'),
  (1, 1002, '2023-04-20 20:00:00', 'shipped'),
  (2, 1003, '2023-01-03 21:00:00', 'delivered'),
  (3, 1004, '2023-05-03 22:00:00', 'pending'),
  (4, 1005, '2023-04-17 23:00:00', 'shipped'),
  (5, 1006, '2023-02-04 00:00:00', 'delivered');
  
 INSERT INTO `comic_condition` (condition_id, condition_description, condition_value)
VALUES 
  (1, 'Mint(MT)', 10.0),
  (2, 'Near-Mint(NM)', 9.5),
  (3, 'Very Fine(VF)', 8.0),
  (4, 'Fine(FN)', 6.0),
  (5, 'Very Good(VG)', 4.0),
  (6, 'Good(GD)', 2.2),
  (7, 'Fair(FR)', 1.0),
  (8, 'Poor(PR)', 0.5);

INSERT INTO `comic_characters` (`character_id`, `character_name`) 
VALUES 
(1, 'Batman'),
(2, 'Spider-Man'),
(3, 'Rorschach'),
(4, 'Rick Grimes'),
(5, 'Dream'),
(6, 'Spawn'),
(7, 'Hellboy'),
(8, 'Marv'),
(9, 'Jesse Custer'),
(10, 'Alana'),
(11, 'Art Spiegelman'),
(12, 'Yorick Brown');

INSERT INTO `writers` (`writer_id`, `writer_name`, `character_id`) VALUES
(1, 'John Smith', 1),
(2, 'Jane Doe', 2),
(3, 'Bob Johnson', 3),
(4, 'Sara Lee', 4),
(5, 'Mike Brown', 5),
(6, 'Karen Davis', 6),
(7, 'David Williams', 7),
(8, 'Jessica Kim', 8),
(9, 'Andrew Lee', 9),
(10, 'Emily Chen', 10),
(11, 'Chris Lee', 11),
(12, 'Linda Miller', 12);

INSERT INTO `comic_book_details` 
(`product_id`, `comic_book_name`, `issue_number`, `condition_id`, `price`, `genre`, `publisher`, `writer_id`, `year`, `main_character1_id`,`main_character2_id`) 
VALUES 
(1001, 'Batman: Year One', 1, 1, 2500, 'Superhero', 'DC Comics', 1, 1987, 1,1),
(1002, 'The Amazing Spider-Man', 300, 2, 5000, 'Superhero', 'Marvel Comics', 2, 1988, 2,2),
(1003, 'Watchmen', 1, 3, 10000, 'Superhero', 'DC Comics', 3, 1986, 3,3),
(1004, 'The Walking Dead', 1, 4, 500, 'Horror', 'Image Comics', 4, 2003, 4,4),
(1005, 'Sandman', 1, 1, 3000, 'Fantasy', 'DC Comics', 5, 1989, 5,5),
(1006, 'Spawn', 1, 3, 1000, 'Superhero', 'Image Comics', 6, 1992, 6,6),
(1007, 'Hellboy', 1, 2, 1500, 'Horror', 'Dark Horse Comics', 7, 1993, 7,7),
(1008, 'Sin City', 1, 1, 2000, 'Crime', 'Dark Horse Comics', 8, 1991, 8,8),
(1009, 'Preacher', 1, 4, 800, 'Superhero', 'Vertigo', 9, 1995, 9,9),
(1010, 'Saga', 1, 1, 5000, 'Science Fiction', 'Image Comics', 10, 2012, 10,10),
(1010, 'Maus', 1, 2, 1500, 'Historical', 'Pantheon Books', 11, 1986, 11,11),
(1002, 'Y: The Last Man', 1, 3, 1200, 'Science Fiction', 'Vertigo', 12, 2002, 12,12);