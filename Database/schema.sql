Create extension "pgcrypto";

Create table Customers (
	customerId Integer, 
	name varchar(100),
	accumulatedPoints Integer default '0' not null,
	usedPoints Integer default '0' not null,
	beginMonth Integer default '1' check(beginMonth >= 1 and beginMonth <= 12) not null,
	cardDetails varchar(200), 
	primary key (customerId),
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
	foreign key (orderId) references Order (orderId), 
	foreign key (restaurantId) references Restaurant (restaurantId), 
	foreign key (riderId) references DeliveryRiders (riderId)
);

Create table Last_5_Dest (
	customerId Integer,
	latest varchar(100) not null,
	second_latest varchar(100),
	third_latest varchar(100),
	fourth_latest varchar(100),
	oldest varchar(100),
	primary key (customerId),
	foreign key (customerId) references Customer(customerId) on delete cascade
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
	foreign key (managerId) references Employees(employeeId) on delete cascade
);

Create table DeliveryRiders (
	riderId Integer,

	review varchar(200) references Reviews,
	DeliveryFee integer not null default 5,
	primary key (riderId),
	foreign Key (riderId) references Employees(employeeId) on delete cascade
);

Create table FullTimer (
	riderId Integer references DeliveryRiders on delete cascade, 
	monthNum Integer,
	workdayStart Integer,
	workdayEnd Integer,
	shiftNum Integer,
	baseSalary Integer not null default 1700,
	primary key (riderId, monthNum)
);

Create table PartTimer (
	riderId Integer references DeliveryRiders on delete cascade,
	day Integer,
	startHour Integer,
	endHour Integer,
	weekNum Integer,
	baseSalary Integer not null default 100,
	primary key (riderId, day, startHour, endHour, weekNum)
);


Create table Shift (
	shiftNum Integer
		Check (shiftNum in (1,2,3,4)),
);

Create table Promotion (
	promotionId uuid default gen_random_uuid(),
	startDate date not null,
	endDate date not null,
	discountPerc integer
		Check ((discount > 0) and (discount <= 100)),
	discountAmt integer	
		Check (discountAmt > 0),
	primary key (promotionId)	
);
	
Create table FdsPromotion (
	promotionId Integer,
	Primary key (promotionId),
	Foreign key (promotionId) references Promotion on delete cascade
);

Create table RestaurantPromotion (
	promotionId Integer,
	restaurantId Integer,
	Primary key (promotionId),
	Foreign key (promotionId) references Promotion,
	Foreign key (restaurantId) references Restaurant
);

Create table Restaurant (
	restaurantId Integer,
	area varchar(200),
	name varchar(100),
	minSpendingAmt integer default ‘0’ not null
	primary key (restaurantId)
);
	
Create table Menu (
	restaurantId Integer,
	itemId Integer,
	itemName varchar(100) not null,
	price double not null check (price > 0),
	category varchar(100) not null,
	availability boolean,
	dailyLimit integer default ‘100’ not null,
	Primary key (restaurantId, itemId),
	Foreign key (restaurantId) references Restaurant(restaurantId) on delete cascade
);

Create table Order (
	orderId Integer,
	riderId Integer,
	restaurantId Integer,
	dateOfOrder date not null,
	timeOfOrder time not null,
	deliveryLocationArea varchar(50),
	totalCost double,
	departureTimeToRestaurant time,
	arrivialTimeAtRestaurant time,
	departureTimeToDestination time,
	arrivalTimeAtDestination time,
	Primary key (orderId),
	Foreign key (riderId) references DeliveryRiders(riderId) on delete cascade,
	Foreign key (restaurantId) references Restaurant(restaurantId) on delete cascade
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
	Primary key (orderId, itemId),
	Foreign key (orderId) references Order(orderId) on delete cascade,
	Foreign key (itemId) references Menu(itemId) on delete cascade,
	Foreign key (FdsPromotionId) references FdsPromotion(FdsPromotionId) on delete cascade,
	Foreign key (restaurantPromotionId) references Order(restaurantPromotionId) on delete cascade
);
