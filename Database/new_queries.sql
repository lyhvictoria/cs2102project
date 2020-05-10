/* Common Queries */


/* Customer Related Functionalities */
-- Get customer information
SELECT *
FROM Customers
WHERE customerId = $1
;
-- Get list of restaurants
SELECT DISTINCT restaurantId, area, name, minSpendingAmt
FROM Restaurants
ORDER BY restaurantId
;
-- Get info of restaurant selected
SELECT restaurantId, area, name, minSpendingAmt
FROM Restaurants
WHERE restaurantId = $1
;
-- View menu items for restaurant selected
SELECT DISTINCT itemName, price, category, isAvailable, amtLeft
FROM Menus
WHERE restaurantId = $1
;
-- View all the reviews of restaurant selected *
SELECT DISTINCT  O.orderDate, R.name, RV.review, RV.rating
FROM Reviews RV JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
WHERE R.name = $1
;
-- View all their past reviews *
SELECT DISTINCT O.orderDate, R.name, RV.review, RV.rating
FROM Reviews RV JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
WHERE O.customerId = $1
;
-- View the average rating of restaurant selected
SELECT Round(AVG(ALL R.rating),2) as avgRating
FROM Reviews R JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
WHERE R.name = $1
;
-- Make a review for their order
INSERT INTO Reviews (reviewId, orderId, review, rating) VALUES ($1, $2, $3, $4);

-- Add a credit card for customer
INSERT INTO CreditCards (customerId, cardNumber) VALUES ($1, $2);

-- Delete a credit card for customer
DELETE FROM CreditCards
WHERE customerId = $1 AND cardNumber = $2
;
-- Create a order
INSERT INTO Orders (customerId, orderDate, orderTime, paymentMode) VALUES ($1, $2, $3, $4);
RETURNING orderId --get the new orderId

-- Add items to order (trigger will update orderCost)
INSERT INTO OrderDetails (orderId, restaurantId, itemName, quantity) VALUES ($1, $2, $3, $4);

-- Add location to Locations
INSERT INTO CustomerLocations (custLocation, area) VALUES $1, $2

-- Add location to order
UPDATE Orders
SET deliveryLocation = $1
WHERE orderId = $1
;
-- Add a promotion to order
UPDATE Orders
SET promotionId = $2
WHERE orderId = $1;
;
-- Add departureTimeToRestaurant
UPDATE Orders
SET departureTimeToRestaurant = $2
WHERE orderId = $1
;
-- Add arrivalTimeAtRestaurant
UPDATE Orders
SET arrivalTimeAtRestaurant = $2
WHERE orderId = $1
;
-- Add departureTimeToDestination
UPDATE Orders
SET departureTimeToDestination = $2
WHERE orderId = $1
;
-- Add arrivalTimeAtDestination
UPDATE Orders
SET arrivalTimeAtDestination = $2
WHERE orderId = $1
;
-- Use rewards points, $2 is points used
UPDATE Customers
SET rewardPoints = rewardPoints - $2
WHERE customerId = $1
;
-- After customer selects payment mode
UPDATE Orders
SET paymentMode = $2
WHERE orderId = $1
;


/* Restaurant Staff Related Functionalities */
-- Get info of their restaurant
SELECT R.restaurantId, R.area, R.name, R.minSpendingAmt
FROM Restaurants R JOIN RestaurantStaff S USING (restaurantId)
WHERE S.restStaffId = $1
;
-- View menu items for their restaurant ordered by [type]
-- [type] is either price, amount left or category $2
SELECT DISTINCT M.itemName, M.price, M.category, M.isAvailable, M.amtLeft
FROM Menus M JOIN RestaurantStaff S USING (restaurantId)
WHERE S.restStaffId = $1
ORDER BY $2, M.itemName
;
-- Add a new menu item
INSERT INTO Menus (restaurantId, itemName, price, category, amtLeft) VALUES ($1, $2, $3, $4, $5);

