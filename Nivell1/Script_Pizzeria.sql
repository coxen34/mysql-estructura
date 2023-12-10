
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`customers` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `last_names` VARCHAR(100) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  `phone` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Pizzeria`.`shops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`shops` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(200) NOT NULL,
  `town` VARCHAR(100) NOT NULL,
  `zip_code` VARCHAR(20) NOT NULL,
  `province` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `Pizzeria`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_hour` DATETIME NOT NULL,
  `home_delivery` TINYINT(1) NOT NULL,
 -- `product_name` VARCHAR(100),
  `total_price` DECIMAL(10,2) NOT NULL DEFAULT '0.00',
  `customer_id` INT NOT NULL,
  `selected_products` VARCHAR(200),
  `product_quantity` INT,
  `employee_id` INT,
  `shop_id` INT NOT NULL, 
  PRIMARY KEY (`id`),
  CONSTRAINT `shop_id`
    FOREIGN KEY (`shop_id`)
    REFERENCES `Pizzeria`.`shops` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Pizzeria`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Pizzeria`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type`ENUM('pizza','drink','hamburguer'),
  `description` VARCHAR(150) NOT NULL,
  `img` BLOB NULL,
  `price` DECIMAL(4,2) NOT NULL,
  `category_id` INT ,
  PRIMARY KEY (`id`),
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `Pizzeria`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(100) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `phone` INT(9) NOT NULL,
  `type_worker` ENUM('cuiner', 'repartidor') NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `shop_id_employees`
    FOREIGN KEY (`shop_id`)
    REFERENCES `Pizzeria`.`shops` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`deliveries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `delivery_date_time` DATETIME NOT NULL,
  `order_id` INT,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`),
 -- INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
 -- INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `Pizzeria`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    CONSTRAINT `employee_id_deliveries`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Pizzeria`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`order_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order__id` INT NOT NULL,
  `product__id` INT NOT NULL,
  `quantity` INT NOT NULL,
  -- `employee_id` INT,
  PRIMARY KEY (`id`),
--  INDEX `product__id_idx` (`product__id` ASC) VISIBLE,
-- INDEX `order__id_idx` (`order__id` ASC) VISIBLE,
  CONSTRAINT `product__id`
    FOREIGN KEY (`product__id`)
    REFERENCES `Pizzeria`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order__id`
    FOREIGN KEY (`order__id`)
    REFERENCES `Pizzeria`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- VALUES CATEGORIES
INSERT INTO `pizzeria`.`categories` (`name`) VALUES ('PREMIUM');
INSERT INTO `pizzeria`.`categories` (`name`) VALUES ('GREATEST HITS');
INSERT INTO `pizzeria`.`categories` (`name`) VALUES ('SIN GLUTEN');
-- VALUES PRODUCTS
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Bourbon BBQ','pizza', 'Carne, bacon, pollo kebab, mozzarella, salsa barbacoa y deliciosa salsa bourbon bbq por encima.', '25.90','1');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Supreme','pizza', 'Carne, pepperoni, cebolla roja, pimiento, champiñones y mozzarella.', '25.90','1');
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('Marinera','pizza', 'Atún, anchoas, aceitunas negras, mozzarella y salsa de tomate.', '25.90','1');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Pollo a la parrilla','pizza', 'Pollo a la parrilla, champiñón, maíz, tomate y mozzarella.', '25.90','1');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Carbonara','pizza', 'Jamón de York, champiñones, cebolla roja, mozzarella y salsa carbonara.', '25.90','1');
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('Cheese Lovers','pizza', 'Mezcla de 4 quesos: mozzarella, queso azul, cheddar y emmental acompañados de salsa de tomate.', '25.90','1');
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('Hawaiana', 'pizza','Piña, doble de jamón de York, mozzarella y salsa de tomate.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Kebab','pizza', 'Pollo kebab, cebolla roja, tomate natural, mozzarella, salsa especial y salsa de tomate.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Pepperoni Lovers', 'pizza','Doble de pepperoni, mozzarella y salsa de tomate.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Americana', 'pizza','Pepperoni, bacon, cebolla roja, mozzarella y salsa de tomate.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Barbacoa', 'pizza','Carne, cebolla roja, bacon, mozzarella y salsa barbacoa.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Queso de cabra','pizza', 'Queso de cabra al horno, cebolla caramelizada, mozzarella y salsa cremosa.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Margarita', 'pizza','Mozzarella y salsa de tomate.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Veggie Lovers', 'pizza','Cebolla roja, maíz, pimiento, champiñón, tomate y mozzarella.', '24.90','2');
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('4 Quesos Sin Gluten','pizza', 'Mezcla de queso mozzarella, queso azul, cheddar y emmental.', '24.90','3');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Barbacoa Sin Gluten', 'pizza','Pollo, bacon y nuestra irresistible salsa barbacoa.', '24.90','3');
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('Jamón-Bacon Sin Gluten', 'pizza','Jamón y bacon.', '24.90','3');
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('num1', 'hamburguer','Descriptinon 1', '5.90',NULL);
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('num2','hamburguer', 'Description 2', '6.50',NULL);
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('num3','hamburguer', 'Description 3', '6',NULL);
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('num4', 'hamburguer','Description 4', '5.90',NULL);
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('num5','hamburguer', 'Description 5', '7.90',NULL);
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('water','drink', 'Drink 1', '1.50',NULL);
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('coke-cola', 'drink','Drink 2', '2.50',NULL);
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('fanta naranja', 'drink','Drink 3', '2.50',NULL);
INSERT INTO `pizzeria`.`products` (`name`,`type`, `description`, `price`,`category_id`) VALUES ('cerveza','drink', 'Drink 4', '3',NULL);
INSERT INTO `pizzeria`.`products` (`name`, `type`,`description`, `price`,`category_id`) VALUES ('fanta limón','drink', 'Drink 5', '2.50',NULL);


