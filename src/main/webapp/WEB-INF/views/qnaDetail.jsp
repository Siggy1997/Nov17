<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="./css/qnaDetail.css">
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
	<div class="question">
	<!-- <div class="boardNum">${qnaQuestion.bno}</div> -->	
		<div class="btitle">${qnaQuestion.btitle}</div>
		<div class="mname">${qnaQuestion.mname}</div>
		<div class="bdate">${qnaQuestion.bdate}</div>
		
			<c:if test="${qnaQuestion.mno ne mno}">
		<i class="xi-minus-circle-o xi-x" id="reportButton"></i>
	</c:if>
		
		
		<br>
		
		<div class="bdetail">${qnaQuestion.bcontent}</div>
		
		<br>
		
		 <c:if test="${qnaQuestion.dpkind ne 'unknown'}">
		<div class="dpkind">${qnaQuestion.dpkind}</div>
		 </c:if>
	</div>





	<div id="reportModal" class="modal">
		<div class="modal-content">
			<span class="close" id="closeModal">&times;</span>
			<h2>신고하기</h2>

			<form action="/reportPost" method="post" id="reportForm">
				<input type="hidden" name="rpdate" id="rpdate"> <input
					type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
				<textarea rows="5" cols="13" name="rpcontent" id="rpcontent"
				placeholder="신고사유를 작성해주세요."></textarea>
				<button type="submit" id="submitReport">신고하기</button>
			</form>

		</div>
	</div>

	<c:if test="${isDibsTrue eq false}">
		<form id="callDibsForm" action="/qnaCallDibs" method="POST">
			<input type="hidden" id="callDibsInput" name="callDibsInput"
				value="false"> <input type="hidden" name="bno" id="bno"
				value="${qnaQuestion.bno}">
			<button type="submit" id="dibsButtonFalse">☆ 찜하기</button>
		</form>
	</c:if>

	<c:if test="${isDibsTrue eq true}">
		<form id="callDibsForm" action="/qnaCallDibs" method="POST">
			<input type="hidden" id="callDibsInput" name="callDibsInput"
				value="true"> <input type="hidden" name="bno" id="bno"
				value="${qnaQuestion.bno}">
			<button type="submit" id="dibsButtonTrue">★ 찜하기</button>
		</form>
	</c:if>


	<c:if test="${qnaQuestion.mno eq mno}">
		<form action="deleteQnaQuestion" method="post" id="deleteQnaQuestion">
			<input type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
			<i class="xi-trash-o xi-x" id="editButton" class="bdelete" onclick="deleteConfirm()"></i>
		</form>
	</c:if>

<c:if test="${qnaQuestion.mno eq mno}">
<form id="requestEditForm" action="/editQna" method="POST">
<input type="hidden" name="bno" id="bno"
			value="${qnaQuestion.bno}">
			<input type="hidden" name="btitle" id="btitle"
			value="${qnaQuestion.btitle}">
			<input type="hidden" name="bcontent" id="bcontent"
			value="${qnaQuestion.bcontent}">
			<input type="hidden" name="dpkind" id="dpkind"
			value="${qnaQuestion.dpkind}">
<i class="xi-pen-o xi-x" id="editButton"></i>
</form>
</c:if>

	<c:if test="${not empty dno}">
		<button type="button" id="answerToggleButton">답변 작성하기</button>
	</c:if>

	<div id="formContainer" style="display: none;">
		<form action="./writeQnaAnswer" method="post" id="qnaAnswerForm">
			<div>
	
				<textarea rows="5" cols="13" name="ccontent" id="ccontent"
					style="display: none;"></textarea>
			</div>
			<input type="hidden" name="cdate" id="cdate"> <input
				type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
			<button type="button" id="cancelAnswerButton">취소</button>
			<button type="submit" id="submitAnswerButton">완료</button>
		</form>
	</div>


	<br><div class="answerTitle">의료인 답변</div>
	<br>
	<br>
	<div class="answer">
		<c:forEach items="${qnaAnswer}" var="answer">
			<input type="hidden" name="hospitalNum" value="${answer.hno}">
			<input type="hidden" name="doctorNum" value="${answer.dno}">
			
			<div class="cdetail">${answer.ccontent}</div><br>
			<div class="cdate">${answer.cdate}</div>
			
			<c:if test="${answer.dno eq dno}">
				<form action="deleteQnaAnswer" method="post" id="deleteQnaAnswer">
					<input type="hidden" name="cno" id="cno" value="${answer.cno}">
					<input type="hidden" name="bno" id="bno" value="${qnaQuestion.bno}">
					<button class="cdelete" onclick="deleteConfirm()">삭제하기</button>
				</form>
		
			</c:if>
			<c:forEach items="${doctorInfo}" var="doctor">
			   <c:if test="${doctor.dno eq answer.dno}">
			   			<div class="cinfoLine_top"></div>
				<img class="doctorImg" src="${doctor.dimg}" alt="의사 이미지" height="75">
			   <div class="doctorInfo">
				<div class="doctorName">${doctor.dname} 의사</div>
				<div class="doctorDpkind">${doctor.dpkind}</div>
				<div class="hospital">${doctor.hname}</div>
				</div>
				<div class="cinfoLine_bottom"></div>
				 </c:if>
			</c:forEach>
		</c:forEach>
	</div>



