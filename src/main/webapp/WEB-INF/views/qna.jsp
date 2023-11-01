<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


    <c:forEach items="${qnaList}" var="qna">
     <a href="<c:url value='/detail'/>?bno=${qna.bno}">
    <div class="table">   
      <div class="title">${qna.btitle}</div>
      <div class="detail">${qna.bdetail}</div>
      <div class="count">${qna.comment_count}</div><br>
</div>
</a>
    </c:forEach>

<script>
    var maxLength = 30; // 최대 문자열 길이
    var detailElements = document.querySelectorAll(".detail");

    detailElements.forEach(function(detailElement) {
        var text = detailElement.textContent;

        if (text.length > maxLength) {
            var truncatedText = text.slice(0, maxLength) + "...";
            detailElement.textContent = truncatedText;
        }
    });
</script>
</body>
</html>