-- VALUES CUSTOMERS
INSERT INTO `pizzeria`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer1', 'LastName1', 'C/Sant Feliu nº5 pis 3 porta B, Sabadell, 08333  Espanya', '888787487');
INSERT INTO `pizzeria`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer2', 'LastName2', 'C/Santa Maria nº50 CASA , Terrassa, 08888  Espanya', '615874582');
INSERT INTO `pizzeria`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer3', 'LastName3', 'Pl.del Coll  nº27 pis 3 porta 4, Barcelona, 08444  Espanya', '935874587');
INSERT INTO `pizzeria`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer4', 'LastName4', 'C/del Mar nº1 pis 1 , Badalona, 08222  Espanya', '987452136');
INSERT INTO `pizzeria`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer5', 'LastName5', 'C/Sant Martí nº 11 pis 1, Sant Cugat del Vallès, 08172 Espanya','875921457');

-- VALUES SHOPS
INSERT INTO `pizzeria`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Sabadell', ' 08333', 'Barcelona');
INSERT INTO `pizzeria`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Terrassa', ' 08888',   'Barcelona');
INSERT INTO `pizzeria`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Barcelona',  '08444',  'Barcelona');
INSERT INTO `pizzeria`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx',' Badalona', '08222',  'Barcelona');
INSERT INTO `pizzeria`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Sant Cugat del Vallès', '08172',  'Barcelona');

-- VALUES EMPLOYEES
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 1', 'LastName1', '87452158O', '658789632', 'cuiner', '5');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 2', 'LastName2', '25487021E', '652154879', 'repartidor', '1');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 3', 'LastName3', '85974123T', '651248796', 'repartidor', '2');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 4', 'LastName4', '25488898F', '606985444', 'repartidor', '3');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 5', 'LastName5', '25879632Y', '658774455', 'cuiner', '4');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 6', 'LastName6', '21453752T', '696325874', 'repartidor', '4');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 7', 'LastName7', '87596778R', '687521364', 'cuiner', '3');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 8', 'LastName8', '14721212E', '607895222', 'repartidor', '5');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 9', 'LastName9', '12547869S', '618518877', 'cuiner', '2');
INSERT INTO `pizzeria`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 10', 'LastName10', '52875987Z', '626879852', 'cuiner', '1');

-- VALUES ORDERS
INSERT INTO `pizzeria`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `employee_id`, `shop_id`) VALUES ('2005-01-25', '1', '1', '3','2');
INSERT INTO `pizzeria`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `shop_id`) VALUES ('2005-02-26 16:30:15', '0', '2','1');
INSERT INTO `pizzeria`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `employee_id`, `shop_id`) VALUES ('2005-02-27', '1', '3', '4','3');
INSERT INTO `pizzeria`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `employee_id`, `shop_id`) VALUES ('2005-02-27', '1', '3', '4','3');
UPDATE `pizzeria`.`orders` SET `employee_id` = '4' WHERE (`id` = '5');
UPDATE `pizzeria`.`orders` SET `employee_id` = '4' WHERE (`id` = '4');
UPDATE `pizzeria`.`orders` SET `employee_id` = '3' WHERE (`id` = '2');
UPDATE `pizzeria`.`orders` SET `employee_id` = '2' WHERE (`id` = '3');



DELIMITER //
CREATE TRIGGER update_total_price_and_products
AFTER INSERT ON `Pizzeria`.`order_detail`
FOR EACH ROW
BEGIN
  DECLARE total_price DECIMAL(10, 2);
  DECLARE product_quantity INT;
  DECLARE selected_products VARCHAR(255);

  SELECT SUM(products.`price` * order_detail.`quantity`) INTO total_price
  FROM `Pizzeria`.`products`, `Pizzeria`.`order_detail`
  WHERE products.`id` = order_detail.`product__id` AND order_detail.`order__id` = NEW.`order__id`;

  SELECT GROUP_CONCAT(products.`name`) INTO selected_products
  FROM `Pizzeria`.`products`, `Pizzeria`.`order_detail`
  WHERE products.`id` = order_detail.`product__id` AND order_detail.`order__id` = NEW.`order__id`;

  SELECT SUM(`quantity`) INTO product_quantity
  FROM `Pizzeria`.`order_detail`
  WHERE `order__id` = NEW.`order__id`;

  UPDATE `Pizzeria`.`orders`
  SET `total_price` = total_price,
      `product_quantity` = product_quantity,
      `selected_products` = selected_products
  WHERE `id` = NEW.`order__id`;
END;
//
DELIMITER ;

-- DELETE TRIGGER
  -- DROP TRIGGER IF EXISTS update_total_price_and_products;


