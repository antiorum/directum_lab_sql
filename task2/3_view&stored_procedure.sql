use directumlabdb;

GO
CREATE PROCEDURE GetOrdersByCity
    @city NVARCHAR(200)	
AS
SELECT * FROM Orders WHERE CustomerId in (SELECT DISTINCT Id FROM Customers WHERE City = @city)

GO
CREATE VIEW SellersInfo AS
SELECT t.Id as Id,
		t.LastName as SecondName,
		t.FirstName as FirstName,
		t.MiddleName as MiddleName,
		t.CommissionPercentage as CommissionPercentage,
		t.ComissionSumm as ComissionSumm
from
	(select s.Id, s.LastName, s.FirstName, s.MiddleName, s.CommissionPercentage, (s.CommissionPercentage/100 * o.OrdersSumm) as ComissionSumm
	from
	Sellers as s,
	(select SellerId, SUM(Summ) as OrdersSumm from Orders group by SellerId) as o 
	where s.Id = o.SellerId) as t