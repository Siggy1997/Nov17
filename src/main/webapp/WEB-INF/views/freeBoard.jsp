<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<link rel="stylesheet" href="./css/qnaBoard.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

	<main>

		<div class="freeContainer">

			<!-- <h1>자유 게시판</h1> -->
			<div class="backGroundBar">
				<div class="space">
					<button class="writeButton" onclick="location.href='writeFree'">작성하기</button>
				</div>
			</div>

			<c:forEach items="${requestScope.freeList}" var="free">
				<a
					href="<c:url value='/freeDetail'>
    <c:param name='bno' value='${free.bno}' />
  </c:url>">
					<div class="freeList">
						<div class="space">
							<div class="title">${free.btitle}</div>
							<div class="content">${free.bcontent}</div>
							<div class="nickname">${free.mnickname}</div>
							<div class="rightSide">
								<div class="xi-comment-o xi-x"></div>
								<div class="countComment">${free.comment_count}</div>
								<div class="xi-heart-o xi-x"></div>
								<div class="countCalldibs">${free.bcalldibsCount}</div>
							</div>
						</div>
					</div>
					<div class="line"></div>
				</a>
			</c:forEach>

		</div>
		<div style="height: 9vh"></div>
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

	// 뒤로가기 버튼
	$(document).on("click", ".xi-angle-left", function() {
		history.back();
	});
</script>

</html>