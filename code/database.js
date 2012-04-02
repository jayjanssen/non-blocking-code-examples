var mysql = require( 'mysql' );

var client = mysql.createClient( {
   user: 'root',
   database: 'test'
});

client.query( 
  'select * from test where id = ?', [ 10 ], 
  function ( err, results, fields ) {
      if( err ) {
          throw err;
      }
      console.log( results );
      client.end();
  }  
);