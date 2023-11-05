<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/chatt.css">
<script src="../js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<body>
	<div  class="header">
		<a href="./main"><i class="xi-angle-left xi-4x"></i></a>
		<div class="headerTitle">실시간채팅</div>
		<div id="blank"></div>
	</div>

	<div id='chatt'>
		<c:choose>
			<c:when test="${sessionScope.mgrade gt 4 }">
				<input type='hidden' id='mid' value="의사 ${sessionScope.mname}">
			</c:when>
			<c:otherwise> 
				<input type='hidden' id='mid' value="${sessionScope.mname}님">
			</c:otherwise>
		</c:choose>
		<input type='hidden' id='mgrade' value="${sessionScope.mgrade}">
		
		<div id='talk'></div>
		<div id='sendZone'>
			<textarea id='msg'></textarea>
			<div id='btnSend'><i  class="xi-send xi-2x"></i></div>
		</div>
	</div> 
	<script type="text/javascript">
		$(function() {
			let ws;
			let mid = getId('mid');
			let btnSend = getId('btnSend');
			let talk = getId('talk');
			let msg = getId('msg');
			let data = {};//전송 데이터(JSON)
			let mgrade = $('#mgrade').val();

			let mno = "${sessionScope.mno}";
			//mgrade로 의사인지 판별하기, 
			if (mgrade == 6) {
				ws = new WebSocket("ws://" + location.host + "/chatt/43");

				//의사가 아니면 새로운 방 오픈하기
			} else {
				ws = new WebSocket("ws://" + location.host + "/chatt/" + mno);

			}

			ws.onmessage = function(msg) {
				let data = JSON.parse(msg.data);
				//누가 보냈는지 구분하기
				let className = data.mid == mid.value ? 'me' : 'other'

				//메세지 띄워주기
				let item = "<div class='" + className + "'><div class='date'>"
						+ data.date + "</div>";
				item += "<div class='message'>";
				if (data.mid != mid.value) {
				    item += "<span><b>" + data.mid +"</b></span><br>";
				} 
				item += "<div id='content'>" + data.msg + "</div></div></div>";

				talk.innerHTML += item;

				// 스크롤바 하단으로 이동
				talk.scrollTop = talk.scrollHeight;
			}

			//enter눌러도 메세지 보내기
			$('#msg').keyup(function(a) {
				if (a.keyCode === 13) {
					send();
				}
			});

			//버튼 눌러도 메세지 보내기
			$('#btnSend').click(function() {
				send();
			});

			//보내는 법
			function send() {
				if (msg.value.trim() != '') {
					data.mid = mid.value;
					data.msg = msg.value;
					data.date = new Date().toLocaleTimeString('ko-KR', {
						hour : '2-digit',
						minute : '2-digit'
					});
					let temp = JSON.stringify(data);
					ws.send(temp);
				}
				msg.value = '';
			}

			function getId(id) {
				return document.getElementById(id);
			}
		})
	</script>
</body>
</html>
