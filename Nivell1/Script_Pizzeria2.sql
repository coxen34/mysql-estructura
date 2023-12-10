
CREATE SCHEMA IF NOT EXISTS `Pizzeria2` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria2` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`customers` (
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
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`shops` (
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
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_hour` DATETIME NOT NULL,
  `home_delivery` TINYINT(1) NOT NULL,
  `products` VARCHAR(100),
  `total_price` DECIMAL(10,2) NOT NULL,
  `customer_id` INT NOT NULL,
  `selected_products` INT,
  `product_quantity` INT,
  `employee_id` INT,
  `shop_id` INT NOT NULL, 
  PRIMARY KEY (`id`),
  CONSTRAINT `shop_id`
    FOREIGN KEY (`shop_id`)
    REFERENCES `Pizzeria2`.`shops` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Pizzeria2`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `type`ENUM('pizza','drink','hamburguer'),
  `description` VARCHAR(150) NOT NULL,
  `img` BLOB NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Pizzeria`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;





-- -----------------------------------------------------
-- Table `Pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`employees` (
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
    REFERENCES `Pizzeria2`.`shops` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`deliveries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `delivery_date_time` DATETIME NOT NULL,
  `order_id` INT,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`),
 -- INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
 -- INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `Pizzeria2`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`pizzas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`id`),
 -- INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
 -- INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `Pizzeria2`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `Pizzeria2`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria2`.`order_detail` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order__id` INT NOT NULL,
  `product__id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `employee_id` INT,
  PRIMARY KEY (`id`),
--  INDEX `product__id_idx` (`product__id` ASC) VISIBLE,
-- INDEX `order__id_idx` (`order__id` ASC) VISIBLE,
  CONSTRAINT `product__id`
    FOREIGN KEY (`product__id`)
    REFERENCES `Pizzeria2`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order__id`
    FOREIGN KEY (`order__id`)
    REFERENCES `Pizzeria2`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- VALUES PRODUCTS
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Bourbon BBQ','pizza', 'Carne, bacon, pollo kebab, mozzarella, salsa barbacoa y deliciosa salsa bourbon bbq por encima.', '25.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Supreme','pizza', 'Carne, pepperoni, cebolla roja, pimiento, champiñones y mozzarella.', '25.90');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('Marinera','pizza', 'Atún, anchoas, aceitunas negras, mozzarella y salsa de tomate.', '25.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Pollo a la parrilla','pizza', 'Pollo a la parrilla, champiñón, maíz, tomate y mozzarella.', '25.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Carbonara','pizza', 'Jamón de York, champiñones, cebolla roja, mozzarella y salsa carbonara.', '25.90');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('Cheese Lovers','pizza', 'Mezcla de 4 quesos: mozzarella, queso azul, cheddar y emmental acompañados de salsa de tomate.', '25.90');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('Hawaiana', 'pizza','Piña, doble de jamón de York, mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Kebab','pizza', 'Pollo kebab, cebolla roja, tomate natural, mozzarella, salsa especial y salsa de tomate.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Pepperoni Lovers', 'pizza','Doble de pepperoni, mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Americana', 'pizza','Pepperoni, bacon, cebolla roja, mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Barbacoa', 'pizza','Carne, cebolla roja, bacon, mozzarella y salsa barbacoa.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Queso de cabra','pizza', 'Queso de cabra al horno, cebolla caramelizada, mozzarella y salsa cremosa.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Margarita', 'pizza','Mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Veggie Lovers', 'pizza','Cebolla roja, maíz, pimiento, champiñón, tomate y mozzarella.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('4 Quesos Sin Gluten','pizza', 'Mezcla de queso mozzarella, queso azul, cheddar y emmental.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Barbacoa Sin Gluten', 'pizza','Pollo, bacon y nuestra irresistible salsa barbacoa.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('Jamón-Bacon Sin Gluten', 'pizza','Jamón y bacon.', '24.90');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('num1', 'hamburguer','Descriptinon 1', '5.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('num2','hamburguer', 'Description 2', '6.50');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('num3','hamburguer', 'Description 3', '6');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('num4', 'hamburguer','Description 4', '5.90');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('num5','hamburguer', 'Description 5', '7.90');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('water','drink', 'Drink 1', '1.50');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('coke-cola', 'drink','Drink 2', '2.50');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('fanta naranja', 'drink','Drink 3', '2.50');
INSERT INTO `pizzeria2`.`products` (`name`,`type`, `description`, `price`) VALUES ('cerveza','drink', 'Drink 4', '3');
INSERT INTO `pizzeria2`.`products` (`name`, `type`,`description`, `price`) VALUES ('fanta limón','drink', 'Drink 5', '2.50');

-- VALUES CATEGORIES
INSERT INTO `pizzeria2`.`categories` (`name`) VALUES ('PREMIUM');
INSERT INTO `pizzeria2`.`categories` (`name`) VALUES ('GREATEST HITS');
INSERT INTO `pizzeria2`.`categories` (`name`) VALUES ('SIN GLUTEN');

-- VALUES PIZZAS
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('1', '1');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('2', '1');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('3', '1');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('4', '1');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('5', '1');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('6', '1');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('7', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('8', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('9', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('10', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('11', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('12', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('13', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('14', '2');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('15', '3');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('16', '3');
INSERT INTO `pizzeria2`.`pizzas` (`product_id`, `category_id`) VALUES ('17', '3');

-- VALUES CUSTOMERS
INSERT INTO `pizzeria2`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer1', 'LastName1', 'C/Sant Feliu nº5 pis 3 porta B, Sabadell, 08333  Espanya', '888787487');
INSERT INTO `pizzeria2`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer2', 'LastName2', 'C/Santa Maria nº50 CASA , Terrassa, 08888  Espanya', '615874582');
INSERT INTO `pizzeria2`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer3', 'LastName3', 'Pl.del Coll  nº27 pis 3 porta 4, Barcelona, 08444  Espanya', '935874587');
INSERT INTO `pizzeria2`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer4', 'LastName4', 'C/del Mar nº1 pis 1 , Badalona, 08222  Espanya', '987452136');
INSERT INTO `pizzeria2`.`customers` (`name`, `last_names`, `address`, `phone`) VALUES ('Customer5', 'LastName5', 'C/Sant Martí nº 11 pis 1, Sant Cugat del Vallès, 08172 Espanya','875921457');

-- VALUES SHOPS
INSERT INTO `pizzeria2`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Sabadell', ' 08333', 'Barcelona');
INSERT INTO `pizzeria2`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Terrassa', ' 08888',   'Barcelona');
INSERT INTO `pizzeria2`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Barcelona',  '08444',  'Barcelona');
INSERT INTO `pizzeria2`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx',' Badalona', '08222',  'Barcelona');
INSERT INTO `pizzeria2`.`shops` (`street`,`town`,`zip_code`,`province`) VALUES ('C/ xxxxx nºxx', 'Sant Cugat del Vallès', '08172',  'Barcelona');

-- VALUES EMPLOYEES
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 1', 'LastName1', '87452158O', '658789632', 'cuiner', '5');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 2', 'LastName2', '25487021E', '652154879', 'repartidor', '1');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 3', 'LastName3', '85974123T', '651248796', 'repartidor', '2');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 4', 'LastName4', '25488898F', '606985444', 'repartidor', '3');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 5', 'LastName5', '25879632Y', '658774455', 'cuiner', '4');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 6', 'LastName6', '21453752T', '696325874', 'repartidor', '4');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 7', 'LastName7', '87596778R', '687521364', 'cuiner', '3');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 8', 'LastName8', '14721212E', '607895222', 'repartidor', '5');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 9', 'LastName9', '12547869S', '618518877', 'cuiner', '2');
INSERT INTO `pizzeria2`.`employees` (`name`, `last_name`, `nif`, `phone`, `type_worker`, `shop_id`) VALUES ('Employee 10', 'LastName10', '52875987Z', '626879852', 'cuiner', '1');

-- VALUES ORDERS
INSERT INTO `pizzeria2`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `employee_id`, `shop_id`) VALUES ('2005-01-25', '1', '1', '3','2');
INSERT INTO `pizzeria2`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `shop_id`) VALUES ('2005-02-26 16:30:15', '0', '2','1');
INSERT INTO `pizzeria2`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `employee_id`, `shop_id`) VALUES ('2005-02-27', '1', '3', '4','3');
INSERT INTO `pizzeria2`.`orders` (`date_hour`, `home_delivery`, `customer_id`, `employee_id`, `shop_id`) VALUES ('2005-02-27', '1', '3', '4','3');
UPDATE `pizzeria2`.`orders` SET `employee_id` = '4' WHERE (`id` = '5');
UPDATE `pizzeria2`.`orders` SET `employee_id` = '4' WHERE (`id` = '4');
UPDATE `pizzeria2`.`orders` SET `employee_id` = '3' WHERE (`id` = '2');
UPDATE `pizzeria2`.`orders` SET `employee_id` = '2' WHERE (`id` = '3');


-- VALUES ORDER_DETAIL
 -- INSERT INTO `pizzeria`.`order_detail` (`idOrderDetail`, `order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('', '2', '15', '2', '4');
 -- INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('3', '23', '1', '4');
 -- INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('4', '19', '1', '4');
 -- INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('4', '24', '1', '4');
 -- INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('1', '24', '1', '4');
 -- INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('1', '25', '1', '4');



-- TRIGGER xArreglar

DELIMITER //
CREATE TRIGGER update_total_price_and_products
AFTER INSERT ON `Pizzeria2`.`order_detail`
FOR EACH ROW
BEGIN
  DECLARE total_price DECIMAL(10, 2);
  DECLARE selected_products VARCHAR(255);
  DECLARE product_quantity INT;
  DECLARE employee_id INT;

  SELECT SUM(products.`price` * NEW.`quantity`) INTO total_price
  FROM `Pizzeria2`.`products`
  WHERE products.`id` = NEW.`product__id`;

  SELECT GROUP_CONCAT(products.`name`) INTO selected_products
  FROM `Pizzeria2`.`products`
  WHERE products.`id` = NEW.`product__id`;

  SELECT SUM(`quantity`) INTO product_quantity
  FROM `Pizzeria2`.`order_detail`
  WHERE `order__id` = NEW.`order__id`;
  
  SELECT `employee_id` INTO employee_id
  FROM `Pizzeria2`.`orders`
  WHERE `id` = NEW.`order__id`;

  INSERT INTO `Pizzeria2`.`orders` (`id`, `total_price`, `selected_products`, `product_quantity`, `employee_id`)
  VALUES (NEW.`order__id`, total_price, selected_products, product_quantity, employee_id)
  ON DUPLICATE KEY UPDATE
    `total_price` = total_price,
    `selected_products` = selected_products,
    `product_quantity` = product_quantity,
    `employee_id` = employee_id;
END;
//
DELIMITER ;

-- DELETE TRIGGER
  -- DROP TRIGGER IF EXISTS update_total_price_and_products;


