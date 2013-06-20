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

USE [BIT];

GO
BEGIN TRAN
IF  EXISTS (SELECT 'x' from [BIT].[dbo].StagingInfo where dataActualizacao > '01 Jan 1970' )
	BEGIN
		-- limpa as tabelas temporárias
	  RAISERROR('A remover as tabelas de  BIT ...',0,1); --info
		Drop Table [BIT].[dbo].Loja
		Drop Table [BIT].[dbo].Funcionario
		Drop Table [BIT].[dbo].Funcao
		Drop Table [BIT].[dbo].Distrito
		Drop Table [BIT].[dbo].Concelho
		Drop Table [BIT].[dbo].Freguesia
		Drop Table [BIT].[dbo].TipoPagamento
		Drop Table [BIT].[dbo].TipoServico
		Drop Table [BIT].[dbo].InfoDemografica
		Drop Table [BIT].[dbo].Servico
		Drop Table [BIT].[dbo].Entrega
		Drop Table [BIT].[dbo].Pagamento
		Drop Table [BIT].[dbo].Pessoa
		Drop Table [BIT].[dbo].Morada
		Drop Table [BIT].[dbo].Cliente
		Drop Table [BIT].[dbo].CodigoPostal
		
	END

RAISERROR('A popular as tabelas fixas de  BIT ...',0,1); --info

--select * from [siad.e.ipl.pt,40022].BIT.dbo.funcao

select *  into Loja
from [siad.e.ipl.pt,40022].[BIT].[dbo].Loja

select *  into Funcionario
from [siad.e.ipl.pt,40022].[BIT].[dbo].Funcionario f
where f.FuncionarioId not in (select oltp_id from [DataStagingBIT].[Operacoes].[Funcionario])

select *  into Funcao
from [siad.e.ipl.pt,40022].[BIT].[dbo].Funcao

select *  into Distrito
from [siad.e.ipl.pt,40022].[BIT].[dbo].Distrito

select *  into Concelho
from [siad.e.ipl.pt,40022].[BIT].[dbo].Concelho

select *  into Freguesia
from [siad.e.ipl.pt,40022].[BIT].[dbo].Freguesia

select *  into TipoPagamento
from [siad.e.ipl.pt,40022].[BIT].[dbo].TipoPagamento

select *  into TipoServico
from [siad.e.ipl.pt,40022].[BIT].[dbo].TipoServico t
where t.TipoServicoId not in (select oltp_id from [DataStagingBIT].[Operacoes].[TipoServico])

select *  into Morada
from [siad.e.ipl.pt,40022].[BIT].[dbo].Morada m
where m.MoradaId not in (select oltp_id from [DataStagingBIT].[Operacoes].[Morada])

select *  into Pessoa
from [siad.e.ipl.pt,40022].[BIT].[dbo].Pessoa

select 
	ClienteId	 
	,CAST(InfoDemografica as XML) as InfoDemografica
	,dataAlter
into InfoDemografica
FROM
      OPENQUERY([siad.e.ipl.pt,40022],'
			SELECT
				ClienteId
				,Cast(InfoDemografica as Varchar(max)) as InfoDemografica
				,dataAlter
			FROM
				[BIT].[dbo].InfoDemografica'
		) a

-- o resto das actividades esta condicionado a um periodo temporal: timeUltimaActualizacao e Now
DECLARE
  @fromDate DATETIME,
  @toDate	DATETIME
SELECT
  @fromdate = dataActualizacao,
  @toDate = GETDATE()
From dbo.StagingInfo

update dbo.stagingInfo set dataActualizacao = @toDate

RAISERROR('A actualizar as tabelas variaveis ',0,1); --info


select *  into Servico
from [siad.e.ipl.pt,40022].[BIT].[dbo].Servico
where dataAlter between @fromDate and @toDate

select *  into Entrega
from [siad.e.ipl.pt,40022].[BIT].[dbo].Entrega
where dataTentativa between @fromDate and @toDate

select p.*  into Pagamento
from [siad.e.ipl.pt,40022].[BIT].[dbo].Pagamento  p, [siad.e.ipl.pt,40022].[BIT].[dbo].entrega e								
where p.EntregaId = e.EntregaId
  and  e.dataTentativa between @fromDate and @toDate


select *  into Cliente
from [siad.e.ipl.pt,40022].[BIT].[dbo].Cliente
where dataAlter between @fromDate and @toDate

select cp.*  into CodigoPostal
from [siad.e.ipl.pt,40022].[BIT].[dbo].CodigoPostal cp, [siad.e.ipl.pt,40022].[BIT].[dbo].Morada m 
where m.cp = cp.id 
  and dataAlter between @fromDate and @toDate


Commit
RAISERROR('A actualização Concluída',0,1); --info



