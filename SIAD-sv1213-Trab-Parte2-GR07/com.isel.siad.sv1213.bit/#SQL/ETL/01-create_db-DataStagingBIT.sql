/*
*	ISEL-ADEETC-MEIC
* 	SIAD2012/2013N -Ver�o
*	Grupo 8, Abril de 2013
*
*	Projecto BIT
*        Cria��o das tabelas DW �rea de Stagging
*   v0 -2013.04.27
*   v1 -2013.05 (tabelas da financeira)
*   v2 -2013.05 (schema financeiro, nome tabela financeira, scd)
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
	keycol INT PRIMARY KEY IDENTITY,--keycol TINYINT PRIMARY KEY IDENTITY, --PROBLEMA: SSAS Converte para INT!
	oltp_id TINYINT UNIQUE NOT NULL,
	tipo  VARCHAR(50) NOT NULL	 --TipoServico.tipo
);
/* carregamento:
    Tipo de Servico, com base na data de alteracao
*/

/* FF: nao � preciso 
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

CREATE TABLE [Operacoes].[Cliente](
	[keycol] [int] IDENTITY(1,1) NOT NULL,
	[oltp_id] [int] NOT NULL,
	[designacao] [varchar](100) NOT NULL,
	[nomeContacto] [varchar](50) NOT NULL,
	[sobrenomeContacto] [varchar](50) NOT NULL,
	[singular] [char](1) NOT NULL,
	[cPostal] [varchar](4) NOT NULL,
	[activo] [char](1) NOT NULL,
	[BirthDate] [datetime] NULL,
	[IntervaloIdadeID] [int] NOT NULL,
	[IntervaloIdadeMinimo] [int] NOT NULL,
	[IntervaloIdadeMaximo] [int] NOT NULL,
	[IntervaloIdade] [varchar](50) NOT NULL,
	[IntervaloIdadeNome] [varchar](50) NOT NULL,
	[MaritalStatus] [varchar](150) NULL,
	[YearlyIncome] [varchar](150) NULL,
	[RendimentoID] [int] NOT NULL,
	[IntervaloRendimentoCodigo] [varchar](50) NOT NULL,
	[IntervaloRendimentoClasse] [varchar](50) NOT NULL,
	[Gender] [varchar](150) NULL,
	[TotalChildren] [varchar](150) NULL,
	[NumberChildrenAtHome] [varchar](150) NULL,
	[Education] [varchar](150) NULL,
	[Occupation] [varchar](150) NULL,
	[HomeOwnerFlag] [varchar](150) NULL,
	[NumberCarsOwned] [varchar](150) NULL,
	[dataInicio] [datetime] NULL,
	[dataFim] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[keycol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
	--[keycol] [int] IDENTITY(1,1) NOT NULL,
	--[valorMinimo] int NOT NULL,
	--[valorMaximo] int NOT NULL,
	--[intervalo] [varchar](50) NOT NULL,
	--[nome] [varchar](50) NOT NULL
/* carregamento:
    base tabela de cliente, join pessoa
      com filtro por dataAlter
      RM: e tamb�m InfoDemografica.dataAlter?

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

CREATE TABLE [Operacoes].[IntervaloRendimento](
	[keycol] [int] IDENTITY(1,1) NOT NULL,
	[SalaryTypeXML] [varchar](50) NOT NULL,
	[codigo] [varchar](50) NOT NULL,
	[classe] [varchar](50) NOT NULL
PRIMARY KEY CLUSTERED 
(
	[keycol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE [Operacoes].[IntervaloIdade](
	[keycol] [int] IDENTITY(1,1) NOT NULL,
	[valorMinimo] int NOT NULL,
	[valorMaximo] int NOT NULL,
	[intervalo] [varchar](50) NOT NULL,
	[nome] [varchar](50) NOT NULL
PRIMARY KEY CLUSTERED 
(
	[keycol] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE Operacoes.Servicos
(
	keycol INT PRIMARY KEY IDENTITY,
	oltp_id INT UNIQUE NOT NULL,
	cliente INT REFERENCES Operacoes.Cliente,
	moradaEntrega INT REFERENCES Operacoes.Morada,
	moradaFacturacao INT REFERENCES Operacoes.Morada,
	tipoServico INT REFERENCES Operacoes.TipoServico,--tipoServico TINYINT REFERENCES Operacoes.TipoServico,--PROBLEMA: SSAS Converte Operacoes.TipoServico.keycol para INT!
	dataRequisicao INT REFERENCES Operacoes.Data,
	horaRequisicao TINYINT REFERENCES Operacoes.Hora,
	dataConclusao INT REFERENCES Operacoes.Data,
	horaConclusao TINYINT REFERENCES Operacoes.Hora,
	horaEntrega TINYINT REFERENCES Operacoes.Hora,
	intervaloRendimentoCliente INT REFERENCES Operacoes.IntervaloRendimento,
	intervaloIdadeCliente INT REFERENCES Operacoes.IntervaloIdade,
	numeroEntregas INT NOT NULL, -- count( Entregas)
	valor Decimal(8,2), -- Pagamento.Valor usando Entrega.servicoid = servico.servicoid  and entrega.entregaid= tipo.entregaid
	--rmiranda:nao faz sentido, nao mesuravel--tipoPagamento VARCHAR(50),-- Pagamento.Valor usando Entrega.servicoid = servico.servicoid  and entrega.entregaid= tipo.entregaid
	dentroDoSLA TINYINT, --Entrega.Sucesso and dataTentativa <= servico.dataRequisicao + horaEntrega + 2:00; 0-> N�O, 1->SIM
	concluido TINYINT NOT NULL -- entrega.sucesso. dataTentativa, 0 -> n�o conlcuido, ou com insucesso, 1 -> concluido com sucesso
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
INSERT INTO Operacoes.HORA VALUES(24, N'NA',N'NA' )--RMIRANDA, EXISTEM SERVICOS COM horaEntrega a null, para esses ser� esta a dimens�o


INSERT INTO [Operacoes].[IntervaloRendimento] VALUES(N'0-25000',N'D',N'baixa')
INSERT INTO [Operacoes].[IntervaloRendimento] VALUES(N'25001-50000',N'C2',N'm�dia-baixa')
INSERT INTO [Operacoes].[IntervaloRendimento] VALUES(N'50001-75000',N'C1',N'm�dia')
INSERT INTO [Operacoes].[IntervaloRendimento] VALUES(N'75001-100000',N'B',N'm�dia-alta')
INSERT INTO [Operacoes].[IntervaloRendimento] VALUES(N'greater than 100000',N'A',N'alta')
INSERT INTO [Operacoes].[IntervaloRendimento] VALUES(N'NA',N'NA',N'NA')
GO

INSERT INTO [Operacoes].[IntervaloIdade] VALUES(0,17,N'0-17',N'adolescente')
INSERT INTO [Operacoes].[IntervaloIdade] VALUES(18,29,N'18-29',N'jovem adulto')
INSERT INTO [Operacoes].[IntervaloIdade] VALUES(30,39,N'30-39',N'adulto')
INSERT INTO [Operacoes].[IntervaloIdade] VALUES(40,64,N'40-64',N'meia idade')
INSERT INTO [Operacoes].[IntervaloIdade] VALUES(65,150,N'65-150',N'senior')
INSERT INTO [Operacoes].[IntervaloIdade] VALUES(-1,-1,N'NA',N'NA')
GO


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
INSERT INTO MonthDescr VALUES(3,N'Mar�o')
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
INSERT INTO DiaSemanaDescr VALUES(3,N'Ter�a-Feira')
INSERT INTO DiaSemanaDescr VALUES(4,N'Quarta-Feira')
INSERT INTO DiaSemanaDescr VALUES(5,N'Quinta-Feira')
INSERT INTO DiaSemanaDescr VALUES(6,N'Sexta-Feira')
INSERT INTO DiaSemanaDescr VALUES(7,N'S�bado')
INSERT INTO DiaSemanaDescr VALUES(0,N'????')
GO

/* schema/tabelas para o processo financeiro 
*/

