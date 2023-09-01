CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`customers` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NOT NULL,
  `lastNames` VARCHAR(100) NOT NULL,
  `address` VARCHAR(200) NOT NULL,
  `phone` INT NOT NULL,
  PRIMARY KEY (`idCustomer`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`orders` (
  `idOrder` INT NOT NULL AUTO_INCREMENT,
  `dateHour` DATETIME NOT NULL,
  `homeDelivery` TINYINT(1) NOT NULL,
  products VARCHAR(100),
  `totalPrice` DECIMAL(10,2) NOT NULL,
  `customer_id` INT NOT NULL,
  `selected_products` INT,
  `product_quantity` INT,
  `employee_id` INT,
  PRIMARY KEY (`idOrder`),
 -- INDEX `costumer_id_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `costumer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Pizzeria`.`customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Pizzeria`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(150) NOT NULL,
  `img` BLOB NULL,
  `price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Pizzeria`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`categories` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`shops`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`shops` (
  `idShop` INT NOT NULL AUTO_INCREMENT,
  `adress` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idShop`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`employees` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(100) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `phone` INT(9) NOT NULL,
  `typeWorker` ENUM('cuiner', 'repartidor') NOT NULL,
  `shop_id` INT NOT NULL,
  PRIMARY KEY (`idEmployee`),
 -- INDEX `shop_id_idx` (`shop_id` ASC) VISIBLE,
  CONSTRAINT `shop_id`
    FOREIGN KEY (`shop_id`)
    REFERENCES `Pizzeria`.`shops` (`idShop`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`deliveries`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`deliveries` (
  `idDelivery` INT NOT NULL AUTO_INCREMENT,
  `delivery_dateTime` DATETIME NOT NULL,
  `order_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`idDelivery`),
 -- INDEX `order_id_idx` (`order_id` ASC) VISIBLE,
 -- INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `order_id`
    FOREIGN KEY (`order_id`)
    REFERENCES `Pizzeria`.`orders` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Pizzeria`.`employees` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`pizzas` (
  `idPizza` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`idPizza`),
 -- INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
 -- INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `Pizzeria`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `Pizzeria`.`categories` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`order_detail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`order_detail` (
  `idOrderDetail` INT NOT NULL AUTO_INCREMENT,
  `order__id` INT NOT NULL,
  `product__id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `employee_id` INT,
  PRIMARY KEY (`idOrderDetail`),
--  INDEX `product__id_idx` (`product__id` ASC) VISIBLE,
-- INDEX `order__id_idx` (`order__id` ASC) VISIBLE,
  CONSTRAINT `product__id`
    FOREIGN KEY (`product__id`)
    REFERENCES `Pizzeria`.`products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `order__id`
    FOREIGN KEY (`order__id`)
    REFERENCES `Pizzeria`.`orders` (`idOrder`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- VALUES PRODUCTS
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Bourbon BBQ', 'Carne, bacon, pollo kebab, mozzarella, salsa barbacoa y deliciosa salsa bourbon bbq por encima.', '25.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Supreme', 'Carne, pepperoni, cebolla roja, pimiento, champiñones y mozzarella.', '25.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Marinera', 'Atún, anchoas, aceitunas negras, mozzarella y salsa de tomate.', '25.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Pollo a la parrilla', 'Pollo a la parrilla, champiñón, maíz, tomate y mozzarella.', '25.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Carbonara', 'Jamón de York, champiñones, cebolla roja, mozzarella y salsa carbonara.', '25.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Cheese Lovers', 'Mezcla de 4 quesos: mozzarella, queso azul, cheddar y emmental acompañados de salsa de tomate.', '25.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Hawaiana', 'Piña, doble de jamón de York, mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Kebab', 'Pollo kebab, cebolla roja, tomate natural, mozzarella, salsa especial y salsa de tomate.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Pepperoni Lovers', 'Doble de pepperoni, mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Americana', 'Pepperoni, bacon, cebolla roja, mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Barbacoa', 'Carne, cebolla roja, bacon, mozzarella y salsa barbacoa.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Queso de cabra', 'Queso de cabra al horno, cebolla caramelizada, mozzarella y salsa cremosa.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Margarita', 'Mozzarella y salsa de tomate.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Veggie Lovers', 'Cebolla roja, maíz, pimiento, champiñón, tomate y mozzarella.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza 4 Quesos Sin Gluten', 'Mezcla de queso mozzarella, queso azul, cheddar y emmental.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Barbacoa Sin Gluten', 'Pollo, bacon y nuestra irresistible salsa barbacoa.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Pizza Jamón-Bacon Sin Gluten', 'Jamón y bacon.', '24.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Hamb num1', 'Descriptinon 1', '5.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Hamb num2', 'Description 2', '6.50');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Hamb num3', 'Description 3', '6');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Hamb num4', 'Description 4', '5.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Hamb num5', 'Description 5', '7.90');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Drink water', 'Drink 1', '1.50');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Drink coke-cola', 'Drink 2', '2.50');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Drink fanta naranja', 'Drink 3', '2.50');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Drink cerveza', 'Drink 4', '3');
INSERT INTO `pizzeria`.`products` (`name`, `description`, `price`) VALUES ('Drink fanta limón', 'Drink 5', '2.50');

-- VALUES CATEGORIES
INSERT INTO `pizzeria`.`categories` (`name`) VALUES ('PREMIUM');
INSERT INTO `pizzeria`.`categories` (`name`) VALUES ('GREATEST HITS');
INSERT INTO `pizzeria`.`categories` (`name`) VALUES ('SIN GLUTEN');

-- VALUES PIZZAS
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('1', '1');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('2', '1');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('3', '1');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('4', '1');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('5', '1');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('6', '1');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('7', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('8', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('9', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('10', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('11', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('12', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('13', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('14', '2');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('15', '3');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('16', '3');
INSERT INTO `pizzeria`.`pizzas` (`product_id`, `category_id`) VALUES ('17', '3');

-- VALUES CUSTOMERS
INSERT INTO `pizzeria`.`customers` (`name`, `lastNames`, `address`, `phone`) VALUES ('Customer1', 'LastName1', 'C/Sant Feliu nº5 pis 3 porta B, Sabadell, 08333  Espanya', '888787487');
INSERT INTO `pizzeria`.`customers` (`name`, `lastNames`, `address`, `phone`) VALUES ('Customer2', 'LastName2', 'C/Santa Maria nº50 CASA , Terrassa, 08888  Espanya', '615874582');
INSERT INTO `pizzeria`.`customers` (`name`, `lastNames`, `address`, `phone`) VALUES ('Customer3', 'LastName3', 'Pl.del Coll  nº27 pis 3 porta 4, Barcelona, 08444  Espanya', '935874587');
INSERT INTO `pizzeria`.`customers` (`name`, `lastNames`, `address`, `phone`) VALUES ('Customer4', 'LastName4', 'C/del Mar nº1 pis 1 , Badalona, 08222  Espanya', '987452136');
INSERT INTO `pizzeria`.`customers` (`name`, `lastNames`, `address`, `phone`) VALUES ('Customer5', 'LastName5', 'C/Sant Martí nº 11 pis 1, Sant Cugat del Vallès, 08172 Espanya','875921457');

-- VALUES SHOPS
INSERT INTO `pizzeria`.`shops` (`adress`) VALUES ('C/ xxxxx nºxx, Sabadell, C.P. 08333, Província: Barcelona');
INSERT INTO `pizzeria`.`shops` (`adress`) VALUES ('C/ xxxxx nºxx, Terrassa, C.P. 08888,  Província: Barcelona');
INSERT INTO `pizzeria`.`shops` (`adress`) VALUES ('C/ xxxxx nºxx, Barcelona, C.P. 08444,  Província: Barcelona');
INSERT INTO `pizzeria`.`shops` (`adress`) VALUES ('C/ xxxxx nºxx, Badalona, C.P. 08222,  Província: Barcelona');
INSERT INTO `pizzeria`.`shops` (`adress`) VALUES ('C/ xxxxx nºxx, Sant Cugat del Vallès, C.P. 08172,  Província: Barcelona');

-- VALUES EMPLOYEES
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 1', 'LastName1', '87452158O', '658789632', 'cuiner', '5');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 2', 'LastName2', '25487021E', '652154879', 'repartidor', '1');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 3', 'LastName3', '85974123T', '651248796', 'repartidor', '2');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 4', 'LastName4', '25488898F', '606985444', 'repartidor', '3');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 5', 'LastName5', '25879632Y', '658774455', 'cuiner', '4');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 6', 'LastName6', '21453752T', '696325874', 'repartidor', '4');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 7', 'LastName7', '87596778R', '687521364', 'cuiner', '3');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 8', 'LastName8', '14721212E', '607895222', 'repartidor', '5');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 9', 'LastName9', '12547869S', '618518877', 'cuiner', '2');
INSERT INTO `pizzeria`.`employees` (`name`, `lastName`, `nif`, `phone`, `typeWorker`, `shop_id`) VALUES ('Employee 10', 'LastName10', '52875987Z', '626879852', 'cuiner', '1');

-- VALUES ORDERS
INSERT INTO `pizzeria`.`orders` (`dateHour`, `homeDelivery`, `customer_id`, `employee_id`) VALUES ('2005-01-25', '1', '1', '3');
INSERT INTO `pizzeria`.`orders` (`dateHour`, `homeDelivery`, `customer_id`) VALUES ('2005-02-26 16:30:15', '0', '2');
INSERT INTO `pizzeria`.`orders` (`dateHour`, `homeDelivery`, `customer_id`, `employee_id`) VALUES ('2005-02-27', '1', '3', '4');
INSERT INTO `pizzeria`.`orders` (`dateHour`, `homeDelivery`, `customer_id`, `employee_id`) VALUES ('2005-02-27', '1', '3', '4');
UPDATE `pizzeria`.`orders` SET `employee_id` = '4' WHERE (`idOrder` = '5');
UPDATE `pizzeria`.`orders` SET `employee_id` = '4' WHERE (`idOrder` = '4');
UPDATE `pizzeria`.`orders` SET `employee_id` = '3' WHERE (`idOrder` = '2');
UPDATE `pizzeria`.`orders` SET `employee_id` = '2' WHERE (`idOrder` = '3');


-- VALUES ORDER_DETAIL
INSERT INTO `pizzeria`.`order_detail` (`idOrderDetail`, `order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('', '2', '15', '2', '4');
INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('3', '23', '1', '4');
INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('4', '19', '1', '4');
INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('4', '24', '1', '4');
INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('5', '24', '1', '4');
INSERT INTO `pizzeria`.`order_detail` (`order__id`, `product__id`, `quantity`, `employee_id`) VALUES ('5', '25', '1', '4');



-- TRIGGER solo muestra nombre un producto y cantidad total de diferentes productos

DELIMITER //
CREATE TRIGGER update_total_price_and_products
AFTER INSERT ON `Pizzeria`.`order_detail`
FOR EACH ROW
BEGIN
  DECLARE total_price DECIMAL(10, 2);
  DECLARE selected_products VARCHAR(255);
  DECLARE product_quantity INT;
  DECLARE employee_id INT;

  SELECT SUM(products.`price` * NEW.`quantity`) INTO total_price
  FROM `Pizzeria`.`products`
  WHERE products.`idProduct` = NEW.`product__id`;

  SELECT GROUP_CONCAT(products.`name`) INTO selected_products
  FROM `Pizzeria`.`products`
  WHERE products.`idProduct` = NEW.`product__id`;

  SELECT SUM(`quantity`) INTO product_quantity
  FROM `Pizzeria`.`order_detail`
  WHERE `order__id` = NEW.`order__id`;
  
  SELECT `employee_id` INTO employee_id
  FROM `Pizzeria`.`orders`
  WHERE `idOrder` = NEW.`order__id`;

  INSERT INTO `Pizzeria`.`orders` (`idOrder`, `totalPrice`, `selected_products`, `product_quantity`, `employee_id`)
  VALUES (NEW.`order__id`, total_price, selected_products, product_quantity, employee_id)
  ON DUPLICATE KEY UPDATE
    `totalPrice` = total_price,
    `selected_products` = selected_products,
    `product_quantity` = product_quantity,
    `employee_id` = employee_id;
END;
//
DELIMITER ;

-- DELETE TRIGGER
  -- DROP TRIGGER IF EXISTS update_total_price_and_products;

-- QUERIES X VERIFICAR DADES
SELECT COUNT(od.quantity) AS cantidad_bebidas_vendidas
FROM order_detail od
INNER JOIN orders o ON od.order__id = o.idOrder
INNER JOIN products p ON od.product__id = p.idProduct
INNER JOIN customers c ON o.customer_id = c.idCustomer
WHERE p.name LIKE('Drink%') AND c.address LIKE '%Barcelona%';

SELECT COUNT(*) AS cantidad_comandas_efectuadas
FROM orders
WHERE employee_id = 4;