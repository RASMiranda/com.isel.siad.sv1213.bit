/*
*	ISEL-ADEETC-MEIC
* 	SIAD2012/2013N -Verão
*	Grupo 7, Junho de 2013
*
*	Projecto BIT
*        Criação das tabelas replica Operacional para um dado periodo temporal
*   v0 -2013.06.19
*/

SET NOCOUNT ON;
SET XACT_ABORT ON

GO
USE [master];
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'BIT')
BEGIN
  RAISERROR('A remover a base de dados BIT ...',0,1); --info
   ALTER DATABASE [BIT] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
   DROP DATABASE [BIT];

END
GO
RAISERROR('A criar a base de dados BIT ...',0,1); --info
	EXEC sp_addlinkedserver @server = 'siad.e.ipl.pt,40022'
	go
	exec sp_addlinkedsrvlogin 'siad.e.ipl.pt,40022'
		 ,@useself = 'FALSE'
		 ,@rmtuser = 'SIAD_DWCREATOR' 
		 ,@rmtpassword ='SIAD_DWCREATOR'
	go

RAISERROR('A criar a base de dados BIT ...',0,1); --info
CREATE DATABASE BIT;
GO


USE BIT;

Begin tran

CREATE TABLE dbo.StagingInfo
(
	keycol INT PRIMARY KEY IDENTITY,
	dataActualizacao DateTime 
);
INSERT INTO dbo.StagingInfo VALUES( '01 Jan 1970' ) --todos os registos para o load inicial
Commit

RAISERROR('Base de dados BIT criada',0,1); --info