</main>
<footer></footer>

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

		
		

		// "답변 작성하기" 버튼 클릭 시 답변 입력창 나타내기
		document.getElementById('answerToggleButton').addEventListener(
				'click',
				function() {

					const textarea = document.getElementById('ccontent');
					const formContainer = document
							.getElementById('formContainer');

					if (textarea.style.display === 'none') {
						textarea.style.display = 'block';
						formContainer.style.display = 'block';
					} else {
						textarea.style.display = 'none';
						formContainer.style.display = 'none';
					}
				});
		

		// "취소" 버튼 클릭 시 답변 입력창 가리기 
		document
				.getElementById('cancelAnswerButton')
				.addEventListener(
						'click',
						function() {
							document.getElementById('ccontent').style.display = 'none';
							document.getElementById('formContainer').style.display = 'none';
						});

		function deleteConfirm() {
			if (confirm("삭제하시겠습니까?")) {
				return true;
			} else {
				event.preventDefault(); // 기본 제출 동작을 막음
			}
		}

		// 버튼 클릭 시 모달 열기
		document.getElementById("reportButton").addEventListener("click", function() {
		    const mno = "${mno}"; 
		    
		    
		    
		    if (mno === null || mno === undefined || mno === "") {
		        // 로그인 창으로 이동
		        if (confirm("로그인 한 사용자만 이용할 수 있습니다. 로그인 하시겠습니까?")) {
		            window.location.href = "/login"; 
		        }
		        } else {
		        const reportCount = ${reportCount};
		        
		        if (reportCount !== 0) {
		            alert("이미 신고한 게시물입니다.");
		        } else {
		            document.getElementById("reportModal").style.display = "block";
		        }
		    }
		    
		});

		// 닫기 버튼 클릭 시 모달 닫기
		closeModal.addEventListener("click", function() {
			document.getElementById("reportModal").style.display = "none";
		});

		// 모달 외부 클릭 시 모달 닫기
		window.addEventListener("click", function(event) {
			if (event.target == document.getElementById("reportModal")) {
				document.getElementById("reportModal").style.display = "none";
			}
		});
		
		
		
		//찜버튼 유효성검사
		document.getElementById("dibsButtonFalse").addEventListener("click", function (event) {
    const mno = "${mno}";

    if (mno === null || mno === undefined || mno === "") {
        event.preventDefault();

        if (confirm("로그인 한 사용자만 이용할 수 있습니다. 로그인 하시겠습니까?")) {
            window.location.href = "/login";
        }
    }
});
		
		
		document.addEventListener('DOMContentLoaded', function() {
		    var mnameElements = document.getElementsByClassName('mname');
		    
		    for (var i = 0; i < mnameElements.length; i++) {
		        var originalText = mnameElements[i].innerText;

		        if (originalText.length >= 2) {
		            var shortenedText = originalText.charAt(0) + 'O'.repeat(originalText.length - 1);
		            mnameElements[i].innerText = shortenedText;
	
		        }
		    }
		});
		
		// 뒤로가기 버튼
		$(document).on("click", ".xi-angle-left", function(){
			history.back();
		});
		
	</script>

</body>
</html>