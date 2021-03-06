-- MySQL Script generated by MySQL Workbench
-- Wed Dec 20 23:43:51 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

drop table IF EXISTS planovaniRozvrhu.prednasejicipredmetu;
drop table IF EXISTS planovaniRozvrhu.lonskeTerminy;
drop table IF EXISTS planovaniRozvrhu.terminyPozadavkuNaZkousky;
drop table IF EXISTS planovaniRozvrhu.pozadavkyNaZkousky;
drop table IF EXISTS planovaniRozvrhu.terminyPozadavkuNaRozvrh;
drop table IF EXISTS planovaniRozvrhu.pozadavkyNaRozvrh;
drop table IF EXISTS planovaniRozvrhu.kolize;
drop table IF EXISTS planovaniRozvrhu.zapsaniStudenti;
drop table IF EXISTS planovaniRozvrhu.povinnostVOboru;
drop table IF EXISTS planovaniRozvrhu.majiRegistrovane;
drop table IF EXISTS planovaniRozvrhu.studenti;
drop table IF EXISTS planovaniRozvrhu.obory;
drop table IF EXISTS planovaniRozvrhu.nedostupnost;
drop table IF EXISTS planovaniRozvrhu.zkousce_prislusi;
drop table IF EXISTS planovaniRozvrhu.casyZkousek;
drop table IF EXISTS planovaniRozvrhu.verzeZkousek;
drop table IF EXISTS planovaniRozvrhu.predmetuPrislusi;
drop table IF EXISTS planovaniRozvrhu.mistnosti;
drop table IF EXISTS planovaniRozvrhu.casyPredmetu;
drop table IF EXISTS planovaniRozvrhu.verzeRozvrhu;
drop table IF EXISTS planovaniRozvrhu.semestry;
drop table IF EXISTS planovaniRozvrhu.predmety;
drop table IF EXISTS planovaniRozvrhu.ucitele;
-- -----------------------------------------------------
-- Schema planovaniRozvrhu
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema planovaniRozvrhu
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `planovaniRozvrhu` DEFAULT CHARACTER SET utf8 ;
USE `planovaniRozvrhu` ;

