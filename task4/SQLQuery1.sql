--1
select CompanyName from SalesLT.Customer where CustomerID in
(select CustomerID from SalesLT.CustomerAddress where AddressID in
(select AddressID from SalesLT.Address where City = 'Toronto'))
order by SalesLT.Customer.CompanyName
--or:
select c.CompanyName
	from SalesLT.Customer as c
join SalesLT.CustomerAddress as ca
	on c.CustomerID = ca.CustomerID
join SalesLT.Address as ad
	on ad.City = 'Toronto' and ca.AddressID = ad.AddressID
order by c.CompanyName

--2
select sum(od.OrderQty)
	from SalesLT.SalesOrderDetail as od
	where ProductID in 
		(select ProductID from SalesLT.Product where ListPrice > 1000)

--3
select c.CompanyName from SalesLT.Customer as c
	where c.CustomerID in
		(select soh.CustomerId
			from SalesLT.SalesOrderHeader as soh
			group by soh.CustomerID
			having sum(soh.TotalDue) > 50000)

--4
select distinct c.CompanyName 
	from SalesLT.Customer as c
join SalesLT.SalesOrderHeader as soh
	on soh.CustomerID = c.CustomerID
join SalesLT.SalesOrderDetail as sod 
	on soh.SalesOrderID = sod.SalesOrderID
join SalesLT.Product as p
	on p.Name like 'Racing Socks%' and p.ProductID = sod.ProductID

--5
select top 25 sod.ProductId, p.Name as ProductName, sum(sod.OrderQty * p.ListPrice) as TotalProductSales
	from SalesLT.SalesOrderDetail as sod
join SalesLT.Product as p
	on p.ProductID = sod.ProductID
group by
	sod.ProductID, p.Name
order by
	TotalProductSales desc

--6
select count(SalesOrderID) as OrdersCount, sum(TotalDue) as OrdersSumm, Diapason from
	(select SalesOrderId, TotalDue,
		CASE
	        WHEN TotalDue between 0 and 99 THEN '0...99'
			WHEN TotalDue between 100 and 999 THEN '100...999'
			WHEN TotalDue between 1000 and 9999 THEN '1000...9999'
			WHEN TotalDue > 9999 THEN '10000 and more'
			else 'unknown diapason'
	    END AS Diapason
	from SalesLT.SalesOrderHeader
	group by SalesOrderId, TotalDue) as tmp
group by Diapason

--7
select CompanyName
from
	(select c.CompanyName, '1' as grp from SalesLT.Customer as c
		where c.CompanyName like '%bike%'
	union select c.CompanyName, '2' as grp from SalesLT.Customer as
		c where c.CompanyName like '%cycle%') as temp
order by grp

--8
select top 10 a.City, sum(ct.CustomerTotal) as CityTotalSales from SalesLT.Address as a
join SalesLT.CustomerAddress as ca
	on ca.AddressID = a.AddressID
join SalesLT.Customer as c
	on ca.CustomerID = c.CustomerID
join
	(select soh.CustomerID as Id, sum(soh.TotalDue) as CustomerTotal
		from SalesLT.SalesOrderHeader as soh group by soh.CustomerID) as ct
	on c.CustomerID = ct.Id
group by
	a.City
order by
	CityTotalSales desc

	
