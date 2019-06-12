<!doctype html>
<html lang="en">
  <head>
    <title>Websocket ChatRoom</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/webjars/bootstrap/4.3.1/dist/css/bootstrap.min.css">
    <style>
      [v-cloak] {
          display: none;
      }
    </style>
  </head>
  <body>
    <div class="container" id="app" v-cloak>
        <div>
            <h2>{{roomName}}</h2>
        </div>
        <div class="input-group">
            <div class="input-group-prepend">
                <label class="input-group-text">내용</label>
            </div>
            <input type="text" class="form-control" v-model="message" v-on:keypress.enter="sendMessage">
            <div class="input-group-append">
                <button class="btn btn-primary" type="button" @click="sendMessage">보내기</button>
            </div>
        </div>
        <ul class="list-group">
            <li class="list-group-item" v-for="message in messages">
                {{message.sender}} - {{message.message}}</a>
            </li>
        </ul>
    </div>
    <!-- JavaScript -->
    <script src="/webjars/vue/2.5.16/dist/vue.min.js"></script>
    <script src="/webjars/axios/0.17.1/dist/axios.min.js"></script>
    <script src="/webjars/sockjs-client/1.1.2/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/2.3.3-1/stomp.min.js"></script>
    <script>
        // websocket & stomp initialize
        var sock = new SockJS("/ws-stomp");
        var ws = Stomp.over(sock);
        var reconnect = 0;
        // vue.js
        var vm = new Vue({
            el: '#app',
            data: {
                roomId: '',
                roomName: '',
                sender: '',
                message: '',
                messages: [],
                token: ''
            },
            created() {
                this.roomId = localStorage.getItem('wschat.roomId');
                this.roomName = localStorage.getItem('wschat.roomName');
                const that = this;
                this.getUser().then(function () {
                    that.connect();
                });
            },
            methods: {
                connect: function() {
                    const that = this;
                    ws.connect({"token":this.token}, function(frame) {
                        ws.subscribe("/sub/chat/room/"+that.roomId, function(message) {
                            var recv = JSON.parse(message.body);
                            that.recvMessage(recv);
                        });
                        ws.send("/pub/chat/message", {"token":that.token}, JSON.stringify({type:'ENTER', roomId:that.roomId, sender:that.sender}));
                    }, function(error) {
                        alert("서버 연결에 실패하였습니다.");
                        location.href="/chat/room";
                    });
                },
                sendMessage: function() {
                    ws.send("/pub/chat/message", {"token":this.token}, JSON.stringify({type:'TALK', roomId:this.roomId, sender:this.sender, message:this.message}));
                    this.message = '';
                },
                recvMessage: function(recv) {
                    this.messages.unshift({"type":recv.type,"sender":recv.type=='ENTER'?'[알림]':recv.sender,"message":recv.message})
                },
                getUser: function() {
                    const that = this;
                    return new Promise(function (resolve, reject) {
                        axios.get('/chat/user').then(response => {
                            that.sender = response.data.name;
                            that.token = response.data.token;
                            resolve();
                        });
                    });
                }
            }
        });
    </script>
  </body>
</html>