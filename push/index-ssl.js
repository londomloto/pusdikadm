var fs = require('fs');
var path = require('path');
var http = require('http');
var https = require('https');
var express = require('express');
var app = express();

var server = https.createServer({ 
    key: fs.readFileSync('ssl/private.key'), 
    cert: fs.readFileSync('ssl/certificate.crt'),
    ca: fs.readFileSync('ssl/ca_bundle.crt')
}, app);

// var server = https.createServer({ 
//     key: fs.readFileSync('ssl/server.key'), 
//     cert: fs.readFileSync('ssl/server.crt')
// }, app);

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

server.listen(8443, function(){
    console.log('info => listen on *:8443');
});