-- MySQL Script generated by MySQL Workbench
-- Sat Sep  8 19:10:17 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Proyecto
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Proyecto
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Proyecto` DEFAULT CHARACTER SET utf8 ;
USE `Proyecto` ;

-- -----------------------------------------------------
-- Table `Proyecto`.`R_huella`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`R_huella` (
  `idHuella` INT(30) NOT NULL,
  PRIMARY KEY (`idHuella`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto`.`R_Propietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`R_Propietario` (
  `IDP` INT(10) NOT NULL,
  `Nombre` TEXT(20) NULL,
  `Direccion` VARCHAR(10) NULL,
  `Placa` VARCHAR(10) NULL,
  PRIMARY KEY (`IDP`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto`.`Propietario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`Propietario` (
  `Codigo_P` INT(20) NOT NULL,
  `N_parqueadero` VARCHAR(45) NULL,
  `Nombre` TEXT(20) NULL,
  `Apellido` TEXT(20) NULL,
  `Direccion` VARCHAR(10) NULL,
  `R_Propietario_IDP` INT(10) NOT NULL,
  `R_huella_idHuella` INT(30) NOT NULL,
  PRIMARY KEY (`Codigo_P`, `R_Propietario_IDP`, `R_huella_idHuella`),
  INDEX `fk_Propietario_R_Propietario1_idx` (`R_Propietario_IDP` ASC),
  INDEX `fk_Propietario_R_huella1_idx` (`R_huella_idHuella` ASC),
  CONSTRAINT `fk_Propietario_R_Propietario1`
    FOREIGN KEY (`R_Propietario_IDP`)
    REFERENCES `Proyecto`.`R_Propietario` (`IDP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Propietario_R_huella1`
    FOREIGN KEY (`R_huella_idHuella`)
    REFERENCES `Proyecto`.`R_huella` (`idHuella`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto`.`Tarjeta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`Tarjeta` (
  `idTarjeta` INT(10) NOT NULL,
  `Serial` VARCHAR(20) NULL,
  PRIMARY KEY (`idTarjeta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto`.`Visitantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`Visitantes` (
  `ID` INT(10) NOT NULL,
  `Nombre` TEXT(20) NULL,
  `Apellido` TEXT(20) NULL,
  `Direccion` VARCHAR(10) NULL,
  `Placa` VARCHAR(10) NULL,
  `Tarjeta_idTarjeta` INT(10) NOT NULL,
  PRIMARY KEY (`ID`, `Tarjeta_idTarjeta`),
  INDEX `fk_Visitantes_Tarjeta1_idx` (`Tarjeta_idTarjeta` ASC),
  CONSTRAINT `fk_Visitantes_Tarjeta1`
    FOREIGN KEY (`Tarjeta_idTarjeta`)
    REFERENCES `Proyecto`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`Roles` (
  `Administrador` CHAR(10) NOT NULL,
  `J_Guarda` TEXT(20) NULL,
  `Guarda_T` TEXT(20) NULL,
  `Visitantes_ID` INT(10) NOT NULL,
  `Visitantes_Tarjeta_idTarjeta` INT(10) NOT NULL,
  `R_Propietario_IDP` INT(10) NOT NULL,
  PRIMARY KEY (`Administrador`, `Visitantes_ID`, `Visitantes_Tarjeta_idTarjeta`, `R_Propietario_IDP`),
  INDEX `fk_Roles_Visitantes1_idx` (`Visitantes_ID` ASC, `Visitantes_Tarjeta_idTarjeta` ASC),
  INDEX `fk_Roles_R_Propietario1_idx` (`R_Propietario_IDP` ASC),
  CONSTRAINT `fk_Roles_Visitantes1`
    FOREIGN KEY (`Visitantes_ID` , `Visitantes_Tarjeta_idTarjeta`)
    REFERENCES `Proyecto`.`Visitantes` (`ID` , `Tarjeta_idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Roles_R_Propietario1`
    FOREIGN KEY (`R_Propietario_IDP`)
    REFERENCES `Proyecto`.`R_Propietario` (`IDP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Proyecto`.`ActivacionT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`ActivacionT` (
  `Codigo_Act` INT(20) NOT NULL,
  `N_Act` VARCHAR(30) NULL,
  PRIMARY KEY (`Codigo_Act`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = tis620;


-- -----------------------------------------------------
-- Table `Proyecto`.`Tarjeta_has_ActivacionT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Proyecto`.`Tarjeta_has_ActivacionT` (
  `Tarjeta_idTarjeta` INT(10) NOT NULL,
  `ActivacionT_Codigo_Act` INT(20) NOT NULL,
  PRIMARY KEY (`Tarjeta_idTarjeta`, `ActivacionT_Codigo_Act`),
  INDEX `fk_Tarjeta_has_ActivacionT_ActivacionT1_idx` (`ActivacionT_Codigo_Act` ASC),
  INDEX `fk_Tarjeta_has_ActivacionT_Tarjeta1_idx` (`Tarjeta_idTarjeta` ASC),
  CONSTRAINT `fk_Tarjeta_has_ActivacionT_Tarjeta1`
    FOREIGN KEY (`Tarjeta_idTarjeta`)
    REFERENCES `Proyecto`.`Tarjeta` (`idTarjeta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tarjeta_has_ActivacionT_ActivacionT1`
    FOREIGN KEY (`ActivacionT_Codigo_Act`)
    REFERENCES `Proyecto`.`ActivacionT` (`Codigo_Act`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
