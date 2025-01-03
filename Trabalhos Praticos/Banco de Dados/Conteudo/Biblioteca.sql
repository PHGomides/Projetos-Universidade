-- MySQL Script generated by MySQL Workbench
-- Mon Feb 19 16:01:16 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Biblioteca
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Biblioteca` ;

-- -----------------------------------------------------
-- Schema Biblioteca
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Biblioteca` ;
USE `Biblioteca` ;

-- -----------------------------------------------------
-- Table `Biblioteca`.`acervo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`acervo` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`acervo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(200) NOT NULL,
  `anoPublicacao` INT NOT NULL,
  `pessoa_id_Editora` INT NOT NULL,
  `pessoa_id_Autor` INT NOT NULL,
  `localizacao_id` INT NOT NULL,
  `tipoAcervo_id` INT NOT NULL,
  `generoLiterario_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `titulo_UNIQUE` (`titulo` ASC) VISIBLE,
  INDEX `fk_acervo_pessoa1_idx` (`pessoa_id_Editora` ASC) VISIBLE,
  INDEX `fk_acervo_pessoa2_idx` (`pessoa_id_Autor` ASC) VISIBLE,
  INDEX `fk_acervo_localizacao1_idx` (`localizacao_id` ASC) VISIBLE,
  INDEX `fk_acervo_tipoAcervo1_idx` (`tipoAcervo_id` ASC) VISIBLE,
  INDEX `fk_acervo_generoLiterario1_idx` (`generoLiterario_id` ASC) VISIBLE,
  CONSTRAINT `fk_acervo_pessoa1`
    FOREIGN KEY (`pessoa_id_Editora`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acervo_pessoa2`
    FOREIGN KEY (`pessoa_id_Autor`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acervo_localizacao1`
    FOREIGN KEY (`localizacao_id`)
    REFERENCES `Biblioteca`.`localizacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acervo_tipoAcervo1`
    FOREIGN KEY (`tipoAcervo_id`)
    REFERENCES `Biblioteca`.`tipoAcervo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acervo_generoLiterario1`
    FOREIGN KEY (`generoLiterario_id`)
    REFERENCES `Biblioteca`.`generoLiterario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`cidade`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`cidade` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`cidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(120) NOT NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_estado1_idx` (`estado_id` ASC) VISIBLE,
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `Biblioteca`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`departamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`departamento` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`departamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  UNIQUE INDEX `sigla_UNIQUE` (`sigla` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`emprestimo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`emprestimo` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`emprestimo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataHoraRetirada` DATETIME NOT NULL,
  `dataPrevisaoDevolucao` DATE NOT NULL,
  `dataHoraDevolucao` DATETIME NOT NULL,
  `acervo_id` INT NOT NULL,
  `pessoa_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_emprestimo_acervo1_idx` (`acervo_id` ASC) VISIBLE,
  INDEX `fk_emprestimo_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  CONSTRAINT `fk_emprestimo_acervo1`
    FOREIGN KEY (`acervo_id`)
    REFERENCES `Biblioteca`.`acervo` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_emprestimo_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`endereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`endereco` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('Rua', 'Avenida', 'Rodovia', 'Praça') NOT NULL,
  `logradouro` VARCHAR(160) NOT NULL,
  `CEP` VARCHAR(8) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereco_cidade1_idx` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_endereco_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `Biblioteca`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`estado`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`estado` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  INDEX `fk_estado_pais1_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_estado_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `Biblioteca`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`generoLiterario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`generoLiterario` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`generoLiterario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`localizacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`localizacao` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`localizacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `sala_id` INT NOT NULL,
  `secao_id` INT NOT NULL,
  `prateleira_id` INT NOT NULL,
  `posicao` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_localizacao_sala1_idx` (`sala_id` ASC) VISIBLE,
  INDEX `fk_localizacao_secao1_idx` (`secao_id` ASC) VISIBLE,
  INDEX `fk_localizacao_prateleira1_idx` (`prateleira_id` ASC) VISIBLE,
  UNIQUE INDEX `posicao_UNIQUE` (`posicao` ASC) VISIBLE,
  CONSTRAINT `fk_localizacao_sala1`
    FOREIGN KEY (`sala_id`)
    REFERENCES `Biblioteca`.`sala` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_localizacao_secao1`
    FOREIGN KEY (`secao_id`)
    REFERENCES `Biblioteca`.`secao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_localizacao_prateleira1`
    FOREIGN KEY (`prateleira_id`)
    REFERENCES `Biblioteca`.`prateleira` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`pais` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`pessoa`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`pessoa` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`pessoa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(180) NOT NULL,
  `tipo` ENUM('F', 'J') NOT NULL COMMENT 'Tipo da pessoa pode ser:\nF - Físico\nJ - Jurídico',
  `categoria` ENUM('1', '2', '3', '4', '99') NOT NULL COMMENT 'São categorias de pessoas:\n1 - Colaborador/Funcionário\n2 - Parceiros/Clienetes\n3 - Empresa/Fornecedor\n4 - Cooperativa\n5 - Vendedor\n99 - Não identificada',
  `cpf_cnpj` VARCHAR(14) NOT NULL COMMENT 'Para formatar o campo, verifique o tipo da pessoa.',
  `pais_id_Nacionalidade` INT NOT NULL,
  `email` VARCHAR(240) NULL,
  `telefone` VARCHAR(12) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cpf_cnpj_UNIQUE` (`cpf_cnpj` ASC) VISIBLE,
  INDEX `fk_pessoa_pais1_idx` (`pais_id_Nacionalidade` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_pais1`
    FOREIGN KEY (`pais_id_Nacionalidade`)
    REFERENCES `Biblioteca`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`pessoaDepartamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`pessoaDepartamento` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`pessoaDepartamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataAdmissao` DATE NOT NULL,
  `pessoa_id` INT NOT NULL,
  `departamento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaDepartamento_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoaDepartamento_departamento1_idx` (`departamento_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaDepartamento_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaDepartamento_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `Biblioteca`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`pessoaEndereco`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`pessoaEndereco` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`pessoaEndereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('1', '2', '3', '4') NOT NULL COMMENT 'Os tipos de endereços podem ser:\n1 - Residência\n2 - Trabalho\n3 - Cobrança\n4 - Entregas',
  `status` ENUM('0', '1') NOT NULL COMMENT 'Os status podem ser:\n0 - Inativo (quando for excluídos na aplicação)\n1 - Ativo',
  `numero` VARCHAR(12) NOT NULL,
  `complemento` VARCHAR(18) NULL,
  `pessoa_id` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaEndereco_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoaEndereco_endereco1_idx` (`endereco_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaEndereco_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaEndereco_endereco1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `Biblioteca`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`pessoaFisica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`pessoaFisica` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`pessoaFisica` (
  `pessoa_id` INT NOT NULL,
  `numeroReservista` VARCHAR(64) NULL,
  `dataNascimento` DATE NULL,
  `profissao_id` INT NOT NULL,
  PRIMARY KEY (`pessoa_id`),
  INDEX `fk_pessoaFisica_profissao1_idx` (`profissao_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaFisica_pessoa`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaFisica_profissao1`
    FOREIGN KEY (`profissao_id`)
    REFERENCES `Biblioteca`.`profissao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`pessoaJuridica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`pessoaJuridica` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`pessoaJuridica` (
  `pessoa_id` INT NOT NULL,
  `nomeFantasia` VARCHAR(160) NOT NULL,
  `regimeTributario` ENUM('1', '2', '3') NOT NULL COMMENT 'Identifica o regime tributário, sendo:\n1 - Simples Nacional\n2 - Lucro Real\n3 - Lucro Presumido',
  PRIMARY KEY (`pessoa_id`),
  UNIQUE INDEX `nomeFantasia_UNIQUE` (`nomeFantasia` ASC) VISIBLE,
  INDEX `fk_pessoaJuridica_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaJuridica_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`pessoaVinculo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`pessoaVinculo` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`pessoaVinculo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('1', '2', '3') NULL COMMENT 'Identifica o tipo do vinculo, pode ser:\n1 - Dependente\n2 - Filial\n3 - Representante',
  `pessoa_id_Principal` INT NOT NULL,
  `pessoa_id_Vinculo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaVinculo_pessoa1_idx` (`pessoa_id_Principal` ASC) VISIBLE,
  INDEX `fk_pessoaVinculo_pessoa2_idx` (`pessoa_id_Vinculo` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaVinculo_pessoa1`
    FOREIGN KEY (`pessoa_id_Principal`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaVinculo_pessoa2`
    FOREIGN KEY (`pessoa_id_Vinculo`)
    REFERENCES `Biblioteca`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`prateleira`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`prateleira` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`prateleira` (
  `id` INT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`profissao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`profissao` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`profissao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`sala`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`sala` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`sala` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`secao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`secao` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`secao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Biblioteca`.`tipoAcervo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Biblioteca`.`tipoAcervo` ;

CREATE TABLE IF NOT EXISTS `Biblioteca`.`tipoAcervo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(60) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
