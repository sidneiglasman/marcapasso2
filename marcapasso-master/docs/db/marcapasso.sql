SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `marcapasso` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;

CREATE TABLE IF NOT EXISTS `marcapasso`.`plano` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `valor` DECIMAL(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `marcapasso`.`agenda` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `prestador_categoria_id` INT(11) NOT NULL,
  `hora_inicio` DATETIME NOT NULL,
  `hora_fim` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_agenda_prestador_categoria1_idx` (`prestador_categoria_id` ASC),
  CONSTRAINT `fk_agenda_prestador_categoria1`
    FOREIGN KEY (`prestador_categoria_id`)
    REFERENCES `marcapasso`.`prestador_categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `marcapasso`.`categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` TEXT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `marcapasso`.`sub_categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `marcapasso`.`vinculo` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `descricao` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `marcapasso`.`prestador_categoria` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `sub_categoria_id` INT(11) NOT NULL,
  `categoria_id` INT(11) NOT NULL,
  `usuario_id` INT(11) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_prestador_categoria_sub_categoria1_idx` (`sub_categoria_id` ASC),
  INDEX `fk_prestador_categoria_categoria1_idx` (`categoria_id` ASC),
  INDEX `fk_prestador_categoria_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_prestador_categoria_sub_categoria1`
    FOREIGN KEY (`sub_categoria_id`)
    REFERENCES `marcapasso`.`sub_categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestador_categoria_categoria1`
    FOREIGN KEY (`categoria_id`)
    REFERENCES `marcapasso`.`categoria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prestador_categoria_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `marcapasso`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `marcapasso`.`usuario` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `ativo` SET('true', 'false') NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `tipo_pessoa` SET('J','F') NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL DEFAULT '-',
  `cnpj` VARCHAR(45) NOT NULL DEFAULT '-',
  `endereco` VARCHAR(255) NOT NULL,
  `numero` INT(11) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `celular` VARCHAR(45) NULL DEFAULT NULL,
  `cep` VARCHAR(45) NOT NULL,
  `sexo` SET('M', 'F') NULL DEFAULT NULL,
  `data_nascimento` DATE NULL DEFAULT NULL,
  `plano_id` INT(11) NOT NULL,
  `vinculo_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  INDEX `fk_usuario_plano1_idx` (`plano_id` ASC),
  INDEX `fk_usuario_vinculo1_idx` (`vinculo_id` ASC),
  CONSTRAINT `fk_usuario_plano1`
    FOREIGN KEY (`plano_id`)
    REFERENCES `marcapasso`.`plano` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_vinculo1`
    FOREIGN KEY (`vinculo_id`)
    REFERENCES `marcapasso`.`vinculo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;

CREATE TABLE IF NOT EXISTS `marcapasso`.`usuario_has_agenda` (
  `usuario_id` INT(11) NOT NULL,
  `agenda_id` INT(11) NOT NULL,
  PRIMARY KEY (`usuario_id`, `agenda_id`),
  INDEX `fk_usuario_has_agenda_agenda1_idx` (`agenda_id` ASC),
  INDEX `fk_usuario_has_agenda_usuario1_idx` (`usuario_id` ASC),
  CONSTRAINT `fk_usuario_has_agenda_usuario1`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `marcapasso`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_has_agenda_agenda1`
    FOREIGN KEY (`agenda_id`)
    REFERENCES `marcapasso`.`agenda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
