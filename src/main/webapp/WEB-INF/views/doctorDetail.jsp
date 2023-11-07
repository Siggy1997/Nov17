<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="../css/hospital.css">
<script src="../js/jquery-3.7.0.min.js"></script> 
<!-- <script src="./js/wnInterface.js"></script> 
<script src="./js/mcore.min.js"></script> 
<script src="./js/mcore.extends.js"></script>  -->
<script type="text/javascript">
	$(function(){
		
		$(".doctorHospital").click(function(){
			location.href = '/hospitalDetail/${doctor.hno}';
		});
		
/* 		$(document).on("click", ".reviewDate", function(){
		}); */
		
		
	});

	/* Collection of functions */
	
	
	


</script>

</head>
<body>
	<h1>doctor</h1>
	
	
	<div class="doctorContainerBox">
	<div class="doctorHeader">
		<div class="doctorHeaderLeft">
			<div class="doctorImg"><img src="${doctor.dimg}" style="width:10%"></div>
		</div>
		<div class="doctorHeaderRight">
			<div class="doctorNameBox">
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
								<c:when test="${currentTime ge doctor.hopentime && currentTime le doctor.hholidayendtime}">
									<span class="availableCircle">● </span><span class="doctorStatus_text">진료 중</span>
								</c:when>
								<c:otherwise><span class="unavailableCircle">● </span><span class="doctorStatus_text">진료 종료</span></c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise><span class="unavailableCircle">● </span><span class="doctorStatus_text">휴진</span></c:otherwise>
					</c:choose>
				</c:if>
				
				<!-- 평일 -->
				<c:if test="${ !(currentDay == '토요일' || currentDay == '일요일') }">
					<c:choose>
						<c:when test="${doctor.hnightday == currentDay}">
							<c:choose>
								<c:when test="${currentTime ge doctor.hopentime && currentTime le doctor.hnightendtime}">
									<span class="availableCircle">● </span><span class="doctorStatus_text">진료 중</span>
								</c:when>
								<c:when test="${currentTime ge doctor.hbreaktime && currentTime le doctor.hbreakendtime}">
									<span class="unavailableCircle">● </span><span class="doctorStatus_text">점심시간</span>
								</c:when>
								<c:otherwise><span class="unavailableCircle">● </span><span class="doctorStatus_text">진료 종료</span></c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
							<c:choose>
									<c:when test="${currentTime ge doctor.hopentime && currentTime le doctor.hclosetime}">
										<span class="availableCircle">● </span><span class="doctorStatus_text">진료 중</span>
									</c:when>
									<c:when test="${currentTime ge doctor.hbreaktime && currentTime le doctor.hbreakendtime}">
										<span class="unavailableCircle">● </span><span class="doctorStatus_text">점심시간</span>
									</c:when>
									<c:otherwise><span class="unavailableCircle">● </span><span class="doctorStatus_text">진료 종료</span></c:otherwise>
								</c:choose>
						</c:otherwise>
					</c:choose>
				</c:if>
				</div>
				<!-- { dReviewCount=6, dpsymptom=치아 질환, dtelehealth=1, dspecialist=0, dgender=0, 
	hReviewCount=11, dReviewAverage=4.2, dname=이국종, dinfo=환자분들의 건강을 위해 최선의 진료를 다하고 있습니다., 
	dpkind=치과,hparking=1, dpno=2, dno=1, hno=1, dpkeyword=치아교정,충치치료,치아미백,치통, 
	hReviewAverage=3.5, hbreaktime, hbreakendtime
	hopentime=09:00:00, hnightendtime=23:00:00, haddr=서울 강남구 언주로 211, hclosetime=13:00:00, hholiday=1} -->
				<div class="doctorDepartmentBox">
					<div class="doctorHospitalName">${doctor.hname}</div>
					<div class="doctorDepartment">${doctor.dpkind}</div>
				</div>
				<div class="doctorReviewBox">
					<img src="../img/star.png" style="width: 4%">
					<div class="reviewScore">${doctor.dReviewAverage}</div>
					<div class="telehealthCount">
						<c:choose>
							<c:when test="${doctor.count == 0}">신규</c:when>
							<c:otherwise>${doctor.count}회 진료</c:otherwise>
						</c:choose>
					</div>
				</div>
			</div>
			<div class="dotorSpecialist">
				<c:choose>
					<c:when test="${doctor.dspecialist == 1}">
						<img src="../img/specialist.png" style="width:5%">${doctor.dpkind} 전문의
					</c:when>
					<c:otherwise>일반의</c:otherwise>
				</c:choose>
			</div>
		</div>
	</div>
	
	<div class="doctorBody">
		<div class="doctorBar">
			<div class="doctorBarIntroduce">소개</div>
			<div class="doctorBarIntroduce">리뷰(${doctor.dReviewCount})</div>
		</div>
		<div class="doctorInfoBox">
			<div class="doctorTitle">의사 소개</div>
			<div class="doctorInfo"><h3>안녕하세요. 
				<c:choose>
						<c:when test="${doctor.dpno == 9}">한의사 <span style="font-size: large; color: #00C9FF;">${doctor.dname}</span>입니다.</c:when>
						<c:otherwise>의사 <span style="font-size: x-large; color: #00C9FF;">${doctor.dname}</span>입니다.</c:otherwise>
					</c:choose></h3>
				<p>${doctor.dinfo}</p>
			
			</div>
		</div>
		<div class="doctorCareerBox">
			<div class="doctorTitle">경력 및 약력</div>
			<div class="doctorCareer">${doctor.dcareer}</div>
		</div>
		<div class="doctorHospitalBox">
			<div class="doctorTitle">소속 병원</div>
			<div class="doctorHospital">
				<div class="hospitalImg"><img src="${doctor.himg}" style="width: 5%;"></div>
				<div class="hospitalBox">
					<div class="hospitalName">${doctor.hname}</div>
					<div class="hospitalAddr">${doctor.haddr}</div>
				</div>
				<div class="hospitalNext"><span class="xi-angle-right"></span></div>
			</div>
		</div>
		<div class="doctorReviewBox">
			<div class="doctorTitle">리뷰<span>${doctor.dReviewCount}</span></div>
			<div class="doctorReviewScoreBoxLeft">
				<div class="doctorReviewScore">${doctor.dReviewAverage}</div>
				<div class="doctorReviewStar">별</div>
			</div>
			<div class="doctorReviewScoreBoxRight">
				매우 만족, 만족, 보통, 별로, 매우 별로
			</div>
			<div class="doctorReviewWrite">
				<form id="reviewWrite" action="/doctorDetail/${doctor.dno}" method="post">
					<button>리뷰 작성</button>
				</form>
			</div>
		</div>
		<div class="">
			<div class="sortReview">
				<button type="button" class="sortReviewButton">최신 순</button>
				<button type="button" class="sortReviewButton">오래된 순</button>
				<button type="button" class="sortReviewButton">별점 높은 순</button>
				<button type="button" class="sortReviewButton">별점 낮은 순</button>
			</div>
