use BIT;
declare @entregatot int,@pagamentotot int, @entregacompagamento int, @entregasempagamento int;
select @entregatot=COUNT(*) from Entrega;
select @pagamentotot=COUNT(*) from Pagamento;

select @entregacompagamento=COUNT(*) 
from Entrega e inner join Pagamento p on p.EntregaId = e.EntregaId;

select @entregasempagamento=COUNT(*) 
from Entrega
where EntregaId not in (select EntregaId from Pagamento);

select	@entregatot entregatot
		,@pagamentotot pagamentotot
		, @entregacompagamento entregacompagamento
		, @entregasempagamento entregasempagamento
		, @entregacompagamento+@entregasempagamento
;