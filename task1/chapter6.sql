USE productsdb;
 
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL 
  DROP TABLE dbo.Orders;

IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL 
  DROP TABLE dbo.Products;

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL 
  DROP TABLE dbo.Customers;

CREATE TABLE Products
(
    Id INT IDENTITY PRIMARY KEY,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
);
CREATE TABLE Customers
(
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(30) NOT NULL
);
CREATE TABLE Orders
(
    Id INT IDENTITY PRIMARY KEY,
    ProductId INT NOT NULL REFERENCES Products(Id) ON DELETE CASCADE,
    CustomerId INT NOT NULL REFERENCES Customers(Id) ON DELETE CASCADE,
    CreatedAt DATE NOT NULL,
    ProductCount INT DEFAULT 1,
    Price MONEY NOT NULL
);

INSERT INTO Products 
VALUES ('iPhone 6', 'Apple', 2, 36000),
('iPhone 6S', 'Apple', 2, 41000),
('iPhone 7', 'Apple', 5, 52000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000),
('Mi 5X', 'Xiaomi', 2, 26000),
('OnePlus 5', 'OnePlus', 6, 38000)
 
INSERT INTO Customers VALUES ('Tom'), ('Bob'),('Sam')
 
INSERT INTO Orders 
VALUES
( 
    (SELECT Id FROM Products WHERE ProductName='Galaxy S8'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-11',  
    2, 
    (SELECT Price FROM Products WHERE ProductName='Galaxy S8')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone 6S'), 
    (SELECT Id FROM Customers WHERE FirstName='Tom'),
    '2017-07-13',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
),
( 
    (SELECT Id FROM Products WHERE ProductName='iPhone 6S'), 
    (SELECT Id FROM Customers WHERE FirstName='Bob'),
    '2017-07-11',  
    1, 
    (SELECT Price FROM Products WHERE ProductName='iPhone 6S')
)

SELECT *
FROM Products
WHERE Price = (SELECT MIN(Price) FROM Products)

SELECT *
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)

SELECT CreatedAt, 
        Price, 
        (SELECT ProductName FROM Products 
        WHERE Products.Id = Orders.ProductId) AS Product
FROM Orders

SELECT ProductName,
       Manufacturer,
       Price, 
        (SELECT AVG(Price) FROM Products AS SubProds 
         WHERE SubProds.Manufacturer=Prods.Manufacturer)  AS AvgPrice
FROM Products AS Prods
WHERE Price > 
    (SELECT AVG(Price) FROM Products AS SubProds 
     WHERE SubProds.Manufacturer=Prods.Manufacturer)

SELECT *
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products)

SELECT * FROM CUSTOMERS
WHERE Id NOT IN (SELECT CustomerId FROM Orders)

SELECT * FROM Products
WHERE Price < ALL(SELECT Price FROM Products WHERE Manufacturer='Apple')

SELECT * FROM Products
WHERE Price < ANY(SELECT Price FROM Products WHERE Manufacturer='Apple')

SELECT *, 
(SELECT ProductName FROM Products WHERE Id=Orders.ProductId) AS Product 
FROM Orders

--UPDATE Orders
--SET ProductCount = ProductCount + 2
--WHERE CustomerId=(SELECT Id FROM Customers WHERE FirstName='Tom')

--UPDATE Orders
--SET Price = (SELECT Price FROM Products WHERE Id=Orders.ProductId) + 2000
--WHERE Id=1

--DELETE FROM Orders
--WHERE ProductId=(SELECT Id FROM Products WHERE ProductName='Galaxy S8')
--AND CustomerId=(SELECT Id FROM Customers WHERE FirstName='Bob')

SELECT *
FROM Customers
WHERE EXISTS (SELECT * FROM Orders 
                  WHERE Orders.CustomerId = Customers.Id)

SELECT *
FROM Products
WHERE NOT EXISTS (SELECT * FROM Orders WHERE Products.Id = Orders.ProductId)