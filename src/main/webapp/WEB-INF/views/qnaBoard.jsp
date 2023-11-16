<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 

<link rel="stylesheet" href="./css/qnaBoard.css">

<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="loginAlert.jsp"%>
	

	<header>
		 <i class="xi-angle-left xi-x" onclick="location.href = '/main'"></i>

		<div class="header title">커뮤니티</div>
		<div class="blank"></div>
	</header>

	<main>

		<div id="boardButtonsContainer">
			<button id="qnaBoardButton" onclick="toggleBoard('qnaBoard')"
				style="display: none;">QnA게시판</button>
			<button id="qnaBoardBoldButton">QnA게시판</button>
			<button id="freeBoardButton" onclick="toggleBoard('freeBoard')">자유게시판</button>
			<button id="freeBoardBoldButton" style="display: none;">자유게시판</button>
		</div>
		<!-- <button id="hospitalMapButton" onclick="location.href='hospitalMap'">병원지도</button> -->



	<div class="space">
			<div class="searchForm">
				<form action="/searchWord" method="post" onsubmit="searchForm()">
 <div class="selectOptionTitle">
            	<div class="optionTitle margin-right">제목+내용</div>
            	<i class="xi-angle-down-thin"></i>
            </div>
          
	         <div id="openOptionList">
	         	<div class="selectOptionList" style="display: none;">
		            <div class="allOption" onclick="updateSelectedOption('allOption')">제목+내용</div>
		            <div class="titleOption" onclick="updateSelectedOption('titleOption')">제목만</div>
		            <div class="contentOption" onclick="updateSelectedOption('contentOption')">내용만</div>
	            </div>
	         </div>
	         <input type="hidden" name="selectOption" id="selectedOptionInput" value="allOption">
<input type="text" name="searchWord" id="searchWordInput"

						placeholder="검색 할 내용을 입력하세요">
					<button type="submit" class="xi-search xi-x"></button>
				</form>
			</div>
		</div>




		<div id="freeBoard" style="display: none;">
			<jsp:include page="freeBoard.jsp">
				<jsp:param name="freeList" value="${requestScope.freeList}" />
			</jsp:include>
		</div>



		<div id="qnaBoard" style="display: block;">
			<!-- <h1>QnA 게시판</h1> -->

			<div class="backGroundBar">
				<div class="space">

						<!-- 정렬 리스트 -->
            <div class="selectDepartment">
            	<div class="sortTitle margin-right">진료과목</div>
            	<i class="xi-angle-down-thin"></i>
            </div>
          
	         <div id="openSortList">
	         	<div class="selectSortList" style="display: none;">
		            <div class="전체">전체</div>
		            <div class="소아과">소아과</div>
		            <div class="치과">치과</div>
		             <div class="내과">내과</div>
		            <div class="이비인후과">이비인후과</div>
		            <div class="피부과">피부과</div>
		            <div class="산부인과">산부인과</div>
		            <div class="안과">안과</div>
		            <div class="정형외과">정형외과</div>
		              <div class="한의학과">한의학과</div>
		            <div class="비뇨기과">비뇨기과</div>
		            <div class="신경과">신경과</div>
		            <div class="외과">외과</div>
		            <div class="정신의학과">정신의학과</div>
	            </div>
	         </div>


					<button class="writeButton" onclick="confirmWriteQna()">작성하기</button>
				</div>
			</div>

			<div id="qnaListContainer">
				<c:forEach items="${qnaList}" var="qna">
					<a
						href="<c:url value='/qnaDetail'><c:param name='bno' value='${qna.bno}' /></c:url>">
						<div class="list">
							<div class="space">

								<div class="title">${qna.btitle}</div>
								<c:if test="${qna.dpkind ne 'unknown'}">
									<div class="kind">${qna.dpkind}</div>
								</c:if>
								<div class="content">${qna.bcontent}</div>

								<c:choose>
									<c:when test="${qna.comment_count == 0}">
										<div class="wait">
											<img
												src="https://cdn-icons-png.flaticon.com/512/1686/1686823.png"
												alt="답변 대기 중 이미지" style="width: 20px; height: auto;">
											답변 대기 중
										</div>
									</c:when>
									<c:otherwise>
										<div class="count">
											<img
												src="https://cdn-icons-png.flaticon.com/512/9616/9616817.png"
												alt="답변 완료 이미지" style="width: 20px; height: auto;">
											${qna.comment_count}개의 답변
										</div>
									</c:otherwise>
								</c:choose>
							</div>

						<div class="line"></div>
						</div>

					</a>
				</c:forEach>
			</div>

		</div>

		<div style="height: 9vh"></div>



	</main>

	<footer>
		<a href="./main">
			<div class="footerIcon">
				<img alt="없음" src="/img/mainHomebefore.png">
				<p>홈</p>
			</div>
		</a> <a href="./search">
			<div class="footerIcon">
				<img alt="없음" src="/img/mainSearchBefore.png">
				<p>검색</p>
			</div>
		</a> <a href="./hospitalMap">
			<div class="footerMain">
				<div class="footerIcon" id="mapIcon">
					<img alt="없음" src="/img/mainMap.png">
				</div>
			</div>
		</a> <a href="./qnaBoard">
			<div class="footerIcon now">
				<img alt="없음" src="/img/mainQnAafter.png">
				<p>고민 상담</p>
			</div>
		</a><a class="chatting">
			<div class="footerIcon">
				<img alt="없음" src="/img/myChatting3.png">
				<p>실시간 채팅</p>
			</div>
		</a>
	</footer>

