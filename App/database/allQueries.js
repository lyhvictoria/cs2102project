const sql = {}

sql.query = {
    //example_get_customers: 'SELECT customerId FROM Customers',
    //example_insert_new_customer: 'INSERT INTO Customers(id, name)'

    list_restaurants: 'SELECT DISTINCT restaurantId, name,  area, minSpendingAmt FROM Restaurants ORDER BY restaurantId',
    get_restaurant_info: 'SELECT DISTINCT restaurantId, name,  area, minSpendingAmt FROM Restaurants WHERE restaurantId = $1',
    get_restaurant_menu: 'SELECT DISTINCT itemId, itemName, price, category, isAvailable, amtLeft FROM Menus WHERE restaurantId = $1',
    get_menu_itemId: 'SELECT itemId FROM Menus WHERE restaurantId = $1 AND itemName = $2',
    add_to_order: 'SELECT M.itemName, (M.price * $3) as price, $3 as quantity FROM Menu M WHERE M.restaurantId = $1 AND M.itemName = $2'
}

module.exports = sql