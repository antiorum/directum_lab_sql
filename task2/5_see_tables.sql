use directumlabdb;

select * from Customers
select * from Sellers
select * from Orders
SELECT * FROM OrdersHistory

select * from SellersInfo
exec GetOrdersByCity @city = 'London'