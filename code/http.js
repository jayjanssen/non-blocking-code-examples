var http = require('http');

http.get( 
    {
        host:'forecast.weather.gov',
        path: '/MapClick.php?lat=42.12100&lon=-77.94750&FcstType=dwml'
    },
    function( res ) {
        var data;
        
        console.log( "Got HTTP response " + res.statusCode );
        
        res.on( 'data', function( chunk ) {
            data += chunk;      
        });
        
        res.on( 'end', function() {
            console.log( "Data is " + data.length + " bytes long" );
            console.log('Data received');
        })
    }
);

console.log('Request sent');
