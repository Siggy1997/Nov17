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
<link rel="stylesheet" href="./css/hospital.css">
<script src="./js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">
	$(document).ready(function(){
		
		/* 병원 총 개수 세기 */
	    hospitalCount();

		/* 접수 여부 표시하기 */
		$(".hospitalStatus_text").each(function() {
	        let $this = $(this);
	        let text = $this.text().trim();
	        if (text === '진료 중') {
	            $this.closest(".hospitalList").find(".receptionStatus").text('접수 가능');
	        } else {
	            $this.closest(".hospitalList").find(".receptionStatus").text('접수 마감');
	        }
	    });
		
		/* input창에 검색 키워드 넣기 */
		let urlString = window.location.search;
		let urlParams = new URLSearchParams(urlString);
		let kindKeyword = urlParams.get('kindKeyword');
		let symptomKeyword = urlParams.get('symptomKeyword');
		let otherKeyword = urlParams.get('otherKeyword');
		let keyword = urlParams.get('keyword');
		if (urlParams == '') {
			$("#keyword").val("예약 가능한 병원");
		} else if (kindKeyword != null) {
			$("#keyword").val(kindKeyword);
			$(".selectByDepartmentText").text(kindKeyword);
			$(".selectByDepartment").addClass(".filter-btn-css");
			$(".departmentKind:contains('" + kindKeyword + "')").addClass("btn-color-css");
			$(".departmentGroup").show();
			$(".symptomContainer").hide();
		} else if (symptomKeyword != null) {
			$("#keyword").val(symptomKeyword);
			$(".selectByDepartmentText").text(symptomKeyword);
			$(".selectByDepartment").addClass(".filter-btn-css");
			$(".symptomKind:contains('" + symptomKeyword + "')").addClass("btn-color-css");
			$(".departmentGroup").hide();
			$(".symptomContainer").show();
		} 
		
		if (otherKeyword != null) {
			$("#keyword").val(otherKeyword);
			$(".selectByCategoryText").text(otherKeyword);
			$(".departmentGroup").show();
			$(".symptomContainer").hide();
		} 
		if (keyword != null) {
			$("#keyword").val(keyword);
			$(".departmentGroup").show();
			$(".symptomContainer").hide();
		}
		
		/* 야간진료 */
		if (otherKeyword == '야간진료') {
			$(".nightCare").show();
		} else {
			$(".nightCare").hide();
		}
		
		

	});
	
	/* 진료과목 모달 */
	
	
	/* $.ajax({
    url: "./hospital",
    type: "post",
    data: {searchKeyword : searchKeyword},
    dataType: "json",
    success: function(m){
       
    },
    error: function(error){
       alert("Error");
    }
 }); */		
		
		

		
		
		
		
		
			
			
			
	
	
	$(function(){
		
		/* 진료 중인 병원만 보기 */
		$(".selectByAvailable").click(function(){
		    let inTreatment = $(".hospitalStatus_text:contains('진료 중')");
		    let onlyInTreatment = inTreatment.filter(".hospitalList");
		    if (onlyInTreatment.is(':visible')) {
		        $(".hospitalList").show();
		    } else {
		        $(".hospitalList").hide();
		        onlyInTreatment.show();
		    }
		    hospitalCount();
		});
		
		/* 모달 */
		$(document).on("click", ".selectByDepartment", function(){
			$("#exampleModal").modal("show");
		});

		/* 진료과 선택했을 때 */
		$(document).on("click", ".modalDepartment", function(){
			$(".departmentGroup").show();
			$(".symptomContainer").hide();
		});
		
		/* 진료과 검색하기 */
		$(document).on("click", ".departmentKind", function(){
			let departmentKind = $(this).text();
			$('#keyword').val(departmentKind);
		});
		
		/* 증상 선택했을 때 */
		$(document).on("click", ".modalSymptom", function(){
			$(".departmentGroup").hide();
			$(".symptomContainer").show();
		});
		
		/* 증상이 들어와있을 경우 */
		if ($(".symptomKind").hasClass("btn-color-css")) {
			let keywordClass = $(".btn-color-css").parent();
			toggleClass(keywordClass);
			/* 증상 그룹별로 보여주기 */
			$(document).on("click", ".symptomGroup", function(){
				let togglKeyword = $(this).siblings();
				toggleClass(togglKeyword);
			});
		} else {
			/* 증상이 안 들어와있을 경우 */
			let keywordClass = $(".symptomKindBox:first .symptomGroup").nextAll();
			toggleClass(keywordClass);
			/* 증상 그룹별로 보여주기 */
			$(document).on("click", ".symptomGroup", function(){
				let togglKeyword = $(this).siblings();
				toggleClass(togglKeyword);
			});
		}
		
		/* 증상 검색하기 */
		$(document).on("click", ".symptomKind", function(){
			let symptomKind = $(this).text();
			$('#keyword').val(symptomKind);
		});
		
		/* 검색 input창 */
		$("#keyword").click(function(){
			window.location.href= '/search';
		});
		
	});
	
	
	/* 병원 상세보기 페이지 이동 */
	function hospitalDetail(hno) {
		window.location.href= '/hospitalDetail/' + hno;
	}
	
	/* 모달에서 증상별 토글 효과 */
	function toggleClass(keyword) {
		let otherKeyword = $('.symptomKindButton').not(keyword);
		if (otherKeyword.is(":visible")) {
			otherKeyword.slideUp();
			toggleIcon(otherKeyword);
		}
		if (keyword.is(":visible")) {
	        toggleIcon(keyword);
	        keyword.slideUp();
	    } else {
	        toggleIcon(keyword);
	        keyword.slideDown();
	    }
	}
	
	/* 모달에서 증상별 토글 아이콘 변경 */
	function toggleIcon(keyword) {
		if (keyword.is(":visible")) {
	        let toggle = keyword.siblings().children(".xi-angle-up-thin");
	        toggle.removeClass("xi-angle-up-thin").addClass("xi-angle-down-thin");
	    } else {
	    	let toggle = keyword.siblings().children(".xi-angle-down-thin");
	    	toggle.removeClass("xi-angle-down-thin").addClass("xi-angle-up-thin");
	    }
	}
	
	/* 목록에 있는 병원 개수 세기 */
	function hospitalCount() {
		let divCount = $(".hospitalList:visible").length;
		$(".countNumber").text("총 " + divCount + "개");
	}

