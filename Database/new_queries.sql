/* Common Queries */


/* Customer Related Functionalities */
-- Get customer information
SELECT *
FROM Customers
WHERE customerId = $1

-- Get list of restaurants
SELECT DISTINCT restaurantId, area, name, minSpendingAmt
FROM Restaurants
ORDER BY restaurantId

-- Get info of restaurant selected
SELECT restaurantId, area, name, minSpendingAmt
FROM Restaurants
WHERE restaurantId = $1

-- View menu items for restaurant selected
SELECT DISTINCT itemName, price, category, isAvailable, amtLeft
FROM Menus
WHERE restaurantId = $1

-- View all the reviews of restaurant selected
SELECT DISTINCT  to_char(O.date,\'DD-Mon-YYYY\') as date, R.name, R.review, R.rating
FROM Reviews R JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
WHERE R.name = $1

-- View all their past reviews
SELECT DISTINCT to_char(O.date,\'DD-Mon-YYYY\') as date, R.name, R.review, R.rating
FROM Reviews R JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
WHERE O.customerId = $1

-- View the average rating of restaurant selected
SELECT Round(AVG(ALL R.rating),2) as avgRating
FROM Reviews R JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
WHERE R.name = $1

-- Make a review for their order
INSERT INTO Reviews (reviewId, orderId, review, rating) VALUES ($1, $2, $3, $4)

-- Add a credit card for customer
INSERT INTO CreditCards (customerId, cardNumber) VALUES ($1, $2)

-- Delete a credit card for customer
DELETE FROM CreditCards
WHERE customerId = $1 AND cardNumber = $2

-- Use rewards points, $2 is points used
UPDATE Customers
SET rewardPoints = rewardPoints - $2
WHERE customerId = $1

-- After customer selects payment mode
UPDATE Orders
SET paymentMode = $2
WHERE orderId = $1


/* Restaurant Staff Related Functionalities */
-- Get info of their restaurant
SELECT R.restaurantId, R.area, R.name, R.minSpendingAmt
FROM Restaurants R JOIN RestaurantStaff S USING (restaurantId)
WHERE S.restStaffId = $1

-- View menu items for their restaurant ordered by [type]
-- [type] is either price, amount left or category $2
SELECT DISTINCT M.itemName, M.price, M.category, M.isAvailable, M.amtLeft
FROM Menus M JOIN RestaurantStaff S USING (restaurantId)
WHERE S.restStaffId = $1
ORDER BY $2, M.itemName

-- Add a new menu item
INSERT INTO Menus (restaurantId, itemName, price, category, amtLeft) VALUES ($1, $2, $3, $4, $5);

-- Edit a menu item's name
-- $1 = old name, $2 = restaurantId, $3 = new name
UPDATE Menus
SET itemName = $3
WHERE itemName = $1 AND restaurantId = $2

-- Edit a menu items's price
-- $1 = itemName, $2 = restaurantId,  $3 = price
UPDATE Menus
SET price = $3
WHERE itemName = $1 AND restaurantId = $2

-- Edit a menu items's amount left
-- $1 = itemName, $2 = restaurantId, $3 = amount left
UPDATE Menus
SET amtLeft = $3
WHERE itemName = $1 AND restaurantId = $2

-- View the past reviews for their restaurant
SELECT to_char(O.date,\'DD-Mon-YYYY\') as date, R.review, R.rating
FROM Reviews R JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
    JOIN RestaurantStaff S USING (restaurantId)
WHERE S.restStaffId = $1

-- Create a restaurant promotion with discount %
-- $1 = startDate, $2 = endDate, $3 = % discount, $4 = minimumAmtSpent
-- $5 = restaurantId
WITH newPromo as (
    INSERT INTO Promotions (type, startDate, endDate, discountPerc, minimumAmtSpent) VALUES ('Restpromo', $1, $2, $3, $4)
    RETURNING promotionId --get the new promotionId
)

INSERT INTO RestaurantPromotions (promotionId, restaurantId)
SELECT promotionId, $5
FROM newPromo

-- Create a restaurant promotion with fixed discount amount
-- $1 = startDate, $2 = endDate, $3 = discount amount, $4 = minimumAmtSpent
-- $5 = restaurantId
WITH newPromo as (
    INSERT INTO Promotions (type, startDate, endDate, discountAmt, minimumAmtSpent) VALUES ('Restpromo', $1, $2, $3, $4)
    RETURNING promotionId --get the new promotionId
)

INSERT INTO RestaurantPromotions (promotionId, restaurantId)
SELECT promotionId, $5
FROM newPromo

-- Edit start and end date of restaurant promotion
UPDATE Promotions
SET startDate = $2 AND endDate = $3
WHERE promotionId = $1

-- Edit discount % of restaurant promotion
UPDATE Promotions
SET discountPerc = $2
WHERE promotionId = $1

-- Edit discount amount of restaurant promotion
UPDATE Promotions
SET discountAmt = $2
WHERE promotionId = $1

-- Edit minimumAmtSpent of restaurant promotion
UPDATE Promotions
SET minimumAmtSpent = $2
WHERE promotionId = $1

-- View summary information for orders
-- 1) Total number of completed orders
-- 2) Total cost of all completed orders (excluding delivery fees)
SELECT year, month, COUNT(orderId) AS totalCompletedOrders, SUM(totalCost) As totalCompletedCost
FROM (
    SELECT DISTINCT EXTRACT(YEAR FROM (O.date)) AS year, EXTRACT(MONTH FROM (O.date)) as month, O.orderId, O.totalCost
    FROM Orders O
    WHERE O.arrivalTimeAtDestination <> NULL --completed order
    AND O.restaurantID = $1
    AND EXTRACT(YEAR FROM (O.date)) = $2 AND EXTRACT(MONTH FROM (O.date)) = $3)
GROUP BY year, month

-- 3) Top 5 favorite food items (in terms of the number of orders for that item)
WITH TopFiveFoodItems (year, month, itemName, totalOrders) AS (
    SELECT DISTINCT EXTRACT(YEAR FROM (O.date)) AS year, EXTRACT(MONTH FROM (O.date)) as month, OD.itemName as itemName, SUM(OD.quantity) as totalOrders
    FROM OrderDetails OD JOIN Orders O USING (orderId)
    WHERE O.arrivalTimeAtDestination <> NULL --completed order
    AND OD.restaurantId = $1
    GROUP BY year, month, food
    ORDER BY totalOrders DESC
    LIMIT 5
)

