/* required for database connection */
var express = require('express');
var router = express.Router();

const sql_query = require('../database/allQueries');

const { Pool } = require('pg')
const pool = new Pool({
  connectionString: process.env.DATABASE_URL
})
/* required for database connection */

/* SQL Query */
/* this was the example query

router.get('/', function(req, res, next) {
	pool.query(sql_query.query.QUERY_FUNC_NAME, (err, data) => {
		// what you want it to do
	});
});

*/
module.exports = router;