<!-- [{rlike=42, rno=1, dno=1, rdate=2023-10-25 01:33:38.0, hno=1, rrate=4.0, rcontent=친절하게 진찰해주셨어요., 
mname=송화진, rkeyword=효과좋아요,친절해요, mno=1} -->
			<div class="reviewBox">
				<c:forEach items="${doctorReview}" var="row">
					<div class="reviewStar">
						<c:forEach begin="1" end="${row.rrate}">
							<span class="xi-star"></span>
						</c:forEach>
						<c:forEach begin="1" end="${5 - row.rrate}">
							<span class="xi-star-o"></span>
						</c:forEach>
					</div>
					<div class="reviewKeyword">
						<c:forEach items="${row.rkeyword.split(',')}" var="keyword">
							<div>${keyword}</div>
						</c:forEach>
					</div>
					<div class="reviewContent">${row.rcontent}</div>
					<div class="reviewDate">${row.rdate}</div>
					<div class="reviewName">${row.mname}</div>
					<div class="reviewLike">
						<button>추천해요 <img src="../img/thumbs_up.png" style="width: 10%;">${row.rlike}</button>
					</div>
					<hr> <!-- 나중에 지울 것 -->
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="doctocFooter">
		<c:choose>
			<c:when test="${doctor.dspecialist == 0 }">
				<button>비대면 진료 불가</button>
			</c:when>
			<c:otherwise>
				<button>비대면 진료 신청</button>
			</c:otherwise>
		</c:choose>
	</div>
	
	
	
	
	
	
	
	
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
</html>