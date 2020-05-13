# Step by step dev guide
Hopefully it's correct :)
##To run
 1. cd into 'cs2102project'
 2. Enter command: `npm install`
 3. cd into 'App', Enter command: `cd App`
 4. Enter command: `node app.js`
## To add a new web page
 1. In `App/app.js` , Add `var pageNameRouter = require('./routes/pageName');` to Page Routers Section
 2. In `App/app.js`, Add `app.use('/pageName', pageNameRouter)` to Pages Section.
 3. Create a file with name `pageName.js` in folder `App/routes`. This connects to database and gets stuff.
 4. Create a file with name `pageName.ejs` in folder `App/views/`. This is more or less the frontend.
 5. Add whatever functionality to that page by editing `pageName.js` & `pageName.ejs` as required.
 6. Add page to Nav bar in `partials/navbar.ejs`
 7. In `App/app.js`, Add page to Render Pages Section with code block below:
 ```javascript
 app.get('/pageName', (req, res) => {
	res.render('pageName');
});
```
## SQL Queries
Include this code block in all .js files that require SQL

```javascript
var express = require('express');
var router = express.Router();

const sql_query = require('../database/allQueries');

const { Pool } = require('pg')
const pool = new Pool({
  connectionString: process.env.DATABASE_URL
})
```
Using the SQL query and the Pool, you can send the query to SQL using:

`pool.query(sql query, (err, data) => /* callback */ );`
- Callback is the operation that you are going to perform once you retrieve the data from the
SQL database.

Example:
```javascript
router.get('/', function(req, data) {
	pool.query(sql_query.query.QUERY_FUNC_NAME, (err, data) => {
        // what you want it to do, example below will show users the select page and display all Users 
        res.render('select', { title: 'Select All Users', usersInfo: data.rows });
	});
});
```