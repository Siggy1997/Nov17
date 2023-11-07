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
<!-- <script src="./js/wnInterface.js"></script> 
<script src="./js/mcore.min.js"></script> 
<script src="./js/mcore.extends.js"></script>  -->
<script type="text/javascript">
	$(function(){
		
		$("#keyword").val('비대면 진료');
		let urlString = location.search;
		let urlParams = new URLSearchParams(urlString);
		let kindKeyword = urlParams.get('kindKeyword');
		let symptomKeyword = urlParams.get('symptomKeyword');
		
		if (kindKeyword != null) {
			$(".selectByDepartmentText").text(kindKeyword);
			$(".selectByDepartment").addClass("btn-color-css");
			$(".departmentKind").filter(function() {
			    return $(this).text().trim() === kindKeyword;
			}).addClass("btn-color-css");
		} else if (symptomKeyword != null) {
			$(".selectByDepartmentText").text(symptomKeyword);
			$(".selectByDepartment").addClass("btn-color-css");
			$(".symptomKind").filter(function() {
			    return $(this).text().trim() === symptomKeyword;
			}).addClass("btn-color-css");
		} 
		
		/* 검색하기 */
		$(document).on("click", "#keyword", function(){
			$("#keyword").val('');
		});
		
		/* 의사 수 세기 */
	    doctorCount();

		/* 진료 중인 의사만 보기 */
		$(document).on("click", ".selectByAvailable", function(){
			let inTreatment = $(".doctorListContainer").filter(function() {
			    return $(this).find(".doctorStatus_text").text().trim() === '진료 중';
			});
			if ( $(this).hasClass("btn-color-css") ) {
				$(this).removeClass("btn-color-css");
				$(".doctorListContainer").show();
			} else {
				$(this).addClass("btn-color-css");
		        $(".doctorListContainer").hide();
		        inTreatment.show();
			    }
			doctorCount();
		});
		
		/* 전문의인 의사만 보기 */
		$(document).on("click", ".selectBySpecialist", function(){
			let inSpecialist = $(".doctorListContainer").filter(function() {
			    return $(this).find(".dotorSpecialist img").length > 0;
			});
			if ( $(this).hasClass("btn-color-css") ) {
				$(this).removeClass("btn-color-css");
				$(".doctorListContainer").show();
			} else {
				$(this).addClass("btn-color-css");
		        $(".doctorListContainer").hide();
		        inSpecialist.show();
			    }
			doctorCount();
		});
		
		/* 진료과, 증상 모달 */
		$(document).on("click", ".selectByDepartment", function(){
			if( symptomKeyword != null ) {
				$(".departmentGroup").hide();
				$(".symptomContainer").show();
			} else {
				$(".departmentGroup").show();
				$(".symptomContainer").hide();
			}
			$(".symptomModal").modal("show");
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
		if ($(".symptomKind").hasClass("filter-btn-css")) {
			let keywordClass = $(".filter-btn-css").parent();
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
		
		/* 정렬 */
		$(".sortDoctor").change(function(){
			let selectedOption = $(this).find("option:selected").text();
			
			/* 별점 순 정렬 */
			if (selectedOption === '별점 순') {
				let doctorListContainer = $(".doctorListContainer");
				doctorListContainer.sort(function(a, b) {
	                let ratingA = parseFloat($(a).find(".reviewScore").text());
	                let ratingB = parseFloat($(b).find(".reviewScore").text());
	                return ratingB - ratingA;
	            });
				$(".doctorListContainerBox").html(doctorListContainer);
			}
			
			/* 리뷰 순 */
			if (selectedOption === '리뷰 순') {
				let doctorListContainer = $(".doctorListContainer");
				doctorListContainer.sort(function(a, b) {
	                let ratingA = parseInt($(a).find(".reviewCount").text().replace(/[()]/g, ''));
	                let ratingB = parseInt($(b).find(".reviewCount").text().replace(/[()]/g, ''));
	                return ratingB - ratingA;
	            });
				$(".doctorListContainerBox").html(doctorListContainer);
			}
			
			/* 기본 순 */
			if (selectedOption === '기본 순') {
				let doctorListContainer = $(".doctorListContainer");
				doctorListContainer.sort(function(a, b) {
	                let ratingA = parseInt($(a).find(".dno").val());
	                let ratingB = parseInt($(b).find(".dno").val());
	                return ratingA - ratingB;
	            });
				$(".doctorListContainerBox").html(doctorListContainer);
			}
		});
		
		/* 카테고리 선택 해제 */
		let selectByDepartment = $(".selectByDepartment");
		deselect(selectByDepartment);
		let selectByCategory = $(".selectByCategory");
		deselect(selectByCategory);
		

	});

	/* Collection of functions */
	
	/* 병원 상세보기 페이지 이동 */
	function doctorDetail(dno) {
		location.href= '/doctorDetail/' + dno;
	}
	
	/* 모달에서 증상별 토글 효과 */
	function toggleClass(keyword) {
		let otherKeyword = $(".symptomKindButton").not(keyword);
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
	
	/* 모달에서 옵션 토글 아이콘 변경 */
	function optionToggleIcon(optionKind) {
		if ( optionKind.hasClass("xi-check-circle") ) {
			optionKind.addClass("xi-radiobox-blank").removeClass("xi-check-circle");
			
		} else {
			optionKind.addClass("xi-check-circle").removeClass("xi-radiobox-blank");
		}
	}
	
	/* 의사 수 세기 */
	function doctorCount() {
		let divCount = $(".doctorListContainer:visible").length;
		$(".countNumber").text("총 " + divCount + "명");
	}
	
	/* 카테고리 선택 해제하기 */
	function deselect(select) {
		if (select.hasClass("filter-btn-css")) {
			let toggleDepartment = select.children(".xi-angle-down-min");
			toggleDepartment.removeClass("xi-angle-down-min").addClass("xi-close-circle");
		} else {
			let toggleDepartment = select.children(".xi-angle-down-min");
			toggleDepartment.removeClass("xi-close-circle").addClass("xi-angle-down-min");
		}
	}

</script>

</head>
<body>
	<h1>Non-face-to-face</h1>
	<form id="searchForm" action="/telehealthSearch" method="post">
	<div class="doctorBox">
		<div class="searchDoctor">
			<div class="xi-angle-left"></div>
			<input name="keyword" id="keyword">
			<button class="xi-search"></button>
		</div>
	
		<div class="filterDoctor">
			<button type="button" class="selectByAvailable"><span class="xi-time"></span> 진료중</button>
			<button type="button" class="selectBySpecialist"><span class="xi-school"></span> 전문의</button>
			<button type="button" class="selectByDepartment">
				<span class="xi-plus-square"></span> 
				<span class="selectByDepartmentText"> 진료과/증상</span>
				<span class="xi-angle-down-min"></span>
			</button>
		</div>
		<div class="doctorBar">
			<div class="doctorCount">
				의사<span class="countNumber"></span>
			</div>
			<select class="sortDoctor">
				<option class="sortByExact">기본 순</option>
				<option class="sortByRate">별점 순</option>
				<option class="sortByReview">리뷰 순</option>
			</select>
		</div>
		<div class="doctorListContainerBox">
			 <c:forEach items="${doctorList}" var="row">
			 	<div class="doctorListContainer" onclick="doctorDetail(${row.dno})">
					<div class="doctorHeader">
						<div class="doctorImg"><img src="${row.dimg}" style="width:10%"></div>
						<input type="hidden" class="dno" value="${row.dno}">
						<div class="doctorInfo">
							<div class="doctorInfoHeader">
								<div class="dotorName">
									<c:choose>
										<c:when test="${row.dpno == 9}">${row.dname} 한의사</c:when>
										<c:otherwise>${row.dname} 의사</c:otherwise>
									</c:choose>
								</div>
								<div class="doctorStatus">
								
								<!-- 공휴일 -->
								<c:if test="${currentDay == '토요일' || currentDay == '일요일'}">
									<c:choose>
										<c:when test="${row.hholiday == 1}">
											<c:choose>
												<c:when test="${currentTime ge row.hopentime && currentTime le row.hholidayendtime}">
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
										<c:when test="${row.hnightday == currentDay}">
											<c:choose>
												<c:when test="${currentTime ge row.hopentime && currentTime le row.hnightendtime}">
													<span class="availableCircle">● </span><span class="doctorStatus_text">진료 중</span>
												</c:when>
												<c:when test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
													<span class="unavailableCircle">● </span><span class="doctorStatus_text">점심시간</span>
												</c:when>
												<c:otherwise><span class="unavailableCircle">● </span><span class="doctorStatus_text">진료 종료</span></c:otherwise>
											</c:choose>
										</c:when>
										<c:otherwise>
											<c:choose>
												<c:when test="${currentTime ge row.hopentime && currentTime le row.hclosetime}">
													<span class="availableCircle">● </span><span class="doctorStatus_text">진료 중</span>
												</c:when>
												<c:when test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
													<span class="unavailableCircle">● </span><span class="doctorStatus_text">점심시간</span>
												</c:when>
												<c:otherwise><span class="unavailableCircle">● </span><span class="doctorStatus_text">진료 종료</span></c:otherwise>
												</c:choose>
										</c:otherwise>
									</c:choose>
								</c:if>
								</div>
							</div>
							<div class="doctorInfoBody">
								<div class="doctorHospitalName">${row.hname}</div> | 
								<div class="doctorDepartment">${row.dpkind}</div>								
							</div>
							<div class="doctorInfoFooter">
								<img src="./img/star.png" style="width: 4%">
								<div class="reviewScore">${row.dReviewAverage}</div>
								<div class="reviewCount">(${row.dReviewCount})</div>
							</div>
						</div>
						<div class="doctorNext"><span class="xi-angle-right"></span></div>
					</div>
					<div class="doctorFooter">
						<div class="dotorSpecialist">
							<c:choose>
								<c:when test="${row.dspecialist == 1 }">
									<img src="./img/specialist.png" style="width:5%">${row.dpkind} 전문의
								</c:when>
								<c:otherwise>
									일반의
								</c:otherwise>
							</c:choose>
						</div>
						<div class="dotorTelehealth">
							<img src="./img/telehealth.png" style="width:5%"> 비대면 진료 가능
						</div>
					</div>
				</div>
			</c:forEach>
			
		</div>
		
		
		<!-- 진료과/증상 모달 -->
		<div class="modal fade symptomModal" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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