select 
	s. 
from 
	[BIT].[dbo].[Servico] s
left outer join 
	[BIT].[dbo].[Entrega] e 
		on e.ServicoId=s.ServicoId
where e.EntregaId is NULL