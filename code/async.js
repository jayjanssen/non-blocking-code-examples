var async = require( 'async' );
var mysql = require( 'mysql' );

var client = mysql.createClient( {
   user: 'root',
   database: 'test'
});

// Start a "transaction"
async.waterfall([
    // statement 1
    function( callback ) {
        client.query( 'select * from test where id = ?', [ 10 ], callback );
    },
    // // statement 2, gets all arguments passed to last to last callback
    function( last_results, last_fields, callback ) {
        console.log( last_results );
        client.query( 'select * from test where id = ?', [ 5 ], callback );
    }
], 

// This function gets called if any statement produces an error, or all statements complete successfully
function( err, result ) {
    if( err ) {
        throw err;
    } else {
        console.log( "Done successfully" );
        console.log( result );
        client.end();
    }
});

