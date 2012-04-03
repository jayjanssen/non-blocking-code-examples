var intervalID = setInterval( function() {
    console.log( "1 second passed");
}, 1000 );

setTimeout( function() {
    console.log( "5 seconds passed" );
    clearInterval( intervalID );
}, 5000 );

