select 
	sal.meses_id
	, rub.keycol as rubrica_id
	, sal.salarios as salarios
from 
	DataStagingBIT.Operacoes.Rubrica rub
	,(
		select 
			m.keycol as meses_id
			, SUM(salarioBase) as salarios
		from 
			BIT.dbo.Funcao fu
			, BIT.dbo.Funcionario fc
			, DataStagingBIT.Operacoes.Meses m
		where 
			not (
				fc.dataAlter <
				CAST(
					CAST(m.ano AS VARCHAR(4)) +
					RIGHT('0' + CAST(m.mes AS VARCHAR(2)), 2) +
					'01' 
				 AS DATETIME)
				and ISNULL(fc.activo,0) =0
			)
		group by m.keycol
	) sal
where rub.nome='Salarios'
