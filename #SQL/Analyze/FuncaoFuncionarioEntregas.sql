select 
	distinct fn.Nome 
from
Entrega e
	inner join Funcionario f on e.Estafeta = f.num
	inner join Funcao fn on fn.Funcaoid = f.funcao