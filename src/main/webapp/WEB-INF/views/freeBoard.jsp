<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="./css/freeBoard.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

<main>

<!-- <h1>자유 게시판</h1> -->

<button class="freeWriteButton" onclick="location.href='writeFree'">작성하기</button>

	<c:forEach items="${requestScope.freeList}" var="free">
		<a href="<c:url value='/freeDetail'>
    <c:param name='bno' value='${free.bno}' />
  </c:url>">
			<div class="list">
				<div class="title">${free.btitle}</div>
				<div class="content">${free.bcontent}</div>
				<div class="nickname">${free.mnickname}</div>
				<div class= "rightSide">
				<div class="xi-comment-o xi-x"></div>
				<div class="countComment">${free.comment_count}</div>
				<div class="xi-heart-o xi-x"></div>
				<div class="countCalldibs">${free.bcalldibsCount}</div>
				</div>
			</div>
		</a>
	</c:forEach>
	
	</main>
	
	<footer></footer>
	
	
	
</body>
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
    
    
</script>

</html>