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

SELECT * FROM Orders, Customers

SELECT * FROM Orders, Customers
WHERE Orders.CustomerId = Customers.Id

SELECT Customers.FirstName, Products.ProductName, Orders.CreatedAt 
FROM Orders, Customers, Products
WHERE Orders.CustomerId = Customers.Id AND Orders.ProductId=Products.Id

--Inner join

SELECT Orders.CreatedAt, Orders.ProductCount, Products.ProductName 
FROM Orders
JOIN Products ON Products.Id = Orders.ProductId

SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName 
FROM Orders
JOIN Products ON Products.Id = Orders.ProductId
JOIN Customers ON Customers.Id=Orders.CustomerId
WHERE Products.Price < 45000
ORDER BY Customers.FirstName

SELECT Orders.CreatedAt, Customers.FirstName, Products.ProductName 
FROM Orders
JOIN Products ON Products.Id = Orders.ProductId AND Products.Manufacturer='Apple'
JOIN Customers ON Customers.Id=Orders.CustomerId
ORDER BY Customers.FirstName

--OUTER JOIN

SELECT FirstName, CreatedAt, ProductCount, Price, ProductId 
FROM Orders LEFT JOIN Customers 
ON Orders.CustomerId = Customers.Id

SELECT FirstName, CreatedAt, ProductCount, Price 
FROM Customers LEFT JOIN Orders 
ON Orders.CustomerId = Customers.Id

SELECT FirstName, CreatedAt, ProductCount, Price, ProductId 
FROM Orders RIGHT JOIN Customers 
ON Orders.CustomerId = Customers.Id

SELECT Customers.FirstName, Orders.CreatedAt, 
       Products.ProductName, Products.Manufacturer
FROM Orders 
LEFT JOIN Customers ON Orders.CustomerId = Customers.Id
LEFT JOIN Products ON Orders.ProductId = Products.Id
WHERE Products.Price < 45000
ORDER BY Orders.CreatedAt

SELECT Customers.FirstName, Orders.CreatedAt, 
       Products.ProductName, Products.Manufacturer
FROM Orders 
JOIN Products ON Orders.ProductId = Products.Id AND Products.Price < 45000
LEFT JOIN Customers ON Orders.CustomerId = Customers.Id
ORDER BY Orders.CreatedAt

-- Join with group
SELECT FirstName, COUNT(Orders.Id)
FROM Customers JOIN Orders 
ON Orders.CustomerId = Customers.Id
GROUP BY Customers.Id, Customers.FirstName;

SELECT Products.ProductName, Products.Manufacturer, 
        SUM(Orders.ProductCount * Orders.Price) AS Units
FROM Products LEFT JOIN Orders
ON Orders.ProductId = Products.Id
GROUP BY Products.Id, Products.ProductName, Products.Manufacturer