-- Edit a menu item's name
-- $1 = old name, $2 = restaurantId, $3 = new name
UPDATE Menus
SET itemName = $3
WHERE itemName = $1 AND restaurantId = $2
;
-- Edit a menu items's price
-- $1 = itemName, $2 = restaurantId,  $3 = price
UPDATE Menus
SET price = $3
WHERE itemName = $1 AND restaurantId = $2
;
-- Edit a menu items's amount left
-- $1 = itemName, $2 = restaurantId, $3 = amount left
UPDATE Menus
SET amtLeft = $3
WHERE itemName = $1 AND restaurantId = $2
;
-- View the past reviews for their restaurant
SELECT O.orderDate, R.review, R.rating
FROM Reviews R JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
    JOIN RestaurantStaff S USING (restaurantId)
WHERE S.restStaffId = $1
;
-- Create a restaurant promotion with discount %
-- $1 = startDate, $2 = endDate, $3 = % discount, $4 = minimumAmtSpent
-- $5 = restaurantId
DECLARE newPromoId INTEGER
BEGIN
    INSERT INTO Promotions (type, startDate, endDate, discountPerc, minimumAmtSpent) VALUES ('Restpromo', $1, $2, $3, $4)
    RETURNING promotionId INTO newPromoId; --get the new promotionId

    INSERT INTO RestaurantPromotions (promotionId, restaurantId)
    SELECT newPromoId, $5;
END;
-- Create a restaurant promotion with fixed discount amount
-- $1 = startDate, $2 = endDate, $3 = discount amount, $4 = minimumAmtSpent
-- $5 = restaurantId
DECLARE newPromoId INTEGER
BEGIN
    INSERT INTO Promotions (type, startDate, endDate, discountAmt, minimumAmtSpent) VALUES ('Restpromo', $1, $2, $3, $4)
    RETURNING promotionId INTO newPromoId; --get the new promotionId

    INSERT INTO RestaurantPromotions (promotionId, restaurantId)
    SELECT newPromoId, $5;
END;
-- Edit start and end date of restaurant promotion
UPDATE Promotions
SET startDate = $2, endDate = $3
WHERE promotionId = $1
;
-- Edit discount % of restaurant promotion
UPDATE Promotions
SET discountPerc = $2
WHERE promotionId = $1
;
-- Edit discount amount of restaurant promotion
UPDATE Promotions
SET discountAmt = $2
WHERE promotionId = $1
;
-- Edit minimumAmtSpent of restaurant promotion
UPDATE Promotions
SET minimumAmtSpent = $2
WHERE promotionId = $1
;
-- View summary information for orders for specific year and month
-- 1) Total number of completed orders
-- 2) Total cost of all completed orders (excluding delivery fees)
WITH temp AS (
    SELECT DISTINCT EXTRACT(YEAR FROM (O.orderDate)) AS orderYear, EXTRACT(MONTH FROM (O.orderDate)) as orderMonth, O.orderId, O.totalCost
    FROM Orders O
    WHERE O.arrivalTimeAtDestination <> NULL --completed order
    AND O.restaurantID = $1
    AND EXTRACT(YEAR FROM (O.orderDate)) = $2 AND EXTRACT(MONTH FROM (O.orderDate)) = $3
)

SELECT orderYear, orderMonth, COUNT(orderId) AS totalCompletedOrders, SUM(totalCost) As totalCompletedCost
FROM temp
;
-- 3) Top 5 favorite food items (in terms of the number of orders for that item)
WITH TopFiveFoodItems (orderYear, orderMonth, itemName, totalOrders) AS (
    SELECT DISTINCT EXTRACT(YEAR FROM (O.orderDate)) AS orderYear, EXTRACT(MONTH FROM (O.orderDate)) as orderMonth, OD.itemName as itemName, SUM(OD.quantity) as totalOrders
    FROM OrderDetails OD JOIN Orders O USING (orderId)
    WHERE O.arrivalTimeAtDestination <> NULL --completed order
    AND OD.restaurantId = $1
    GROUP BY orderYear, orderMonth, itemName
    ORDER BY totalOrders DESC
    LIMIT 5
)

