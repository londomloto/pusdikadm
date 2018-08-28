var path = require('path');
var http = require('http');
var express = require('express');
var app = express();
var server = http.createServer(app);
var io = require('socket.io')(server);

app.use('/node_modules', express.static(path.join(__dirname, 'node_modules')));

app.get('/', function(req, res){
    res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket) {
    var room = socket.handshake.query.room;
    
    socket.join(room);
    
    socket.on('emit', function(data){
        socket.to(room).emit('emit', data);
    });

    socket.on('broadcast', function(data){
        socket.broadcast.to(room).emit('broadcast', data);
    });

});

server.listen(8080, function(){
    console.log('info => listening on *:8080');
});
