<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="./js/jquery-3.7.0.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<form action="/searchWord" method="post" onsubmit="searchForm()">
		<select name = "selectOption">
          <option value = "all" selected>제목+내용</option>
          <option value = "title">제목만</option>
          <option value = "content">내용만</option>
       </select>	
		<input type="text" name="searchWord" id="searchWordInput"
			placeholder="검색 할 내용을 입력하세요">		
		<button type="submit">검색</button>
	</form>

<button id="qnaBoardButton" onclick="toggleBoard('qnaBoard')">QnA게시판</button>
<button id="freeBoardButton" onclick="toggleBoard('freeBoard')">자유게시판</button>
<!-- <button id="hospitalMapButton" onclick="location.href='hospitalMap'">병원지도</button> -->



<div id="freeBoard" style="display:none;">
    <jsp:include page="freeBoard.jsp">
        <jsp:param name="freeList" value="${requestScope.freeList}" />
    </jsp:include>
</div>



<div id="qnaBoard" style="display:block;"> 
<h1>QnA 게시판</h1>

<button onclick="location.href='writeQna'">작성하기</button>

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

    <!-- 필터링 전 코드 -->
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
                                "답변 대기 중"
                            </c:when>
                            <c:otherwise>
                                <div class="count">답변 ${qna.comment_count}개</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </a>
                <br>
            </c:forEach>

</div>

</div>


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
    // select 요소의 변경이 감지되면 실행되는 함수
    $("#selectDepartment").change(function () {
        // 선택된 부서 값을 가져옴
        var selectedDepartment = $(this).val();

        // AJAX를 사용하여 서버에 데이터 요청
        $.ajax({
            type: "GET",
            url: "/selectDepartment",
            data: { department: selectedDepartment },
            success: function (response) {
                // 서버로부터 받은 응답을 사용하여 게시글을 업데이트
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
        qnaListContainer.innerHTML = ""; // 기존 목록 초기화

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
</body>
</html>