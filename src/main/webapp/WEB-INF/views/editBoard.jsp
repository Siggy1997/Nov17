<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/editBoard.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

<header>
    <i class="xi-angle-left xi-x"></i>
    <div class="header title">글 수정하기</div>
    <div class="blank"></div>
</header>

<main>

<!-- <h2>[게시판 글 수정하기]</h2> -->

	<form action="/submitEditBoard" method="post" id="editForm">
		<div>
		<input type="text" name="btitle" class="btitle" value="${btitle}">
		</div>
		<div>
			<textarea rows="5" cols="13" name="bcontent" class="bcontent">${bcontent}</textarea>
		</div>
		<input type="hidden" name="bno" id="bno"
			value="${bno}">
			<div class="rightSide">
		<button type="button" class="cancel" onclick="history.back()">취소</button>
		<button type="submit" class="submit">완료</button>
		</div>
	</form>
	
	</main>
	
	<footer></footer>

<script>
		
		document.getElementById('editForm').addEventListener(
				'submit',
				function(event) {
					
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