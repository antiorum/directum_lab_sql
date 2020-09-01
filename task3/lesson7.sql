create view dbo.OrdNameView
as
select c.cname, s.sname, o.amt, o.odate
from Orders o
inner join Customers c
on o.cnum = c.cnum
inner join Salespeople s
on o.snum = s.snum

select * from OrdNameView

exec sp_helptext OrdNameView

exec sp_depends OrdNameView

exec sp_depends Orders
exec sp_depends Customers
