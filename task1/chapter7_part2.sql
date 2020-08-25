-- Union
use usersdb

IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL 
  DROP TABLE dbo.Orders;

if OBJECT_ID('dbo.Customers', 'U') is not null
	drop table dbo.Customers;

if OBJECT_ID('dbo.Employees', 'U') is not null
	drop table dbo.Employees;

CREATE TABLE Customers
(
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
    AccountSum MONEY
);

CREATE TABLE Employees
(
    Id INT IDENTITY PRIMARY KEY,
    FirstName NVARCHAR(20) NOT NULL,
    LastName NVARCHAR(20) NOT NULL,
);
 
INSERT INTO Customers VALUES
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Mark', 'Adams', 2500),
('Paul', 'Ins', 4200),
('John', 'Smith', 2800),
('Tim', 'Cook', 2800)
 
INSERT INTO Employees VALUES
('Homer', 'Simpson'),
('Tom', 'Smith'),
('Mark', 'Adams'),
('Nick', 'Svensson')

SELECT FirstName, LastName 
FROM Customers
UNION SELECT FirstName, LastName FROM Employees

SELECT FirstName, LastName
FROM Customers
UNION ALL SELECT FirstName, LastName 
FROM Employees

-- expect
SELECT FirstName, LastName
FROM Customers
EXCEPT SELECT FirstName, LastName 
FROM Employees

SELECT FirstName, LastName
FROM Employees
EXCEPT SELECT FirstName, LastName 
FROM Customers

--intersect
SELECT FirstName, LastName
FROM Employees
INTERSECT SELECT FirstName, LastName 
FROM Customers
