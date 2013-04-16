use BIT;
declare @clientetot int,@infodemograficatot int, @clientecominfodemografica int, @clienteseminfodemografica int;
select @clientetot=COUNT(*) from cliente;
select @infodemograficatot=COUNT(*) from infodemografica;

select @clientecominfodemografica=COUNT(*) 
from cliente e inner join infodemografica p on p.clienteId = e.clienteId;

select @clienteseminfodemografica=COUNT(*) 
from cliente
where clienteId not in (select clienteId from infodemografica);

select	@clientetot clientetot
		,@infodemograficatot infodemograficatot
		, @clientecominfodemografica clientecominfodemografica
		, @clienteseminfodemografica clienteseminfodemografica
		, @clientecominfodemografica+@clienteseminfodemografica
;