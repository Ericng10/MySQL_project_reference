SET SQL_SAFE_UPDATES=0;
-- query the information of computer
SELECT *
FROM `Product`
WHERE `type`='computer';

-- query the total quantity of products from store with store_id 8 in the shopping cart
SELECT SUM(`quantity`) AS `totalQuantity`
FROM `Save_to_Shopping_Cart`
WHERE `Save_to_Shopping_Cart`.`product_id` IN (SELECT `Product`.`product_id` FROM `Product` WHERE `Store_id`=8);

-- query the name and address of orders delivered on 2023-05-20
SELECT `name`, `streetaddr`, `city`
FROM `Address`
WHERE `address_id` IN (SELECT `addrid` FROM `Deliver_To` WHERE `TimeDelivered` = '2023-05-20');

-- query the comments of product_id 42133 
 SELECT *
 FROM `Comments`
 WHERE  `product_id` = 42133; 
 
 -- Insert the user id of sellers whose name starts with E and ends with c into buyer
INSERT INTO `buyer`
SELECT * FROM `seller`
WHERE `user_id` IN (SELECT `user_id` FROM `Users` WHERE name LIKE 'E%c');


-- Update the payment state of orders to Processing which created after year '2023-05-20' and with total amount greater than 20.
UPDATE `Orders`
SET `paymentState` = 'Processing'
WHERE `creationTime` > '2023-05-20' AND `totalAmount` > 20;

-- Update the name and contact phone number of address where user_id=3.
UPDATE `Address`
SET `name` = 'ERIC', `contactPhoneNumber` = 51182034
WHERE `user_id` = 3;

-- Delete the store which opened before year 2023
DELETE FROM  `Save_to_Shopping_Cart`
WHERE `addTime` < '2023-01-01';

-- Create view of all products whose price above average price.
CREATE VIEW `Products_Above_Average_Price` AS
SELECT `product_id`, `name`, `price` 
FROM `Product`
WHERE `price` > (SELECT AVG(`price`) FROM `Product`);
select * from`Products_Above_Average_Price`;

-- Update the view
UPDATE Products_Above_Average_Price
SET price = 1
WHERE name = 'camera';

-- Create view of all products sales in 2022.
CREATE VIEW `Product_Sales_For_2022` AS
SELECT `product_id`, `name`, `price`
FROM `Product`
WHERE `product_id` IN (SELECT `product_id` FROM `OrderItem` WHERE `itemid` IN 
              (SELECT `itemid` FROM `Contain` WHERE `orderNumber` IN
               (SELECT `orderNumber` FROM `Payment` WHERE `payTime` > '2022-01-01' AND` payTime` < '2022-12-31')
              )
             );

SELECT * FROM `Product_Sales_For_2022`;

-- Check whether the products saved to the shopping cart is it conform our constraints quantity smaller than 10 or addTime is after '2023-01-01').
DROP TABLE `Save_to_Shopping_Cart`;
CREATE TABLE `Save_to_Shopping_Cart`(
    `user_id` INT NOT NULL PRIMARY KEY ,
    `product_id` INT NOT NULL PRIMARY KEY,
    `addTime` DATE,
    `quantity` INT,
    FOREIGN KEY(`user_id`) REFERENCES `Buyer`(`user_id`),
    FOREIGN KEY(`product_id`) REFERENCES Product(`product_id`),
    CHECK (quantity <= 10 OR addTime > '2023-01-01')
    );
INSERT INTO Save_to_Shopping_Cart VALUES(3,729,'2023-05-21',9);
INSERT INTO Save_to_Shopping_Cart VALUES(2,412,'2023-02-29',8);
INSERT INTO Save_to_Shopping_Cart VALUES(5,800,'2022-12-31',11); -- error
    