--4.3
select sname, comm from Salespeople

--4.4
select cname, rating, city from Customers

--4.7
select distinct
	sname from Salespeople
where
	snum
in
	(select snum from Customers)

--4.9
select * from Customers where rating = 300

--4.10
select * from Orders where amt > 2000

--4.11
SET DATEFORMAT DMY
select * from Orders
where odate = '23.10.1990' and amt<1599

--4.12
select * from Customers where city='Москва'
union
select * from Customers where rating > 200

--4.13
select * from Customers where city!='Москва' and rating <= 200

--4.14
select *
	from Orders
where
	((odate = '10.03.1990' and snum < 1002) or amt < 2000)

--5.1
select * from Customers where city = 'Таллин' or city = 'Ижевск'
select * from Customers where city in ( 'Таллин', 'Ижевск')
-- какой быстрее непонятно, у меня оба по 1мс

--5.2
select * from Salespeople where comm >= 0.10 and comm <= 0.12
select * from Salespeople where comm between 0.10 and 0.12

--5.3
select * from Customers where city like 'М%'

--6
select * from Customers where snum is null

--7.1
select sum(amt) from Orders where odate < '05.10.1990'

--7.2
select min(comm) from Salespeople

--7.3
select avg(comm) from Salespeople

--7.4
select count(*) from Customers where rating < 200
select count(cnum) from Customers where rating < 200

--7.5
select distinct count(snum) from Orders

--7.6
select * from Orders where amt = (select max(amt) from Orders)

--7.7
select o.snum as id, s.sname as name, Max(o.amt) as BiggestOrder
from Orders as o
join Salespeople as s
on o.snum = s.snum
group by o.snum, s.sname

--7.8
select snum, odate, Max(amt)
	from Orders
group by 
	snum, odate

--8
select 
	snum, odate, Max(amt)
from 
	Orders
group by 
	snum, odate 
having
	Max(amt) > 1000

--9.1
select * from Customers, Salespeople where Customers.city = Salespeople.city

--9.2
select c.cname, s.city as SellerCity
from Customers as c
join Salespeople as s
on c.snum = s.snum

--9.3
select s.sname, s.comm, (s.comm * o.amt) as CommSum
from Orders as o
join Salespeople as s
on s.snum = o.snum

--10
select Table1.cname, Table2.cname, Table1.rating
from Customers Table1
JOIN Customers Table2
ON Table1.rating = Table2.rating
where Table1.cname > Table2.cname

--11.3
select * from Orders where amt > (select avg(amt) from Orders)

--12.2
select * from Orders where snum
in (select snum from Salespeople where city in ('Томск', 'Ижевск'))

--12.3
select * 
		from Salespeople s
		where (select COUNT(*)
			   from Customers c
			   where c.snum = s.snum) > 1

select *
		from Salespeople s
		where Exists (select *
					from Customers c
					where c.snum = s.snum
						group by c.snum
						having COUNT(c.snum) > 1)

-- второй запрос делает меньше чтений

--14
insert into Customers values
(2010, 'Маршалов', 'Ижевск', 120, 1004),
(2010, 'Веточкин', 'Ижевск', 130, 1001)

--14.1
insert into Salespeople values
(2010, 'Антон', 'Ижевск', 0.11)

--14.2
update Salespeople set comm = 0.17 where sname = 'Антон'

--14.3
update Customers set rating = 150 where rating < 150

--14.4
update Customers set rating = rating * 2

--14.5
delete from Customers where cname = 'Веточкин'

-- *** --

--1
select Table1.cname, Table2.cname, Table1.snum
from Customers Table1
JOIN Customers Table2
ON Table1.snum = Table2.snum
where Table1.cname > Table2.cname 

--2
update Salespeople set comm = comm * 0.9 where city = 'Ижевск' 

--3
--Позволяет извлечь из даты ее часть (например, день недели или месяц)

--4
select * into Sellers from Salespeople 
select * from Sellers

--5
select cnum, onum, sum(amt) as Summa
	from Orders 
	group by cnum, onum with rollup 
	having sum(amt) > 150 
	order by cnum 

--6
select cnum, grouping(cnum), onum, grouping(Onum), sum(amt)
	from Orders 
	group by cnum, onum with rollup 
	having sum(amt) > 150 
		order by cnum


