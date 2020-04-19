Create extension "pgcrypto";

DROP TABLE IF EXISTS Customers CASCADE;
DROP TABLE IF EXISTS CreditCards CASCADE;
DROP TABLE IF EXISTS Reviews CASCADE;
DROP TABLE IF EXISTS Last_5_Dests CASCADE;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS FDSManagers CASCADE;
DROP TABLE IF EXISTS DeliveryRiders CASCADE;
DROP TABLE IF EXISTS FullTimers CASCADE;
DROP TABLE IF EXISTS PartTimers CASCADE;
DROP TABLE IF EXISTS Shifts CASCADE;
DROP TABLE IF EXISTS Promotions CASCADE;
DROP TABLE IF EXISTS FdsPromotions CASCADE;
DROP TABLE IF EXISTS RestaurantPromotions CASCADE;
DROP TABLE IF EXISTS Restaurants CASCADE;
DROP TABLE IF EXISTS Menus CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS OrderDetails CASCADE;


Create table Customers (
	customerId Integer,
	first_name varchar(100),
	last_name varchar(100),
	accumulatedPoints Integer default '0' not null,
	usedPoints Integer default '0' not null,
	beginMonth Integer default '1'
		Check(beginMonth >= 1 and beginMonth <= 12) not null,
	primary key (customerId)
);


Create table CreditCards (
	customerId Integer,
	cardNumber varchar(200) not null,
	primary key (cardNumber),
	foreign key (customerId) references Customers (customerId) on delete cascade
);


Create table Reviews (
	reviewId Integer,
	orderId Integer,
	restaurantId Integer,
	customerId Integer,
	riderId Integer,
	review varchar(200),
	rating integer,
	primary key (reviewId),
	foreign key (orderId) references Orders (orderId),
	foreign key (restaurantId) references Restaurants (restaurantId),
	foreign key (riderId) references DeliveryRiders (riderId)
);


Create table Last_5_Dests (
	customerId Integer,
	latest varchar(100) not null,
	second_latest varchar(100),
	third_latest varchar(100),
	fourth_latest varchar(100),
	fifth_latest varchar(100),
	primary key (customerId),
	foreign key (customerId) references Customers (customerId) on delete cascade
);


Create table Employees (
	employeeId Integer,
	employmentType varchar (100),
	totalMonthlySalary Integer,
	name varchar (50),
	primary key (employeeId)
);


Create table FDSManagers (
	managerId Integer,
	primary key (managerId),
	foreign key (managerId) references Employees (employeeId) on delete cascade
);


Create table DeliveryRiders (
	riderId Integer,
	review varchar(200) references Reviews,
	deliveryFee Integer not null default 5,
	primary key (riderId),
	foreign key (riderId) references Employees (employeeId) on delete cascade
);


Create table FullTimers (
	riderId Integer references DeliveryRiders on delete cascade,
	monthNum Integer,
	workdayStart Integer,
	workdayEnd Integer,
	shiftNum Integer,
	baseSalary Integer not null default 1700,
	primary key (riderId, monthNum)
);


Create table PartTimers (
	riderId Integer references DeliveryRiders on delete cascade,
	workDay Integer
		Check (workDay in (1,2,3,4,5,6,7)),
	startHour Integer,
	endHour Integer,
	weekNum Integer,
	baseSalary Integer not null default 100,
	primary key (riderId, workDay, startHour, endHour, weekNum)
);


Create table Shifts (
	shiftNum Integer
		Check (shiftNum in (1,2,3,4))
);


Create table Promotions (
	promotionId uuid default gen_random_uuid(),
	startDate date not null,
	endDate date not null,
	discountPerc Integer
		Check ((discount > 0) and (discount <= 100)),
	discountAmt Integer
		Check (discountAmt > 0),
	primary key (promotionId)	
);


Create table FdsPromotions (
	promotionId Integer,
	primary key (promotionId),
	foreign key (promotionId) references Promotions on delete cascade
);


Create table RestaurantPromotions (
	promotionId Integer,
	restaurantId Integer,
	primary key (promotionId),
	foreign key (promotionId) references Promotions on delete cascade,
	foreign key (restaurantId) references Restaurants on delete cascade
);


Create table Restaurants (
	restaurantId Integer,
	area varchar(200),
	name varchar(100),
	minSpendingAmt Integer default ‘0’ not null,
	primary key (restaurantId)
);


Create table Menus (
	restaurantId Integer,
	itemId Integer,
	itemName varchar(100) not null,
	price Double not null
		Check (price > 0),
	category varchar(100) not null,
	availability boolean,
	dailyLimit Integer default ‘100’ not null,
	primary key (restaurantId, itemId),
	foreign key (restaurantId) references Restaurants (restaurantId) on delete cascade
);


Create table Orders (
	orderId Integer,
	customerId Integer,
	riderId Integer,
	restaurantId Integer,
	dateOfOrder date not null,
	timeOfOrder time not null,
	deliveryLocationArea varchar(50),
	totalCost Double,
	departureTimeToRestaurant time,
	arrivialTimeAtRestaurant time,
	departureTimeToDestination time,
	arrivalTimeAtDestination time,
	primary key (orderId),
	foreign key (customerId) references Customers (customerId) on delete cascade,
	foreign key (riderId) references DeliveryRiders (riderId) on delete cascade,
	foreign key (restaurantId) references Restaurants (restaurantId) on delete cascade
);


Create table OrderDetails (
	orderId Integer,
	itemId Integer,
	quantity Integer,
	FdsPromotionId Integer,
	restaurantPromotionId Integer,
	cost Double,
	pointObtained Integer default CAST(cost as Integer),
	pointsRedeemed Integer default 0,
	paymentMode varchar(50),
	primary key (orderId, itemId),
	foreign key (orderId) references Orders (orderId) on delete cascade,
	foreign key (itemId) references Menus (itemId) on delete cascade,
	foreign key (FdsPromotionId) references FdsPromotions (FdsPromotionId) on delete cascade,
	foreign key (restaurantPromotionId) references Orders (restaurantPromotionId) on delete cascade
);
