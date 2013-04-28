select * 
from
	Pessoa as p
inner join
	Funcionario as f on f.FuncionarioId = p.PessoaId
inner join
	Cliente as c on c.ClienteId = p.PessoaId