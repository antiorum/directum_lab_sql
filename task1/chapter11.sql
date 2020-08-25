-- procedures
USE productsdb;
--GO
--CREATE PROCEDURE ProductDescription AS
--BEGIN
--    SELECT ProductName AS Product, Manufacturer, Price
--    FROM Products
--END;

exec ProductDescription

-- procedures with params

--GO
--CREATE PROCEDURE AddProduct
--    @name NVARCHAR(20),
--    @manufacturer NVARCHAR(20),
--    @count INT = 1, -- Необязательный параметр
--    @price MONEY
--AS
--INSERT INTO Products(ProductName, Manufacturer, ProductCount, Price) 
--VALUES(@name, @manufacturer, @count, @price)

--DECLARE @prodName NVARCHAR(20), @company NVARCHAR(20);
--DECLARE @prodCount INT, @price MONEY
--SET @prodName = 'Galaxy C7'
--SET @company = 'Samsung'
--SET @price = 22000
--SET @prodCount = 5
 
--EXEC AddProduct @prodName, @company, @prodCount, @price --equals 
--EXEC AddProduct 'Galaxy C7', 'Samsung', 5, 22000 --equals
 
SELECT * FROM Products

--output params
--GO
--CREATE PROCEDURE GetPriceStats
--    @minPrice MONEY OUTPUT,
--    @maxPrice MONEY OUTPUT
--AS
--SELECT @minPrice = MIN(Price),  @maxPrice = MAX(Price)
--FROM Products
DECLARE @minPrice MONEY, @maxPrice MONEY
 
EXEC GetPriceStats @minPrice OUTPUT, @maxPrice OUTPUT
 
PRINT 'Минимальная цена ' + CONVERT(VARCHAR, @minPrice)
PRINT 'Максимальная цена ' + CONVERT(VARCHAR, @maxPrice)

-- with return
--USE productsdb;
--GO
--CREATE PROCEDURE GetAvgPrice AS
--DECLARE @avgPrice MONEY
--SELECT @avgPrice = AVG(Price)
--FROM Products
--RETURN @avgPrice;

DECLARE @result MONEY
 
EXEC @result = GetAvgPrice
PRINT 'avg: ' + CONVERT(VARCHAR, @result)