-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`ucitele`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`ucitele` (
  `id` INT NOT NULL,
  `jmeno` VARCHAR(200) NULL,
  `email` VARCHAR(100) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`predmety`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`predmety` (
  `id` INT NOT NULL,
  `id_garanta` INT NULL,
  `predmet_id` VARCHAR(100) NULL,
  `nazev` VARCHAR(200) NULL,
  `zkratka` VARCHAR(10) NULL,
  `fakulta` ENUM('FIT', 'FEKT', 'FSI', 'FP', 'FA', 'FCH', 'FAST', 'FAVU', 'USI') NULL,
  `kapacita` INT NULL,
  `pocet_zapsanych_studentu` INT NULL,
  `planovat_zkousky_flag` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_predmety_ucitele1_idx` (`id_garanta` ASC),
  CONSTRAINT `fk_predmety_ucitele1`
    FOREIGN KEY (`id_garanta`)
    REFERENCES `planovaniRozvrhu`.`ucitele` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`semestry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`semestry` (
  `id` INT NOT NULL,
  `obdobi` ENUM('ZS', 'LS') NULL,
  `rok` INT NULL,
  `akademicky_rok` VARCHAR(45) NULL,
  `zkouskove_od` DATE NULL,
  `zkouskove_do` DATE NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`verzeRozvrhu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`verzeRozvrhu` (
  `id` INT NOT NULL,
  `id_semestru` INT NULL,
  `nazev_verze` VARCHAR(200) NULL,
  `cislo_verze` INT NULL,
  `je_aktivni_flag` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_verzeRozvrhu_semestry1_idx` (`id_semestru` ASC),
  CONSTRAINT `fk_verzeRozvrhu_semestry1`
    FOREIGN KEY (`id_semestru`)
    REFERENCES `planovaniRozvrhu`.`semestry` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`casyPredmetu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`casyPredmetu` (
  `id` INT NOT NULL,
  `id_verze` INT NULL,
  `id_predmetu` INT NULL,
  `verze` INT NULL,
  `datum` DATE NULL,
  `cas_od` TIME(6) NULL,
  `cas_do` TIME(6) NULL,
  `typ` ENUM('p', 'n', 'c', 'l', 'z', 'o') NULL,
  INDEX `fk_verzeRozvrhu_has_predmety_predmety1_idx` (`id_predmetu` ASC),
  INDEX `fk_verzeRozvrhu_has_predmety_verzeRozvrhu1_idx` (`id_verze` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_verzeRozvrhu_has_predmety_verzeRozvrhu1`
    FOREIGN KEY (`id_verze`)
    REFERENCES `planovaniRozvrhu`.`verzeRozvrhu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_verzeRozvrhu_has_predmety_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`mistnosti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`mistnosti` (
  `id` INT NOT NULL,
  `nazev` VARCHAR(45) NULL,
  `kapacita` INT NULL,
  `kapacita_ob1` INT NULL,
  `kapacita_ob2` INT NULL,
  `fakulta` ENUM('FIT', 'FEKT', 'FSI', 'FP', 'FA', 'FCH', 'FAST', 'FAVU', 'USI') NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`predmetuPrislusi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`predmetuPrislusi` (
  `id` INT NOT NULL,
  `id_casu_predmetu` INT NULL,
  `id_mistnosti` INT NULL,
  INDEX `fk_casyPredmetu_has_mistnosti_mistnosti1_idx` (`id_mistnosti` ASC),
  INDEX `fk_casyPredmetu_has_mistnosti_casyPredmetu1_idx` (`id_casu_predmetu` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_casyPredmetu_has_mistnosti_casyPredmetu1`
    FOREIGN KEY (`id_casu_predmetu`)
    REFERENCES `planovaniRozvrhu`.`casyPredmetu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_casyPredmetu_has_mistnosti_mistnosti1`
    FOREIGN KEY (`id_mistnosti`)
    REFERENCES `planovaniRozvrhu`.`mistnosti` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`verzeZkousek`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`verzeZkousek` (
  `id` INT NOT NULL,
  `id_semestru` INT NULL,
  `nazev_verze` VARCHAR(200) NULL,
  `cislo_verze` INT NULL,
  `je_aktivni_flag` TINYINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_verzeZkousek_semestry1_idx` (`id_semestru` ASC),
  CONSTRAINT `fk_verzeZkousek_semestry1`
    FOREIGN KEY (`id_semestru`)
    REFERENCES `planovaniRozvrhu`.`semestry` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`casyZkousek`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`casyZkousek` (
  `id` INT NOT NULL,
  `id_verze` INT NULL,
  `id_predmetu` INT NULL,
  `verze` INT NULL,
  `datum` DATE NULL,
  `cas_od` TIME(6) NULL,
  `cas_do` TIME(6) NULL,
  `termin` ENUM('radny', '1opravny', '2opravny') NULL,
  `pevny_cas_flag` TINYINT NULL,
  INDEX `fk_predmety_has_verzeZkousek_verzeZkousek1_idx` (`id_verze` ASC),
  INDEX `fk_predmety_has_verzeZkousek_predmety1_idx` (`id_predmetu` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_predmety_has_verzeZkousek_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_predmety_has_verzeZkousek_verzeZkousek1`
    FOREIGN KEY (`id_verze`)
    REFERENCES `planovaniRozvrhu`.`verzeZkousek` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`zkousce_prislusi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`zkousce_prislusi` (
  `id` INT NOT NULL,
  `mistnosti_id` INT NULL,
  `casyZkousek_id` INT NULL,
  INDEX `fk_mistnosti_has_casyZkousek_casyZkousek1_idx` (`casyZkousek_id` ASC),
  INDEX `fk_mistnosti_has_casyZkousek_mistnosti1_idx` (`mistnosti_id` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_mistnosti_has_casyZkousek_mistnosti1`
    FOREIGN KEY (`mistnosti_id`)
    REFERENCES `planovaniRozvrhu`.`mistnosti` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mistnosti_has_casyZkousek_casyZkousek1`
    FOREIGN KEY (`casyZkousek_id`)
    REFERENCES `planovaniRozvrhu`.`casyZkousek` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`nedostupnost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`nedostupnost` (
  `id` INT NOT NULL,
  `id_mistnosti` INT NULL,
  `duvod` VARCHAR(200) NULL,
  `datum` DATE NULL,
  `cas_od` TIME(6) NULL,
  `cas_do` TIME(6) NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_nedostupnost_mistnosti1_idx` (`id_mistnosti` ASC),
  CONSTRAINT `fk_nedostupnost_mistnosti1`
    FOREIGN KEY (`id_mistnosti`)
    REFERENCES `planovaniRozvrhu`.`mistnosti` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`obory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`obory` (
  `id` INT NOT NULL,
  `id_semestru` INT NULL,
  `nazev` VARCHAR(200) NULL,
  `zkratka` VARCHAR(10) NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_obory_semestry1_idx` (`id_semestru` ASC),
  CONSTRAINT `fk_obory_semestry1`
    FOREIGN KEY (`id_semestru`)
    REFERENCES `planovaniRozvrhu`.`semestry` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`studenti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`studenti` (
  `id` INT NOT NULL,
  `id_oboru` INT NULL,
  `student_id` INT NULL,
  `login` VARCHAR(45) NULL,
  `jmeno` VARCHAR(45) NULL,
  `prijmeni` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_studenti_obory1_idx` (`id_oboru` ASC),
  CONSTRAINT `fk_studenti_obory1`
    FOREIGN KEY (`id_oboru`)
    REFERENCES `planovaniRozvrhu`.`obory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`majiRegistrovane`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`majiRegistrovane` (
  `id` INT NOT NULL,
  `id_studenta` INT NULL,
  `id_predmetu` INT NULL,
  INDEX `fk_studenti_has_predmety_predmety1_idx` (`id_predmetu` ASC),
  INDEX `fk_studenti_has_predmety_studenti1_idx` (`id_studenta` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_studenti_has_predmety_studenti1`
    FOREIGN KEY (`id_studenta`)
    REFERENCES `planovaniRozvrhu`.`studenti` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_studenti_has_predmety_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`povinnostVOboru`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`povinnostVOboru` (
  `id` INT NOT NULL,
  `id_oboru` INT NULL,
  `id_predmetu` INT NULL,
  `typ_povinnosti` ENUM('P', 'PV', 'V') NULL,
  INDEX `fk_obory_has_predmety_predmety1_idx` (`id_predmetu` ASC),
  INDEX `fk_obory_has_predmety_obory1_idx` (`id_oboru` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_obory_has_predmety_obory1`
    FOREIGN KEY (`id_oboru`)
    REFERENCES `planovaniRozvrhu`.`obory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_obory_has_predmety_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`zapsaniStudenti`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`zapsaniStudenti` (
  `id` INT NOT NULL,
  `id_oboru` INT NULL,
  `id_predmetu` INT NULL,
  `pocet_zapsanych_studentu` INT NULL,
  INDEX `fk_obory_has_predmety_predmety2_idx` (`id_predmetu` ASC),
  INDEX `fk_obory_has_predmety_obory2_idx` (`id_oboru` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_obory_has_predmety_obory2`
    FOREIGN KEY (`id_oboru`)
    REFERENCES `planovaniRozvrhu`.`obory` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_obory_has_predmety_predmety2`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`kolize`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`kolize` (
  `id` INT NOT NULL,
  `id_predmetu` INT NULL,
  `id_predmetu_v_kolizi` INT NULL,
  `pocet_studentu_v_kolizi` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_kolize_predmety1_idx` (`id_predmetu` ASC),
  INDEX `fk_kolize_predmety2_idx` (`id_predmetu_v_kolizi` ASC),
  CONSTRAINT `fk_kolize_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kolize_predmety2`
    FOREIGN KEY (`id_predmetu_v_kolizi`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`pozadavkyNaRozvrh`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`pozadavkyNaRozvrh` (
  `id` INT NOT NULL,
  `id_predmetu` INT NULL,
  `id_vyucujiciho` INT NULL,
  `typ` VARCHAR(100) NULL,
  `skupin` VARCHAR(100) NULL,
  `kapacita` INT NULL,
  `hodin` INT NULL,
  `tyden` VARCHAR(100) NULL,
  `mistnosti` VARCHAR(100) NULL,
  `poznamka` TEXT(1000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_pozadavkyNaRozvrh_predmety1_idx` (`id_predmetu` ASC),
  INDEX `fk_pozadavkyNaRozvrh_ucitele1_idx` (`id_vyucujiciho` ASC),
  CONSTRAINT `fk_pozadavkyNaRozvrh_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pozadavkyNaRozvrh_ucitele1`
    FOREIGN KEY (`id_vyucujiciho`)
    REFERENCES `planovaniRozvrhu`.`ucitele` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`terminyPozadavkuNaRozvrh`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`terminyPozadavkuNaRozvrh` (
  `id` INT NOT NULL,
  `id_PozadavkuNaRozvrh` INT NULL,
  `typ_terminu` ENUM('vyhovující', 'nemožný') NULL,
  `den` VARCHAR(100) NULL,
  `od` TIME(6) NULL,
  `do` TIME(6) NULL,
  `prio` ENUM('low', 'medium', 'high') NULL,
  `poznamka` TEXT(1000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_terminyPozadavkuNaRozvrh_pozadavkyNaRozvrh1_idx` (`id_PozadavkuNaRozvrh` ASC),
  CONSTRAINT `fk_terminyPozadavkuNaRozvrh_pozadavkyNaRozvrh1`
    FOREIGN KEY (`id_PozadavkuNaRozvrh`)
    REFERENCES `planovaniRozvrhu`.`pozadavkyNaRozvrh` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`pozadavkyNaZkousky`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`pozadavkyNaZkousky` (
  `id` INT NOT NULL,
  `id_predmetu` INT NULL,
  `id_zkousejiciho` INT NULL,
  `rozsaz` ENUM('vedle sebe', 'ob1', 'ob2') NULL,
  `poznamka` TEXT(1000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_pozadavkyNaZkousky_predmety1_idx` (`id_predmetu` ASC),
  INDEX `fk_pozadavkyNaZkousky_ucitele1_idx` (`id_zkousejiciho` ASC),
  CONSTRAINT `fk_pozadavkyNaZkousky_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pozadavkyNaZkousky_ucitele1`
    FOREIGN KEY (`id_zkousejiciho`)
    REFERENCES `planovaniRozvrhu`.`ucitele` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`terminyPozadavkuNaZkousky`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`terminyPozadavkuNaZkousky` (
  `id` INT NOT NULL,
  `id_pozadavkuNaZkousky` INT NULL,
  `typ` ENUM('vyhovující', 'nemožný') NULL,
  `termin` ENUM('všechny', 'předtermín', '1. termín', '2. termín', '3. termín', '4. termín', '5. termín') NULL,
  `datum_od` DATE NULL,
  `datum_do` DATE NULL,
  `den` VARCHAR(100) NULL,
  `cas_od` TIME(6) NULL,
  `cas_do` TIME(6) NULL,
  `hod.` INT NULL,
  `pocet_kol` INT NULL,
  `pref_mistnosti` VARCHAR(100) NULL,
  `poznamka` TEXT(1000) NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_terminyPozadavkuNaZkousky_pozadavkyNaZkousky1_idx` (`id_pozadavkuNaZkousky` ASC),
  CONSTRAINT `fk_terminyPozadavkuNaZkousky_pozadavkyNaZkousky1`
    FOREIGN KEY (`id_pozadavkuNaZkousky`)
    REFERENCES `planovaniRozvrhu`.`pozadavkyNaZkousky` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`lonskeTerminy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`lonskeTerminy` (
  `id` INT NOT NULL,
  `id_predmetu` INT NULL,
  `id_garanta` INT NULL,
  `zak` ENUM('Zazk', 'Zk', 'Klz', 'Za') NULL,
  `stud` INT NULL,
  `#1` INT NULL,
  `#2` INT NULL,
  `#3` INT NULL,
  `#4` INT NULL,
  `#5` INT NULL,
  `#6` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  INDEX `fk_vypsaneTerminy_predmety1_idx` (`id_predmetu` ASC),
  INDEX `fk_lonskeTerminy_ucitele1_idx` (`id_garanta` ASC),
  CONSTRAINT `fk_vypsaneTerminy_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lonskeTerminy_ucitele1`
    FOREIGN KEY (`id_garanta`)
    REFERENCES `planovaniRozvrhu`.`ucitele` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `planovaniRozvrhu`.`prednasejiciPredmetu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `planovaniRozvrhu`.`prednasejiciPredmetu` (
  `id` INT NOT NULL,
  `id_predmetu` INT NULL,
  `id_ucitele` INT NULL,
  INDEX `fk_predmety_has_ucitele_ucitele1_idx` (`id_ucitele` ASC),
  INDEX `fk_predmety_has_ucitele_predmety1_idx` (`id_predmetu` ASC),
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  CONSTRAINT `fk_predmety_has_ucitele_predmety1`
    FOREIGN KEY (`id_predmetu`)
    REFERENCES `planovaniRozvrhu`.`predmety` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_predmety_has_ucitele_ucitele1`
    FOREIGN KEY (`id_ucitele`)
    REFERENCES `planovaniRozvrhu`.`ucitele` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Naplnění místností
-- -----------------------------------------------------

INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (1,'A112',64,32,21,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (2,'A113',64,32,21,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (3,'A211',8,4,2,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (4,'A218',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (5,'A127.1',6,3,2,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (6,'A128',8,4,2,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (7,'C209',30,15,10,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (8,'C211',7,3,2,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (9,'C228',24,12,8,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (10,'C236',15,7,5,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (11,'C304',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (12,'D0206',154,77,51,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (13,'D0207',90,45,30,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (14,'D105',300,150,100,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (15,'E104',72,36,24,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (16,'E105',72,36,24,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (17,'E112',156,78,52,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (18,'G108',50,25,16,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (19,'G202',80,40,26,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (20,'L116',24,12,8,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (21,'L118',8,4,2,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (22,'L220',16,8,5,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (23,'L304',12,6,4,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (24,'L305',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (25,'L306',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (26,'L311',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (27,'L314',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (28,'L321',16,8,5,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (29,'M103',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (30,'N103',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (31,'N104',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (32,'N105',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (33,'N203',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (34,'N204',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (35,'N205',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (36,'O105',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (37,'O203',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (38,'O204',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (39,'O205',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (40,'P108',70,35,23,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (41,'Q322',10,5,3,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (42,'R211',50,25,16,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (43,'S206',20,10,6,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (44,'S207',10,5,3,'FIT');
INSERT INTO `mistnosti` (`id`,`nazev`,`kapacita`,`kapacita_ob1`,`kapacita_ob2`,`fakulta`) VALUES (45,'S214',20,10,6,'FIT');