-- View summary information for promotions
-- 1) Duration of promotion campaign in terms of days or hours (if days < 0)
-- 2) average number of orders received during the promotion per day or hours (if days < 0)
WITH Duration AS (
    SELECT DISTINCT P.promotionId,
                    DATE_PART(\'day\', endDate::date - startDate::date) as durationInDays,
                    DATE_PART(\'hour\', endDate::timestamp - startDate::timestamp) as durationInHours
    FROM RestaurantPromotions R JOIN Promotions P USING (promotionId))
    WHERE R.restaurantId = $1
    ),

    OrdersMade As (
        SELECT DISTINCT P.promotionId, COUNT(DISTINCT O.orderId) as totalOrders
        FROM RestaurantPromotions R JOIN Promotions P USING (promotionId)
            JOIN Orders O USING (promotionId)
            WHERE R.restaurantId = $1
        GROUP BY P.promoID
    )

SELECT DISTINCT D.promotionId, totalOrders, durationInDays, durationInHours,
                CASE
                    WHEN durationInDays > 0 THEN ROUND(OM.totalOrders/durationInDays::NUMERIC, 2)
                    ELSE 0
                    END AS avgOrdersPerDay,
                CASE
                    WHEN durationInDays = 0 AND durationInHours = 0 then 0
                    ELSE ROUND(OM.totalOrders/(durationInHours - (durationInDays * 24))::NUMERIC, 2)
                    END AS aveOrdersPerHour
FROM Duration D LEFT JOIN OrdersMade OM using (promotionId)
ORDER BY OM.orderId DESC

/* Delivery Rider Related Functionalities */

/* view total number of orders delivered by each rider for each month and year */
/*FULL TIME*/
select distinct FT.riderId, EXTRACT(YEAR from WW.workDate) as year, EXTRACT(MONTH from WW.workDate) as month, SUM(WW.numCompleted) as totalOrders
From  FullTime FT
Inner join WorkingWeeks WW on FT.riderId = WW.riderId
Group by FT.riderID, EXTRACT(YEAR from WW.workDate), EXTRACT(MONTH from WW.workDate)

/*PART TIME*/
select distinct PT.riderId, EXTRACT(YEAR from WD.workDate) as year, EXTRACT(MONTH  from WD.workDate) as month, SUM(WD.numCompleted) as totalOrders
from PartTime PT
Inner join WorkingDays WD ON PT.riderId = WD.riderId
GROUP BY PT.riderId, EXTRACT(YEAR from WD.workDate), EXTRACT(MONTH from WD.workDate);

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
Inner join WorkingDays WD on PT.riderId = WD.riderId
where WD.numCompleted > 0
group by PT.riderId, extract(year from WD.workdate), extract(month from WD.workDate)
)
Select DR.riderId, computePT.year as year, computePT.month as month, computePT.complete * computePT.basePay + computePT.complete * DR.deliveryFee + computePT.totalNumOfWeeksWorked * computePt.basePay as monthlyPay
From DeliveryRiders DR
Inner join computePT on DR.riderId = computePT.riderId
;

