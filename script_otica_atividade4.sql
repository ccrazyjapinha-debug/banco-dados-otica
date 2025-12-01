CREATE DATABASE IF NOT EXISTS `otica` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `otica`;

--
-- Table structure for table `cliente`
--
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `cpf` char(11) DEFAULT NULL,
  `telefone` varchar(15) DEFAULT NULL,
  `nascimento` date DEFAULT NULL,
  `cep` char(8) DEFAULT NULL,
  `cidade` varchar(20) DEFAULT NULL,
  `bairro` varchar(20) DEFAULT NULL,
  `rua` varchar(20) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cliente`
--
LOCK TABLES `cliente` WRITE;
INSERT INTO `cliente` VALUES 
(1,'Janiele Xavier Cândido','42534867890','1190000-0000','1994-05-08','09071415','santo andré','sacadura cabral','Nilopolis',92),
(2,'Rebeca liz Xavier Padilha','12345678912','1190000-0000','2024-07-24','09070000','são caetano','barcelona','owsvaldo cruz',15),
(3,'Eldo Luiz Padilha','39239489721','1193284-5847','1964-08-02','09078621','santo andré','vila guiomar','gago coutinho',65),
(4,'Celia Maria','38271947281','1194209-3321','1980-06-09','09287612','São Bernado','vila vivalde','bernado rocha',55),
(5,'Levi Martins','23248571841','1193456-0092','2020-02-10','09234567','Santo André','vila palmares','novo horizonte',100);
UNLOCK TABLES;

--
-- Table structure for table `oculos`
--
DROP TABLE IF EXISTS `oculos`;
CREATE TABLE `oculos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `codigo_armacao` varchar(20) DEFAULT NULL,
  `lente` varchar(100) NOT NULL,
  `preco` decimal(10,2) DEFAULT NULL,  -- Coluna adicionada para corrigir o erro do UPDATE
  `od_esferico` decimal(4,2) DEFAULT NULL,
  `od_cilindrico` decimal(4,2) DEFAULT NULL,
  `od_eixo` int DEFAULT NULL,
  `oe_esferico` decimal(4,2) DEFAULT NULL,
  `oe_cilindrico` decimal(4,2) DEFAULT NULL,
  `oe_eixo` int DEFAULT NULL,
  `adicao` decimal(4,2) DEFAULT NULL,
  `dp` int DEFAULT NULL,
  `altura` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `oculos`
--
LOCK TABLES `oculos` WRITE;
INSERT INTO `oculos` VALUES 
(1,'RB-AVIATOR','Polarizada G15', 600.00, 0.00,0.00,0,0.00,0.00,0,0.00,0,0),
(2,'OAK-SPORT','Policarbonato Antirreflexo', 800.00, -2.00,0.00,0,-2.25,-0.50,180,0.00,64,30),
(3,'RB-BD','Multifocal Digital Crizal', 2800.00, 1.50,-1.00,90,1.75,-1.25,100,2.50,62,32),
(4,'VOGUE-LEIT','CR filtro Azul', 450.00, 2.00,0.00,0,2.00,0.00,0,0.00,60,28),
(5,'MIRAFLEX','Trivex incolor', 350.00, -0.50,0.00,0,-0.50,0.00,0,0.00,54,25);
UNLOCK TABLES;

--
-- Table structure for table `receita`
--
DROP TABLE IF EXISTS `receita`;
CREATE TABLE `receita` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_cliente` int NOT NULL,
  `medico` varchar(30) NOT NULL,
  `data_prescricao` date NOT NULL,
  `od_esferico` decimal(4,2) DEFAULT NULL,
  `od_cilindrico` decimal(4,2) DEFAULT NULL,
  `od_eixo` int DEFAULT NULL,
  `oe_esferico` decimal(4,2) DEFAULT NULL,
  `oe_cilindrico` decimal(4,2) DEFAULT NULL,
  `oe_eixo` int DEFAULT NULL,
  `adicao` decimal(4,2) DEFAULT NULL,
  `dp` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_cliente` (`id_cliente`),
  CONSTRAINT `receita_ibfk_1` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `receita`
--
LOCK TABLES `receita` WRITE;
INSERT INTO `receita` VALUES 
(1,1,'Dr. Alison Luiz','2025-10-10',-2.00,0.00,0,-2.25,-0.50,180,0.00,64),
(2,2,'Dra. Ana Paula','2025-11-01',1.50,-1.00,90,1.75,-1.25,100,2.50,62),
(3,3,'Cópia Óculos Antigo','2025-11-20',2.00,0.00,0,2.00,0.00,0,0.00,60),
(4,5,'Dr.Rodinei Del Sordi','2025-11-25',-0.50,0.00,0,-0.50,0.00,0,0.00,54);
UNLOCK TABLES;

