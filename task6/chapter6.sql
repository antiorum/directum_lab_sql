--drop table Customers, orders, products cascade

create table Products
(
    Id serial primary key,
    ProductName varchar(30) not null,
    Company varchar(20) not null,
    ProductCount integer default 0,
    Price numeric not null
);
create table Customers
(
    Id serial primary key,
    FirstName varchar(30) not null
);
create table Orders
(
    Id serial primary key,
    ProductId integer not null references Products(Id) on delete cascade,
    CustomerId integer not null references Customers(Id) on delete cascade,
    CreatedAt date not null,
    ProductCount integer default 1,
    Price numeric not null
);

insert into Products(ProductName, Company, ProductCount, Price)
values ('iPhone X', 'Apple', 2, 66000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 42000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8 Plus', 'Samsung', 1, 46000),
('Nokia 9', 'HDM Global', 2, 26000),
('Desire 12', 'HTC', 6, 38000);

insert into Customers(FirstName)
values ('Tom'), ('Bob'),('Sam');

insert into Orders(ProductId, CustomerId, CreatedAt, ProductCount, Price)
values
(
    (select Id from Products where ProductName='Galaxy S9'),
    (select Id from Customers where FirstName='Tom'),
    '2017-07-11',
    2,
    (select Price from Products where ProductName='Galaxy S9')
),
(
    (select Id from Products where ProductName='iPhone 8'),
    (select Id from Customers where FirstName='Tom'),
    '2017-07-13',
    1,
    (select Price from Products where ProductName='iPhone 8')
),
(
    (select Id from Products where ProductName='iPhone 8'),
    (select Id from Customers where FirstName='Bob'),
    '2017-07-11',
    1,
    (select Price from Products where ProductName='iPhone 8')
);



select * from Orders, Customers
where Orders.CustomerId = Customers.Id;

select Customers.FirstName, Products.ProductName, Orders.CreatedAt
from Orders, Customers, Products
where Orders.CustomerId = Customers.Id and Orders.ProductId=Products.Id;

select C.FirstName, P.ProductName, O.*
from Orders as O, Customers as C, Products as P
where O.CustomerId = C.Id and O.ProductId=P.Id;

select O.CreatedAt, O.ProductCount, P.ProductName
from Orders as O
join Products as P
on P.Id = O.ProductId;

select Orders.CreatedAt, Customers.FirstName, Products.ProductName
from Orders
join Products on Products.Id = Orders.ProductId and Products.Company='Apple'
join Customers on Customers.Id=Orders.CustomerId
order by Customers.FirstName;

select FirstName, CreatedAt, ProductCount, Price, ProductId
from Orders left join Customers
on Orders.CustomerId = Customers.Id;

-- INNER JOIN
select FirstName, CreatedAt, ProductCount, Price
from Customers join Orders
on Orders.CustomerId = Customers.Id;

--LEFT JOIN
select FirstName, CreatedAt, ProductCount, Price
from Customers left join Orders
on Orders.CustomerId = Customers.Id;

--full join
select FirstName, CreatedAt, ProductCount, Price, ProductId
from Orders full join Customers
on Orders.CustomerId = Customers.Id;

select Customers.FirstName, Orders.CreatedAt,
       Products.ProductName, Products.Company
from Orders
left join Customers on Orders.CustomerId = Customers.Id
left join Products on Orders.ProductId = Products.Id
where Products.Price > 55000
order by Orders.CreatedAt;

select Customers.FirstName, Orders.CreatedAt,
       Products.ProductName, Products.Company
from Orders
join Products on Orders.ProductId = Products.Id and Products.Price > 45000
left join Customers on Orders.CustomerId = Customers.Id
order by Orders.CreatedAt;

select * from Orders cross join Customers;
--equals
select * from Orders, Customers;

--with group
select Products.ProductName, Products.Company,
        sum(Orders.ProductCount * Orders.Price) as TotalSum
from Products left join Orders
on Orders.ProductId = Products.Id
group by Products.Id, Products.ProductName, Products.Company;

--select * from customers
----drop table customers cascade

CREATE TABLE Customers
(
    Id SERIAL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    AccountSum NUMERIC DEFAULT 0
);
CREATE TABLE Employees
(
    Id SERIAL PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL
);

INSERT INTO Customers(FirstName, LastName, AccountSum) VALUES
('Tom', 'Smith', 2000),
('Sam', 'Brown', 3000),
('Paul', 'Ins', 4200),
('Victor', 'Baya', 2800),
('Mark', 'Adams', 2500),
('Tim', 'Cook', 2800);

INSERT INTO Employees(FirstName, LastName) VALUES
('Homer', 'Simpson'),
('Tom', 'Smith'),
('Mark', 'Adams'),
('Nick', 'Svensson');

SELECT FirstName, LastName
FROM Customers
UNION SELECT FirstName, LastName FROM Employees;

--c повторами
SELECT FirstName, LastName
FROM Customers
UNION ALL SELECT FirstName, LastName
FROM Employees;

--сортинг по названию столбцов первой выборки
SELECT FirstName || ' ' || LastName AS FullName
FROM Customers
UNION SELECT FirstName || ' ' || LastName AS EmployeeName
FROM Employees
ORDER BY FullName;

--union одной таблицы
SELECT FirstName, LastName, AccountSum + AccountSum * 0.1 AS TotalSum
FROM Customers WHERE AccountSum < 3000
UNION SELECT FirstName, LastName, AccountSum + AccountSum * 0.3 AS TotalSum
FROM Customers WHERE AccountSum >= 3000


SELECT FirstName, LastName
FROM Customers
EXCEPT SELECT FirstName, LastName
FROM Employees;

--except
SELECT FirstName, LastName
FROM Employees
EXCEPT SELECT FirstName, LastName
FROM Customers;

--intersect
SELECT FirstName, LastName
FROM Employees
INTERSECT SELECT FirstName, LastName
FROM Customers;
