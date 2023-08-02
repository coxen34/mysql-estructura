CREATE SCHEMA IF NOT EXISTS `Cul_d'Ampolla`;

USE `Cul_d'Ampolla`;

-- PROVIDERS
CREATE TABLE IF NOT EXISTS `Cul_d'Ampolla`.`providers` (
  `idProvider` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(20) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phone` INT NOT NULL,
  `fax` INT(10) NULL,
  `nif` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idProvider`));

-- BRANDS
CREATE TABLE IF NOT EXISTS brands (
  idBrand INT NOT NULL AUTO_INCREMENT,
  brandName VARCHAR(45) NOT NULL,
  id_provider INT NOT NULL,
  PRIMARY KEY (idBrand),
  CONSTRAINT `id_provider`
    FOREIGN KEY (id_provider)
    REFERENCES providers (idProvider));
    
-- GLASSES
CREATE TABLE IF NOT EXISTS `Cul_d'Ampolla`.`glasses` (
  idGlass INT NOT NULL AUTO_INCREMENT,
  id_brand INT NOT NULL,
  graduationRight INT NOT NULL,
  graduationLeft INT NOT NULL,
  frameType VARCHAR(45) NOT NULL,
  frameColor VARCHAR(45) NOT NULL,
  glassColor VARCHAR(45) NOT NULL,
  cost DECIMAL(2) NOT NULL,
  PRIMARY KEY (`idGlass`),
  CONSTRAINT `id_brand`
    FOREIGN KEY (`id_brand`)
    REFERENCES `Cul_d'Ampolla`.`brands` (`idBrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- CUSTOMERS
CREATE TABLE IF NOT EXISTS `Cul_d'Ampolla`.`customers` (
  `idCostumer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `mail` VARCHAR(20) NOT NULL,
  `registDate` DATE NOT NULL,
  `referringCustomer_id` INT NULL,
  PRIMARY KEY (`idCostumer`),
 CONSTRAINT `referringCustomer_id`
    FOREIGN KEY (`referringCustomer_id`)
    REFERENCES `Cul_d'Ampolla`.`customers` (`idCostumer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- MODIFICO LONGITUD
ALTER TABLE `cul_d'ampolla`.`customers`
MODIFY COLUMN `address` VARCHAR(100);


-- EMPLOYEES
CREATE TABLE IF NOT EXISTS `Cul_d'Ampolla`.`employees` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;

-- SALES
CREATE TABLE IF NOT EXISTS `Cul_d'Ampolla`.`sales` (
  `idSale` INT NOT NULL AUTO_INCREMENT,
  `glasses_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  `saleDtae` DATETIME NOT NULL,
  PRIMARY KEY (`idSale`),
  CONSTRAINT `glasses_id`
    FOREIGN KEY (`glasses_id`)
    REFERENCES `Cul_d'Ampolla`.`glasses` (`idGlass`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Cul_d'Ampolla`.`customers` (`idCostumer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Cul_d'Ampolla`.`employees` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- SI T'EQUIVOQUES A L'ESCRIURE EL NOM DE LA COLUMNA
ALTER TABLE `Cul_d'Ampolla`.`sales`
CHANGE COLUMN `saleDtae` `saleDate` DATETIME NOT NULL;



-- VALUES PROVIDERS 

INSERT INTO `cul_d'ampolla`.`providers` (`name`, `address`, `phone`, `fax`, `nif`) VALUES ('prov1', 'C/Lluis Companys nº5 pis 3 porta B, Sant Cugat del Vallès, 08172 Espanya', '932589869', 'NULL', '53226874T');
INSERT INTO `cul_d'ampolla`.`providers` (`name`, `address`, `phone`, `fax`, `nif`) VALUES ('prov2', 'C/Major nº53 planta 0 porta E, Barcelona, 08425 Espanya', '932819658', '2254784120', '53226452Y');
INSERT INTO `cul_d'ampolla`.`providers` (`name`, `address`, `phone`, `nif`) VALUES ('prov3', 'C/Francesc Moragas nº33 pis 11 porta 4, Gèlida, 08258 Espanya', '938887879', '53226521J');
INSERT INTO `cul_d'ampolla`.`providers` (`name`, `address`, `phone`, `fax`, `nif`) VALUES ('prov4', 'Ps.del Mar nº75 pis 3 porta 4, Alicante, 03172 Espanya', '972584875', '8954725687', '154872564B');
INSERT INTO `cul_d'ampolla`.`providers` (`name`, `address`, `phone`, `nif`) VALUES ('prov5', 'Av.Rius i Taulet nº2 planta baixa, Berga, 02148 Espanya', '952587496', '158745871V');

-- VALUES BRANDS
INSERT INTO `cul_d'ampolla`.`brands` (`brandName`, `id_provider`) VALUES ('brand1', '1');
INSERT INTO `cul_d'ampolla`.`brands` (`brandName`, `id_provider`) VALUES ('brand2', '2');
INSERT INTO `cul_d'ampolla`.`brands` (`brandName`, `id_provider`) VALUES ('brand3', '3');
INSERT INTO `cul_d'ampolla`.`brands` (`brandName`, `id_provider`) VALUES ('brand4', '4');

-- VALUES GLASSES
INSERT INTO `cul_d'ampolla`.`glasses` (`id_brand`, `graduationRight`, `graduationLeft`, `frameType`, `frameColor`, `glassColor`, `cost`) VALUES ('2', '0.25', '1', 'flotant', 'blanc', 'transparent', '45.24');
INSERT INTO `cul_d'ampolla`.`glasses` (`id_brand`, `graduationRight`, `graduationLeft`, `frameType`, `frameColor`, `glassColor`, `cost`) VALUES ('2', '0', '0', 'pasta', 'negre', 'negre', '53.25');
INSERT INTO `cul_d'ampolla`.`glasses` (`id_brand`, `graduationRight`, `graduationLeft`, `frameType`, `frameColor`, `glassColor`, `cost`) VALUES ('1', '0', '0', 'metal.lica', 'plata', 'negre', '60');
INSERT INTO `cul_d'ampolla`.`glasses` (`id_brand`, `graduationRight`, `graduationLeft`, `frameType`, `frameColor`, `glassColor`, `cost`) VALUES ('3', '1', '1.25', 'flotant', 'gris fosc', 'negre', '65.25');
INSERT INTO `cul_d'ampolla`.`glasses` (`id_brand`, `graduationRight`, `graduationLeft`, `frameType`, `frameColor`, `glassColor`, `cost`) VALUES ('4', '0', '0.25', 'pasta', 'verd oliva', 'transparent', '35');

-- VALUES COSTUMERS
INSERT INTO `cul_d'ampolla`.`customers` (`name`, `address`, `phone`, `mail`, `registDate`, `referringCustomer_id`) VALUES ('Albert', 'C/Sant Feliu nº5 pis 3 porta B, Sabadell, 08333  Espanya', '2222222', 'mailto1.com', '2020.07.03', NULL);
INSERT INTO `cul_d'ampolla`.`customers` (`name`, `address`, `phone`, `mail`, `registDate`, `referringCustomer_id`) VALUES ('Jana', 'C/Santa Maria nº50 CASA , Terrassa, 08888  Espanya', '8975412', 'mailto2.com', '2023-08-02', '1');
INSERT INTO `cul_d'ampolla`.`customers` (`name`, `address`, `phone`, `mail`, `registDate`) VALUES ('Marta', 'Pl.del Coll  nº27 pis 3 porta 4, Barcelona, 08444  Espanya', '4710235', 'mailto3.com', '2015-01-25');
INSERT INTO `cul_d'ampolla`.`customers` (`name`, `address`, `phone`, `mail`, `registDate`) VALUES ('Jordi', 'C/del Mar nº1 pis 1 , Badalona, 08222  Espanya', '0214587', 'mailto4.com', '2018-03-13');
INSERT INTO `cul_d'ampolla`.`customers` (`name`, `address`, `phone`, `mail`, `registDate`, `referringCustomer_id`) VALUES ('Carla', 'C/Sant Martí nº 11 pis 1, Sant Cugat del Vallès, 08172 Espanya', '3216688', 'mailto5.com', '2023-07-31', '2');

-- VALUES EMPLOYEES
INSERT INTO `cul_d'ampolla`.`employees` (`name`, `lastName`) VALUES ('name1', 'last1');
INSERT INTO `cul_d'ampolla`.`employees` (`name`, `lastName`) VALUES ('name2', 'last2');
INSERT INTO `cul_d'ampolla`.`employees` (`name`, `lastName`) VALUES ('name3', 'last3');
INSERT INTO `cul_d'ampolla`.`employees` (`name`, `lastName`) VALUES ('name4', 'last4');
INSERT INTO `cul_d'ampolla`.`employees` (`name`, `lastName`) VALUES ('name5', 'last5');

-- VALUES SALES
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('2', '5', '3', '2023-01-02');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('1', '4', '2', '2023-02-03');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('3', '3', '1', '2023-03-04');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('5', '1', '5', '2023-04-06');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('4', '2', '4', '2023-05-13');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('1', '1', '1', '2023-04-10');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('2', '2', '2', '2023-02-24');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('3', '3', '3', '2023-03-03');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('4', '4', '4', '2023-07-17');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('5', '5', '5', '2023-01-12');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('1', '5', '2', '2023-01-02');
INSERT INTO `cul_d'ampolla`.`sales` (`glasses_id`, `customer_id`, `employee_id`, `saleDtae`) VALUES ('3', '1', '2', '2023-06-01');



-- ------------------------------------------------------------------------------------------------------------------------------------
-- TOTAL COMPRES D'UN CLIENT
SELECT count(glasses_id) as totalCompres_Albert
FROM sales
WHERE customer_id=1 ;

-- TOTAL COMPRES TOTS ELS CLIENTS
SELECT c.idCostumer, c.name, COUNT(s.glasses_id) as totalCompres
FROM customers c
INNER JOIN sales s ON c.idCostumer = s.customer_id
GROUP BY c.idCostumer, c.name;

--  TIPUS D'ULLERES VENGUDES X EMPLEAT DURANT 1 ANY
SELECT COUNT( DISTINCT g.idGlass, g.frameType, g.frameColor, g.glassColor)as salesEmployee2023
FROM sales s
INNER JOIN glasses g ON s.glasses_id = g.idGlass
WHERE s.employee_id = 1 AND YEAR(s.saleDate) = 2023;

-- TIPUS D'ULLERES VENGUDES X EMPLEAT DURANT 1 ANY
SELECT e.name as salesEmployee2023, g.idGlass, g.frameType, g.frameColor, g.glassColor
FROM sales s
JOIN glasses g ON s.glasses_id = g.idGlass
JOIN employees e ON s.employee_id = e.idEmployee
WHERE e.name = 'name1' AND YEAR(s.saleDate) = 2023;
-- GROUP BY e.idEmployee, e.name,(s.saleDate) = 2023;  Aquesta línia no acaba de funcionar bé (Pendent mirar)

-- DIFERENTS PROVEÏDORS
SELECT DISTINCT p.name AS differentProviders
FROM providers p
JOIN brands b ON p.idProvider = b.id_provider
JOIN glasses g ON b.idBrand = g.id_brand
WHERE g.idGlass IN (SELECT glasses_id FROM sales);


SELECT * FROM glasses;
SELECT * FROM sales;
SELECT * FROM employees;
SELECT * FROM providers;
SELECT * FROM costumers;


-- DELETE TABLA
DROP TABLE customers;

-- DELETE FILA
DELETE FROM customers
WHERE idCostumer=2;

-- ACTUALITZAR LA COLUMNA QUE EM DONA PROBLEMES A L'HORA DE DELETE
UPDATE `cul_d'ampolla`.`customers`
SET `referringCustomer_id` = NULL
WHERE `idCostumer` = 1;

-- PER QUE TORNI A 1 L'AUTOINCREMENT
ALTER TABLE `cul_d'ampolla`.`customers` AUTO_INCREMENT = 1;


