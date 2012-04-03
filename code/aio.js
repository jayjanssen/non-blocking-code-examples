var http = require('http');
var fs = require('fs');

var i = 1;
http.createServer(function (request, response) {
    console.log('starting #' + i++);
    var stream = fs.createReadStream('data.bin', { bufferSize: 64 * 1024 });
    stream.pipe(response);
}).listen(8000);

console.log('Server running at http://127.0.0.1:8000/');