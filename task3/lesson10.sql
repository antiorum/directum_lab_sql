alter table orders add
	ocamt float not null default 0,
	osamt float not null default 0

alter table Documents add constraint dcamt_default default 0 for dcamt 
alter table Documents add constraint dsamt_default default 0 for dsamt
-----------------------------
go
CREATE TRIGGER Upd_cnum ON Customers
FOR UPDATE
AS
   declare @NumRow int
   set @NumRow = @@rowcount
   if Update(cnum) 
      begin
      if @NumRow=1
         update Orders
            set Orders.cnum=inserted.cnum
            from Orders, inserted, deleted
            where Orders.cnum=deleted.cnum 
      else
         rollback
      end

-------------------
go
CREATE TRIGGER upd_snum ON Salespeople
FOR UPDATE
AS
   declare @NumRow int
   set @NumRow = @@rowcount
   if Update(snum) 
      begin
      if @NumRow>1
         rollback
      else
         if exists(select * 
                   from deleted d 
                   join Customers c 
                   on d.snum=c.snum) or 
            exists(select * 
                   from deleted d 
                   join Orders o 
                   on d.snum=o.snum)
            rollback
      end
-----------------------
go
create trigger in_documents
on Documents
for insert
as
update o
  set ocamt = ocamt + (select sum(dcamt) from inserted i where i.onum = o.onum),
      osamt = osamt + (select sum(dsamt) from inserted i where i.onum = o.onum)
FROM Orders o 
WHERE o.onum IN (SELECT DISTINCT onum FROM inserted)

go
create trigger out_documents
on Documents
for delete
as
update o
  set ocamt = ocamt - (select sum(dcamt) from deleted d where d.onum = o.onum),
      osamt = osamt - (select sum(dsamt) from deleted d where d.onum = o.onum)
FROM Orders o 
WHERE o.onum IN (SELECT DISTINCT onum FROM deleted)
----------------------------
go
create procedure create_ReportV
as
select o.onum, 
       o.cnum, 
       o.osamt-o.ocamt as dolg, 
       (select top 1 dcamt 
           from Documents d 
           where d.onum = o.onum and dcamt > 0
           order by ddate desc) as pamt, 
       (select top 1 ddate 
           from Documents d 
           where d.onum = o.onum  and dcamt > 0
           order by ddate desc) as pdateamt, 
       o.snum
   INTO ##ReportV
   FROM Orders o

go
execute create_ReportV
select * from ##ReportV