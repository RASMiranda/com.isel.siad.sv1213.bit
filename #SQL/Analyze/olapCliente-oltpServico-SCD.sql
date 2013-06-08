SELECT DISTINCT
	  c.oltp_id as oltp_id
	, c.keycol as keycol
	, c.IntervaloIdadeID as IntervaloIdadeID
	, c.RendimentoID as RendimentoID
  FROM 
	[DataStagingBIT].[Operacoes].[Cliente] c
  WHERE 
	c.dataFim is NULL --Vamos sempre buscar o cliente mais recente

--SELECT DISTINCT
--	  c.oltp_id as oltp_id
--	, c.keycol as keycol
--	, c.IntervaloIdadeID as IntervaloIdadeID
--	, c.RendimentoID as RendimentoID
--  FROM 
--	[BIT].[dbo].[Servico] s 
--	--ATENCAO: BD BIT e DataStagingBIT tem que estar na mesma instancia SQL Server (ToDo Pre-ETL: Copia (selectiva?) do OLTP e só aí correr o ETL)
--  INNER JOIN
--	[DataStagingBIT].[Operacoes].[Cliente] c
--		ON c.oltp_id = s.ClienteId
--  WHERE 
--	c.dataFim is NULL --Vamos sempre buscar o cliente mais recente



--SELECT 
--	--distinct s.ServicoId --467
--	--934
--	c.keycol Cliente_olap_keycol,c.oltp_id Cliente_oltp_id,c.dataInicio Cliente_olap_InicioSCD,c.dataFim Cliente_olap_FimSCD
--	,s.Servicoid Servico_oltp_id,s.ClienteId Servico_Cliente_oltp_id
--	,s.dataAlter Servico_oltp_Alteracao,s.dataConclusao Servico_oltp_Conclusao,s.dataRequisicao Servico_oltp_Requisicao
--  FROM 
--	[BIT].[dbo].[Servico] s
--  INNER JOIN
--	[DataStagingBIT].[Operacoes].[Cliente] c
--		ON c.oltp_id = s.ClienteId
--  WHERE 
--	---c.oltp_id = 2 
--	--AND s.Servicoid = 90123 AND 
--	((s.dataRequisicao between c.dataInicio and c.dataFim)
--			OR c.dataFim is NULL
--	)
--GO


