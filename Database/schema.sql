Create extension IF NOT EXISTS "pgcrypto";

DROP TABLE IF EXISTS Users CASCADE;
DROP TABLE IF EXISTS Customers CASCADE;
DROP TABLE IF EXISTS CreditCards CASCADE;
DROP TABLE IF EXISTS Areas CASCADE;
DROP TABLE IF EXISTS Restaurants CASCADE;
DROP TABLE IF EXISTS Menus CASCADE;
DROP TABLE IF EXISTS Promotions CASCADE;
DROP TABLE IF EXISTS RestaurantPromotions CASCADE;
DROP TABLE IF EXISTS RestaurantStaff CASCADE;
DROP TABLE IF EXISTS DeliveryRiders CASCADE;
DROP TABLE IF EXISTS FullTime CASCADE;
DROP TABLE IF EXISTS PartTime CASCADE;
DROP TABLE IF EXISTS WorkingDays CASCADE;
DROP TABLE IF EXISTS ShiftOptions CASCADE;
DROP TABLE IF EXISTS WorkingWeeks CASCADE;
DROP TABLE IF EXISTS Orders CASCADE;
DROP TABLE IF EXISTS OrderDetails CASCADE;
DROP TABLE IF EXISTS Delivers CASCADE;
DROP TABLE IF EXISTS Reviews CASCADE;
DROP TABLE IF EXISTS Last_5_Dests CASCADE;

CREATE TABLE Users (
	uid INTEGER GENERATED ALWAYS AS IDENTITY,
	name VARCHAR(100) NOT NULL,
	username VARCHAR(100) NOT NULL,
	password VARCHAR(100) NOT NULL,
	type VARCHAR(100) NOT NULL CHECK(
		type IN (
			'Customer',
			'FDSManager',
			'RestaurantStaff',
			'DeliveryRider'
		)
	),
	PRIMARY key (uid)
);

CREATE TABLE Customers (
	customerId INTEGER,
	rewardPoints INTEGER DEFAULT 0 NOT NULL,
	startDate DATE DEFAULT CURRENT_DATE NOT NULL,
	PRIMARY key (customerId),
	FOREIGN key (customerId) REFERENCES Users (uid) ON DELETE CASCADE
);

CREATE TABLE CreditCards (
	customerId INTEGER,
	cardNumber VARCHAR(200) NOT NULL,
	PRIMARY key (customerId, cardNumber),
	FOREIGN key (customerId) REFERENCES Customers (customerId) ON DELETE CASCADE
);

CREATE TABLE Areas (
	area VARCHAR(200) NOT NULL CHECK (
		area IN (
			'North',
			'East',
			'South',
			'West',
			'Central'
		)
	),
	PRIMARY key (area)
);

CREATE TABLE Restaurants (
	restaurantId INTEGER,
	area VARCHAR(200),
	name VARCHAR(200),
	minSpendingAmt INTEGER DEFAULT 0 NOT NULL,
	PRIMARY key (restaurantId),
	FOREIGN key (area) REFERENCES Areas (area)
);

CREATE TABLE Menus (
	restaurantId INTEGER,
	itemName VARCHAR(100) NOT NULL,
	price NUMERIC NOT NULL CHECK (price > 0),
	category VARCHAR(100) NOT NULL,
	isAvailable BOOLEAN NOT NULL,
	amtLeft INTEGER NOT NULL CHECK (amtLeft >= 0) DEFAULT 100,
	PRIMARY key (restaurantId, itemName),
	FOREIGN key (restaurantId) REFERENCES Restaurants (restaurantId) ON DELETE CASCADE
);

CREATE TABLE Promotions (
	promotionId INTEGER,
	type VARCHAR(100) NOT NULL CHECK (type IN ('FDSpromo', 'Restpromo')),
	startDate DATE NOT NULL,
	endDate DATE NOT NULL,
	discountPerc INTEGER CHECK (
		(discountPerc >= 0)
		AND (discountPerc <= 100)
	),
	discountAmt INTEGER CHECK (discountAmt >= 0),
	minimumAmtSpent INTEGER CHECK (minimumAmtSpent >= 0) DEFAULT 0,
	PRIMARY key (promotionId),
	CHECK (startDate < endDate)
);

CREATE TABLE RestaurantPromotions (
	promotionId INTEGER,
	restaurantId INTEGER,
	PRIMARY key (promotionId),
	FOREIGN key (promotionId) REFERENCES Promotions ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN key (restaurantId) REFERENCES Restaurants ON DELETE CASCADE
);

CREATE TABLE RestaurantStaff (
	restStaffId INTEGER,
	restaurantId INTEGER,
	PRIMARY key (restStaffId),
	FOREIGN key (restStaffId) REFERENCES Users (uid) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN key (restaurantId) REFERENCES Restaurants ON DELETE CASCADE
);

