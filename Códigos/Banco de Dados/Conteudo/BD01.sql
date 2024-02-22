-- MySQL Script generated by MySQL Workbench
-- Wed Feb  7 10:47:30 2024
-- Model: Clínica Médica    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bcc_saude
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bcc_saude` ;

-- -----------------------------------------------------
-- Schema bcc_saude
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bcc_saude` ;
USE `bcc_saude` ;

-- -----------------------------------------------------
-- Table `bcc_saude`.`atendimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`atendimento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `consulta_id` INT NOT NULL,
  `relatoQueixas` MEDIUMTEXT NOT NULL,
  `diagnosticoPreliminar` MEDIUMTEXT NOT NULL,
  `prescricaoMedica` MEDIUMTEXT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_atendimento_consulta1_idx` (`consulta_id` ASC) VISIBLE,
  CONSTRAINT `fk_atendimento_consulta1`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `bcc_saude`.`consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`bancoAgencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`bancoAgencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(45) NOT NULL,
  `numeroFenabram` VARCHAR(10) NOT NULL,
  `sigla` VARCHAR(45) NOT NULL,
  `agencia` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`cidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`cidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(240) NOT NULL,
  `estado_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_cidade_estado1_idx` (`estado_id` ASC) VISIBLE,
  CONSTRAINT `fk_cidade_estado1`
    FOREIGN KEY (`estado_id`)
    REFERENCES `bcc_saude`.`estado` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`consulta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`consulta` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataHora` DATETIME NOT NULL,
  `pessoa_id_colaborador` INT NOT NULL,
  `pessoa_id_paciente` INT NOT NULL,
  `pessoa_id_medico` INT NOT NULL,
  `especialidade_id` INT NOT NULL,
  `tipoConsulta` ENUM('1', '2') NOT NULL COMMENT '1 - Inicial\n2 - Retorno',
  `categoria` ENUM('1', '2', '3') CHARACTER SET 'ascii' NULL COMMENT 'Pode ser:\n1 - Particular\n2 - Plano de Saúde\n3 - Rede pública',
  `queixaInicial` MEDIUMTEXT NOT NULL,
  `status` ENUM('1', '2', '3', '4') NOT NULL COMMENT '1 - Ativa\n2 - Atendida\n3 - Cancelada\n4 - Remarcada',
  `observacao` VARCHAR(200) NULL COMMENT 'Deve ser informado dados sobre a remarcação e/ou cancelamentos da consulta.',
  `dataRetorno` DATETIME NULL,
  `consulta_id_Anterior` INT NULL COMMENT 'Deve ser informado o código da consulta que gerou o registro do retorno.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idconsulta_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_consulta_pessoa1_idx` (`pessoa_id_colaborador` ASC) VISIBLE,
  INDEX `fk_consulta_pessoa2_idx` (`pessoa_id_paciente` ASC) VISIBLE,
  INDEX `fk_consulta_pessoa3_idx` (`pessoa_id_medico` ASC) VISIBLE,
  INDEX `fk_consulta_especialidadeProfissional1_idx` (`especialidade_id` ASC) VISIBLE,
  INDEX `fk_consulta_consulta1_idx` (`consulta_id_Anterior` ASC) VISIBLE,
  CONSTRAINT `fk_consulta_pessoa1`
    FOREIGN KEY (`pessoa_id_colaborador`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_pessoa2`
    FOREIGN KEY (`pessoa_id_paciente`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_pessoa3`
    FOREIGN KEY (`pessoa_id_medico`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_especialidadeProfissional1`
    FOREIGN KEY (`especialidade_id`)
    REFERENCES `bcc_saude`.`especialidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consulta_consulta1`
    FOREIGN KEY (`consulta_id_Anterior`)
    REFERENCES `bcc_saude`.`consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`consultaExame`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`consultaExame` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataLancamento` DATETIME NULL,
  `consulta_id` INT NOT NULL,
  `exames_id` INT NOT NULL,
  `observacao` TINYTEXT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_consultaExame_consulta1_idx` (`consulta_id` ASC) VISIBLE,
  INDEX `fk_consultaExame_exames1_idx` (`exames_id` ASC) VISIBLE,
  CONSTRAINT `fk_consultaExame_consulta1`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `bcc_saude`.`consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultaExame_exames1`
    FOREIGN KEY (`exames_id`)
    REFERENCES `bcc_saude`.`exames` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`consultaPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`consultaPagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `data` DATE NULL,
  `formaPagamento_id` INT NOT NULL,
  `consulta_id` INT NOT NULL,
  `valor` DECIMAL(14,2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_consultaPagamento_formaPagamento1_idx` (`formaPagamento_id` ASC) VISIBLE,
  INDEX `fk_consultaPagamento_consulta1_idx` (`consulta_id` ASC) VISIBLE,
  CONSTRAINT `fk_consultaPagamento_formaPagamento1`
    FOREIGN KEY (`formaPagamento_id`)
    REFERENCES `bcc_saude`.`formaPagamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultaPagamento_consulta1`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `bcc_saude`.`consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`consultaPlanoSaude`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`consultaPlanoSaude` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `consulta_id` INT NOT NULL,
  `pessoa_id` INT NOT NULL,
  `tipoVinculo` ENUM('1', '2') NULL COMMENT 'Deve ser informado:\n1 - Titular do Plano\n2 - Dependente',
  PRIMARY KEY (`id`),
  INDEX `fk_consultaPlanoSaude_consulta1_idx` (`consulta_id` ASC) VISIBLE,
  INDEX `fk_consultaPlanoSaude_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  CONSTRAINT `fk_consultaPlanoSaude_consulta1`
    FOREIGN KEY (`consulta_id`)
    REFERENCES `bcc_saude`.`consulta` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultaPlanoSaude_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`departamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`departamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `sigla` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE,
  UNIQUE INDEX `sigla_UNIQUE` (`sigla` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`endereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('Rua', 'Avenida', 'Rodovia', 'Praça') NOT NULL,
  `logradouro` VARCHAR(240) NOT NULL,
  `cep` VARCHAR(8) NOT NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_endereço_cidade1_idx` (`cidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_endereço_cidade1`
    FOREIGN KEY (`cidade_id`)
    REFERENCES `bcc_saude`.`cidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`especialidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`estado` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `pais_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_estado_pais1_idx` (`pais_id` ASC) VISIBLE,
  CONSTRAINT `fk_estado_pais1`
    FOREIGN KEY (`pais_id`)
    REFERENCES `bcc_saude`.`pais` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`exames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`exames` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`formaPagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`formaPagamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pais` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(60) NOT NULL,
  `sigla` VARCHAR(2) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoa` (
  `id` INT NULL AUTO_INCREMENT,
  `nome` VARCHAR(200) NOT NULL,
  `tipo` ENUM('F', 'J', 'N') NOT NULL COMMENT 'Podem ser:\nF - Pessoa Fícia\nJ - Pessoa Jurídica\nN - Não informado\nObs.: para pessoas física e jurídicas, validadar o atributo CPF/CNPJ, conforme o tipo.',
  `categoria` ENUM('1', '2', '3', '4', '5', '6', '7', '8', '9', '99') NOT NULL COMMENT 'São categorias de pessoas:\n1 - coloborador (funcionários)\n2 - parceiros (clientes)\n3 - fornecedor\n4 - cooperativa\n5 - Plano de saúde \n6 - Prestador serviço\n7 - Terceirizados\n8 - Transportadora \n9 - Produtor Rural\n99-Não identificada',
  `perfil` ENUM('1', '2', '3', '99') NULL COMMENT 'A pessoa pode ter o seguinte perfil\n1 - Usuário do sistema\n2 - Empresa do sistema\n3 - Profissional de saúde\n99 - Geral',
  `CPF_CNPJ` VARCHAR(14) NOT NULL,
  `telefone` VARCHAR(14) NULL,
  `email` VARCHAR(30) NULL,
  `status` ENUM('0', '1', '2') NULL COMMENT 'São status permitidos:\n0 - Falecido\n1 - Ativo\n2 - Inativo',
  `ramoAtividade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idpessoa_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `CPF_CNPJ_UNIQUE` (`CPF_CNPJ` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_pessoa_ramoAtividade1_idx` (`ramoAtividade_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoa_ramoAtividade1`
    FOREIGN KEY (`ramoAtividade_id`)
    REFERENCES `bcc_saude`.`ramoAtividade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaContrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaContrato` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NOT NULL,
  `dataInicio` DATE NOT NULL,
  `dataFim` DATE NOT NULL,
  `valorContrato` DECIMAL(14,2) NOT NULL,
  `descricao` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_pessoaContrato_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaContrato_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaDadosBancario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaDadosBancario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NOT NULL,
  `banco_id` INT NOT NULL,
  `tipoConta` ENUM('1', '2', '3', '4') NOT NULL COMMENT 'As contas podem ser:\n1 - Corrente pessoa física\n2 - Poupança pessoa física\n3 - Corrente Jurídica\n4 - Paoupança Jurídica',
  `numeroConta` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaDadosBancario_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoaDadosBancario_banco1_idx` (`banco_id` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaDadosBancario_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaDadosBancario_banco1`
    FOREIGN KEY (`banco_id`)
    REFERENCES `bcc_saude`.`bancoAgencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaDepartamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaDepartamento` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataAdmissao` DATE NOT NULL,
  `pessoa_id` INT NOT NULL,
  `departamento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaDepartamento_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoaDepartamento_departamento1_idx` (`departamento_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaDepartamento_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaDepartamento_departamento1`
    FOREIGN KEY (`departamento_id`)
    REFERENCES `bcc_saude`.`departamento` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaEndereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaEndereco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NOT NULL,
  `endereco_id` INT NOT NULL,
  `tipo` ENUM('1', '2', '3', '4') NOT NULL COMMENT 'os tipos de endereços podem ser:\n1- Residência;\n2- Trabalho;\n3- Cobrança;\n4- Entrega;',
  `status` ENUM('0', '1') NOT NULL COMMENT 'Os status podem ser:\n1- Ativo;\n0- Inativo(quando for excluído na aplicação);',
  `numero` VARCHAR(12) NOT NULL,
  `complemento` VARCHAR(18) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaEndereco_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoaEndereco_endereço1_idx` (`endereco_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaEndereco_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaEndereco_endereço1`
    FOREIGN KEY (`endereco_id`)
    REFERENCES `bcc_saude`.`endereco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaEspecialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaEspecialidade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataInicio` DATE NULL,
  `pessoaFisica_pessoa_id` INT NOT NULL,
  `especialidade_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaEspecialidade_pessoaFisica1_idx` (`pessoaFisica_pessoa_id` ASC) VISIBLE,
  INDEX `fk_pessoaEspecialidade_especialidadeProfissional1_idx` (`especialidade_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaEspecialidade_pessoaFisica1`
    FOREIGN KEY (`pessoaFisica_pessoa_id`)
    REFERENCES `bcc_saude`.`pessoaFisica` (`pessoa_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaEspecialidade_especialidadeProfissional1`
    FOREIGN KEY (`especialidade_id`)
    REFERENCES `bcc_saude`.`especialidade` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaFisica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaFisica` (
  `pessoa_id` INT NOT NULL,
  `numeroReservista` VARCHAR(64) NOT NULL,
  `DataNascimento` DATE NOT NULL,
  `numeroCarteiraProfisional` VARCHAR(40) NULL,
  `possuiPlanoSaude` ENUM('Sim', 'Não') NULL,
  PRIMARY KEY (`pessoa_id`),
  INDEX `fk_pessoaFisica_pessoa_idx` (`pessoa_id` ASC) VISIBLE,
  UNIQUE INDEX `numeroCarteiraProfisional_UNIQUE` (`numeroCarteiraProfisional` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaFisica_pessoa`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaJuridica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaJuridica` (
  `pessoa_id` INT NOT NULL AUTO_INCREMENT,
  `nomeFantasia` VARCHAR(120) NOT NULL,
  `regimeTributario` ENUM('1', '2', '3') NOT NULL COMMENT '1 - Simples Nacional\n2 - Lucro Presumido \n3 - Lucro Real',
  `registroOrgaoRegulador` VARCHAR(60) NULL COMMENT 'Deve ser informado para Planos de Saúde, Transportadoras e Cooperativas, conforme classifcação informada no cadastro do Parceiro.',
  `formaRepasseFinanceiro` ENUM('1', '2') NULL COMMENT 'Identifica a forma de repasse de pagamento quando da prestação de serviços realizados por Planos de Saúde, pode ocorrer o mesmo para as transportadoras.\n1 - Direto ao prestador de serviço\n2 - Para a empresa',
  PRIMARY KEY (`pessoa_id`),
  CONSTRAINT `fk_pessoaJuridica_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaReferencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaReferencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pessoa_id` INT NOT NULL,
  `tipo` ENUM('1', '2') NULL COMMENT 'Tipo de referência\n1 - Pessoa Física\n2 - Pessoa Jurídica',
  `dataInicio` DATE NOT NULL,
  `dataFim` DATE NOT NULL,
  `descricao` MEDIUMTEXT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_pessoaHistoricoTrabalho_pessoa1_idx` (`pessoa_id` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaHistoricoTrabalho_pessoa1`
    FOREIGN KEY (`pessoa_id`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`pessoaVinculo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`pessoaVinculo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo` ENUM('1', '2', '3') NULL COMMENT 'identifica o tipo do vínculo, pode ser :\n1- Dependente;\n2- Filial;\n3-Representante;',
  `pessoa_id_Principal` INT NOT NULL,
  `pessoa_id_Vinculo` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pessoaVinculo_pessoa1_idx` (`pessoa_id_Principal` ASC) VISIBLE,
  INDEX `fk_pessoaVinculo_pessoa2_idx` (`pessoa_id_Vinculo` ASC) VISIBLE,
  CONSTRAINT `fk_pessoaVinculo_pessoa1`
    FOREIGN KEY (`pessoa_id_Principal`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pessoaVinculo_pessoa2`
    FOREIGN KEY (`pessoa_id_Vinculo`)
    REFERENCES `bcc_saude`.`pessoa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bcc_saude`.`ramoAtividade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcc_saude`.`ramoAtividade` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
