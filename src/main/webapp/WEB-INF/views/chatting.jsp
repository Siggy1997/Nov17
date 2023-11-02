<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/chatt.css">
</head>
<body>
	<div id='chatt'>
		<h1>WebSocket Chatting</h1>
		<input type='text' id='mid' value='홍길동'> <input type='button'
			value='로그인' id='btnLogin'> <br />
		<div id='talk'></div>
		<div id='sendZone'>
			<textarea id='msg' value='hi...'></textarea>
			<input type='button' value='전송' id='btnSend'>
		</div>
	</div>
	<script type="text/javascript">
	function getId(id){
		return document.getElementById(id);
	}

	var data = {};//전송 데이터(JSON)

	var ws ;
	var mid = getId('mid');
	var btnLogin = getId('btnLogin');
	var btnSend = getId('btnSend');
	var talk = getId('talk');
	var msg = getId('msg');

	btnLogin.onclick = function(){
		ws = new WebSocket("ws://" + location.host + "/chatt");
		
		ws.onmessage = function(msg){
			var data = JSON.parse(msg.data);
			var css;
			
			if(data.mid == mid.value){
				css = 'class=me';
			}else{
				css = 'class=other';
			}
			
			var item = `<div ${css} >
			                <span><b>${data.mid}</b></span> [ ${data.date} ]<br/>
	                      <span>${data.msg}</span>
							</div>`;
						
			talk.innerHTML += item;
			talk.scrollTop=talk.scrollHeight;//스크롤바 하단으로 이동
		}
	}

	msg.onkeyup = function(ev){
		if(ev.keyCode == 13){
			send();
		}
	}

	btnSend.onclick = function(){
		send();
	}

	function send(){
		if(msg.value.trim() != ''){
			data.mid = getId('mid').value;
			data.msg = msg.value;
			data.date = new Date().toLocaleString();
			var temp = JSON.stringify(data);
			ws.send(temp);
		}
		msg.value ='';
		
	}
	
	</script>
</body>
</html>