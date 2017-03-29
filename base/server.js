var http = require('http');

function handleRequest(request, response){
    response.writeHead(200, {'Content-Type': 'text/plain'});
    response.end();
};

var server = http.createServer(handleRequest);
const port = process.env.PORT || '8080';
server.listen(port, function(){
    console.log("Listening on: %s port", port);
});