CREATE SCHEMA Financeiro;
GO

CREATE TABLE Financeiro.Meses
(
	keycol INT PRIMARY KEY IDENTITY,
	ano INT NOT NULL,
	trimestre TINYINT NOT NULL,
	mes TINYINT NOT NULL,
	descricaoMes VARCHAR(15) NOT NULL
);

CREATE TABLE Financeiro.Rubrica
(
	keycol INT PRIMARY KEY IDENTITY,
	classe VARCHAR(15) NOT NULL, -- pode ser Proveito ou Custo
	nome VARCHAR(50) NOT NULL  -- nome da rubrica: Servicos, Material, Financeiro, Outros
);

CREATE TABLE Financeiro.Resultados
(
	keycol INT IDENTITY,
	meses INT REFERENCES Financeiro.Meses,
	rubrica INT REFERENCES Financeiro.Rubrica,
	valor DECIMAL( 10,2) NOT NULL
 CONSTRAINT [PK_Resultados] PRIMARY KEY CLUSTERED 
(
    [keycol] ASC
),
CONSTRAINT [UQ_Resultados] UNIQUE NONCLUSTERED
(
    [meses], [rubrica], [valor]
)
) ON [PRIMARY]

INSERT INTO Financeiro.Rubrica VALUES( 'Proveito', 'Servicos')
INSERT INTO Financeiro.Rubrica VALUES( 'Custo', 'Material')
INSERT INTO Financeiro.Rubrica VALUES( 'Custo', 'Financeiro')
INSERT INTO Financeiro.Rubrica VALUES( 'Custo', 'Salarios')
INSERT INTO Financeiro.Rubrica VALUES( 'Custo', 'Outros')

insert into Financeiro.Meses (ano, trimestre, mes, descricaoMes) 
select ano, trimestre, mes, descricaoMes
  from Operacoes.Data
 where dia =1 and ano > 2000;


RAISERROR('... OK',0,1) --info
COMMIT

/* NOTAS sobre Impacto das alteracoes e o processo de actualizacao:

Processo de presquisa: 
	Obtem o NOW() da base de dados de origem 
	Para cada tabela contra data de altera��o > ultima actualizacao e <= NOW()
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
as restantes o acesso � controlado e vai buscar o que for

*/