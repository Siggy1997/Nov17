<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>[게시판 글 수정하기]</h2>

	<form action="/submitEditBoard" method="post" id="editForm">
		<div>
			제목<input type="text" name="btitle" value="${btitle}">
		</div>
		<div>
			내용
			<textarea rows="5" cols="13" name="bcontent">${bcontent}</textarea>
		</div>
		<input type="hidden" name="bno" id="bno"
			value="${bno}">
		<input type="hidden" name="btype" id="btype"
			value="${btype}">
		<button type="submit">완료</button>
		<button type="button" onclick="history.back()">취소</button>
	</form>

<script>
		
		document.getElementById('editForm').addEventListener(
				'submit',
				function(event) {
					
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