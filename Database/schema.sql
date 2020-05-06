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

/* TRIGGERS */
-- Checks if order can go through
create or replace function check_isAvailable() returns trigger as $$
DECLARE currAvailAmt INTEGER;
DECLARE qtyOrdered INTEGER;

begin
	qtyOrdered := NEW.quantity;

	SELECT amtLeft into currAvailAmt
	FROM Menus M
	WHERE M.itemName = NEW.itemName
	AND M.restaurantId = NEW.restaurantId;

	if NEW.quantity > currAvailAmt then
		RAISE NOTICE 'Exceed Daily Limit';
		RETURN NULL; -- reject order
	else -- update amtLeft
		UPDATE Menus M
		SET amtLeft = amtLeft - qtyOrdered
		WHERE M.itemName = NEW.itemName
		AND M.restaurantId = NEW.restaurantId;

		RETURN NEW;
	end if;
end;
$$ language plpgsql;

create trigger trig_check_isAvailable
before insert or update
on OrderDetails
for each row
execute function check_isAvailable();

-- Auto sets item availability if amtLeft changes
create or replace function update_isAvailable() returns trigger as $$
begin
	if NEW.amtLeft = 0 then
		UPDATE Menus
		SET isAvailable = false;
	end if;
	RETURN NEW;
end;
$$ language plpgsql;

create trigger trig_update_isAvailable
after insert or update
on Menus
for each row
execute function update_isAvailable();

-- Auto add rewards points
create or replace function insert_default_points() returns trigger as $$
begin
	Update Customers C
	Set C.rewardPoints = C.rewardPoints + Trunc(NEW.orderCost)
	Where C.customerId = NEW.customerId;
	RETURN NULL;
end;
$$ language plpgsql;

create trigger trig_insert_default_points
after insert
on OrderDetails
for each row
execute function insert_default_points();

--Calculate total costs of order for every item added
Create or replace function add_total_costs() returns trigger as $$
Declare price_to_add Numeric;

begin
	price_to_add := NEW.orderCost;

	Update Orders
	Set totalCost = totalCost + price_to_add
	Where Orders.orderId = NEW.orderId;

	RETURN NEW;
end;
$$ language plpgsql;


Create trigger calculate_total_costs_trigger
After update or insert
on OrderDetails
For each row
Execute function add_total_costs();

-- Calculate orderCosts of order details from quantity & price
Create or replace function add_order_costs returns trigger as $$
Declare item_price Numeric;

Begin
	Select M.price as item_price
	From Menus M
	Where M.restaurantId = NEW.restaurantId
	And M.itemName = NEW.itemName;

	Update OrderDetails
	Set orderCost = item_price * NEW.quantity
	Where OrderDetails.orderId = NEW.orderId;

	Return NEW;
End;
$$ language plpgsql;

Drop trigger if exists calculate_order_costs on OrderDetails cascade;
Create trigger calculate_order_costs trigger
After update or insert on OrderDetails
For each row
Execute function add_order_costs();
