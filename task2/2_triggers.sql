use directumlabdb;

GO
CREATE TRIGGER OrdersAfterInsert
ON Orders
AFTER INSERT
AS
	declare @insertedCount int, @sameCityCount int;
	set @insertedCount = (select count(*) from inserted)
	set @sameCityCount = (
		select count(*) from
			(select
				i.Id, s.City as SellerCity, c.City as CustomerCity
				from
					inserted as i
				join
					Sellers as s on i.SellerId = s.Id
				join
					Customers as c on i.CustomerId = c.Id) as temp
				where
					temp.SellerCity=temp.CustomerCity)
	if @insertedCount != @sameCityCount
		begin
			delete from Orders where Id in (select Id from inserted) -- or :
			-- rollback transaction
			RAISERROR('Seller and customer must be from the same city!', 16, 1)
		end
	else
		begin
			insert into OrdersHistory (OrderId, Operation, OrderDateTime, CustomerId, SellerId)
			select Id, 'INSERT', OrderDateTime, CustomerId, SellerId from inserted order by Id
		end

GO
CREATE TRIGGER OrdersAfterDelete
ON Orders
AFTER DELETE
AS
	insert into OrdersHistory (OrderId, Operation, OrderDateTime, CustomerId, SellerId)
	select Id, 'DELETE', OrderDateTime, CustomerId, SellerId from deleted order by Id

GO
CREATE TRIGGER OrdersAfterUpdate
ON Orders
AFTER UPDATE
AS
	insert into OrdersHistory (OrderId, Operation, OrderDateTime, CustomerId, SellerId)
	select Id, 'UPDATE', OrderDateTime, CustomerId, SellerId from inserted order by Id