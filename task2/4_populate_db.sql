use directumlabdb;

insert into Customers values
('Nagibator', 'Super', '9000', 'Moscow'),
('Валерий', 'Котов', 'Эдуардович', 'London'),
('Иванов', 'Иван', 'Иваныч', 'Moscow'),
('Путин', 'Владимир', 'Владимирович', 'Moscow'),
('Sam', 'Breadford', 'John', 'London')

insert into Sellers values
('Боря', 'Иванов', 'Николаич', 'Moscow', 12),
('John', 'Smit', 'Samuel', 'London', 14),
('test', 'test', 'test', 'Ufa', 666);

insert into Orders values
('Пивас', 56, DEFAULT, 1, 1),
('Дом с баней', 34524687, DEFAULT, 3, 1),
('Tea with lemon', 1.22, DEFAULT, 2, 2),
('Guinness', 4.5, DEFAULT, 5, 2),
('Газета', 42, DEFAULT, 3, 1),
('ЖОлтая Нива', 420000, DEFAULT, 4, 1),
('Золотой унитаз', 444259897, DEFAULT, 4, 1)

delete from Orders where id in (1, 2)

update Orders set Description = 'just thing' where id in (3, 4)

insert into Orders values                     -- will not affected
('Another thing', 42, DEFAULT, 1, 2),
('Hell thing', 666, DEFAULT, 1, 1)