</script>

</head>
<body>
	<h1>hospital</h1>
	<form id="searchForm" action="/search" method="post">
	<div class="hospitalBox">
		<div class="searchHospital">
			<div class="xi-angle-left"></div>
			<input placeholder="질병, 진료과, 병원을 검색하세요." name="keyword" id="keyword">
			<button class="xi-search"></button>
		</div>
	
		<div class="filterHospital">
			<button type="button" class="selectByLocal">위치</button>
			<button type="button" class="selectByAvailable">진료중</button>
			<button type="button" class="selectByDepartment">
				<span class="selectByDepartmentText">진료과/증상</span>
				<span class="xi-angle-down-min"></span>
			</button>
			<button type="button" class="selectByCategory">
				<span class="selectByCategoryText">유형</span>
				<span class="xi-angle-down-min"></span>
			</button>
		</div>
		<div class="hospitalBar">
			<div class="hospitalCount">
				병원<span class="countNumber"></span>
			</div>
			<select class="sortHospital">
				<option class="sortByExact">정확도 순</option>
				<option class="sortByRate">별점 순</option>
				<option class="sortByReview">리뷰 순</option>
			</select>
		</div>
		<!-- [{dpkind=피부과, hholidayendtime=12:00:00, hparking=1, dpno=5, hnightday=수요일, dno=1, 
		dpsymptom=피부 질환, hno=1, dpkeyword=티눈,아토피,안면홍조, dspecialist=0, dgender=0, reviewCount=4, 
		hopentime=09:00:00, hnightendtime=23:00:00, hname=연세세브란스, haddr=서울특별시 서대문구 신촌동 연세로 50-1, 
		hclosetime=18:00:00, hholiday=0, reviewAverage=4.2} -->
		<div class="nightCare">오늘 야간진료 병원</div>
		 <c:forEach items="${hospitalList}" var="row">
			<div class="hospitalList" onclick="hospitalDetail(${row.hno})">
				<div class="hospitalStatus" style="color:red;">
				
					<!-- 공휴일 -->
					<c:if test="${currentDay == '토요일' || currentDay == '일요일'}">
						<c:choose>
							<c:when test="${row.hholiday == 1}">
								<c:choose>
									<c:when test="${currentTime ge row.hopentime && currentTime le row.hholidayendtime}">
										<img src="./img/status.png" style="width: 4%"><span class="hospitalStatus_text">진료 중</span>
									</c:when>
									<c:otherwise><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise><span class="hospitalStatus_text">휴진</span></c:otherwise>
						</c:choose>
					</c:if>
					
					<!-- 평일 -->
					<c:if test="${ !(currentDay == '토요일' || currentDay == '일요일') }">
						<c:choose>
							<c:when test="${row.hnightday == currentDay}">
								<c:choose>
									<c:when test="${currentTime ge row.hopentime && currentTime le row.hnightendtime}">
										<img src="./img/status.png" style="width: 4%"><span class="hospitalStatus_text">진료 중</span>
									</c:when>
									<c:otherwise><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<c:choose>
										<c:when test="${currentTime ge row.hopentime && currentTime le row.hclosetime}">
											<img src="./img/status.png" style="width: 4%"><span class="hospitalStatus_text">진료 중</span>
										</c:when>
										<c:otherwise><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
									</c:choose>
							</c:otherwise>
						</c:choose>
					</c:if>
				</div>
				
				<div class="hospitalHeader">
					<div class="hospitalName">${row.hname}</div>
					<div class="hospitalDepartment">${row.dpkind}</div>
					<div class="hospitalLike xi-heart-o"></div>
				</div>
				<div class="hospitalBody">
					<!-- <div class="hospitalDistance">뺄지말지고민</div> -->
					<div class="hospitalAddress">${row.haddr}</div>
				</div>
				<div class="hospitalReview">
					<img src="./img/star.png" style="width: 4%">
					<div class="reviewScore">${row.reviewAverage}</div>
					<div class="reviewCount">(${row.reviewCount})</div>
				</div>
				<div class="hospitalReserve">
					<div class="receptionStatus" style="color: blue"></div>
					<div class="reservationStatus">예약 가능</div>
				</div>
			</div>
		</c:forEach>
		
		<c:if test="${notTodayNightHospital.size() gt 0 }">
		<div class="nightCare">다른 요일 야간진료 병원</div>
			<c:forEach items="${notTodayNightHospital}" var="row">
				<div class="hospitalList" onclick="hospitalDetail(${row.hno})">
					<div class="hospitalStatus" style="color:red;">
					
						<!-- 공휴일 -->
						<c:if test="${currentDay == '토요일' || currentDay == '일요일'}">
							<c:choose>
								<c:when test="${row.hholiday == 1}">
									<c:choose>
										<c:when test="${currentTime ge row.hopentime && currentTime le row.hholidayendtime}">
											<img src="./img/status.png" style="width: 4%"><span class="hospitalStatus_text">진료 중</span>
										</c:when>
										<c:otherwise><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise><span class="hospitalStatus_text">휴진</span></c:otherwise>
							</c:choose>
						</c:if>
						<!-- 평일 -->
						<c:if test="${ !(currentDay == '토요일' || currentDay == '일요일') }">
							<c:choose>
								<c:when test="${row.hnightday == currentDay}">
									<c:choose>
										<c:when test="${currentTime ge row.hopentime && currentTime le row.hnightendtime}">
											<img src="./img/status.png" style="width: 4%"><span class="hospitalStatus_text">진료 중</span>
										</c:when>
										<c:otherwise><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:choose>
											<c:when test="${currentTime ge row.hopentime && currentTime le row.hclosetime}">
												<img src="./img/status.png" style="width: 4%"><span class="hospitalStatus_text">진료 중</span>
											</c:when>
											<c:otherwise><span class="hospitalStatus_text">진료 종료</span></c:otherwise>
										</c:choose>
								</c:otherwise>
							</c:choose>
						</c:if>
					</div>
					<div class="hospitalHeader">
						<div class="hospitalName">${row.hname}</div>
						<div class="hospitalDepartment">${row.dpkind}</div>
						<div class="hospitalLike xi-heart-o"></div>
					</div>
					<div class="hospitalBody">
						<!-- <div class="hospitalDistance">뺄지말지고민</div> -->
						<div class="hospitalAddress">${row.haddr}</div>
					</div>
					<div class="hospitalReview">
						<img src="./img/star.png" style="width: 4%">
						<div class="reviewScore">${row.reviewAverage}</div>
						<div class="reviewCount">(${row.reviewCount})</div>
					</div>
					<div class="hospitalReserve">
						<div class="receptionStatus" style="color: blue"></div>
						<div class="reservationStatus">예약 가능</div>
					</div>
				</div>
			</c:forEach>
		</c:if>
		
		
		<!-- 진료과/증상 모달 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered">
	         <div class="modal-content">
	            <!-- 모달 헤더 -->
	            <div class="modal-header">
	               <h5 class="modal-title" id="exampleModalLabel">
		               	<button type="button" class="modalDepartment">진료과</button>
		               	<button type="button" class="modalSymptom">증상·질환</button>
	               </h5>
	               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
				<!-- 모달 바디 -->
	            <div class="modal-body">
	            	<!-- 진료과 -->
	            	<div class="departmentGroup">
	            		<button class="departmentKind">전체</button>
		            	<c:forEach items="${departmentKeyword}" var="row">
		            	<button class="departmentKind">${row.dpkind}</button>
		            	</c:forEach>
	            	</div>
	            	<!-- 증상 -->
		  			 <div class="symptomContainer">
		            	<c:forEach items="${departmentKeyword}" var="row">
		            	<div class="symptomKindBox">
		            		<div class="symptomGroup">
		            			<div class="symptomGroupText">${row.dpsymptom}</div>
		            			<div class="xi-angle-down-thin"></div>
		            		</div>
				        	<div class="symptomKindButton">
		            		<c:set var="keywords" value="${row.dpkeyword.split(',')}"/>
					        <c:forEach var="keyword" items="${keywords}">
				            	<button class="symptomKind">${keyword}</button>
					        </c:forEach>
		            		</div>
			        	</div>
		            	</c:forEach>
		           	</div>
	            </div>
	         </div>
	      </div>
	   </div>
   </div>
   </form>
   			
	
	


	
	
	
	
	<!-- Bootstrap core JS -->
   <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
   <script src="js/scripts.js"></script>
   <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>