CREATE TABLE TANQUE(
  CODIGO INTEGER NOT NULL,
  NOME VARCHAR(100) NOT NULL,
  TIPO CHAR(3) NOT NULL,
  CONSTRAINT PK_TANQUE PRIMARY KEY(CODIGO)
);

CREATE TABLE BOMBA(
  CODIGO INTEGER NOT NULL,
  NOME VARCHAR(100) NOT NULL,
  CODIGO_TANQUE INTEGER NOT NULL,
  CONSTRAINT PK_BOMBA PRIMARY KEY(CODIGO),
  CONSTRAINT FK_BOMBA_TANQUE FOREIGN KEY(CODIGO_TANQUE) REFERENCES TANQUE(CODIGO)
);

CREATE TABLE ABASTECIMENTO(
  CODIGO INTEGER NOT NULL,
  QTDE_LITROS DECIMAL (12,2) NOT NULL,
  VLR_ABASTECIMENTO DECIMAL (12,2) NOT NULL,
  VLR_IMPOSTO DECIMAL (12,2) NOT NULL,
  DATA_CADASTRO DATE NOT NULL,
  CODIGO_BOMBA INTEGER NOT NULL,
  FORMA_PAGAMENTO VARCHAR(50) NOT NULL,
  CONSTRAINT PK_ABASTECIMENTO PRIMARY KEY (CODIGO),
  CONSTRAINT FK_ABASTECIMENTO_BOMBA FOREIGN KEY(CODIGO_BOMBA) REFERENCES BOMBA(CODIGO)
);

CREATE TABLE COMPOSICAO(
  CODIGO INTEGER NOT NULL,
  VLR_LITRO_GASOLINA DECIMAL(12,2) NOT NULL,
  VLR_LITRO_OLEO_DIESEL DECIMAL(12,2) NOT NULL,
  PERC_IMPOSTO DECIMAL(3,2) NOT NULL,
  CONSTRAINT PK_COMPOSICAO PRIMARY KEY(CODIGO)
);

CREATE GENERATOR GEN_ABASTECIMENTO_ID;
CREATE GENERATOR GEN_BOMBA_ID;
CREATE GENERATOR GEN_TANQUE_ID;

INSERT INTO COMPOSICAO (CODIGO, VLR_LITRO_GASOLINA, VLR_LITRO_OLEO_DIESEL, PERC_IMPOSTO)
VALUES (1, 5.59, 4.28, 13);

INSERT INTO TANQUE (CODIGO, NOME, TIPO)
VALUES (1, 'TANQUE 01 - GASOLINA', 'G');
INSERT INTO TANQUE (CODIGO, NOME, TIPO)
VALUES (2, 'TANQUE 02 - ÓLEO DIESEL', 'D');

INSERT INTO BOMBA (CODIGO, NOME, CODIGO_TANQUE)
VALUES (1, 'BOMBA 01 - GASOLINA', 1);
INSERT INTO BOMBA (CODIGO, NOME, CODIGO_TANQUE)
VALUES (2, 'BOMBA 02 - GASOLINA', 1);
INSERT INTO BOMBA (CODIGO, NOME, CODIGO_TANQUE)
VALUES (3, 'BOMBA 03 - ÓLEO DIESEL', 2);
INSERT INTO BOMBA (CODIGO, NOME, CODIGO_TANQUE)
VALUES (4, 'BOMBA 04 - ÓLEO DIESEL', 2);
