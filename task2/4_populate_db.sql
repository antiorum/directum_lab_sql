use directumlabdb;

insert into Customers values
('Super', 'Manager', 'Иосифович', 'Moscow'),
('Котов', 'Валерий', 'Эдуардович', 'London')

insert into Sellers values
('Боря', 'Иванов', 'Николаич', 'Moscow', 12),
('John', 'Smit', 'Samuel', 'London', 14);

insert into Orders values
('Hell thing', 666, DEFAULT, 1, 1),
('Hell thing', 666, DEFAULT, 1, 1),
('Another thing', 42, DEFAULT, 1, 2), --not affected, but it's ok, see Messages
('Paradise thing', 777, DEFAULT, 2, 2),
('Paradise thing', 777, DEFAULT, 2, 2)

delete from Orders where id = 1
update Orders set Description = 'just thing' where id = 2

