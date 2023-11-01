<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


	<div class="freePost">
		<div class="boardNum">${freePost.bno}</div>
		<div class="btitle">${freePost.btitle}</div>
		익명
		<div class="bdetail">${freePost.bcontent}</div>
		<div class="bdate">${freePost.bdate}</div>
	</div>


<div id="formContainer">
      <form action="./writeFreeComment" method="post" id="freeCommentForm">
         <div>
            댓글작성<br>
            <textarea rows="5" cols="13" name="ccontent" id="ccontent"></textarea>
         </div>
         <input type="hidden" name="cdate" id="cdate"> <input
            type="hidden" name="bno" id="bno" value="${freePost.bno}">
         <button type="submit" id="submitCommnetButton">완료</button>
         <button type="button" id="cancelCommnetButton">취소</button>
      </form>
   </div>


	

<br> 댓글
	<div class="comment">
		<c:forEach items="${freeComment}" var="comment">
			<div class="cdetail">${comment.ccontent}</div>
			<div class="cdate">${comment.cdate}</div>
			<c:if test="${comment.mno eq mno}">
				<form action="deleteFreeComment" method="post" id="deleteFreeComment">
				<input type="hidden" name="cno" id="cno" value="${comment.cno}">
					<input type="hidden" name="bno" id="bno" value="${freePost.bno}">
					<button class="cdelete">삭제하기</button>
				</form>
			</c:if>
			<br>
		</c:forEach>
	</div>

	




	<script>
	
		//날짜, 시간 변환하기
		function updateDate(element, dateString) {
			const postTime = new Date(dateString);
			const currentTime = new Date();
			const timeDiff = currentTime - postTime;
			const minutesDiff = Math.floor(timeDiff / (1000 * 60));

			if (minutesDiff < 1) {
				element.textContent = "방금 전";
			} else if (minutesDiff < 60) {
				element.textContent = minutesDiff + "분 전";
			} else if (minutesDiff < 24 * 60) {
				const hoursDiff = Math.floor(minutesDiff / 60);
				element.textContent = hoursDiff + "시간 전";
			} else {
				const year = postTime.getFullYear();
				const month = postTime.getMonth() + 1; // 월은 0부터 시작하므로 1을 더해줌
				const day = postTime.getDate();
				const formattedDate = year + "." + month + "." + day;
				element.textContent = formattedDate;
			}
		}

		document.addEventListener("DOMContentLoaded", function() {
			// bdate, cdate에 적용
			const bdateElements = document.querySelectorAll(".bdate");
			bdateElements.forEach(function(element) {
				updateDate(element, element.textContent);
			});

			const cdateElements = document.querySelectorAll(".cdate");
			cdateElements.forEach(function(element) {
				updateDate(element, element.textContent);
			});
		});

		
		// 댓글 작성 시 현재 날짜와 시간을 추가
	      document.getElementById('freeCommentForm').addEventListener(
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

	               document.getElementById('cdate').value = formattedDatetime
	                     .toISOString().slice(0, 19).replace("T", " ");

	               const content = document
	                     .querySelector('textarea[name="ccontent"]').value;

	               // 폼 제출
	               this.submit();
	            });
		
	</script>

</body>
</html>