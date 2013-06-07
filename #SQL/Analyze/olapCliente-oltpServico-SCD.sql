SELECT 
	--distinct s.ServicoId --467
	--934
	c.keycol Cliente_olap_keycol,c.oltp_id Cliente_oltp_id,c.dataInicio Cliente_olap_InicioSCD,c.dataFim Cliente_olap_FimSCD
	,s.Servicoid Servico_oltp_id,s.ClienteId Servico_Cliente_oltp_id
	,s.dataAlter Servico_oltp_Alteracao,s.dataConclusao Servico_oltp_Conclusao,s.dataRequisicao Servico_oltp_Requisicao
  FROM 
	[BIT].[dbo].[Servico] s
  INNER JOIN
	[DataStagingBIT].[Operacoes].[Cliente] c
		ON c.oltp_id = s.ClienteId
  WHERE 
	c.oltp_id = 2 
	AND s.Servicoid = 90123
	--AND s.dataRequisicao between c.dataInicio and c.dataFim
	
GO