SELECT *
FROM TopFiveFoodItems
;
-- View summary information for promotions
-- 1) Duration of promotion campaign in terms of days or hours
-- 2) average number of orders received during the promotion per day or hour
WITH Duration AS (
    SELECT DISTINCT P.promotionId,
                    (endDate::date - startDate::date) as durationInDays::NUMERIC,
                    (endDate::date - startDate::date) * 24 as durationInHours::NUMERIC
    FROM RestaurantPromotions R JOIN Promotions P USING (promotionId))
    WHERE R.restaurantId = $1
    ),

    OrdersMade As (
        SELECT DISTINCT P.promotionId, COUNT(DISTINCT O.orderId) as totalOrders
        FROM RestaurantPromotions R JOIN Promotions P USING (promotionId)
            JOIN Orders O USING (promotionId)
            WHERE R.restaurantId = $1
        GROUP BY P.promotionId
    )

SELECT DISTINCT D.promotionId, totalOrders, durationInDays, durationInHours,
                CASE
                    WHEN durationInDays > 0 THEN ROUND(OM.totalOrders/durationInDays, 2)
                    ELSE 0
                    END AS avgOrdersPerDay,
                CASE
                    WHEN durationInDays = 0 AND durationInHours = 0 THEN 0
                    ELSE ROUND(OM.totalOrders/durationInHours), 2)
                    END AS aveOrdersPerHour
FROM Duration D LEFT JOIN OrdersMade OM using (promotionId)
ORDER BY OM.orderId DESC
;

/* Delivery Rider Related Functionalities */

/* view total number of orders delivered by each rider for each month and year */
/*FULL TIME*/
Select distinct FT.riderId, EXTRACT(YEAR from WW.workDate) as year, EXTRACT(MONTH from WW.workDate) as month, SUM(WW.numCompleted) as totalOrders
From  FullTime FT
Inner join WorkingWeeks WW using (riderId)
Group by FT.riderID, EXTRACT(YEAR from WW.workDate), EXTRACT(MONTH from WW.workDate)
Order by FT.riderId;

/*PART TIME*/
Select distinct PT.riderId, EXTRACT(YEAR from WD.workDate) as year, EXTRACT(MONTH  from WD.workDate) as month, SUM(WD.numCompleted) as totalOrders
From PartTime PT
Inner join WorkingDays WD using (riderId)
Group by PT.riderId, EXTRACT(YEAR from WD.workDate), EXTRACT(MONTH from WD.workDate)
Order by PT.riderId;

/*View total salary earned by each rider for each month*/
/*PartTime*/
With computePT as (
Select distinct PT.riderId as riderId,
PT.weeklyBasePay as basePay,
Extract (year from WD.workDate) as year,
Extract (month from WD.workDate) as month,
Count(distinct extract(week from WD.workDate)) as totalNumOfWeeksWorked,
Sum(WD.numCompleted) as complete
From PartTime as PT
Inner join WorkingDays WD using (riderId)
where WD.numCompleted > 0
group by PT.riderId, extract(year from WD.workdate), extract(month from WD.workDate)
)
Select DR.riderId, computePT.year as year, computePT.month as month, computePT.complete * computePT.basePay + computePT.complete * DR.deliveryFee + computePT.totalNumOfWeeksWorked * computePt.basePay as monthlyPay
From DeliveryRiders DR
Inner join computePT using (riderId)
;

/*FullTime*/
With ComputeFT as (
Select distinct FT.riderId as riderId,
FT.monthlyBasePay as basePay,
Extract(year from WW.workDate) as year,
Extract(month from WW.workDate) as month,
Sum(WW.numCompleted) as completed
From FullTime FT
Inner join WorkingWeeks WW using (riderId)
Where WW.numCompleted > 0
Group by FT.riderId, extract(year from WW.workDate), extract(month from WW.workdate)
)
Select DR.riderId, computeFT.year as year, computeFT.month as month, (DR.deliveryFee * computeFT.completed + computeFT.completed * computeFT.basePay) as monthlySalary
From DeliveryRiders DR
Inner join computeFT using (riderId)
;

/*create weekly work schedule for PartTime*/
-- $1 = riderId, $2 = workDate, $3 = IntervalStart, $4 = IntervalEnd, $5 = numCompleted

Insert into WorkingDays ($1, $2, $3, $4, $5);

/*create monthly work schedule for FullTime*/
--$1 = riderId, $2 = workDate, $3 = shiftId, $4 = numcompleted
Insert into WorkDays ($1, $2, $3, $4);

