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

--������������ ������ pk_onam

DBCC SHOWCONTIG ('dbo.Orders')

drop index Orders.idx_cnum
drop index Orders.idx_snum

exec sp_helpindex Orders

--*********************--
--4
select o.odate, c.cname from Orders as o
inner loop join Customers as c on c.cnum = o .cnum

select o.odate, c.cname from Orders as o
inner merge join Customers as c on c.cnum = o .cnum

select o.odate, c.cname from Orders as o
inner hash join Customers as c on c.cnum = o .cnum