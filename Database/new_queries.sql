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
SELECT extract(hour from o.orderTime) as Hour, COUNT(*) as TotalOrders, o.deliveryLocationArea as Area
FROM Orders o
WHERE o.orderDate = $1
GROUP BY extract(hour from o.orderTime), o.deliveryLocationArea
;

-- View summary for each rider INCOMPLETE!!!!!!
SELECT d.riderId, count(d.orderId)
FROM Delivers d INNER JOIN Orders o ON (d.orderId = o.orderId)
WHERE extract(year from o.orderDate) = $1
GROUP BY D.riderId, extract(month from o.orderDate)
;

-- View # new custs & orders & total cost of all orders for each monthly  INCOMPLETE!!!!!
SELECT extract(year from ) as year, extract (month from ) as month, as TotalOrderCosts, as TotalNewCustomers
from
WHERE
