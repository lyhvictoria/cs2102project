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

-- View the average rating of restaurant selected
SELECT Round(AVG(ALL R.rating),2) as avgRating
FROM Reviews R JOIN Orders O USING (orderId)
    JOIN OrderDetails OD USING (orderId)
    JOIN Restaurants R USING (restaurantId)
WHERE R.name = $1

-- Add a menu item
SELECT M.itemName, (M.price * $3) as price ,$3 as quantity
FROM Menus M join Restaurants R using(restaurantId)
WHERE M.itemName = $1 and R.name = $2

/* Restaurant Staff Related Functionalities */

/* Delivery Rider Related Functionalities */

/* FDS Manager Rider Related Functionalities */

