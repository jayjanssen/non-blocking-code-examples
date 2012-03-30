var http = require('http');

http.createServer(function (req, res) {
    if( req.url === '/' ) {
        
        console.log( "HTTPD: Got request for '/'" );
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Hello World');
        
    } else if( req.url === '/test' ) {
        
        console.log( "HTTPD: Got request for '/test'" );
        res.writeHead(200, {'Content-Type': 'text/plain'});
        res.end('Test page');
    }
}).listen(8080, '127.0.0.1');

console.log('Starting HTTPD');