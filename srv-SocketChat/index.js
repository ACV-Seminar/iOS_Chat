var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var userList = [];
var id = 0;
var typingUsers = {};

app.get('/', function(req, res){
  res.send('<h1>AppCoda - SocketChat Server</h1>');
});


http.listen(1992, function(){
  console.log('Listening on *:1992');
});


io.on('connection', function(clientSocket){
  console.log('a user connected');

  clientSocket.on('disconnect', function(){
    console.log('a user disconnected');
  });

  clientSocket.on("exitUser", function(clientNickname){
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["nickname"] == clientNickname) {
        userList[i]["isConnected"] = false
        break;
      }
    }

    delete typingUsers[clientNickname];
    io.emit("userList", userList);
    io.emit("userLogout", clientNickname);
    io.emit("userTypingUpdate", typingUsers);
  });

  clientSocket.on("disconnectChat", function(clientNickname){
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["nickname"] == clientNickname) {
        userList[i]["isConnected"] = false
        break;
      }
    }

    delete typingUsers[clientNickname];
    io.emit("userList", userList);
    io.emit("userTypingUpdate", typingUsers);
  });

  clientSocket.on("reconnectChat", function(clientNickname){
    for (var i=0; i<userList.length; i++) {
      if (userList[i]["nickname"] == clientNickname) {
        userList[i]["isConnected"] = true
        break;
      }
    }

    delete typingUsers[clientNickname];
    io.emit("userList", userList);
    io.emit("userTypingUpdate", typingUsers);
  });

  clientSocket.on('chatMessage', function(clientNickname, message){
    var currentDateTime = new Date().toLocaleString();
    delete typingUsers[clientNickname];
    io.emit("userTypingUpdate", typingUsers);
    io.emit('newChatMessage', clientNickname, message, currentDateTime);
  });


  clientSocket.on("connectUser", function(clientNickname) {
      var message = "User " + clientNickname + " was connected.";
      console.log(message);

      var userInfo = {};
      var foundUser = false;
      for (var i=0; i<userList.length; i++) {
        if (userList[i]["nickname"] == clientNickname) {
          userList[i]["isConnected"] = true
          // userList[i]["id"] = clientSocket.id;
          userInfo = userList[i];
          foundUser = true;
          break;
        }
      }

      if (!foundUser) {
        // userInfo["id"] = clientSocket.id;
        userInfo["id"] = id ++ ;
        userInfo["nickname"] = clientNickname;
        userInfo["isConnected"] = true
        userList.push(userInfo);
      }

      io.emit("userList", userList);
  });

  clientSocket.on("joinRoomChat", function(clientNickname){
    io.emit("userInRoomChat", clientNickname);
  });

  clientSocket.on("outRoomChat", function(clientNickname){
    io.emit("userOutRoomChat", clientNickname);
  });

  clientSocket.on("startType", function(clientNickname){
    console.log("User " + clientNickname + " is writing a message...");
    typingUsers[clientNickname] = 1;
    io.emit("userTypingUpdate", typingUsers);
  });


  clientSocket.on("stopType", function(clientNickname){
    console.log("User " + clientNickname + " has stopped writing a message...");
    delete typingUsers[clientNickname];
    io.emit("userTypingUpdate", typingUsers);
  });

});
