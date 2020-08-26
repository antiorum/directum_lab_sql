use directumlabdb;

GO
CREATE PROCEDURE GetOrdersByCity
    @city NVARCHAR(200)	
AS
SELECT * FROM Orders WHERE SellerId in (SELECT DISTINCT Id FROM Sellers WHERE City = @city)

GO
CREATE VIEW SellersInfo AS
SELECT s.Id as Id,
		s.LastName as LastName,
		s.FirstName as FirstName,
		s.MiddleName as MiddleName,
		s.CommissionPercentage as CommissionPercentage,
		(s.CommissionPercentage/100 * o.OrdersSumm) as ComissionSumm
from
	Sellers as s,
	(select SellerId, SUM(Summ) as OrdersSumm from Orders group by SellerId) as o 
	where s.Id = o.SellerId