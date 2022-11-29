SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `cod_cliente` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `DNI` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NULL,
  `telefono` INT NOT NULL,
  `cod_cliente_aval` INT NULL,
  PRIMARY KEY (`cod_cliente`),
  UNIQUE INDEX `DNI_UNIQUE` (`DNI` ASC) VISIBLE,
  UNIQUE INDEX `cod_cliente_UNIQUE` (`cod_cliente` ASC) VISIBLE,
  INDEX `fk_Cliente_Cliente1_idx` (`cod_cliente_aval` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Cliente1`
    FOREIGN KEY (`cod_cliente_aval`)
    REFERENCES `mydb`.`Cliente` (`cod_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reserva` (
  `idreserva` INT NOT NULL,
  `fecha_inicio` DATETIME NULL,
  `fecha_fin` DATETIME NULL,
  `precio_total` DECIMAL NULL,
  `Cliente_cod_cliente` INT NOT NULL,
  PRIMARY KEY (`idreserva`, `Cliente_cod_cliente`),
  INDEX `fk_Reserva_Cliente1_idx` (`Cliente_cod_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_Cliente1`
    FOREIGN KEY (`Cliente_cod_cliente`)
    REFERENCES `mydb`.`Cliente` (`cod_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Coche`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Coche` (
  `idcoche` INT NOT NULL,
  `matricula` VARCHAR(45) NOT NULL,
  `color` VARCHAR(45) NULL,
  `marca` VARCHAR(45) NULL,
  `precio_x_hora` DECIMAL NULL,
  `lts_combustible` VARCHAR(45) NULL,
  PRIMARY KEY (`idcoche`),
  UNIQUE INDEX `matricula_UNIQUE` (`matricula` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empresa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empresa` (
  `idempresa` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`idempresa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Empresa_has_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Empresa_has_Cliente` (
  `Empresa_idempresa` INT NOT NULL,
  `Cliente_cod_cliente` INT NOT NULL,
  `Cliente_Reserva_idreserva` INT NOT NULL,
  PRIMARY KEY (`Empresa_idempresa`, `Cliente_cod_cliente`, `Cliente_Reserva_idreserva`),
  INDEX `fk_Empresa_has_Cliente_Cliente1_idx` (`Cliente_cod_cliente` ASC, `Cliente_Reserva_idreserva` ASC) VISIBLE,
  INDEX `fk_Empresa_has_Cliente_Empresa1_idx` (`Empresa_idempresa` ASC) VISIBLE,
  CONSTRAINT `fk_Empresa_has_Cliente_Empresa1`
    FOREIGN KEY (`Empresa_idempresa`)
    REFERENCES `mydb`.`Empresa` (`idempresa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Empresa_has_Cliente_Cliente1`
    FOREIGN KEY (`Cliente_cod_cliente`)
    REFERENCES `mydb`.`Cliente` (`cod_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Reserva_Coche`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Reserva_Coche` (
  `Reserva_idreserva` INT NOT NULL,
  `Reserva_Cliente_cod_cliente` INT NOT NULL,
  `Coche_idcoche` INT NOT NULL,
  PRIMARY KEY (`Reserva_idreserva`, `Reserva_Cliente_cod_cliente`, `Coche_idcoche`),
  INDEX `fk_Reserva_has_Coche_Coche1_idx` (`Coche_idcoche` ASC) VISIBLE,
  INDEX `fk_Reserva_has_Coche_Reserva1_idx` (`Reserva_idreserva` ASC, `Reserva_Cliente_cod_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_Reserva_has_Coche_Reserva1`
    FOREIGN KEY (`Reserva_idreserva` , `Reserva_Cliente_cod_cliente`)
    REFERENCES `mydb`.`Reserva` (`idreserva` , `Cliente_cod_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reserva_has_Coche_Coche1`
    FOREIGN KEY (`Coche_idcoche`)
    REFERENCES `mydb`.`Coche` (`idcoche`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
-- ----------------------------------------------------------
--  INSERTAR DATOS A TABLA CLIENTES
INSERT INTO Cliente (cod_cliente,nombre,DNI,direccion,telefono)
VALUES (01, 'Martin Rodriguez',41761159, 'Yrigoyen 3619',873338);

INSERT INTO Cliente (cod_cliente,nombre,DNI,direccion,telefono,cod_cliente_aval)
 VALUES (02, 'Lucas',41152352, 'sta catalina 1235',321545,01);

INSERT INTO Cliente (cod_cliente,nombre,DNI,direccion,telefono,cod_cliente_aval)
VALUES (03, 'Franco',43152451, 'Aeroclub',251548,02);
-- ----------------------------------------------------------
--  INSERTAR DATOS A TABLA COCHE
INSERT INTO coche (idcoche,matricula,coloR,marca,precio_x_hora,lts_combustible)
VALUES (01, 'AEI-677','AZUL', 'AUDI',5000,15);

INSERT INTO coche (idcoche,matricula,coloR,marca,precio_x_hora,lts_combustible)
VALUES (02, 'AEI-777','VERDE', 'FIAT',2500,25);

INSERT INTO coche (idcoche,matricula,coloR,marca,precio_x_hora,lts_combustible)
VALUES (03, 'AEI-999','ROJO', 'RENAULT',1500,10);
-- -----------------------------------------------------------
--  INSERTAR DATOS A TABLA RESERVA
INSERT INTO reserva (idreserva,fecha_inicio,fecha_fin,precio_total,cliente_cod_cliente) 
VALUES (01, '2022-01-03','2022-02-03','8000',01);

INSERT INTO reserva (idreserva,fecha_inicio,fecha_fin,precio_total,cliente_cod_cliente)
 VALUES (02, '2022-01-03','2022-02-04','5000',02);
 
 INSERT INTO reserva (idreserva,fecha_inicio,fecha_fin,precio_total,cliente_cod_cliente)
 VALUES (03, '2022-01-05','2022-02-06','6000',03);
 -- ----------------------------------------------------------
 --  INSERTAR DATOS A TABLA RESERVA_COCHE
 INSERT INTO reserva_coche (Reserva_idreserva,Reserva_Cliente_cod_cliente,coche_idcoche)
 VALUES (01,01,01);
 
 INSERT INTO reserva_coche (Reserva_idreserva,Reserva_Cliente_cod_cliente,coche_idcoche)
 VALUES (02,02,02);

INSERT INTO reserva_coche (Reserva_idreserva,Reserva_Cliente_cod_cliente,coche_idcoche)
 VALUES (03,03,03);

 -- ---------------------------------------------------------
 -- CONSULTAS -----------------------------------------------
 SELECT nombre,direccion,telefono,fecha_inicio,fecha_fin,precio_total,matricula,marca FROM cliente 
INNER JOIN reserva_coche ON cliente.cod_cliente = reserva_Cliente_cod_cliente 
INNER JOIN reserva ON Reserva_idreserva = idreserva 
INNER JOIN coche ON coche.idcoche = reserva_coche.Coche_idcoche;
-- ------------------------------------------------------------------------------------------------
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;