/*View the total number of hours worked for each week and month*/ - fulltime & parttime
/*Full Time*/
Select distinct FT.riderId, EXTRACT(YEAR from WW.workDate) as year, EXTRACT(MONTH from WW.workDate) as month, count(shiftID) * 8 as totalHours
From FullTime FT
Inner join WorkingWeeks WW using (riderId)
where WW.numCompleted > 0
Group by FT.riderId, EXTRACT(YEAR FROM WW.workDate), EXTRACT(MONTH FROM WW.workDate)
UNION
/*PART TIME*/
Select distinct PT.riderId, EXTRACT(YEAR from WD.workDate) as year, EXTRACT(MONTH from  WD.workDate) as month,
/*convert to minutes first then convert back to hours after adding in minutes from interval*/

TRUNC((sum(DATE_PART('hour', WD.intervalEnd - WD.intervalStart) * 60
+ DATE_PART('minute', WD.intervalEnd - WD.intervalStart))::decimal / 60), 2) as totalHours

From PartTime PT
Inner join WorkingDays WD using (riderId)
Where WD.numCompleted > 0
Group by PT.riderId, EXTRACT(YEAR from WD.workDate), EXTRACT(MONTH from WD.workDate);

/*View number of ratings received by riders for each month*/
Select distinct DR.riderId, EXTRACT(YEAR FROM O.orderDate) as year, EXTRACT(MONTH from O.orderDate) as month, count(D.rating ) as totalRatings
From DeliveryRiders DR
Left join Delivers D using (riderId)
Left join Orders O using (orderId)
Group by DR.riderId, EXTRACT(YEAR FROM O.orderDate), EXTRACT(MONTH FROM O.orderDate);



/*View average rating received for rider for each month*/ -- additional feature
Select distinct DR.riderId, EXTRACT(YEAR FROM O.orderDate) as year, EXTRACT(MONTH from O.orderDate) as month, avg(D.rating ) as averageRatings
From DeliveryRiders DR
Left join Delivers D using (riderId)
Left join Orders O using (orderId)
Group by DR.riderId, EXTRACT(YEAR FROM O.orderDate), EXTRACT(MONTH FROM O.orderDate);


/* FDS Manager Rider Related Functionalities */

/*View for each hour for each delivery location area
-- Total orders
View for each month for each rider
-- Total deliveries
-- Total man-hours
-- Total salary
-- Average rating
-- Average delivery time
For each month, can view:
-- Total number of new customers
-- Total number of orders
-- Total cost of all orders
For each month and each customer, can view:
-- Total number of orders placed by the customer
-- Total cost of all these orders
For each restaurant, can view: (?)
-- The ratings given to a specific restaurant
-- The food item that is most popular*/

-- View total orders for each delivery location area
SELECT extract(hour from o.orderTime) as Hour, COUNT(*) as TotalOrders, l.area as Area
FROM Orders o INNER JOIN CustomerLocations l ON (o.deliveryLocation = l.custLocation)
WHERE o.orderDate = $1
GROUP BY extract(hour from o.orderTime), l.custLocation
;

-- For each month, each rider.....
--View for each month, each rider, total deliveries
SELECT d.riderId, count(d.riderId), extract(month from o.orderDate), extract(year from o.orderDate)
FROM Delivers d INNER JOIN Orders o ON (d.orderId = o.orderId)
WHERE extract(month from o.orderDate) = $1 and extract(year from o.orderDate) = $2 and d.riderId = $3
GROUP BY d.riderId, extract(month from o.orderDate), extract(year from o.orderDate)
;


--View for each month, each rider, total man hours

Select FT.riderId, extract(year from WW.workDate), extract(month from WW.workDate), count(shiftId) * 8 as totalHours
From FullTime FT
Inner join WorkingWeeks WW using (riderId)
Where WW.numCompleted > 0 and FT.riderId = $1;
Group by FT.riderId, extract(year from WW.workDate), extract(month from WW.workDate)

