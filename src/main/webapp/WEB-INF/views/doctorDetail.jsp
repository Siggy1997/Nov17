<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Calendar, java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>doctorDetail</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/doctorDetail.css">
<script src="../js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">
	$(function() {
		let sessionId = '';
		
		/* 그래프 : hospitalDetail 참고 */
		let verygood = parseInt(${reviewCount.veryGood});
		let good = parseInt(${reviewCount.good});
		let normal = parseInt(${reviewCount.normal});
		let bad = parseInt(${reviewCount.bad});
		let verybad = parseInt(${reviewCount.veryBad});

		let maxCount = Math.max(verygood, good, normal, bad, verybad);

		displayBar(document.getElementById('verygood-bar'), (verygood / maxCount) * 100);
		displayBar(document.getElementById('good-bar'), (good / maxCount) * 100);
		displayBar(document.getElementById('normal-bar'), (normal / maxCount) * 100);
		displayBar(document.getElementById('bad-bar'), (bad / maxCount) * 100);
		displayBar(document.getElementById('verybad-bar'), (verybad / maxCount) * 100);
		
		
		function displayBar(barElement, targetValue) {
		    barElement.style.width = targetValue + '%';
		}
		
		/* 서브메뉴 고정 : hospitalDetail 참고 */
		let offsetSubMenu = $(".doctorBar").offset().top;
		
		/* 특정 div 위치에 도달시 서브 메뉴 바꾸기 */
		let offsetIntroduce = $(".doctorInfoBox").offset().top - (18 * window.innerHeight / 100);
		let offsetReview = $(".doctorReviewBox").offset().top - (18 * window.innerHeight / 100);
		
		$(window).scroll(function() {
		    let scrollPos = $(window).scrollTop();
			/* 고정 */
		    if (scrollPos >= offsetSubMenu - (7 * window.innerHeight / 100)) {
		    	 $(".doctorBar").addClass("fixed");
		        $('#placeHolderDiv').show();
		    } else {
		    	 $(".doctorBar").removeClass("fixed");
		        $('#placeHolderDiv').hide();
		    }
			
			/* 하이라이트 */
		    if (scrollPos >= offsetMedical && scrollPos < offsetIntroduce) {
		        $('#subMenu1').addClass('selectOption').siblings().removeClass('selectOption');
		    }
		    if (scrollPos >= offsetHospital && scrollPos < offsetDoctor) {
		        $('#subMenu2').addClass('selectOption').siblings().removeClass('selectOption');
		    }
		});

		/* 서브 메뉴 클릭시 보내기 */
		$(document).on("click", ".doctorBarIntroduce", function() {
		    let offset;
		    
		    if ($(this).text() == '소개') {
		        offset = $(".doctorInfoBox").offset().top - (15 * window.innerHeight / 100);
		    }  else {
		        offset = $(".doctorReviewBox").offset().top - (18 * window.innerHeight / 100);
		    }
		    $("html, body").animate({
		        scrollTop: offset
		    }, 450);
		});
		
		sessionId = <%=session.getAttribute("mno")%>
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function() {
			history.back();
		});

		/* 병원 상세보기 이동 */
		$(document).on("click", ".doctorHospital", function() {
			location.href = '/hospitalDetail/${doctor.hno}';
		});

		/* 리뷰 작성할 때 로그인 체크 */
		$(document).on("submit", "#reviewWrite", function(event) {
			if (!loginCheck()) {
				event.preventDefault();
			}
		});

		/* 리뷰 날짜 변경하기 */
		$(".reviewDate").each(function() {
			let rdate = $(this).text();
			let day = rdate.split(" ")[0];
			let time = rdate.split(" ")[1];

			let datetime = new Date(rdate);
			let today = new Date();
			let isToday = datetime.toDateString() === today.toDateString();

			let dateFormat = isToday ? time : day;
			$(this).text(dateFormat);

		});

		/* 정렬 */
		$(document).on("click", ".sortReviewButton", function() {
			let reviewKeyword = $(this).text().trim();
			/* 최신 순 정렬 */
			if (reviewKeyword === '최신 순') {
				let reviewWriteBox = $(".reviewWriteBox");
				reviewWriteBox.sort(function(a, b) {
					let dateA = new Date($(a).find(".dateTime").val());
					let dateB = new Date($(b).find(".dateTime").val());
					return dateB - dateA;
				});
				$(".reviewBox").html(reviewWriteBox);
			}

			/* 오래된 순 정렬 */
			if (reviewKeyword === '오래된 순') {
				let reviewWriteBox = $(".reviewWriteBox");
				reviewWriteBox.sort(function(a, b) {
					let dateA = new Date($(a).find(".dateTime").val());
					let dateB = new Date($(b).find(".dateTime").val());
					return dateA - dateB;
				});
				$(".reviewBox").html(reviewWriteBox);
			}

			/* 별점 높은 순 정렬 */
			if (reviewKeyword === '별점 높은 순') {
				let reviewWriteBox = $(".reviewWriteBox");
				reviewWriteBox.sort(function(a, b) {
					let ratingA = $(a).find(".xi-star").length;
					let ratingB = $(b).find(".xi-star").length;
					return ratingB - ratingA;
				});
				$(".reviewBox").html(reviewWriteBox);
			}

			/* 별점 낮은 순 정렬 */
			if (reviewKeyword === '별점 낮은 순') {
				let reviewWriteBox = $(".reviewWriteBox");
				reviewWriteBox.sort(function(a, b) {
					let ratingA = $(a).find(".xi-star").length;
					let ratingB = $(b).find(".xi-star").length;
					return ratingA - ratingB;
				});
				$(".reviewBox").html(reviewWriteBox);
			}
		});

		/* 리뷰 글쓴이 익명처리 */
		$(".reviewName").each(function() {
			let anonymousName = anonymous($(this).text());
			$(this).text(anonymousName);
		})

		/* 리뷰 추천하기 */
		$(document).on("click", ".recommend", function() {
			let currentButton = $(this);
			if (loginCheck()) {
				let rno = $(this).parent().siblings(".rno").val();
				$.ajax({
					url : "../reviewRecommend",
					type : "post",
					dataType : "json",
					data : {
						rno : rno
					},
					success : function(data) {
						currentButton.find(".likeUp").text(data.rlike);
					},
					error : function(error) {
						alert("Error");
					}
				});
			}
		});

		/* 내 글 삭제하기 */
		$(document).on("click", ".delete", function() {
			let currentDelete = $(this);
			if (confirm("리뷰를 삭제하시겠습니까?")) {
				let rno = $(this).siblings(".rno").val();
				$.ajax({
					url : "../reviewDelete",
					type : "post",
					dataType : "json",
					data : {
						rno : rno
					},
					success : function(data) {
						currentDelete.parent(".reviewWriteBox").hide();
					},
					error : function(error) {
						alert("Error");
					}
				});
			}
		});

		/* 내 리뷰 수정하기 */
		$(document).on("click", ".edit", function() {
			if (confirm("리뷰를 수정하시겠습니까?")) {
				$(this).siblings(".reviewEdit").show();
				$(this).siblings(".reviewContent").hide();
			}
		});

		/* 내 리뷰 수정해서 보여주기 */
		$(document).on("click", ".editButton", function() {
			let currentEdit = $(this).parent(".reviewEdit");
			let rno = currentEdit.siblings(".rno").val();
			let rcontent = $(this).siblings(".reviewEditWrite").val();
			$.ajax({
				url : "../reviewEdit",
				type : "post",
				dataType : "json",
				data : {
					rno : rno,
					rcontent : rcontent
				},
				success : function(data) {
					currentEdit.siblings(".reviewContent").text(rcontent);
					currentEdit.hide();
					currentEdit.siblings(".reviewContent").show();
				},
				error : function(error) {
					alert("Error");
				}
			});
		});

		/* 비대면 진료 신청할 때 로그인 체크 */
		$(document).on("submit", "#telehealthApply", function(event) {
			if (!loginCheck()) {
				event.preventDefault();
			}
		});

		/* 진료 중일 때만 비대면 진료하기 */
		if ($(".application").length > 0) {
			if ($(".doctorStatus_text").text() == '진료 중') {
				$(".application").addClass("submit-btn-css").prop("disabled", false);;
				$(".application").disabled(abled);
			} else {
				$(".application").text("비대면 진료 종료").removeClass("submit-btn-css").prop("disabled", true);
			}
   	 	}
		
		/* Collection of functions */

		/* 로그인 체크 */
		function loginCheck() {
			if (sessionId == 'null' || sessionId == '') {
				if (confirm("로그인을 해야 이용할 수 있는 서비스입니다. 로그인 하시겠습니까?")) {
					return location.href = './login';
				} else {
					return false;
				}
			} else {
				return true;
			}
		}

		/* 이름 익명 처리하기 */
		function anonymous(name) {
			let lastName = name.charAt(0);
			let firstName = '○'.repeat(name.length - 1);
			return lastName + firstName;
		}
	});
