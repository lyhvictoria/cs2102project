Create extension IF NOT EXISTS "pgcrypto";

DROP TABLE IF EXISTS Customers CASCADE;
DROP TABLE IF EXISTS CreditCards CASCADE;
DROP TABLE IF EXISTS Reviews CASCADE;
DROP TABLE IF EXISTS Last_5_Dests CASCADE;
DROP TABLE IF EXISTS Employees CASCADE;
DROP TABLE IF EXISTS RestaurantStaff CASCADE;
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
	accumulatedPoints Integer default 0 not null,
	usedPoints Integer default 0 not null,
	beginMonth Integer default 1 Check(
		beginMonth >= 1
		and beginMonth <= 12
	) not null,
	primary key (customerId)
);

Create table CreditCards (
	customerId Integer,
	cardNumber varchar(200) not null,
	primary key (cardNumber),
	foreign key (customerId) references Customers (customerId) on delete cascade
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

Create table Restaurants (
	restaurantId Integer,
	area varchar(200),
	name varchar(100),
	minSpendingAmt Integer default 0 not null,
	primary key (restaurantId)
);

Create table Menus (
	itemId Integer not null,
	restaurantId Integer,
	itemName varchar(100) not null,
	price DOUBLE PRECISION not null Check (price > 0),
	category varchar(100) not null,
	isAvailable boolean,
	amtLeft Integer not null Check (amtLeft >= 0) default 100,
	primary key (itemId),
	foreign key (restaurantId) references Restaurants (restaurantId) on delete cascade
);

Create table Promotions (
	promotionId Integer not null,
	startDate date not null,
	endDate date not null,
	discountPerc Integer Check (
		(discountPerc >= 0)
		and (discountPerc <= 100)
	),
	discountAmt Integer Check (discountAmt >= 0),
	minimumAmtSpent Integer Check (minimumAmtSpent >= 0) default 0,
	primary key (promotionId)
);

Create table FdsPromotions (
	promotionId Integer,
	primary key (promotionId),
	foreign key (promotionId) references Promotions on delete cascade on update cascade
);

Create table RestaurantPromotions (
	promotionId Integer,
	restaurantId Integer,
	primary key (promotionId),
	foreign key (promotionId) references Promotions on delete cascade on update cascade,
	foreign key (restaurantId) references Restaurants on delete cascade
);

Create table Employees (
	employeeId Integer,
	employmentType varchar (100) Check (employmentType in ('restaurantStaff', 'manager', 'fullRider', 'partRider')),
	totalMonthlySalary Integer,
	name varchar (50),
	primary key (employeeId)
);

Create table RestaurantStaff (
	restStaffId Integer,
	restaurantId Integer,
	primary key (restStaffId),
	foreign key (restStaffId) references Employees (employeeId) on delete cascade on update cascade,
	foreign key (restaurantId) references Restaurants on delete cascade
);

Create table FdsManagers (
	managerId Integer,
	primary key (managerId),
	foreign key (managerId) references Employees (employeeId) on delete cascade on update cascade
);

Create table DeliveryRiders (
	riderId Integer,
	deliveryFee Integer not null default 5,
	primary key (riderId),
	foreign key (riderId) references Employees (employeeId) on delete cascade on update cascade
);

Create table Shifts (
	shiftNum Integer Check (shiftNum in (1, 2, 3, 4)),
	primary key (shiftNum)
);

Create table FullTimers (
	riderId Integer references DeliveryRiders on delete cascade on update cascade,
	monthNum Integer,
	workdayStart Integer Check (workdayStart in (1, 2, 3, 4, 5, 6, 7)),
	workdayEnd Integer Check (workdayEnd in (1, 2, 3, 4, 5, 6, 7)),
	shiftNum Integer references Shifts (shiftNum) on delete cascade on update cascade,
	baseSalary Integer not null default 1700,
	primary key (riderId, monthNum)
);

Create table PartTimers (
	riderId Integer references DeliveryRiders on delete cascade on update cascade,
	workDay Integer Check (workDay in (1, 2, 3, 4, 5, 6, 7)),
	startHour Integer,
	endHour Integer,
	weekNum Integer Check (weekNum in (1, 2, 3, 4)),
	baseSalary Integer not null default 100,
	primary key (riderId, workDay, startHour, endHour, weekNum)
);

Create table Orders (
	orderId Integer,
	customerId Integer,
	riderId Integer,
	restaurantId Integer,
	dateOfOrder date not null,
	timeOfOrder time not null,
	deliveryLocationArea varchar(50),
	totalCost DOUBLE PRECISION,
	departureTimeToRestaurant time,
	arrivialTimeAtRestaurant time,
	departureTimeToDestination time,
	arrivalTimeAtDestination time,
	paymentMode varchar(50) Check (paymentMode in ('Card', 'Cash')),
	primary key (orderId),
	foreign key (customerId) references Customers (customerId) on delete cascade,
	foreign key (riderId) references DeliveryRiders (riderId) on delete cascade on update cascade,
	foreign key (restaurantId) references Restaurants (restaurantId) on delete cascade on update cascade
);

Create table OrderDetails (
	orderId Integer,
	itemId Integer,
	quantity Integer,
	promotionId Integer,
	orderCost DOUBLE PRECISION,
	pointsObtained Integer,
	pointsRedeemed Integer default 0,
	primary key (orderId, itemId),
	foreign key (orderId) references Orders (orderId) on delete cascade,
	foreign key (itemId) references Menus (itemId) on delete cascade on update cascade,
	foreign key (promotionId) references Promotions (promotionId) on delete cascade on update cascade
);

Create table Reviews (
	reviewId Integer,
	orderId Integer,
	review varchar(200),
	rating Integer Check (rating in (1, 2, 3, 4, 5)),
	primary key (reviewId),
	foreign key (orderId) references Orders (orderId)
);

/* TRIGGERS */
-- Checks if order can go through
create or replace function check_isAvailable() returns trigger as $$
DECLARE currAvailAmt INTEGER;
DECLARE qtyOrdered INTEGER;

begin
	NEW.quantity = qtyOrdered;
	SELECT amtLeft as currAvailAmt
	FROM Menus
	WHERE itemId = NEW.itemId;

	if currAvailAmt - qtyOrdered < 0 then
		RETURN NULL; -- reject order (?)
	else -- update amtLeft
		UPDATE Menus M
		SET amtLeft = amtLeft - qtyOrdered
		WHERE M.itemId = NEW.itemId;

		RETURN NEW;
	end if;
end;
$$ language plpgsql;

create trigger trig_check_isAvailable
before insert or update
on OrderDetails
for each row
execute function check_isAvailable();

-- Auto sets item availibility if amtLeft changes 
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
	if NEW.pointsObtained is null then
		NEW.pointsObtain := Round(NEW.orderCost);
	end if;
	return NEW;
end;
$$ language plpgsql;

create trigger trig_insert_default_points
before insert
on OrderDetails
for each row
execute function insert_default_points();
