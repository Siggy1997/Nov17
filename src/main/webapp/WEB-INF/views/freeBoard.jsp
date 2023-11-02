<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h1>자유 게시판</h1>

<button onclick="location.href='writeFree'">작성하기</button>

	<c:forEach items="${freeList}" var="free">
		<a
			href="<c:url value='/freeDetail'>
    <c:param name='bno' value='${free.bno}' />
  </c:url>">
			<div class="list">
				<div class="title">${free.btitle}</div>
				<div class="content">${free.bcontent}</div>
				<div class="count">${free.comment_count}</div>
			</div>
		</a>
		<br>
	</c:forEach>
	
	
	
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

</body>
</html>