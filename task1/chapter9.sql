use productsdb;

-- variables
DECLARE @name NVARCHAR(20), @age INT;
SET @name='Tom';
SET @age = 18;
PRINT 'Name: ' + @name;
PRINT 'Age: ' + CONVERT(CHAR, @age);

SELECT @name, @age;

-- in queries
DECLARE @maxPrice MONEY, 
    @minPrice MONEY, 
    @dif MONEY, 
    @count INT
 
SET @count = (SELECT SUM(ProductCount) FROM Orders);
 
SELECT @minPrice=MIN(Price), @maxPrice = MAX(Price) FROM Products
 
SET @dif = @maxPrice - @minPrice;
 
PRINT '����� �������: ' + STR(@count, 5) + ' �����a(��)';
PRINT '������� ����� ������������ � ����������� �����: ' + STR(@dif)

-- another query
DECLARE @sum MONEY, @id INT, @prodid INT, @suplieName NVARCHAR(20);
SET @id=2;
 
SELECT @sum = SUM(Orders.Price*Orders.ProductCount), 
     @suplieName=Products.ProductName, @prodid = Products.Id
FROM Orders
INNER JOIN Products ON ProductId = Products.Id
GROUP BY Products.ProductName, Products.Id
HAVING Products.Id=@id
 
PRINT '����� ' + @suplieName + ' ������ �� ����� ' + STR(@sum)

-- if else
DECLARE @lastDate DATE, @productCount INT, @summ MONEY
 
SELECT @lastDate = MAX(CreatedAt), 
        @productCount = SUM(ProductCount) ,
        @summ = SUM(ProductCount * Price)
FROM Orders
 
IF @count > 0
    BEGIN
        PRINT '���� ���������� ������: ' + CONVERT(NVARCHAR, @lastDate) 
        PRINT '������� ' + CONVERT(NVARCHAR, @productCount) + ' ������(�)'
        PRINT '�� ����� ����� ' + CONVERT(NVARCHAR, @summ)
    END;
ELSE
    PRINT '������ � ���� ������ �����������'

-- cycles
DECLARE @number INT, @factorial INT
SET @factorial = 1;
SET @number = 5;
 
WHILE @number > 0
    BEGIN
        SET @factorial = @factorial * @number
        SET @number = @number - 1
    END;
 
PRINT @factorial

CREATE TABLE #Accounts ( CreatedAt DATE, Balance MONEY)
 
DECLARE @rate FLOAT, @period INT, @total MONEY, @date DATE
SET @date = GETDATE()
SET @rate = 0.065;
SET @period = 5;
SET @total = 10000;
 
WHILE @period > 0
    BEGIN
        INSERT INTO #Accounts VALUES(@date, @total)
        SET @period = @period - 1
        SET @date = DATEADD(year, 1, @date)
        SET @total = @total + (@total * @rate)
    END;
 
SELECT * FROM #Accounts
drop table #Accounts

-- + break , continue

-- TRY CATCH

if OBJECT_ID('dbo.Accounts', 'U') is not null
	drop table Accounts

CREATE TABLE Accounts (FirstName NVARCHAR NOT NULL, Age INT NOT NULL)
 
BEGIN TRY
    INSERT INTO Accounts VALUES(NULL, NULL)
    PRINT '������ ������� ���������!'
END TRY
BEGIN CATCH
    PRINT 'Error ' + CONVERT(VARCHAR, ERROR_NUMBER()) + ':' + ERROR_MESSAGE()
END CATCH