</script>

</head>
<body>

	<!-- header -->
	<header>
		<i class="xi-angle-left xi-x"></i>
		<div class="headerTitle">의사 정보</div>
		<div class="blank"></div>
	</header>

	<!-- main -->
	<main class="doctorContainerBox container">
		<div class="doctorHeader">
			<div class="doctorImg margin-right">
				<img src="${doctor.dimg}">
			</div>
			<div class="doctorInfo">
				<!-- 의사 정보 -->
				<div class="doctorInfoHeader">
					<div class="doctorName">
						<c:choose>
							<c:when test="${doctor.dpno == 9}">한의사 ${doctor.dname}</c:when>
							<c:otherwise>의사 ${doctor.dname}</c:otherwise>
						</c:choose>
					</div>
					<div class="doctorStatus">

						<!-- 공휴일 -->
						<c:if test="${currentDay == '토요일' || currentDay == '일요일'}">
							<c:choose>
								<c:when test="${doctor.hholiday == 1}">
									<c:choose>
										<c:when
											test="${currentTime ge doctor.hopentime && currentTime le doctor.hholidayendtime}">
											<span class="availableCircle">● </span>
											<span class="doctorStatus_text">진료 중</span>
										</c:when>
										<c:otherwise>
											<span class="unavailableCircle">● </span>
											<span class="doctorStatus_text">진료 종료</span>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<span class="unavailableCircle">● </span>
									<span class="doctorStatus_text">휴진</span>
								</c:otherwise>
							</c:choose>
						</c:if>

						<!-- 평일 -->
						<c:if test="${ !(currentDay == '토요일' || currentDay == '일요일') }">
							<c:choose>
								<c:when test="${doctor.hnightday == currentDay}">
									<c:choose>
										<c:when
											test="${currentTime ge doctor.hopentime && currentTime le doctor.hnightendtime}">
											<span class="availableCircle">● </span>
											<span class="doctorStatus_text">진료 중</span>
										</c:when>
										<c:when
											test="${currentTime ge doctor.hbreaktime && currentTime le doctor.hbreakendtime}">
											<span class="unavailableCircle">● </span>
											<span class="doctorStatus_text">점심시간</span>
										</c:when>
										<c:otherwise>
											<span class="unavailableCircle">● </span>
											<span class="doctorStatus_text">진료 종료</span>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when
											test="${currentTime ge doctor.hopentime && currentTime le doctor.hclosetime}">
											<span class="availableCircle">● </span>
											<span class="doctorStatus_text">진료 중</span>
										</c:when>
										<c:when
											test="${currentTime ge doctor.hbreaktime && currentTime le doctor.hbreakendtime}">
											<span class="unavailableCircle">● </span>
											<span class="doctorStatus_text">점심시간</span>
										</c:when>
										<c:otherwise>
											<span class="unavailableCircle">● </span>
											<span class="doctorStatus_text">진료 종료</span>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
				</div>
				<div class="doctorInfoBody">
					<div class="doctorHospitalName margin-right">${doctor.hname}</div>
					|
					<div class="doctorDepartment margin-left">${doctor.dpkind}</div>
				</div>
				<div class="doctorInfoFooter">
					<img src="../img/star.png" style="width: 18px;">
					<div class="reviewScore">${doctor.dReviewAverage}</div>
					<div class="reviewCount margin-left">
						<c:choose>
							<c:when test="${doctor.count == 0}">신규</c:when>
							<c:otherwise>${doctor.count}회 진료</c:otherwise>
						</c:choose>
					</div>
				</div>
				<div class="dotorSpecialist">
					<c:choose>
						<c:when test="${doctor.dspecialist == 1}">
							<img src="../img/specialist.png" style="width: 18px">${doctor.dpkind} 전문의
					</c:when>
						<c:otherwise>일반의</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		<div class="graySeperate"></div>
		<!-- 의사 소개 -->
		<div class="doctorBody">
			<div class="doctorBar">
				<div id="subMenu1" class="doctorBarIntroduce selectOption">소개</div>
				<div id="subMenu2" class="doctorBarIntroduce">리뷰(${doctor.dReviewCount})</div>
			</div>
			<div id="placeHolderDiv" style="height: 7vh; display: none;"></div>
			<div class="doctorInfoBox">
				<div class="doctorTitle">의사 소개</div>
				<div class="doctorIntroduce">
					<h3>
						안녕하세요.
						<c:choose>
							<c:when test="${doctor.dpno == 9}">한의사 <span
									style="font-size: large; color: #00C9FF;">${doctor.dname}</span>입니다.</c:when>
							<c:otherwise>의사 <span
									style="font-size: 17px; color: #00C9FF;">${doctor.dname}</span>입니다.</c:otherwise>
						</c:choose>
					</h3>
					<p>${doctor.dinfo}</p>
				</div>
			</div>
			<div class="graySeperate"></div>
			<div class="doctorInfoBox">
				<div class="doctorTitle">경력 및 약력</div>
				<div class="doctorCareer">${doctor.dcareer}</div>
			</div>
			<div class="graySeperate"></div>
			<div class="doctorInfoBox">
				<div class="doctorTitle">소속 병원</div>
				<div class="doctorHospital">
					<div class="hospitalImg">
						<img src="${doctor.himg}" style="width: 70px;">
					</div>
					<div class="hospitalBox">
						<div class="hospitalName">${doctor.hname}</div>
						<div class="hospitalAddr">${doctor.haddr}</div>
					</div>
					<div class="hospitalNext">
						<span class="xi-angle-right"></span>
					</div>
				</div>
			</div>
			<div class="graySeperate"></div>


			<!-- 의사 리뷰 -->
			<div class="doctorReviewBox doctorInfoBox">
				<div class="doctorTitle">
					리뷰<span> ${doctor.dReviewCount}</span>
				</div>

				<div class="reviewHeader">

					<div class="doctorReviewScoreBoxLeft">
						<div class="doctorReviewScore">${doctor.dReviewAverage}</div>
						<div class="doctorReviewStar">
							<c:forEach begin="1"
								end="${fn:substringBefore(doctor.dReviewAverage, '.')}">
								<span class="xi-star"></span>
							</c:forEach>
							<c:forEach begin="1"
								end="${5 - fn:substringBefore(doctor.dReviewAverage, '.')}">
								<span class="xi-star-o"></span>
							</c:forEach>
						</div>
					</div>
					<div class="bar-container">
						<div class="count-container">
							<span>매우 만족</span>
							<div class="count-star" id="verygood-container">
								<div class="bar" id="verygood-bar"></div>
							</div>
						</div>

						<div class="count-container">
							<span>만족</span>
							<div class="count-star" id="good-container">
								<div class="bar" id="good-bar"></div>
							</div>
						</div>
						<div class="count-container">
							<span>보통</span>
							<div class="count-star" id="normal-container">
								<div class="bar" id="normal-bar"></div>
							</div>
						</div>
						<div class="count-container">
							<span>불만족</span>
							<div class="count-star" id="bad-container">
								<div class="bar" id="bad-bar"></div>
							</div>
						</div>
						<div class="count-container">
							<span>매우 불만족</span>
							<div class="count-star" id="verybad-container">
								<div class="bar" id="verybad-bar"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="doctorReviewWrite">
					<form id="reviewWrite" action="/doctorDetail/${doctor.dno}"
						method="post">
						<button class="reviewWritePage">리뷰 작성</button>
					</form>
				</div>

			</div>
			<div class="sortReview">
				<button type="button" class="sortReviewButton">최신 순</button>
				<button type="button" class="sortReviewButton">오래된 순</button>
				<button type="button" class="sortReviewButton">별점 높은 순</button>
				<button type="button" class="sortReviewButton">별점 낮은 순</button>
			</div>
			
			<div class="grayLine"></div>
			
			<div class="reviewBox">
				<c:forEach items="${doctorReview}" var="row">
					<div class="reviewWriteBox">
						<input class="rno" value="${row.rno}" type="hidden">
						<div class="reviewStar">
							<c:forEach begin="1" end="${row.rrate}">
								<span class="xi-star"></span>
							</c:forEach>
							<c:forEach begin="1" end="${5 - row.rrate}">
								<span class="xi-star-o"></span>
							</c:forEach>
						</div>
						<c:if test="${sessionScope.mno == row.mno}">
							<div class="delete">
								<img src="../img/trash.png" style="width: 5%">
							</div>
							<div class="edit">
								<img src="../img/edit.png" style="width: 5%">
							</div>
						</c:if>
						
						<div class="reviewKeyword">
							<c:forEach items="${row.rkeyword.split(',')}" var="keyword">
								<div class="keyword"># ${keyword}</div>
							</c:forEach>
						</div>
						<div class="reviewContent">${row.rcontent}</div>
						<div class="reviewEdit">
							<input value="${row.rcontent}" class="reviewEditWrite">
							<button type="button" class="editButton">수정</button>
						</div>
						<div class="reviewDate">${row.rdate}</div>
						<input class="dateTime" type="hidden" value="${row.rdate}">
						<div class="reviewName">${row.mname}</div>
						<div class="reviewLike">
							<button class="recommend">
								<img src="../img/thumbs_up.png" style="width: 10%;"><span
									class="likeUp">${row.rlike}</span>
							</button>
						</div>
						<hr>
						<!-- 나중에 지울 것 -->
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	</main>
	
	<form id="telehealthApply" action="/telehealthApply" method="get">
	<footer>
		<c:choose>
			<c:when test="${doctor.dtelehealth == 0 }">
				<button class="submit" type="button">비대면 진료 불가</button>
			</c:when>
			<c:otherwise>
				<input name="dno" type="hidden" value="${doctor.dno}">
				<button class="submit application" disabled="disabled">비대면 진료 신청</button>
			</c:otherwise>
		</c:choose>
	</footer>
	</form>
</body>
</html>