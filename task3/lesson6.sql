create index idx_cnum
on Orders(cnum)

exec sp_helpindex Orders

create index idx_snum
on Orders(snum)

exec sp_helpindex Orders

go
set statistics io on
select * from orders

go
set statistics io off
select * from orders

--используется индекс pk_onam

DBCC SHOWCONTIG ('dbo.Orders')

drop index Orders.idx_cnum
drop index Orders.idx_snum

exec sp_helpindex Orders