</body>

<script>
//실시간채팅으로 가기
$('.chatting').click(function() { 
	 if(${sessionScope.mno == null || sessionScope.mno == ''}){
		 $('.dh-modal-wrapper').show();
	 }else{
      location.href='./chatting'
	 }
});

	function toggleBoard(boardId) {
		var boards = document.querySelectorAll("#freeBoard, #qnaBoard");
		boards.forEach(function(board) {
			if (board.id === boardId) {
				board.style.display = "block";
			} else {
				board.style.display = "none";
			}
		});
	}
</script>
<script>
	var maxLength = 50; // 최대 문자열 길이
	var contentElements = document.querySelectorAll(".content");

	contentElements.forEach(function(contentElement) {
		var text = contentElement.textContent;

		if (text.length > maxLength) {
			var truncatedText = text.slice(0, maxLength) + "...";
			contentElement.textContent = truncatedText;
		}
	});

	function searchForm() {
		var searchWordInput = document.getElementById("searchWordInput");
		var searchWord = searchWordInput.value.trim(); // 입력값 앞뒤 공백 제거

		if (searchWord === "") {
			alert("검색어를 입력하세요.");
			event.preventDefault(); // 폼 전송 막기

		}
	}
</script>



<script>
	function confirmWriteQna() {
		
		const mno = "${mno}";

		if (mno === null || mno === undefined || mno === "") {

			$(".dh-modal-wrapper").show();
			

		} else {
			window.location.href = 'writeQna';
		}
	}

	function toggleBoardLogic(boardType) {

		var qnaBoard = document.getElementById("qnaBoard");
		var freeBoard = document.getElementById("freeBoard");

		if (boardType === 'qnaBoard') {
			qnaBoard.style.display = "block";
			freeBoard.style.display = "none";
		} else if (boardType === 'freeBoard') {
			qnaBoard.style.display = "none";
			freeBoard.style.display = "block";
		}
	}

	function toggleBoard(boardType) {

		// 클릭된 버튼 강조
		if (boardType === 'qnaBoard') {
			document.getElementById("qnaBoardButton").style.display = "none";
			document.getElementById("qnaBoardBoldButton").style.display = "block";
			document.getElementById("freeBoardButton").style.display = "block";
			document.getElementById("freeBoardBoldButton").style.display = "none";
		} else if (boardType === 'freeBoard') {
			document.getElementById("qnaBoardButton").style.display = "block";
			document.getElementById("qnaBoardBoldButton").style.display = "none";
			document.getElementById("freeBoardButton").style.display = "none";
			document.getElementById("freeBoardBoldButton").style.display = "block";
		}

		toggleBoardLogic(boardType);

	}

	
	$(document).on("click", ".selectDepartment", function(){
  	  $("#openSortList").toggleClass("maxList");
        $(".selectSortList").slideToggle("fast");
    });
	
	$(document).on("click", ".selectOptionTitle", function(){
	  	  $("#openOptionList").toggleClass("maxOptionList");
	        $(".selectOptionList").slideToggle("fast");
	    });
	
	

	function updateSelectedOption(option) {
		
	    document.getElementById("optionTitle").textContent = option;
	    document.getElementById("selectedOptionInput").value = option;

	}
	
	
	

	document.addEventListener("DOMContentLoaded", function () {
		  // 진료과목 선택하는 요소
		var selectDepartment = document.querySelector(".selectDepartment");

		  // 키워드에 해당하는 게시글만 필터링하는 함수
		  function filterByKeyword(keyword) {
		    var qnaListContainer = document.getElementById("qnaListContainer");
		    var qnaItems = qnaListContainer.getElementsByClassName("list");

		    for (var i = 0; i < qnaItems.length; i++) {
		      var qnaItem = qnaItems[i];
		      var kindElement = qnaItem.querySelector(".kind");
		      
		      // "전체"를 선택한 경우 모든 아이템 보이기
		      if (keyword === "전체") {
		        qnaItem.style.display = "block";
		      } else {
		        // kind 값이 존재하고, kind 값이 선택한 키워드와 다를 경우 해당 아이템 숨김 처리
		        if (kindElement && kindElement.textContent !== keyword) {
		          qnaItem.style.display = "none";
		        } else {
		          qnaItem.style.display = "block";
		        }
		      }
		    }
		  }
		

		  // 각 진료과목 선택 시 이벤트 리스너 추가
		  var sortItems = document.querySelectorAll("#openSortList .selectSortList > div");
		  sortItems.forEach(function (item) {
		    item.addEventListener("click", function () {
		      // 선택한 키워드 가져오기
		      var selectedKeyword = item.textContent.trim();

		      // 진료과목 선택 버튼에 선택한 키워드 표시
		      selectDepartment.querySelector(".sortTitle").textContent = selectedKeyword;

		      // 키워드에 해당하는 게시글만 표시
		      filterByKeyword(selectedKeyword);
		    });
		  });
		});
	
	
	 
	

</script>
</html>