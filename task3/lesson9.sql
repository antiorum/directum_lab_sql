create procedure StudyChangeCity
	@personType bit,
	@personId int,
	@newCity varchar(50),
	@oldCity varchar(50) output
as
	if @personType = 0
		begin
			select @oldCity = city from Customers where cnum = @personId
			update Customers set city = @newCity where cnum = @personId
		end
	else
		begin
			select @oldCity = city from Salespeople where snum = @personId
			update Salespeople set city = @newCity where snum = @personId
		end
go
--------------
declare @cityOldValue varchar(50);
exec StudyChangeCity 0, 2003, 'Vo1tkinsk', @cityOldValue Output

print @cityOldValue
