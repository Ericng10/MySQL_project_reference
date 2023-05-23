CREATE DATABASE `project_reference`;
USE `project_reference`;


CREATE TABLE `Users`( 
	`user_id` INT NOT NULL PRIMARY KEY,
    `phone_id`INT,
	`nick_name` VARCHAR(20)
);

CREATE TABLE `Buyer`(
    `user_id`  INT NOT NULL PRIMARY KEY,
    FOREIGN KEY(`user_id` ) REFERENCES `Users`(`user_id`)
);

CREATE TABLE `Seller`(
    `user_id`  INT NOT NULL PRIMARY KEY,
    FOREIGN KEY(`user_id` ) REFERENCES `Users`(`user_id`)
);

CREATE TABLE `Bank_Card`(
	`cardnumber` INT NOT NULL PRIMARY KEY,
    `transaction_date` DATE,
    `bank_name` VARCHAR(30)
);

CREATE TABLE `Credit_Card`(
	`cardnumber` INT NOT NULL PRIMARY KEY,
    `user_id` INT NOT NULL,
    `Organization` VARCHAR(20),
    FOREIGN KEY (`cardnumber`) REFERENCES `Bank_Card`(`cardnumber`),
	FOREIGN KEY (`user_id`) REFERENCES `Users`(`user_id`)
);

CREATE TABLE `Debit_Card`(
	`cardnumber` INT NOT NULL PRIMARY KEY,
    `user_id` INT NOT NULL,
    FOREIGN KEY (`cardnumber`) REFERENCES `Bank_Card`(`cardnumber`),
	FOREIGN KEY (`user_id`) REFERENCES `Users`(`user_id`)
);

CREATE TABLE `Address`(
    `address_id` INT NOT NULL PRIMARY KEY,
    `user_id` INT NOT NULL,
	`name` VARCHAR(50),
    `Contact_Phone_Number` VARCHAR(20),
    `streetaddr` VARCHAR(100),
    FOREIGN KEY(`user_id`) REFERENCES Users(`user_id`)
);

CREATE TABLE `Store`(
    `Store_id` INT NOT NULL PRIMARY KEY,
    `name`VARCHAR(50),
    `streetaddr` VARCHAR(100),
    `customerGrade` INT,
    `startTime` DATE
);

CREATE TABLE `Brand`(
    `brandName` VARCHAR(20) NOT NULL PRIMARY KEY 
);

CREATE TABLE `Product`(
    `product_id` INT NOT NULL PRIMARY KEY,
    `Store_id` INT NOT NULL,
    `brand` VARCHAR(50) NOT NULL,
    `name` VARCHAR(100),
    `type` VARCHAR(50),
    `modelNumber` VARCHAR(50),
    `colour` VARCHAR(50),
    `amount` INT,
    `price` INT,
    FOREIGN KEY(`Store_id`) REFERENCES `Store`(`Store_id`),
    FOREIGN KEY(`brand`) REFERENCES `Brand`(`brandName`)
);

CREATE TABLE `OrderItem`(
	`itemid` INT NOT NULL PRIMARY KEY,
    `product_id` INT NOT NULL,
    `price` INT,
    `creationTim` DATE,
    FOREIGN KEY(`product_id`) REFERENCES `Product`(`product_id`)
);

CREATE TABLE `Orders`(
    `orderNumber` INT NOT NULL PRIMARY KEY,
    `paymentState` VARCHAR(12),
    `creationTime` DATE,
    `totalAmount` INT
);

CREATE TABLE `Comments`(
    `creationTime` DATE NOT NULL,
    `user_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `grade` FLOAT,
    `content` VARCHAR(500),
    PRIMARY KEY(`creationTime`,`product_id`,`user_id`),
	FOREIGN KEY(`user_id`) REFERENCES `Buyer`(`user_id`),
    FOREIGN KEY(`product_id`) REFERENCES `Product`(`product_id`)
);

CREATE TABLE `ServicePoint`(
    `Service_Point_id`INT NOT NULL PRIMARY KEY,
    `streetaddr` VARCHAR(40),
    `startTime` VARCHAR(20),
    `endTime` VARCHAR(20)
);

CREATE TABLE `Save_to_Shopping_Cart`(
    `user_id` INT NOT NULL PRIMARY KEY ,
    `product_id` INT NOT NULL PRIMARY KEY,
    `addTime` DATE,
    `quantity` INT,
    FOREIGN KEY(`user_id`) REFERENCES `Buyer`(`user_id`),
    FOREIGN KEY(`product_id`) REFERENCES Product(`product_id`)
);

CREATE TABLE `Contain`(
    `orderNumber` INT NOT NULL PRIMARY KEY, 
    `itemid` INT NOT NULL PRIMARY KEY ,
    `quantity` INT,
    FOREIGN KEY(`orderNumber`) REFERENCES `Orders`(`orderNumber`),
    FOREIGN KEY(`itemid`) REFERENCES `OrderItem`(`itemid`)
);

CREATE TABLE `Payment`(
    `orderNumber` INT NOT NULL PRIMARY KEY,
    `creditcardNumber` VARCHAR(25) NOT NULL PRIMARY KEY,
    `payTime` DATE,
    FOREIGN KEY(`orderNumber`) REFERENCES `Orders`(`orderNumber`),
    FOREIGN KEY(`creditcardNumber`) REFERENCES `Credit_Card`(`cardnumber`)
);

CREATE TABLE `Deliver_To`(
    `addrid` INT NOT NULL PRIMARY KEY,
    `orderNumber` INT NOT NULL PRIMARY KEY,
    `TimeDelivered` DATE,
    FOREIGN KEY(`addrid`) REFERENCES `Address`(`address_id`),
    FOREIGN KEY(`orderNumber`) REFERENCES `Orders`(`orderNumber`)
);

