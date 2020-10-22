var http = require('http');
var server = http.createServer(function (request, response) {
response.writeHead(200, {'Content-Type': 'text/html'});
    response.end('NodeJS in 9001');
});
server.listen(9001);
console.log('Listening on 9001');