/*PartTime*/
Select PT.riderId, extract(year from WD.workDate) as year, extract (month from  WD.workDate) as month, sum(extract(‘hour’, WD.intervalEnd – WD.intervalStart) * 60 + extract(‘minute’, WD.intervalEnd = WD.intervalStart):: decimal /60 as totalHours
From PartTime PT
Inner join WorkingDays WD using (riderId)
Where WD.numCompleted > 0 and PT.riderId = $1;
Group by PT.riderId, extract(year from WD.workDate) as year, extract (month from  WD.workDate) as month
;

--view for each month, each rider, total salary

With computeFT as (
Select FT.riderId as riderId, FT.monthlyBasePay as basePay, extract(year from WW.workDate) as year, extract(month from WW.workDate) as month, sum(WW.numcCompleted) as completed
From FullTime FT
Inner join workingWeeks WW using (riderId)
Where WW.numCompleted > 0 and riderId = $1
Group by extract(year from WW.workDate) as year, extract(month from WW.workDate) as month;
)
Select DR.riderId, computeFT.year as year, computeFT.month as month, (DR.deliveryFee * computeFT.completed + computeFT.completed * computeFT.basePay) as monthlyTotalSalary
From DeliveryRiders DR
Inner join computeFT using (riderId);

/*PartTime*/
With computePT as (
Select PT.riderId as riderId, PT.weeklyBasePay as basePay, extract (year from WD.workDate) as year, extract (month from WD.workDate) as month, Count(distinct extract(week from WD.workDate)) as totalNumOfWeeksWorked, Sum(WD.numCompleted) as complete
From PartTime as PT
Inner join WorkingDays WD using (riderId)
where WD.numCompleted > 0 and riderId = $1
Group by extract(year from WW.workDate) as year, extract(month from WW.workDate) as month;
)

Select DR.riderId, computePT.year as year, computePT.month as month, computePT.complete * computePT.basePay + computePT.complete * DR.deliveryFee + computePT.totalNumOfWeeksWorked * computePt.basePay as monthlyPay
From DeliveryRiders DR
Inner join computePT using (riderId);
;



--View for each month, each delivery rider, average rating 

Select DR.riderId, EXTRACT(YEAR FROM O.orderDate) as year, EXTRACT(MONTH from O.orderDate) as month, avg(D.rating) as averageRatings
From DeliveryRiders DR
Left join Delivers D using (riderId)
Left join Orders O using (orderId)
Where DR.riderId = $1
Group by DR.riderId, extract(year FROM O.orderDate), extract(month FROM O.orderDate);


--View for each month, each delivery rider, average delivery time
Select D.riderId, extract(year from O.orderDate), extract(month from O.orderDate), avg((extract(hour from o.arrivalTimeAtDestination – o.departureTimeToRestaurant) * 60 + extract(minute from o.arrivalTimeAtDestination – o.departureTimeToRestaurant))::decimal /60) as AverageDeliveryTime
From Delivers D
Inner join Orders O using orderId
Where D.riderId = 22
Group by extract(year from O.orderDate), extract(month from O.orderDate)
;


-- View total number of orders placed by each customers for each month
SELECT extract(year from orderDate) as year, extract (month from orderDate) as month, customerId, COUNT(OrderID)
FROM Orders O
WHERE O.customerId = $1
GROUP BY extract(year from orderDate), extract (month from orderDate), customerId
;

-- View total cost of orders placed by each customer for each month
SELECT extract(year from orderDate) as year, extract (month from orderDate) as month, customerId, SUM(totalCost)
FROM Orders O
WHERE O.customerId = $1
GROUP BY extract(year from orderDate), extract (month from orderDate), customerId
;
-- View restaurant all ratings for given restaurant
SELECT O.restaurantId, Res.name, R.Rating, R.Review, Ord.customerId
FROM Reviews R, OrderDetails O, Restaurants Res, Orders ord
WHERE O.restaurantId = $1 and Res.restaurantId = $1 and O.OrderId = R.orderId and Ord.orderId = O.orderId
;
-- View food item by popularity for given restaurant
SELECT OD.itemName, SUM(OD.quantity)
FROM OrderDetails OD
WHERE OD.restaurantId = $1
GROUP BY OD.restaurantId, OD.itemName
Order By  SUM(OD.quantity) desc, OD.itemName
;