--
-- Table structure for table `vendedor`
--
DROP TABLE IF EXISTS `vendedor`;
CREATE TABLE `vendedor` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `cpf` char(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf` (`cpf`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `vendedor` WRITE;
INSERT INTO `vendedor` VALUES 
(1,'Marcel Jurado','47929035808'),
(2,'Marcia Jurado','12345671234');
UNLOCK TABLES;

--
-- Table structure for table `venda`
--
DROP TABLE IF EXISTS `venda`;
CREATE TABLE `venda` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_oculos` int NOT NULL,
  `id_cliente` int NOT NULL,
  `id_vendedor` int NOT NULL,
  `id_receita` int DEFAULT NULL,
  `data_venda` date NOT NULL,
  `valor_venda` decimal(10,2) DEFAULT NULL,
  `forma_pagamento` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_oculos` (`id_oculos`),
  KEY `id_cliente` (`id_cliente`),
  KEY `id_vendedor` (`id_vendedor`),
  KEY `id_receita` (`id_receita`),
  CONSTRAINT `venda_ibfk_1` FOREIGN KEY (`id_oculos`) REFERENCES `oculos` (`id`),
  CONSTRAINT `venda_ibfk_2` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id`),
  CONSTRAINT `venda_ibfk_3` FOREIGN KEY (`id_vendedor`) REFERENCES `vendedor` (`id`),
  CONSTRAINT `venda_ibfk_4` FOREIGN KEY (`id_receita`) REFERENCES `receita` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `venda`
--
LOCK TABLES `venda` WRITE;
INSERT INTO `venda` VALUES 
(1,2,1,1,1,'2025-11-25',1250.00,'Cartão Crédito 10x'),
(2,3,2,2,2,'2025-11-26',2800.00,'Boleto'),
(3,4,3,1,3,'2025-11-26',450.00,'Pix'),(4,1,1,2,NULL,'2025-11-27',600.00,'Débito');
UNLOCK TABLES;


-- COMANDOS DML (Manipulação de Dados) - INSERT, SELECT, UPDATE, DELETE

-- Atualiza telefone do cliente 1
UPDATE cliente 
SET telefone = '1198888-9999' 
WHERE id = 1;

-- Atualiza preço do óculos OAK-SPORT (Agora funciona pois a coluna existe)
UPDATE oculos 
SET preco = 850.00 
WHERE codigo_armacao = 'OAK-SPORT';

-- Atualiza o bairro do cliente 5
UPDATE cliente 
SET bairro = 'Vila Nova' 
WHERE id = 5;

-- Estratégia: Inserir dados temporários e deletar em seguida para não violar chaves estrangeiras

-- Deletar Vendedor
INSERT INTO vendedor (nome, cpf) VALUES ('Vendedor Teste', '99999999999'); -- Cria temporário
DELETE FROM vendedor WHERE nome = 'Vendedor Teste'; -- Deleta (Sucesso)

-- Deletar Receita (Precisa ser de um cliente que existe, usaremos id 4 que não tem venda vinculada no momento)
INSERT INTO receita (id_cliente, medico, data_prescricao) VALUES (4, 'Medico Temp', '2025-01-01');
DELETE FROM receita WHERE medico = 'Medico Temp';

-- Deletar Óculos (Cria um óculos sem venda vinculada)
INSERT INTO oculos (lente, codigo_armacao, preco) VALUES ('Lente Teste', 'TEST-01', 100.00);
DELETE FROM oculos WHERE codigo_armacao = 'TEST-01';

-- Consulta com filtro por texto (LIKE)
SELECT * FROM venda 
WHERE forma_pagamento LIKE '%Crédito%';

-- Consulta com ordenação
SELECT nome, cpf, telefone 
FROM cliente 
ORDER BY nome ASC;

-- Consulta complexa com JOIN (Relacionando Venda, Cliente e Óculos)
SELECT 
    c.nome AS Nome_Cliente, 
    o.codigo_armacao AS Oculos, 
    v.data_venda, 
    v.valor_venda
FROM venda v
INNER JOIN cliente c ON v.id_cliente = c.id
INNER JOIN oculos o ON v.id_oculos = o.id;