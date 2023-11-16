<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 

<script src="./js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="./css/freeDetail.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

	<header>
		 <i class="xi-angle-left xi-x" onclick="location.href = '/qnaBoard'"></i>
		<div class="header title">자유게시판</div>
		<div class="blank"></div>
	</header>

	<main>

		<!-- <button class="toFreeBoard" onclick="location.href='freeBoard'">목록으로</button> -->
<div class="space">
		<div class="freePosting">
			<!-- <div class="boardNum">글번호 ${freePosting.bno}</div> -->

			<div class="btitle">${freePosting.btitle}</div>

			<div class="bnickname">${freePosting.mnickname}</div>
			<div class="dot">•</div>
			<div class="bdate">${freePosting.bdate}</div>
	<c:if test="${freePosting.mno ne mno}">
			<img id="reportButton" src='/img/siren.png'/>
		</c:if>
			<div class="bdetail">${freePosting.bcontent}</div>


		</div>

<div class="sideContainer">
		<c:if test="${isDibsTrue eq false}">
			<form id="callDibsForm" action="/freePostLike" method="POST">
				<input type="hidden" id="likePostInput" name="likePostInput"
					value="false"> <input type="hidden" name="bno" id="bno"
					value="${freePosting.bno}">
				<button type="submit" id="dibsButtonFalse">♡ 공감하기</button>
			</form>
		</c:if>

		<c:if test="${isDibsTrue eq true}">
			<form id="callDibsForm" action="/freePostLike" method="POST">
				<input type="hidden" id="likePostInput" name="likePostInput"
					value="true"> <input type="hidden" name="bno" id="bno"
					value="${freePosting.bno}">
				<button type="submit" id="dibsButtonTrue">♥ 공감하기</button>
			</form>
		</c:if>


		<c:if test="${freePosting.mno eq mno}">
			<form id="requestEditForm" action="/editBoard" method="POST">
				<input type="hidden" name="bno" id="bno" value="${freePosting.bno}">
				<input type="hidden" name="btitle" id="btitle"
					value="${freePosting.btitle}"> <input type="hidden"
					name="bcontent" id="bcontent" value="${freePosting.bcontent}">
				<button class="xi-pen-o xi-x" id="editButton"></button>
			</form>
		</c:if>
		</div>


	
	<!-- 신고하기 모달 -->
		<div id="reportModal" class="modal">
			<div class="modal-content">
				<span class="close" id="closeModal">&times;</span>
				<h2>신고하기</h2>
				<form action="/reportFreePost" method="post" id="reportForm">
					<input type="hidden" name="rpdate" id="rpdate"> <input
						type="hidden" name="bno" id="bno" value="${freePosting.bno}">
					<textarea rows="5" cols="13" name="rpcontent" id="rpcontent"
					placeholder="신고사유를 작성해주세요."></textarea>
					<button type="submit" id="submitReport">신고하기</button>
				</form>
			</div>
		</div>