CREATE TABLE DeliveryRiders (
	riderId INTEGER,
	type VARCHAR(100) NOT NULL CHECK (type IN ('FullTime', 'PartTime')),
	deliveryFee INTEGER NOT NULL DEFAULT 5,
	PRIMARY key (riderId),
	FOREIGN key (riderId) REFERENCES Users (uid) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE PartTime (
	riderId INTEGER PRIMARY KEY,
	weeklyBasePay NUMERIC NOT NULL DEFAULT 100,
	FOREIGN KEY (riderId) REFERENCES DeliveryRiders(riderId) ON DELETE CASCADE
);

CREATE TABLE FullTime (
	riderId INTEGER PRIMARY KEY,
	monthlyBasePay INTEGER NOT NULL DEFAULT 1800,
	FOREIGN KEY (riderId) REFERENCES DeliveryRiders(riderId) ON DELETE CASCADE
);

CREATE TABLE WorkingDays ( 	-- Part Timer
	riderId INTEGER,
	workDate DATE NOT NULL,
	intervalStart TIME NOT NULL,
	intervalEnd TIME NOT NULL,
	numCompleted INTEGER DEFAULT 0,
	PRIMARY KEY (
		riderId,
		workDate,
		intervalStart,
		intervalEnd
	),
	FOREIGN KEY (riderId) REFERENCES PartTime(riderId) ON DELETE CASCADE,
	CHECK (intervalEnd > intervalStart),
	CHECK (intervalStart>='10:00:00' and intervalEnd<='22:00:00'),
	CHECK (CAST(CONCAT(CAST(EXTRACT(HOUR from intervalStart) AS VARCHAR),':00:00') AS TIME)=intervalStart),
	CHECK (CAST(CONCAT(CAST(EXTRACT(HOUR from intervalEnd) AS VARCHAR),':00:00') AS TIME)=intervalEnd),
	CHECK ((EXTRACT(HOUR FROM intervalEnd) - EXTRACT(HOUR FROM intervalStart))< 5)
);

CREATE TABLE ShiftOptions (
	shiftId INTEGER CHECK (shiftId IN (1, 2, 3, 4)),
	shiftDetail1 VARCHAR(30) NOT NULL,
	shiftDetail2 VARCHAR(30) NOT NULL,
	PRIMARY KEY (shiftID)
);

CREATE TABLE WorkingWeeks ( -- Full Timer
	riderId INTEGER,
	workDate DATE NOT NULL,
	shiftID INTEGER NOT NULL,
	numCompleted INTEGER DEFAULT 0,
	PRIMARY KEY (riderId, workDate),
	FOREIGN KEY (riderId) REFERENCES FullTime ON DELETE CASCADE,
	FOREIGN KEY (shiftId) REFERENCES ShiftOptions(shiftId)
);

CREATE TABLE Orders (
	orderId INTEGER,
	customerId INTEGER,
	DATE DATE DEFAULT CURRENT_DATE NOT NULL,
	deliveryLocation VARCHAR(50),
	deliveryLocationArea VARCHAR(50),
	totalCost NUMERIC DEFAULT 0 NOT NULL,
	promotionId INTEGER DEFAULT NULL,
	departureTimeToRestaurant TIME,
	arrivalTimeAtRestaurant TIME,
	departureTimeToDestination TIME,
	arrivalTimeAtDestination TIME,
	paymentMode VARCHAR(50) CHECK (paymentMode IN ('Card', 'Cash')),
	PRIMARY key (orderId),
	FOREIGN key (customerId) REFERENCES Customers (customerId) ON DELETE CASCADE,
	FOREIGN key (promotionId) REFERENCES Promotions (promotionId) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE OrderDetails (
	orderId INTEGER,
	restaurantId INTEGER,
	itemName VARCHAR(100) NOT NULL,
	quantity INTEGER CHECK (quantity > 0),
	orderCost NUMERIC,
	PRIMARY key (orderId, itemName),
	FOREIGN key (restaurantId) REFERENCES Restaurants (restaurantId) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN key (orderId) REFERENCES Orders (orderId) ON DELETE CASCADE deferrable initially deferred,
	FOREIGN key (restaurantId, itemName) REFERENCES Menus (restaurantId, itemName) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Delivers (
	orderId INTEGER,
	riderId INTEGER,
	rating INTEGER DEFAULT NULL CHECK (
		rating >= 0
		AND rating <= 5
	),
	PRIMARY KEY (orderID),
	FOREIGN KEY (orderID) REFERENCES Orders(orderID) ON DELETE CASCADE,
	FOREIGN KEY (riderId) REFERENCES DeliveryRiders(riderId) ON DELETE CASCADE
);

CREATE TABLE Reviews (
	orderId INTEGER,
	review VARCHAR(200),
	rating INTEGER CHECK (
		rating >= 0
		AND rating <= 5
	),
	PRIMARY key (orderId),
	FOREIGN key (orderId) REFERENCES Orders (orderId)
);

CREATE TABLE Last_5_Dests (
	customerId INTEGER,
	latest VARCHAR(100) NOT NULL,
	second_latest VARCHAR(100),
	third_latest VARCHAR(100),
	fourth_latest VARCHAR(100),
	fifth_latest VARCHAR(100),
	PRIMARY key (customerId),
	FOREIGN key (customerId) REFERENCES Customers (customerId) ON DELETE CASCADE
);