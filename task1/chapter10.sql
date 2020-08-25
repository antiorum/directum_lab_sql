use productsdb;



--go
--CREATE VIEW OrdersProductsCustomers AS
--SELECT Orders.CreatedAt AS OrderDate, 
--        Customers.FirstName AS Customer,
--        Products.ProductName As Product  
--FROM Orders INNER JOIN Products ON Orders.ProductId = Products.Id
--INNER JOIN Customers ON Orders.CustomerId = Customers.Id

--SELECT * FROM OrdersProductsCustomers

--go
--ALTER VIEW OrdersProductsCustomers
--AS SELECT Orders.CreatedAt AS OrderDate, 
--        Customers.FirstName AS Customer,
--        Products.ProductName AS Product,
--        Products.Manufacturer AS Manufacturer
--FROM Orders INNER JOIN Products ON Orders.ProductId = Products.Id
--INNER JOIN Customers ON Orders.CustomerId = Customers.Id

-- + drop view

--go
--CREATE VIEW ProductView
--AS SELECT ProductName AS Product, Manufacturer, Price
--FROM Products

--INSERT INTO ProductView (Product, Manufacturer, Price)
--VALUES('Nokia 8', 'HDC Global', 18000)

--UPDATE ProductView 
--SET Price= 15000 WHERE Product='Nokia 8'
 
-- DELETE FROM ProductView 
--WHERE Product='Nokia 8'

SELECT * FROM ProductView
select * from Products

-- TABLE VARIABLES
DECLARE @ABrends TABLE (ProductId INT,  ProductName NVARCHAR(20))
 
INSERT INTO @ABrends
VALUES(1, 'iPhone 8'),
(2, 'Samsumg Galaxy S8')
 
SELECT * FROM @ABrends;

-- Temp tables
--CREATE TABLE #ProductSummary
--(ProdId INT IDENTITY,
--ProdName NVARCHAR(20),
--Price MONEY)
 
--INSERT INTO #ProductSummary
--VALUES ('Nokia 8', 18000),
--        ('iPhone 8', 56000)
 
--SELECT * FROM #ProductSummary

--SELECT ProductId, 
--        SUM(ProductCount) AS TotalCount, 
--        SUM(ProductCount * Price) AS TotalSum
--INTO #OrdersSummary
--FROM Orders
--GROUP BY ProductId
 
--SELECT Products.ProductName, #OrdersSummary.TotalCount, #OrdersSummary.TotalSum
--FROM Products
--JOIN #OrdersSummary ON Products.Id = #OrdersSummary.ProductId;

-- derivative tables
WITH OrdersInfo AS
(
    SELECT ProductId, 
        SUM(ProductCount) AS TotalCount, 
        SUM(ProductCount * Price) AS TotalSum
    FROM Orders
    GROUP BY ProductId
)
 
SELECT * FROM OrdersInfo -- 
SELECT * FROM OrdersInfo -- error