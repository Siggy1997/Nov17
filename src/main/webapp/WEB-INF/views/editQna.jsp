<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/editQna.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

<header>
    <i class="xi-angle-left xi-x"></i>
    <div class="header title">상담하기</div>
    <div class="blank"></div>
</header>

<main>

<h2>[게시판 글 수정하기]</h2>



	<form action="/submitEditQna" method="post" id="editForm">
		<div>
			제목<input type="text" name="btitle" value="${btitle}">
		</div>
		<div>
			내용
			<textarea rows="5" cols="13" name="bcontent">${bcontent}</textarea>
		</div>
		<input type="hidden" name="bno" id="bno"
			value="${bno}">
			<select name = "selectDepartment">
		<option value = "department">진료과목</option>
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
          <option value = "unknown">잘 모름</option>
       </select>
		<button type="submit">완료</button>
		<button type="button" onclick="history.back()">취소</button>
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
	const selectDepartment = document.querySelector('select[name="selectDepartment"]').value;
			
			// 제목이나 내용 중 하나라도 비어있으면 경고창을 띄우고 전송을 막음
			if (title.trim() === '') {
				alert('제목을 입력해주세요.');
				event.preventDefault(); // 폼 전송 막기
				return false;
			}
			else if (content.trim() === '') {
				alert('내용을 입력해주세요.');
				event.preventDefault(); // 폼 전송 막기
				return false;
			}
			else if (selectDepartment === 'department') {
				alert('진료 과목을 선택해주세요.');
				event.preventDefault(); // 폼 전송 막기
				return false;
			} else {
				
			const selectedDepartment = selectDepartment === 'unknown' ? null : selectDepartment;
			this.submit();
			}
		});

	</script>

</body>
</html>