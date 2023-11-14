<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>menu</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/menu.css">
<script src="./js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">
	$(function(){
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function(){
			history.back();
		});
		
		let sessionId = "<%=session.getAttribute("mid") %>"
		if( sessionId == "null" || sessionId == '' ) {
			$(".menuHeader").addClass("noLogin");
		} else {
			$(".menuHeader").removeClass("noLogin");
		}
		
	});
	
	function link(url) {
		let sessionId = "<%=session.getAttribute("mid") %>"
		
		if( sessionId == "null" || sessionId == '' ) {
			if (confirm("로그인을 해야 이용할 수 있는 서비스입니다. 로그인 하시겠습니까?")) {
				return location.href= '/login';
			} else {
				return false;
			}
		} else {
			location.href = "/" + url;
		}
	}
	
	function noCheckLink(url) {
		location.href = "/" + url;
	}
</script>

</head>
<body>
	<!-- header -->
	<header>
		<div class="blank"></div>
		<div class="headerTitle"></div>
		<i class="xi-close-thin xi-x"></i>
	</header>
	<main class="container">
		<div class="menuHeader noLogin">
			<c:choose>
				<c:when test="${sessionScope.mid eq null || sessionScopte.mid eq ''}">
					<div class="userImg">
						<img src="/img/user.png">
					</div>
					<div class="noUser">
						<button onclick="noCheckLink('login')">로그인 하기</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="userImg">
						<img src="${userInfo.mimg}">
					</div>
					<div class="userInfo">
						<div class="userName">${userInfo.mname} 님</div>
						<div class="userNickname">${userInfo.mnickname}</div>
						<div class="userBirth">${userInfo.mbirth}</div>
					</div>
					<div class="userEdit" onclick="noCheckLink('logout')"><i class="xi-log-out"></i></div>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="menuButton">
			<div class="buttonSubItem" onclick="link('hospitalLike')">
				<div class="buttonImg" style="background-color: #FDF5D7"><img src="https://cdn-icons-png.flaticon.com/512/616/616489.png"></div>
				<div class="buttonText">즐겨찾기</div>
			</div>
			<div class="buttonSubItem" onclick="link('healthRecord')">
				<div class="buttonImg" style="background-color: #fce4e4"><img src="https://cdn-icons-png.flaticon.com/512/881/881760.png "></div>
				<div class="buttonText">건강관리</div>
			</div>
			<div class="buttonSubItem" onclick="link('myWriting')">
				<div class="buttonImg" style="background-color: #EDF3FD"><img src="https://cdn-icons-png.flaticon.com/512/2674/2674841.png"></div>
				<div class="buttonText">나의 게시글</div>
			</div>
			<div class="buttonSubItem" onclick="link('medicalHistory')">
				<div class="buttonImg" style="background-color: #FBF0E8"><img src="https://cdn-icons-png.flaticon.com/512/11411/11411453.png"></div>
				<div class="buttonText">예약 내역</div>
			</div>
		</div>
		<div class="graySeperate"></div>
		
		
		<div class="menuBody">
			<!-- 나의 관리 -->
			<div class="menuSection">
				<div class="sectionTitle"><img src="https://cdn-icons-png.flaticon.com/512/1144/1144709.png" style="width: 28px; margin-right: 8px;">나의 관리</div>
				<div class="sectionList">
					<div class="listRow" onclick="link('myInfo')">
						<div class="listTitle">내 정보</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="link('hospitalLike')">
						<div class="listTitle">즐겨찾는 병원</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="link('healthRecord')">
						<div class="listTitle">건강 기록 내역</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="link('myWriting')">
						<div class="listTitle">나의 게시글 내역</div><div class="xi-angle-right-min"></div>
					</div>
				</div>
			</div>
			
			<!-- 진료 -->
			<div class="menuSection">
				<div class="sectionTitle"><img src="https://cdn-icons-png.flaticon.com/512/4006/4006511.png" style="width: 28px; margin-right: 8px;">진료</div>
				<div class="sectionList">
					<!-- 추가하기 -->
					<div class="listRow" onclick="link('medicalHistory')">
						<div class="listTitle">진료 내역</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="link('medicalHistory')">
						<div class="listTitle">예약 내역</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="noCheckLink('telehealthSearch')">
						<div class="listTitle">비대면 진료</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="link('')">
						<div class="listTitle">실시간 상담</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="noCheckLink('hospitalMap')">
						<div class="listTitle">주변 병원</div><div class="xi-angle-right-min"></div>
					</div>
				</div>
			</div>
			
			<!-- 기타 -->
			<div class="menuSection">
				<div class="sectionTitle"><img src="https://cdn-icons-png.flaticon.com/512/248/248924.png" style="width: 28px; margin-right: 8px;">기타</div>
				<div class="sectionList">
					<div class="listRow" onclick="noCheckLink('qnaBoard')">
						<div class="listTitle">Q&A 게시판</div><div class="xi-angle-right-min"></div>
					</div>
					<div class="listRow" onclick="noCheckLink('hospitalOpen')">
						<div class="listTitle">신규 병원 등록</div><div class="xi-angle-right-min"></div>
					</div>
				</div>
			</div>
		
		</div>
	
	</main>
	<footer>
	</footer>
</body>
</html>