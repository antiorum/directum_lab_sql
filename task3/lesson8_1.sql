begin tran
   INSERT Salespeople (snum, sname, city, comm)
       VALUES(1099, '���������', '��������', 0.1)
   select * from Salespeople

rollback