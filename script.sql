-- MySQL Script generated by MySQL Workbench
-- Fri Mar  7 23:40:36 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema consulta_medica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema consulta_medica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `consulta_medica` DEFAULT CHARACTER SET utf8 ;
USE `consulta_medica` ;

-- -----------------------------------------------------
-- Table `consulta_medica`.`tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`tipo_usuario` (
  `idtipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_usuario` VARCHAR(100) NOT NULL,
  `descripcion_tipo_usuario` VARCHAR(45) NOT NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`idtipo_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`citas_medicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`citas_medicas` (
  `idcita_medica` INT NOT NULL AUTO_INCREMENT,
  `fecha_hora` DATETIME NOT NULL,
  `motivo_consulta` VARCHAR(100) NOT NULL,
  `citas_medicascol` VARCHAR(45) NOT NULL,
  `estado` VARCHAR(45) NOT NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`idcita_medica`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`historial_medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`historial_medico` (
  `idhistorial_medico` INT NOT NULL AUTO_INCREMENT,
  `fecha_registro` DATETIME NOT NULL,
  `diagnostico` VARCHAR(45) NOT NULL,
  `tratamiento` VARCHAR(100) NOT NULL,
  `notas_adicionales` VARCHAR(100) NOT NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`idhistorial_medico`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`pacientes` (
  `idpaciente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `created` DATETIME NULL,
  `citas_medicas_idcita_medica` INT NOT NULL,
  `historial_medico_idhistorial_medico` INT NOT NULL,
  PRIMARY KEY (`idpaciente`),
  INDEX `fk_pacientes_citas_medicas1_idx` (`citas_medicas_idcita_medica` ASC) VISIBLE,
  INDEX `fk_pacientes_historial_medico1_idx` (`historial_medico_idhistorial_medico` ASC) VISIBLE,
  CONSTRAINT `fk_pacientes_citas_medicas1`
    FOREIGN KEY (`citas_medicas_idcita_medica`)
    REFERENCES `consulta_medica`.`citas_medicas` (`idcita_medica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pacientes_historial_medico1`
    FOREIGN KEY (`historial_medico_idhistorial_medico`)
    REFERENCES `consulta_medica`.`historial_medico` (`idhistorial_medico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`medico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`medico` (
  `idmedico` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `especialidad` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `created` DATETIME NULL,
  `citas_medicas_idcita_medica` INT NOT NULL,
  PRIMARY KEY (`idmedico`),
  INDEX `fk_medico_citas_medicas1_idx` (`citas_medicas_idcita_medica` ASC) VISIBLE,
  CONSTRAINT `fk_medico_citas_medicas1`
    FOREIGN KEY (`citas_medicas_idcita_medica`)
    REFERENCES `consulta_medica`.`citas_medicas` (`idcita_medica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`administrativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`administrativos` (
  `idadministrativo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`idadministrativo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`usuarios` (
  `idusuarios` INT NOT NULL AUTO_INCREMENT,
  `nombre_usuario` VARCHAR(45) NOT NULL,
  `contraseña` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `created` DATETIME NULL,
  `tipo_usuario_idtipo_usuario` INT NOT NULL,
  `pacientes_idpaciente` INT NOT NULL,
  `medico_idmedico` INT NOT NULL,
  `administrativos_idadministrativo` INT NOT NULL,
  PRIMARY KEY (`idusuarios`),
  INDEX `fk_usuarios_tipo_usuario_idx` (`tipo_usuario_idtipo_usuario` ASC) VISIBLE,
  INDEX `fk_usuarios_pacientes1_idx` (`pacientes_idpaciente` ASC) VISIBLE,
  INDEX `fk_usuarios_medico1_idx` (`medico_idmedico` ASC) VISIBLE,
  INDEX `fk_usuarios_administrativos1_idx` (`administrativos_idadministrativo` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_tipo_usuario`
    FOREIGN KEY (`tipo_usuario_idtipo_usuario`)
    REFERENCES `consulta_medica`.`tipo_usuario` (`idtipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_pacientes1`
    FOREIGN KEY (`pacientes_idpaciente`)
    REFERENCES `consulta_medica`.`pacientes` (`idpaciente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_medico1`
    FOREIGN KEY (`medico_idmedico`)
    REFERENCES `consulta_medica`.`medico` (`idmedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_administrativos1`
    FOREIGN KEY (`administrativos_idadministrativo`)
    REFERENCES `consulta_medica`.`administrativos` (`idadministrativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`funcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`funcion` (
  `idfuncion` INT NOT NULL AUTO_INCREMENT,
  `nombre_funcion` VARCHAR(50) NOT NULL,
  `descripcion_funcion` VARCHAR(45) NOT NULL,
  `created` DATETIME NULL,
  PRIMARY KEY (`idfuncion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `consulta_medica`.`administrativos_has_funcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `consulta_medica`.`administrativos_has_funcion` (
  `administrativos_idadministrativo` INT NOT NULL,
  `funcion_idfuncion` INT NOT NULL,
  PRIMARY KEY (`administrativos_idadministrativo`, `funcion_idfuncion`),
  INDEX `fk_administrativos_has_funcion_funcion1_idx` (`funcion_idfuncion` ASC) VISIBLE,
  INDEX `fk_administrativos_has_funcion_administrativos1_idx` (`administrativos_idadministrativo` ASC) VISIBLE,
  CONSTRAINT `fk_administrativos_has_funcion_administrativos1`
    FOREIGN KEY (`administrativos_idadministrativo`)
    REFERENCES `consulta_medica`.`administrativos` (`idadministrativo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_administrativos_has_funcion_funcion1`
    FOREIGN KEY (`funcion_idfuncion`)
    REFERENCES `consulta_medica`.`funcion` (`idfuncion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