/*FullTime*/
With ComputeFT as (
Select distinct FT.riderId as riderId,
FT.monthlyBasePay as basePay,
Extract(year from WW.workDate) as year,
Extract(month from WW.workDate) as month, 
Sum(WW.numCompleted) as completed
From FullTime FT
Inner join WorkingWeeks WW on FT.riderId = WW.riderId
Where WW.numCompleted > 0
Group by FT.riderId, extract(year from WW.workDate), extract(month from WW.workdate)
)
Select DR.riderId, computeFT.year as year, computeFT.month as month, (DR.deliveryFee * computeFT.completed + computeFT.completed * computeFT.basePay) as monthlySalary
From DeliveryRiders DR
Inner join computeFT on DR.riderId = computeFT.riderId
;

/*create weekly work schedule for PartTime*/
riderId, workDate, shiftId, numCompleted
$1 = riderId, $2 = workDate, $3 = IntervalStart, $4 = IntervalEnd, $5 = numCompleted
Begin;
Update WorkingDays 
Set riderId = $1
       Workdate = $2 
       IntervalStart = $3
       IntervalEnd = $4
       numCompleted = $5
where $1 exists (
	select riderId 
	from deliveryRiders
);
Commit;

/*create monthly work schedule for FullTime*/
riderId, workDate, shiftId, numCompleted
$1 = riderId, $2 = workDate, $3 = shiftId, $4 = numcompleted
Begin;
Update WorkingWeeks 
Set riderId = $1
       Workdate = $2 
       shiftId = $3
       numCompleted = $4
where $1 exists (
	select riderId 
	from deliveryRiders
);
Commit;

/*View the total number of hours worked for each week and month*/ - fulltime & parttime
/*Full Time*/
Select distinct FT.riderId, EXTRACT(YEAR from WW.workDate) as year, EXTRACT(MONTH from WW.workDate) as month, count(shiftID) * 8 as totalHours
From FullTime FT
Inner join WorkingWeeks WW on FT.riderId = WW.riderId
where WW.numCompleted > 0 
Group by FT.riderId, EXTRACT(YEAR FROM WW.workDate), EXTRACT(MONTH FROM WW.workDate)
UNION
/*PART TIME*/
select distinct PT.riderId, EXTRACT(YEAR from WD.workDate) as year, EXTRACT(MONTH from  WD.workDate) as month, 
/*convert to minutes first then convert back to hours after adding in minutes from interval*/
sum(DATE_PART('hour', WD.intervalEnd - WD.intervalStart) * 60 
+ DATE_PART('minute', WD.intervalEnd - WD.intervalStart))::decimal / 60 as totalHours
FROM PartTime PT
INNER JOIN WorkingDays WD on PT.riderId = WD.riderId
WHERE WD.numCompleted > 0 
GROUP BY PT.riderId, EXTRACT(YEAR from WD.workDate), EXTRACT(MONTH from WD.workDate);

/*View number of ratings received by riders for each month*/
Select distinct DR.riderId, EXTRACT(YEAR FROM O.date) as year, EXTRACT(MONTH from O.date) as month, count(D.rating ) as totalRatings
From DeliveryRiders DR
Left join Delivers D on DR.riderId = D.riderId
Left join Orders O on D.orderId = O.orderId
Group by DR.riderId, EXTRACT(YEAR FROM O.date), EXTRACT(MONTH FROM O.date);

/*View average rating received for rider for each month*/ - additional feature
Select distinct DR.riderId, EXTRACT(YEAR FROM O.date) as year, EXTRACT(MONTH from O.date) as month, avg(D.rating ) as averageRatings
From DeliveryRiders RD
Left join Delivers D on DR.riderId = D.riderId
Left join Orders O on D.orderId = O.orderId
Group by DR.riderId, EXTRACT(YEAR FROM O.date), EXTRACT(MONTH FROM O.date);


/* FDS Manager Rider Related Functionalities */

