
CREATE TABLE Category (
    CategoryId SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Status (
    StatusId SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE RoomFund (
    RoomFundId SERIAL PRIMARY KEY,
    Floor INTEGER NOT NULL,
    RoomNumber VARCHAR(50) NOT NULL,
    CategoryId INTEGER REFERENCES Category(CategoryId),
    StatusId INTEGER REFERENCES Status(StatusId),
    Price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE Client (
    ClientId SERIAL PRIMARY KEY,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    MiddleName VARCHAR(255)
);

CREATE TABLE Role (
    RoleId SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL
);

CREATE TABLE Employee (
    EmployeeId SERIAL PRIMARY KEY,
    Login VARCHAR(255) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleId INTEGER REFERENCES Role(RoleId),
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    MiddleName VARCHAR(255)
);

CREATE TABLE CleaningSchedule (
    CleaningScheduleId SERIAL PRIMARY KEY,
    CleaningDate TIMESTAMP NOT NULL,
    EmployeeId INTEGER REFERENCES Employee(EmployeeId),
    RoomFundId INTEGER REFERENCES RoomFund(RoomFundId)
);

CREATE TABLE Service (
    ServiceId SERIAL PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Cost NUMERIC(10, 2) NOT NULL,
    Description TEXT
);

CREATE TABLE Booking  (
    BookingId SERIAL PRIMARY KEY,
    ClientId INTEGER REFERENCES Client(ClientId),
    RoomFundId INTEGER REFERENCES RoomFund(RoomFundId),
    CheckInDate DATE ,
    CheckOutDate DATE ,
    StatusId INTEGER REFERENCES Status(StatusId)
);

CREATE TABLE Request (
    RequestId SERIAL PRIMARY KEY,
    StatusId INTEGER REFERENCES Status(StatusId),
    EmployeeId INTEGER REFERENCES Employee(EmployeeId),
    Comment TEXT,
    BookingId INTEGER REFERENCES Booking(BookingId),
    ServiceId INTEGER REFERENCES Service(ServiceId)
);

INSERT INTO public.category ("name") VALUES
	 ('Одноместный стандарт'),
	 ('Одноместный эконом'),
	 ('Стандарт двухместный с 2 раздельными кроватями'),
	 ('Эконом двухместный с 2 раздельными кроватями'),
	 ('3-местный бюджет'),
	 ('Бизнес с 1 или 2 кроватями'),
	 ('Двухкомнатный двухместный стандарт с 1 или 2 кроватями'),
	 ('Люкс с 2 двуспальными кроватями'),
	 ('Студия');

	
	INSERT INTO public.roomfund (floor,roomnumber,categoryid,statusid,price) VALUES
	 (1,'101',1,1,1000.00),
	 (1,'102',1,1,1000.00),
	 (1,'103',2,2,1000.00),
	 (1,'104',2,1,1000.00),
	 (1,'106',3,2,1000.00),
	 (1,'105',3,1,1000.00),
	 (1,'107',4,1,1000.00),
	 (1,'108',4,1,1000.00),
	 (1,'109',5,1,1000.00),
	 (1,'110',5,1,1000.00);
INSERT INTO public.roomfund (floor,roomnumber,categoryid,statusid,price) VALUES
	 (2,'201',6,1,1000.00),
	 (2,'202',6,2,1000.00),
	 (2,'203',6,1,1000.00),
	 (2,'205',7,1,1000.00),
	 (2,'206',7,1,1000.00),
	 (2,'204',7,3,1000.00),
	 (2,'207',1,1,1000.00),
	 (2,'208',1,1,1000.00),
	 (3,'301',9,4,1000.00),
	 (3,'302',9,4,1000.00);
INSERT INTO public.roomfund (floor,roomnumber,categoryid,statusid,price) VALUES
	 (2,'209',1,1,1000.00),
	 (3,'304',8,1,1000.00),
	 (3,'303',9,2,1000.00),
	 (3,'306',8,1,1000.00),
	 (3,'305',8,2,1000.00);

INSERT INTO public.client (lastname,firstname,middlename) VALUES
	 ('Шевченко','Ольга','Викторовна'),
	 ('Тюренкова ','Наталья','Сергеевна'),
	 ('Мазалова','Ольга','Львовна'),
	 ('Семеняка','Юрий','Геннадьевич'),
	 ('Савельев','Олег','Иванович'),
	 ('Бунин ','Эдуард','Михайлович'),
	 ('Александров ','Петр','Константинович'),
	 ('Любяшева','Галина','Акадьевна'),
	 ('Лапшин','Виктор','Романович'),
	 ('Гусев','Семен','Петрович');
INSERT INTO public.client (lastname,firstname,middlename) VALUES
	 ('Гладилина','Вера','Михайловна'),
	 ('Масюк ','Динара','Викторовна'),
	 ('Лукин','Илья','Федорович'),
	 ('Филь','Марина','Федеровна'),
	 ('Михайлов','Михайлов','Вадимович'),
	 ('Петров','Станислав','Игоревич');


SELECT 
  COALESCE(ROUND(
    SUM(CheckOutDate - CheckInDate) * 100.0 / 
    (COUNT(DISTINCT RoomFund.RoomFundId) * (MAX(CheckOutDate) - MIN(CheckInDate) + 1)), 2
  ), 0) AS load_percentage
FROM Booking
JOIN RoomFund ON Booking.RoomFundId = RoomFund.RoomFundId
WHERE RoomFund.StatusId = (SELECT StatusId FROM Status WHERE Name = 'Занят'); 

--zapasnoii
SELECT
    round((COUNT(*) FILTER (WHERE is_rent = true) * 100.0 / COUNT(*)), 0) as percent_unfree
FROM
    rooms_2;


