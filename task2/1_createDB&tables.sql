create database directumlabdb;

go
use directumlabdb;

create table Customers
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(200) NOT NULL,
    LastName NVARCHAR(200) NOT NULL, 
	MiddleName NVARCHAR(200) NOT NULL,
	City NVARCHAR(200) NOT NULL
)

create table Sellers
(
	Id INT PRIMARY KEY IDENTITY,
	FirstName NVARCHAR(200) NOT NULL,
    LastName NVARCHAR(200) NOT NULL, 
	MiddleName NVARCHAR(200) NOT NULL,
	City NVARCHAR(200) NOT NULL,
	CommissionPercentage DECIMAL NOT NULL
)

create table Orders
(
	Id INT PRIMARY KEY IDENTITY,
	Description NVARCHAR(4000) NOT NULL,
	Summ MONEY CHECK(Summ > 0) NOT NULL,
	OrderDateTime DATETIME NOT NULL DEFAULT GETDATE(),
	CustomerId INT NOT NULL,
	SellerId INT NOT NULL,
	CONSTRAINT FK_Orders_To_Customers FOREIGN KEY (CustomerId) REFERENCES Customers (Id),
	CONSTRAINT FK_Orders_To_Sellers FOREIGN KEY (SellerId) REFERENCES Sellers (Id)
)

create table OrdersHistory
(
	Id INT IDENTITY PRIMARY KEY,
    OrderId INT NOT NULL,
    Operation VARCHAR(20) NOT NULL,
    OperationDateTime DATETIME NOT NULL DEFAULT GETDATE(),
	OrderDateTime DATETIME NOT NULL,
	CustomerId INT NOT NULL,
	SellerId INT NOT NULL,
)


