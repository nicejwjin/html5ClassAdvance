var WebSocketServer = require('websocket').server;
var http = require('http');
var clients = [];
// 임의로 ID부여하기 위함
var idlist = [];
var id = 1;
var server = http.createServer(function(request, response) {
  response.writeHead(404);
  response.end();
});
server.listen(8888, function() {
  console.log((new Date()) + ' - 8888 포트번호로 서버가 기동되었습니다.');
});
wsServer = new WebSocketServer({
  httpServer: server,
  autoAcceptConnections: false
});
function originIsAllowed(origin) {
  return true;
}

wsServer.on('request', function(request) {
  if (!originIsAllowed(request.origin)) {
    request.reject();
    console.log((new Date()) + request.origin + '로 부터의 잡속 요청을 거절하였습니다.');
    return;
  }
  var connection = request.accept(null, request.origin);
  clients.push(connection);
  // 임의로 id값을 할당함. request.key값으로 client 구분
  idlist[request.key] = '손님-'+id++;
  console.log((new Date()) + ' 접속을 수락하였습니다.');
  connection.on('message', function(message) {
    if (message.type === 'utf8') {
      console.log('수신 메시지 : ' + message.utf8Data);
      clients.forEach(function(cli) {
        msg = idlist[request.key]+ ': ' +message.utf8Data;
        cli.sendUTF(msg);
      });
    }
    else if (message.type === 'binary') {
      console.log('바이너리 메시지를 전달받았습니다 : ' + message.binaryData.length + ' 바이트');
    }
  });
  connection.on('close', function(reasonCode, description) {
    console.log((new Date()) + connection.remoteAddress + ' 와의 접속상태가 해제되었습니다.');
  });
});