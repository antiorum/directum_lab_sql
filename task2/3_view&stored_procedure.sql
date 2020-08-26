use directumlabdb;

GO
CREATE PROCEDURE GetOrdersByCity
    @city NVARCHAR(200)	
AS
SELECT * FROM Orders WHERE SellerId in (SELECT DISTINCT Id FROM Sellers WHERE City = @city)

GO
CREATE VIEW SellersInfo AS
SELECT
	s.Id as Id,
	s.LastName as LastName,
	s.FirstName as FirstName,
	s.MiddleName as MiddleName,
	s.CommissionPercentage as CommissionPercentage,
	(s.CommissionPercentage/100 * SUM(o.Summ)) as ComissionSumm
from
	Sellers as s left join Orders as o 
on
	s.Id = o.SellerId
group by
	s.CommissionPercentage, s.FirstName, s.MiddleName, s.LastName, s.Id