</div>




		<div class="comment">
		<div class="commentTitle"><div class="space">댓글</div></div>
		<div class="space">
			<c:forEach items="${freeComment}" var="comment">
					<div class="cnickname">${comment.mnickname}</div>
					<div class="cdetail">${comment.ccontent}</div>
					<div class="cdate">${comment.cdate}</div>

					<div class="rightSide">
						<c:if test="${comment.mno ne mno}">
							<button type="submit"
								id="commentReportButton" data-bno="${freePosting.bno}"
								data-cno="${comment.cno}"></button>
						</c:if>

						<c:if test="${comment.mno eq mno}">
							<form action="/deleteFreeComment" method="post"
								id="deleteFreeComment">
								<input type="hidden" name="cno" id="cno" value="${comment.cno}">
								<input type="hidden" name="bno" id="bno"
									value="${freePosting.bno}">
								<button class="xi-trash-o xi-x" id="cdelete"
									onclick="deleteConfirm()"></button>
							</form>
						</c:if>
					</div>
					<div class="line"></div>


				<div id="commentReportModal" class="modal">
					<div class="modal-content">
						<span class="close" id="closeModal2">&times;</span>
						<h2>신고하기</h2>
						신고 사유
						<form action="/reportFreeComment" method="post"
							id="commentReportForm">
							<input type="hidden" name="crpdate" id="crpdate"> <input
								type="hidden" name="cno" id="cno" value="${comment.cno}">
							<input type="hidden" name="bno" id="bno"
								value="${freePosting.bno}">
							<textarea rows="5" cols="13" name="rpcontent" id="rpcontent"></textarea>
							<button type="submit">신고하기</button>
						</form>
					</div>
				</div>
			</c:forEach>
			</div>
		</div>
		
		<!-- 로그인 알림 -->
	<div class="dh-modal-wrapper">
		<div class="dh-modal-login">
			<div class="dh-modal-header">
				<img src="https://cdn-icons-png.flaticon.com/512/7960/7960597.png">
				<div class="dh-modal-body">
					<span class="h4">로그인 후에<br> 이용하실 수 있는 서비스입니다.</span>
					<span class="h6">닥터홈 로그인 후 많은 서비스를 경험해 보세요.</span>
				</div>
			</div>
			<div class="dh-modal-footer">
				<button class="dh-modal-button dh-close-modal">취소</button>
				<button class="dh-modal-button" onclick="location.href='/login'">로그인</button>
			</div>
		</div>
     </div>
     
     	<!-- 댓글 알림 -->
     <div id="dh-modal-alert">
		<div class="dh-modal">
			<div class="dh-modal-content">
				<div class="dh-modal-title">
					<img class="dh-alert-img" src="https://cdn-icons-png.flaticon.com/512/6897/6897039.png">
					알림
				</div>
				<div class="dh-modal-text">내용을 입력해주세요.</div>
			</div>
		</div>
		<div class="dh-modal-blank"></div>
	</div>
     
	
	<div style="height: 9vh"></div>
	</main>

	<footer>

		<div id="formContainer">
			<form action="/writeFreeComment" method="post" id="freeCommentForm">
				<div>
					<textarea rows="5" cols="13" name="ccontent" id="ccontent"></textarea>
				</div>
				<input type="hidden" name="cdate" id="cdate"> <input
					type="hidden" name="bno" id="bno" value="${freePosting.bno}">
				<button type="submit" id="submitCommnetButton"
					class="xi-message-o xi-2x"></button>
			</form>
		</div>


	</footer>


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

		
		document.getElementById('freeCommentForm').addEventListener(
				'submit',
				function(event) {

					var content = document.getElementById('ccontent').value
							.trim();

					if (content.trim() === '') {
						
						//알림
					    $("#dh-modal-alert").addClass("active").fadeIn();
					    setTimeout(function() {
					        $("#dh-modal-alert").fadeOut(function(){
					            $(this).removeClass("active");
					        });
					    }, 1000);
					

						event.preventDefault(); // 폼 전송 막기
						return false;
					}

					// 폼 제출
					this.submit();
				});

		function deleteConfirm() {
			if (confirm("삭제하시겠습니까?")) {
				return true;
			} else {
				event.preventDefault(); // 기본 제출 동작을 막음
			}
		}

		$(".dh-modal-wrapper").hide();
		$(document).on("click", ".dh-close-modal", function(){
			$(".dh-modal-wrapper").hide();
		});

		
		//찜버튼 유효성검사
		document.getElementById("dibsButtonFalse").addEventListener("click",
				function(event) {
					const mno = "${mno}";

					if (mno === null || mno === undefined || mno === "") {
						event.preventDefault();

						$(".dh-modal-wrapper").show();
					}
				});

		// 버튼 클릭 시 모달 열기

		document.getElementById("reportButton").addEventListener("click", function() {
		   
			const mno = "${mno}"; 
		    
		    
		    if (mno === null || mno === undefined || mno === "") {
		       
		    	$(".dh-modal-wrapper").show();
		    	
		        } else {
		        const reportCount = ${reportCount};
		        
		        if (reportCount !== 0) {
		            alert("이미 신고한 게시물입니다.");
		        } else {
		            document.getElementById("reportModal").style.display = "block";
		        }
		    }
		    
		});


						});

		$(document)
				.on(
						"click",
						"#commentReportButton",
						function() {

							const mno = "${mno}";
							const bno = $(this).data("bno");
							const cno = $(this).data("cno");


							 if (mno === null || mno === undefined || mno === "") {
								 $(".dh-modal-wrapper").show();
							 } else {
							
							
							$.ajax({
										url : "/commentReportCount",
										type : "post",
										data : {
											bno : bno,
											cno : cno
										},
										success : function(result) {
											const data = JSON.parse(result);

											if (data.result !== 0) {
												alert("이미 신고한 댓글 입니다");
											} else {
												document
														.getElementById("commentReportModal").style.display = "block";

												// 닫기 버튼 클릭 시 모달 닫기
												closeModal2
														.addEventListener(
																"click",
																function() {
																	document
																			.getElementById("commentReportModal").style.display = "none";
																});

												// 모달 외부 클릭 시 모달 닫기
												window
														.addEventListener(
																"click",
																function(event) {
																	if (event.target == document
																			.getElementById("commentReportModal")) {

																		document
																				.getElementById("commentReportModal").style.display = "none";
																	});

													// 모달 외부 클릭 시 모달 닫기
													window
															.addEventListener(
																	"click",
																	function(
																			event) {
																		if (event.target == document
																				.getElementById("commentReportModal")) {
																			document
																					.getElementById("commentReportModal").style.display = "none";
																		}
																	});
												}

											},
											error : function() {
												// 오류 처리
											}
										});

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


	
		
		
	</script>


</body>
</html>