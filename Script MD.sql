create table Client (
    idClient serial primary key,
    lastName varchar(255) not null,
    firstName varchar(255) not null,
    patronymic varchar(255)
);

create table Service (
    idService serial primary key,
    nameService varchar(255) not null,
    price numeric(10, 2) not null,
    description varchar(255)
);

create table Status (
    idStatus serial primary key,
    nameStatus varchar(255) not null
);

create table Category (
    idCategory serial primary key,
    nameCategory varchar(255) not null
);

create table NumberFund (
    idNumberFund serial primary key,
    floorNumber int not null,
    roomNumber varchar(50) not null,
    categoryId int not null,
    foreign key (categoryId) references Category(idCategory),
    statusId int not null,
    foreign key (statusId) references Status(idStatus),
    price numeric(10, 2) not null
);

create table RoleEmployee (
    idRole serial primary key,
    nameRole varchar(255) not null
);

create table Employee (
    idEmployee serial primary key,
    login varchar(255) not null UNIQUE,
    passwordEmployee varchar(255) not null,
    roleId int not null,
    foreign key (roleId) references RoleEmployee(idRole),
    lastName varchar(255) not null,
    firstname varchar(255) not null,
    patronymic varchar(255)
);

create table CleaningSchedule (
    idCleaningSchedule serial primary key,
    cleaningDate timestamp not null,
    employeeId int not null,
    foreign key (employeeId) references Employee(idEmployee),
    numberFundId int not null,
    foreign key (numberFundId) references NumberFund(idNumberFund)
);

create table Booking  (
    idBooking serial primary key,
    clientId int not null,
    foreign key (clientId) references Client(idClient),
    numberFundId int not null,
    foreign key (numberFundId) references NumberFund(idNumberFund),
    checkInDate date,
    checkOutDate date,
    statusId int not null,
    foreign key (statusId) references Status(idStatus)
);

create table Request (
    idRequest serial primary key,
    statusId int not null,
    foreign key (statusId) references Status(idStatus),
    employeeId int not null,
    foreign key (employeeId) references Employee(idEmployee),
    commentRequest varchar(255),
    bookingId int not null,
    foreign key (bookingId) references Booking(idBooking),
    serviceId int not null,
    foreign key (serviceId) references Service(idService)
);

insert into Category (nameCategory) values
	 ('Одноместный стандарт'),
	 ('Одноместный эконом'),
	 ('Стандарт двухместный с 2 раздельными кроватями'),
	 ('Эконом двухместный с 2 раздельными кроватями'),
	 ('3-местный бюджет'),
	 ('Бизнес с 1 или 2 кроватями'),
	 ('Двухкомнатный двухместный стандарт с 1 или 2 кроватями'),
	 ('Люкс с 2 двуспальными кроватями'),
	 ('Студия');
	
insert into Status (nameStatus) values 
	('Занят'),
	('Чистый'),
	('Грязный'),
	('Назначен к уборке');
	
insert into NumberFund (floorNumber, roomNumber, categoryId, statusId, price) values
	 (1, '101', 1, 1, 1000.00),
	 (1, '102', 1, 1, 1000.00),
	 (1, '103', 2, 2, 1000.00),
	 (1, '104', 2, 1, 1000.00),
	 (1, '105', 3, 1, 1000.00),
	 (1, '106', 3, 2, 1000.00),
	 (1, '107', 4, 1, 1000.00),
	 (1, '108', 4, 1, 1000.00),
	 (1, '109', 5, 1, 1000.00),
	 (1, '110', 5, 1, 1000.00),
	 (2, '201', 6, 1, 1000.00),
	 (2, '202', 6, 2, 1000.00),
	 (2, '203', 6, 1, 1000.00),
	 (2, '204', 7, 4, 1000.00),
	 (2, '205', 7, 1, 1000.00),
	 (2, '206', 7, 1, 1000.00),
	 (2, '207', 1, 1, 1000.00),
	 (2, '208', 1, 1, 1000.00),
	 (2, '209', 1, 1, 1000.00),
	 (3, '301', 9, 3, 1000.00),
	 (3, '302', 9, 3, 1000.00),
	 (3, '303', 9, 2, 1000.00),
	 (3, '304', 8, 1, 1000.00),
	 (3, '305', 8, 2, 1000.00),
	 (3, '306', 8, 1, 1000.00);
	
insert into client (lastname, firstname, patronymic) values
	 ('Шевченко','Ольга','Викторовна'),
	 ('Мазалова', 'Ирина', 'Львовна'),
	 ('Семеняка', 'Юрий', 'Геннадьевич'),
	 ('Савельев', 'Олег', 'Иванович'),
	 ('Бунин', 'Эдуард', 'Михайлович'),
	 ('Бахшиев', 'Павел', 'Иннокентьевич'),
	 ('Тюренкова', 'Наталья', 'Сергеевна'),
	 ('Любяшева', 'Галина', 'Аркадьевна'),
	 ('Александров', 'Петр', 'Константинович'),
	 ('Мазалова', 'Ольга', 'Николаевна'),
	 ('Лапшин', 'Виктор', 'Романович'),
	 ('Гусев', 'Семен', 'Петрович'),
	 ('Гладилина', 'Вера', 'Михайловна'),
	 ('Масюк', 'Динара', 'Викторовна'),
	 ('Лукин', 'Илья', 'Федорович'),
	 ('Петров', 'Станислав', 'Игоревич'),
	 ('Филь', 'Марина', 'Федоровна'),
	 ('Михайлов', 'Игорь', 'Вадимович');

insert into RoleEmployee (nameRole) values ('Администратор');

insert into employee (login, passwordEmployee, roleid, lastname, firstname, patronymic) values
('admin', 'admin123', 1, 'Admin', 'Admin', 'Admin');
	
insert into booking (clientid, numberfundid, checkindate, checkoutdate, statusid) values 
(1, 1, '2025-02-14', '2025-03-02', 1),
(2, 2, '2025-02-28', null, 1),
(3, 4, '2025-02-23', '2025-02-25', 1),
(4, 5, '2025-03-01', '2025-03-07', 1),
(5, 7, '2025-02-27', '2025-04-22', 1),
(6, 7, '2025-02-24', '2025-03-17', 1),
(7, 8, '2025-02-15', '2025-03-20', 1),
(8, 9, '2025-02-27', '2025-03-12', 1),
(9, 10, '2025-02-14', '2025-02-16', 1),
(10, 11, '2025-02-24', '2025-03-17', 1),
(11, 13, '2025-02-25', '2025-03-07', 1),
(12, 15, '2025-03-01', '2025-03-04', 1),
(13, 16, '2025-02-02', '2025-02-04', 1),
(14, 17, '2025-02-25', '2025-03-04', 1),
(15, 18, '2025-02-25', '2025-03-04', 1),
(16, 19, '2025-02-27', null, 1),
(17, 22, '2025-02-28', '2025-03-15', 1),
(18, 24, '2025-02-11', null, 1);


SELECT
    round((count(*) filter (where statusId = 1) * 100.0 / count(*)), 0) || '%' as "Процент загрузки номерного фонда"
FROM
    numberfund;



