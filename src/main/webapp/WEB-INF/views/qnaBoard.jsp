<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/qnaBoard.css">

<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>


<header>
    <i class="xi-angle-left xi-x"></i>
    <div class="header title">커뮤니티</div>
    <div class="blank"></div>
</header>

<main>

<div id="boardButtonsContainer">
<button id="qnaBoardButton" onclick="toggleBoard('qnaBoard')" style="display: none;">QnA게시판</button>
<button id="qnaBoardBoldButton">QnA게시판</button>
<button id="freeBoardButton" onclick="toggleBoard('freeBoard')">자유게시판</button>
<button id="freeBoardBoldButton" style="display: none;">자유게시판</button>
</div>
<!-- <button id="hospitalMapButton" onclick="location.href='hospitalMap'">병원지도</button> -->

	<form action="/searchWord" method="post" onsubmit="searchForm()">
		<select name = "selectOption">
          <option value = "all" selected>제목+내용</option>
          <option value = "title">제목만</option>
          <option value = "content">내용만</option>
       </select>	
		<input type="text" name="searchWord" id="searchWordInput"
			placeholder="검색 할 내용을 입력하세요">		
		<button type="submit" class="xi-search xi-x"></button>
	</form>




<div id="freeBoard" style="display:none;">
    <jsp:include page="freeBoard.jsp">
        <jsp:param name="freeList" value="${requestScope.freeList}" />
    </jsp:include>
</div>



<div id="qnaBoard" style="display:block;"> 
<!-- <h1>QnA 게시판</h1> -->

<button class="writeButton" onclick="confirmWriteQna()">작성하기</button>

<select name ="selectDepartment" id="selectDepartment">
		<option>진료과목</option>
          <option value = "소아과">소아과</option>
          <option value = "치과">치과</option>
          <option value = "내과">내과</option>
          <option value = "이비인후과">이비인후과</option>
          <option value = "피부과">피부과</option>
          <option value = "산부인과">산부인과</option>
          <option value = "안과">안과</option>
          <option value = "정형외과">정형외과</option>
          <option value = "한의학과">한의학과</option>
          <option value = "비뇨기과">비뇨기과</option>
          <option value = "신경과">신경과</option>
          <option value = "외과">외과</option>
          <option value = "정신의학과">정신의학과</option>
       </select>	


<div id="qnaListContainer">
            <c:forEach items="${qnaList}" var="qna"> 
                <a href="<c:url value='/qnaDetail'><c:param name='bno' value='${qna.bno}' /></c:url>">
                    <div class="list"> 
                        <div class="title">${qna.btitle}</div>
                        <div class="content">${qna.bcontent}</div>
                        <c:if test="${qna.dpkind ne 'unknown'}">
                            <div class="kind">${qna.dpkind}</div>
                        </c:if>
                        <c:choose>
                            <c:when test="${qna.comment_count == 0}">
                            <div class="wait">
                                "답변 대기 중"
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="count">답변 ${qna.comment_count}개</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>
            </c:forEach>

</div>

</div>

</main>
<footer></footer>

</body>

<script>
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
    var maxLength = 30; // 최대 문자열 길이
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
$(document).ready(function () {
   
    $("#selectDepartment").change(function () {
        // 선택된 부서 값을 가져옴
        var selectedDepartment = $(this).val();

      
        $.ajax({
            type: "GET",
            url: "/selectDepartment",
            data: { department: selectedDepartment },
            success: function (response) {
               
                updateQnaList(response);
            },
            error: function (error) {
                console.error("Error fetching data:", error);
            }
        });
    });
});
</script>
<script>
    function updateQnaList(filteredQnaList) {
        var qnaListContainer = document.getElementById("qnaListContainer");
        qnaListContainer.innerHTML = "";

        for (var i = 0; i < filteredQnaList.length; i++) {
            var qna = filteredQnaList[i];
            var listItem = document.createElement("div");
            listItem.className = "list";
            listItem.innerHTML = "<a href='/qnaDetail?bno=" + qna.bno + "'>" +
                "<div class='title'>" + qna.btitle + "</div>" +
                "<div class='content'>" + qna.bcontent + "</div>" +
                "<div class='kind'>" + qna.dpkind + "</div>" +
                (qna.comment_count == 0 ? "답변 대기 중" : "<div class='count'>답변 " + qna.comment_count + "개</div>") +
                "</div></a><br>";
            qnaListContainer.appendChild(listItem);
        }
    }
</script>
<script>
function confirmWriteQna() {
    const mno = "${mno}";

    if (mno === null || mno === undefined || mno === "") {
        if (confirm("로그인 한 사용자만 작성할 수 있습니다. 로그인 하시겠습니까?")) {
            window.location.href = "/login";
        }
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
</script>
</html>