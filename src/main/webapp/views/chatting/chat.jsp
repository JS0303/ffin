<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <title>ㅊㅐ팅</title>
    <style>
        *{
            margin:0;
            padding:0;
        }
        .container{
            width: 500px;
            margin: 0 auto;
            padding: 25px
        }
        .container h1{
            text-align: left;
            padding: 5px 5px 5px 15px;
            color: #FFBB00;
            border-left: 3px solid #FFBB00;
            margin-bottom: 20px;
        }
        .chating{
            background-color: #000;
            width: 500px;
            height: 500px;
            overflow: auto;
        }
        .chating .me{
            color: #F6F6F6;
            text-align: right;
        }
        .chating .others{
            color: #FFE400;
            text-align: left;
        }
        input{
            width: 330px;
            height: 25px;
        }
        .msgImg{
            width: 200px;
            height: 125px;
        }
        .clearBoth{
            clear: both;
        }
        .img{
            float: right;
        }
        img{
            /*글쓴이의 프로필 사진을 둥글게*/
            width: 40px;
            height: 40px;
            border: 0px;
            /*border: 1px solid #cecece;*/
            border-radius: 50%;
        }
    </style>
</head>

<script type="text/javascript">
    var ws;
    var userName = '${sessionScope.user.userId}';
    console.log("userName: "+userName);
    $(document).ready(function(){
        // 메세지 리스트 리로드


        wsOpen();

        //  connect();
    });

    function wsOpen(){
        //웹소켓 전송시 현재 방의 번호를 넘겨서 보낸다.
        ws = new WebSocket("ws://" + location.host + "/chating/"+$("#roomNumber").val());
        wsEvt();
    }

    function wsEvt() {
        ws.onopen = function(data){
            //소켓이 열리면 동작
        }

        ws.onmessage = function(data) {
            //메시지를 받으면 동작
            var msg = data.data;

            if(msg != null && msg.type != ''){
                var d = JSON.parse(msg);
                console.log("d: "+d.profile);
                if(d.type == "getId"){
                    var si = d.sessionId != null ? d.sessionId : "";
                    if(si != ''){
                        $("#sessionId").val(si);
                        $("#sessionName").val(d.userName);
                    }
                }else if(d.type == "message"){
                    console.log("d2: "+d)
                    if(d.sessionId == $("#sessionId").val()){
                        $("#chating").append("<p class='me'>" +
                            "<a href='/views/home.jsp'><img src='../../../resources/image/"+d.profile+"' alt='sunil' ></a>"
                            +userName+" :" + d.msg + "</p>");
                    }else{
                        $("#chating").append("<p class='others'><a href='/views/home.jsp'><img src='../../../resources/image/"+d.profile+"' alt='sunil' ></a>" + d.userName + " :" + d.msg + "</p>");
                    }

                }else{
                    console.warn("unknown type!")
                }
            }else{

                //파일 업로드한 경우 업로드한 파일을 채팅방에 뿌려준다.
                var url = URL.createObjectURL(new Blob([msg]));
                console.log('url: '+url)
                console.log('msg: '+msg)
                $("#chating").append("<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div></p>");

                /*
                    채팅에서 사진 전송을 제외하던지
                    다른 방법을 찾아보던지 해야 할 것 같음 잘 안되네

                if(userName== $("#sessionName").val()){
                    console.log("여기지.")
                    $("#chating").append("<p class='me'>"+userName+" :<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div></p>");
                }else{
                    console.log("아니, 여기지.")
                    $("#chating").append("<p class='others'>" + $("#sessionName").val() + " :<div class='img'><img class='msgImg' src="+url+"></div><div class='clearBoth'></div></p>");
                } */

            }
            $("#chating").scrollTop($("#chating")[0].scrollHeight);
        }

        document.addEventListener("keypress", function(e){
            if(e.keyCode == 13){ //enter press
                send();
            }
        });
    }

    function chatName(){
       // var userName = $("#userName").val();
        var userName = '${sessionScope.userId}';
        console.log("userName: "+userName);
      /*  if(userName == null || userName.trim() == ""){
            alert("사용자 이름을 입력해주세요.");
            $("#userName").focus();
        }else{
            wsOpen();
            $("#yourName").hide();
            $("#yourMsg").show();
        }*/
    }

    function send() {

        var option ={
            type: "message",
            roomNumber: $("#roomNumber").val(),
            sessionId : $("#sessionId").val(),
            userName : userName,
            msg : $("#chatting").val()
        }
        ws.send(JSON.stringify(option))
        $('#chatting').val("");
    }

    function fileSend(){
        var file = document.querySelector("#fileUpload").files[0];
        var fileReader = new FileReader();

        console.log("file: "+file+"fileReader : "+fileReader);

        fileReader.onload = function() {
            var param = {
                type: "fileUpload",
                file: file,
                roomNumber: $("#roomNumber").val(),
                sessionId : $("#sessionId").val(),
                msg : $("#chatting").val(),
                userName : userName
            }
            ws.send(JSON.stringify(param)); //파일 보내기전 메시지를 보내서 파일을 보냄을 명시한다.

            arrayBuffer = this.result;
            ws.send(arrayBuffer); //파일 소켓 전송
        };
        fileReader.readAsArrayBuffer(file);
    }


</script>
<body>
<div id="container" class="container">
    <h1>${roomName}의 채팅방</h1>
    <input type="hidden" id="sessionId" value="">
    <input type="hidden" id="sessionName" value="">
    <input type="hidden" id="roomNumber" value="${roomNumber}">

    <div id="chating" class="chating">
    </div>
    <input type="hidden" name="userName" id="userName">
   <%-- <div id="yourName">
        <table class="inputTable">
            <tr>
                <th>사용자명</th>
                <th><input type="text" name="userName" id="userName"></th>
                <th><button onclick="chatName()" id="startBtn">이름 등록</button></th>
            </tr>
        </table>
    </div>--%>
    <div id="yourMsg">
        <table class="inputTable">
            <tr>
                <th>메시지</th>
                <th><input id="chatting" placeholder="보내실 메시지를 입력하세요."></th>
                <th><button onclick="send()" id="sendBtn">보내기</button></th>
            </tr>
            <tr>
                <th>파일업로드</th>
                <th><input type="file" id="fileUpload"></th>
                <th><button onclick="fileSend()" id="sendFileBtn">파일올리기</button></th>
            </tr>
        </table>
    </div>
</div>
</body>
</html>