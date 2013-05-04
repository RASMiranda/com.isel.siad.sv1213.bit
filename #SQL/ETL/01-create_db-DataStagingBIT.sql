/*
*	ISEL-ADEETC-MEIC
* 	SIAD2012/2013N -Verão
*	Grupo 8, Abril de 2013
*
*	Projecto BIT
*        Criação das tabelas DW área de Stagging
*   v0 -2013.04.27
*/

SET NOCOUNT ON;
SET XACT_ABORT ON

GO
USE [master];
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'DataStagingBIT')
BEGIN
  RAISERROR('A remover a base de dados DataStagingBIT ...',0,1); --info
	ALTER DATABASE [DataStagingBIT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE [DataStagingBIT];
END
GO

RAISERROR('A criar a base de dados DataStagingBIT ...',0,1); --info
CREATE DATABASE DataStagingBIT;
GO

USE DataStagingBIT;
GO
CREATE SCHEMA Operacoes;
GO

BEGIN TRANSACTION

CREATE TABLE Operacoes.Morada
(
	keycol INT PRIMARY KEY IDENTITY,
	oltp_id INT UNIQUE, --Morada.moradaid
	rua  VARCHAR(302), --CodigoPorala.arteria_titulo 
	numeroDaPorta VARCHAR(10),  --source: Morada.numPorta
	nomeLocalidade VARCHAR(100) NOT NULL, --CodigoPostal.Nome_localidade
	codigoPostal INT NOT NULL,	 --CodigoPostal.
	extensaoCodigoPostal INT,  -- CodigoPostal.
	designacaoPostal VARCHAR(100) NOT NULL, --CodigoPortal.
	freguesia VARCHAR(50) ,  -- source: freguesia, a partir de codigoPostal
	concelho  VARCHAR(50),  -- source: concelho, a partir de freguesia
	distrito VARCHAR(50)     --source: distrito, a partir de concelho
);

/* carregamento: 
    Morada, com base na data de alteracao
*/

CREATE TABLE Operacoes.TipoServico
(
	keycol TINYINT PRIMARY KEY IDENTITY,
	oltp_id TINYINT UNIQUE NOT NULL,
	tipo  VARCHAR(50) NOT NULL	 --TipoServico.tipo
);
/* carregamento:
    Tipo de Servico, com base na data de alteracao
*/

/* FF: nao é preciso 
CREATE TABLE Operacoes.Loja
(
	keycol INT PRIMARY KEY IDENTITY,
	oltp_id INT UNIQUE NOT NULL,
	nome  VARCHAR(50) NOT NULL,  --Loja.nome
	localizacao  VARCHAR(50) NOT NULL	 --Loja.localizacao
);
/*
    tem de percorrer a tabela toda
*/
*/

CREATE TABLE Operacoes.Cliente
(
	keycol INT PRIMARY KEY IDENTITY,
	oltp_id INT UNIQUE NOT NULL,
	designacao   VARCHAR(100) NOT NULL, --Pessoa.designacao
	nomeContacto VARCHAR(50) NOT NULL,  --Pessoa.
	sobrenomeContacto  VARCHAR(50) NOT NULL, --Pessoa.
	singular  CHAR(1) NOT NULL,  --Pessoa.
	cPostal   VARCHAR(4) NOT NULL,	  --Cliente.
    activo    CHAR(1) NOT NULL  --Cliente.
    --InfoDemografica RM
    ,BirthDate DATETIME NULL
    ,MaritalStatus VARCHAR(150) NULL
    ,YearlyIncome VARCHAR(150) NULL
    ,Gender VARCHAR(150) NULL
    ,TotalChildren VARCHAR(150) NULL
    ,NumberChildrenAtHome VARCHAR(150) NULL
    ,Education VARCHAR(150) NULL
    ,Occupation VARCHAR(150) NULL
    ,HomeOwnerFlag VARCHAR(150) NULL
    ,NumberCarsOwned VARCHAR(150) NULL
    --,dataAlter datetime NULL
);
/* carregamento:
    base tabela de cliente, join pessoa
      com filtro por dataAlter
      RM: e também InfoDemografica.dataAlter?

*/

CREATE TABLE Operacoes.Funcionario
(
	keycol INT PRIMARY KEY IDENTITY,
	oltp_id INT UNIQUE NOT NULL,
	funcao   VARCHAR(50) NOT NULL, -- Funcao.nome
	-- salarioBase DECIMAL(8,2) NOT NULL, -- so devera ter interesse para a parte Financeira
	nome  VARCHAR(50) NOT NULL, --Pessoa.
	sobrenome  VARCHAR(50) NOT NULL, -- Pessoa.
	activo  CHAR(1) NOT NULL, --Funcionario.
	lojaNome  VARCHAR(50) NOT NULL,  --Loja.nome
	localizacao  VARCHAR(50) NOT NULL,	 --Loja.localizacao
	chefeNome VARCHAR(50), --Funcionario.Nome relacao funcionarioId = reporta
	chefeSobrenome  VARCHAR(50),
	chefeFuncao   VARCHAR(50),	 
	chefe_id INT
);
/* Carregamento:
    com base em Funcionario
        com filtro por dataAlter
*/

CREATE TABLE Operacoes.Data
(
	keycol INT PRIMARY KEY,
	data DATE NOT NULL,
	ano INT NOT NULL,
	trimestre TINYINT NOT NULL,
	mes TINYINT NOT NULL,
	descricaoMes VARCHAR(15) NOT NULL,
	diaSemana TINYINT NOT NULL,
	descricaoDiaSemana VARCHAR(15) NOT NULL,
	dia TINYINT NOT NULL	 
);

CREATE TABLE Operacoes.Hora
(
	keycol TINYINT PRIMARY KEY,
	hora24 VARCHAR(5) NOT NULL,
	hora12 VARCHAR(8) NOT NULL
);

CREATE TABLE Operacoes.Servicos
(
	keycol INT PRIMARY KEY IDENTITY,
	oltp_id INT UNIQUE NOT NULL,
	cliente INT REFERENCES Operacoes.Cliente,
	moradaEntrega INT REFERENCES Operacoes.Morada,
	moradaFacturacao INT REFERENCES Operacoes.Morada,
	tipoServico TINYINT REFERENCES Operacoes.TipoServico,
	dataRequisicao INT REFERENCES Operacoes.Data,
	horaRequisicao TINYINT REFERENCES Operacoes.Hora,
	dataConclusao INT REFERENCES Operacoes.Data,
	horaConclusao TINYINT REFERENCES Operacoes.Hora,
	horaEntrega TINYINT REFERENCES Operacoes.Hora,
	numeroEntregas INT NOT NULL, -- count( Entregas)
	valor Decimal(8,2), -- Pagamento.Valor usando Entrega.servicoid = servico.servicoid  and entrega.entregaid= tipo.entregaid
	--rmiranda:nao faz sentido, nao mesuravel--tipoPagamento VARCHAR(50),-- Pagamento.Valor usando Entrega.servicoid = servico.servicoid  and entrega.entregaid= tipo.entregaid
	dentroDoSLA TINYINT, --Entrega.Sucesso and dataTentativa <= servico.dataRequisicao + horaEntrega + 2:00; 0-> NÂO, 1->SIM
	concluido TINYINT NOT NULL -- entrega.sucesso. dataTentativa, 0 -> não conlcuido, ou com insucesso, 1 -> concluido com sucesso
);
	
	
CREATE TABLE Operacoes.Entregas
(
	keycol INT PRIMARY KEY IDENTITY,
	oltp_id INT UNIQUE NOT NULL,
	servico INT REFERENCES Operacoes.Servicos,
	estafeta INT REFERENCES Operacoes.Funcionario,
	dataTentativa INT REFERENCES Operacoes.Data,
	horaTentativa TINYINT REFERENCES Operacoes.Hora,
	sucesso TINYINT NOT NULL -- 0 -> insucesso, 1 -> sucesso
);



/* cria os registos para a dimensao */

DECLARE
  @basedate DATETIME,
  @offset   INT,    --day
  @enddate	DATETIME
SELECT
  @basedate = '01 Jan 2010',
  @offset = 1,
  @enddate = '01 Jan 2014'

SET LANGUAGE Portuguese
WHILE (@basedate < @enddate)
BEGIN
  INSERT INTO Operacoes.Data(keycol, data, ano, trimestre, mes,
       descricaoMes, diaSemana, 
       descricaoDiaSemana, dia) 
  VALUES (CAST( @basedate AS INT) ,@basedate,Year(@basedate),DATEPART(quarter,@basedate),Month(@basedate),
        DATENAME(month,@basedate),DATEPART(weekday, @basedate),DATENAME(weekday,@basedate),DAY(@basedate))
  SELECT @basedate = DATEADD(DAY, @offset, @basedate)
END
--rmiranda: Inserir valor representativo de data nula
  declare @maxdateid int;
  select @maxdateid = max(keycol) , @basedate = '01/01/1753'
  from Operacoes.Data
  INSERT INTO Operacoes.Data(keycol, data, ano, trimestre, mes,
       descricaoMes, diaSemana, 
       descricaoDiaSemana, dia) 
  VALUES (@maxdateid+1 ,@basedate,Year(@basedate),DATEPART(quarter,@basedate),Month(@basedate),
        DATENAME(month,@basedate),DATEPART(weekday, @basedate),DATENAME(weekday,@basedate),DAY(@basedate))
  SELECT @basedate = DATEADD(DAY, @offset, @basedate)



/*
*   Helper databases
*/
IF OBJECT_ID('MonthDescr') IS NOT NULL
	DROP TABLE MonthDescr;

CREATE TABLE MonthDescr
(
	keycol TINYINT PRIMARY KEY,	
	nome VARCHAR(15) NOT NULL
);

INSERT INTO MonthDescr VALUES(1,N'Janeiro')
INSERT INTO MonthDescr VALUES(2,N'Fevereiro')
INSERT INTO MonthDescr VALUES(3,N'Março')
INSERT INTO MonthDescr VALUES(4,N'Abril')
INSERT INTO MonthDescr VALUES(5,N'Maio')
INSERT INTO MonthDescr VALUES(6,N'Junho')
INSERT INTO MonthDescr VALUES(7,N'Julho')
INSERT INTO MonthDescr VALUES(8,N'Agosto')
INSERT INTO MonthDescr VALUES(9,N'Setembro')
INSERT INTO MonthDescr VALUES(10,N'Outubro')
INSERT INTO MonthDescr VALUES(11,N'Novembro')
INSERT INTO MonthDescr VALUES(12,N'Dezembro')
INSERT INTO MonthDescr VALUES(0,N'????')


IF OBJECT_ID('DiaSemanaDescr') IS NOT NULL
	DROP TABLE DiaSemanaDescr;
CREATE TABLE DiaSemanaDescr
(
	keycol TINYINT PRIMARY KEY,	
	nome VARCHAR(15) NOT NULL
);

INSERT INTO DiaSemanaDescr VALUES(1,N'Domingo')
INSERT INTO DiaSemanaDescr VALUES(2,N'Segunda-Feira')
INSERT INTO DiaSemanaDescr VALUES(3,N'Terça-Feira')
INSERT INTO DiaSemanaDescr VALUES(4,N'Quarta-Feira')
INSERT INTO DiaSemanaDescr VALUES(5,N'Quinta-Feira')
INSERT INTO DiaSemanaDescr VALUES(6,N'Sexta-Feira')
INSERT INTO DiaSemanaDescr VALUES(7,N'Sábado')
INSERT INTO DiaSemanaDescr VALUES(0,N'????')

INSERT INTO Operacoes.HORA VALUES(0, N'00:00',N'00:00 AM' )
INSERT INTO Operacoes.HORA VALUES(1, N'01:00',N'01:00 AM' )
INSERT INTO Operacoes.HORA VALUES(2, N'02:00',N'02:00 AM' )
INSERT INTO Operacoes.HORA VALUES(3, N'03:00',N'03:00 AM' )
INSERT INTO Operacoes.HORA VALUES(4, N'04:00',N'04:00 AM' )
INSERT INTO Operacoes.HORA VALUES(5, N'05:00',N'05:00 AM' )
INSERT INTO Operacoes.HORA VALUES(6, N'06:00',N'06:00 AM' )
INSERT INTO Operacoes.HORA VALUES(7, N'07:00',N'07:00 AM' )
INSERT INTO Operacoes.HORA VALUES(8, N'08:00',N'08:00 AM' )
INSERT INTO Operacoes.HORA VALUES(9, N'09:00',N'09:00 AM' )
INSERT INTO Operacoes.HORA VALUES(10, N'10:00',N'10:00 AM' )
INSERT INTO Operacoes.HORA VALUES(11, N'11:00',N'11:00 AM' )
INSERT INTO Operacoes.HORA VALUES(12, N'12:00',N'12:00 AM' )
INSERT INTO Operacoes.HORA VALUES(13, N'13:00',N'01:00 PM' )
INSERT INTO Operacoes.HORA VALUES(14, N'14:00',N'02:00 PM' )
INSERT INTO Operacoes.HORA VALUES(15, N'15:00',N'03:00 PM' )
INSERT INTO Operacoes.HORA VALUES(16, N'16:00',N'04:00 PM' )
INSERT INTO Operacoes.HORA VALUES(17, N'17:00',N'05:00 PM' )
INSERT INTO Operacoes.HORA VALUES(18, N'18:00',N'06:00 PM' )
INSERT INTO Operacoes.HORA VALUES(19, N'19:00',N'07:00 PM' )
INSERT INTO Operacoes.HORA VALUES(20, N'20:00',N'08:00 PM' )
INSERT INTO Operacoes.HORA VALUES(21, N'21:00',N'09:00 PM' )
INSERT INTO Operacoes.HORA VALUES(22, N'22:00',N'10:00 PM' )
INSERT INTO Operacoes.HORA VALUES(23, N'23:00',N'11:00 PM' )
INSERT INTO Operacoes.HORA VALUES(24, N'NA',N'NA' )--RMIRANDA, EXISTEM SERVICOS COM horaEntrega a null, para esses será esta a dimensão


RAISERROR('... OK',0,1) --info
COMMIT

/* NOTAS sobre Impacto das alteracoes e o processo de actualizacao:

Processo de presquisa: 
	Obtem o NOW() da base de dados de origem 
	Para cada tabela contra data de alteração > ultima actualizacao e <= NOW()
	Producao update ou insert e contabiliza a agregacao  em funcao da tabela(s) de destino
	Guarda o valor de NOW() em ultima actualizacao

Funcao			
Funcionario
Pessoa
Morada
Cliente
InfoDemografica
TipoServico
Servico
Entrega(*)
      (*) dataTentativa
as restantes o acesso é controlado e vai buscar o que for

*/