SELECT       
	m.keycol AS meses_id
	, r.keycol AS rubrica_id
	, p.Proveito AS proveito
FROM            
	Operacoes.Meses AS m 
INNER JOIN(
	SELECT        
		YEAR(dataConclusao) AS Ano
		, MONTH(dataConclusao) AS Mes
		, SUM(valor) AS Proveito
	FROM            
		Operacoes.Servicos
	GROUP BY YEAR(dataConclusao), MONTH(dataConclusao)
) AS p ON m.mes = p.Mes AND m.ano = p.Ano 
CROSS JOIN
	Operacoes.Rubrica AS r
WHERE        
	(r.nome = 'Servicos')