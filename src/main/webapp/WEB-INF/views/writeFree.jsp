<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 

<link rel="stylesheet" href="./css/writeFree.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>


<header>
    <i class="xi-angle-left xi-x" onclick="location.href = '/qnaBoard'"></i>
    <div class="header title">작성하기</div>
    <div class="blank"></div>
</header>


	<main>


	<!-- <h2>[자유 게시판 글쓰기]</h2> -->
	<form action='<c:url value='/postFree'/>' method="post" id="freeForm">
		<div>
			<input type="text" name="btitle" class="btitle">
		</div>
		<div>
			
			<textarea rows="5" cols="13" name="bcontent" class="bcontent"></textarea>
		</div>
		<input type="hidden" name="bdate" id="bdate">
		<div class="rightSide">
		<button type="button" onclick="location.href='qnaBoard'" class="cancel">목록</button>
		<button type="submit" class="submit">완료</button>
		</div>
	</form>

	<!-- <div id="imagePreview"></div> -->
<div style="height: 9vh"></div>
</main>


	<footer></footer>


	<script>
		// 폼이 제출될 때 현재 날짜와 시간을 입력란에 추가
		document.getElementById('freeForm').addEventListener(
				'submit',
				function(event) {
					event.preventDefault(); // 기본 제출 동작을 막음

					// 현재 날짜와 시간을 가져오기
					const currentDatetime = new Date();
					const utcDatetime = new Date(currentDatetime.toISOString()
							.slice(0, 19)
							+ "Z"); // UTC 시간으로 변환
					const formattedDatetime = new Date(utcDatetime.getTime()
							+ 9 * 60 * 60 * 1000);

					document.getElementById('bdate').value = formattedDatetime
							.toISOString().slice(0, 19).replace("T", " ");

					const title = document
							.querySelector('input[name="btitle"]').value;
					const content = document
							.querySelector('textarea[name="bcontent"]').value;

					// 제목이나 내용 중 하나라도 비어있으면 경고창을 띄우고 전송을 막음
					if (title.trim() === '') {
						alert('제목을 입력해주세요.');
						event.preventDefault(); // 폼 전송 막기
						return false;
					}
					if (content.trim() === '') {
						alert('내용을 입력해주세요.');
						event.preventDefault(); // 폼 전송 막기
						return false;
					}

					// 폼 제출
					this.submit();
				});

	</script>

</body>
</html>