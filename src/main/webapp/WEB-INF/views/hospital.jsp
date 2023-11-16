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
<title>hospitalList</title>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/hospital.css">
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function(){
			location.href = '/search';
		});
		
		let optionKeywordBox = '';
		let addSelectByDepartment = '';

		/* input창에 검색 키워드 넣기 */
		let urlString = location.search;
		let urlParams = new URLSearchParams(urlString);
		let kindKeyword = urlParams.get('kindKeyword');
		let symptomKeyword = urlParams.get('symptomKeyword');
		let optionKeyword = urlParams.get('optionKeyword');
		let keyword = urlParams.get('keyword');
		if (urlParams == '') {
			$("#keyword").val("예약 가능한 병원");
		} else if (kindKeyword != null) {
			$("#keyword").val(kindKeyword);
			$(".selectByDepartmentText").text(kindKeyword);
			$(".selectByDepartment").addClass("filter-btn-css");
			$(".departmentKind").filter(function() {
			    return $(this).text().trim() === kindKeyword;
			}).addClass("btn-color-css");
		} else if (symptomKeyword != null) {
			$("#keyword").val(symptomKeyword);
			$(".selectByDepartmentText").text(symptomKeyword);
			$(".selectByDepartment").addClass("filter-btn-css");
			$(".symptomKind").filter(function() {
			    return $(this).text().trim() === symptomKeyword;
			}).addClass("btn-color-css");
		} 

		if (optionKeyword != null) {
			$(".selectByCategory").addClass("filter-btn-css-blue");
			optionKeywordBox += optionKeyword;
			if( $("#keyword").val() == '' ) {
				$("#keyword").val(optionKeywordBox);
			}
			let text = $(this).text().trim();
		    let keywords = optionKeyword.split(',');
		    for (let i = 0; i < keywords.length; i++) {
	        	addSelectByDepartment += '<button class="filter-btn-css select addSelectByDepartment" type="button"><div class="xi-command"></div><div class="selectByDepartmentText margin-right"> ' + keywords[i].trim() + '</div><div class="deleteKeyword xi-close-circle"></div></<button>';
	        	$(".optionKindText").each(function() {
	        	    if ($(this).text() === keywords[i].trim()) {
	        	        $(this).closest(".optionKind").addClass("btn-color-css");
	        	        let optionClass = $(this).siblings(".xi-radiobox-blank");
	        	        optionToggleIcon(optionClass);
	        	    }
	        	});
		        if (text.includes(keywords[i].trim())) {
		            return true;
		        }
		    }
		    $(".filterGroup").append(addSelectByDepartment);
			
			$(".optionKind").filter(function() {
				
			    /* 야간진료 */
				if (optionKeyword.includes('야간진료')) {
					$(".nightCare").show();
				} else {
					$(".nightCare").hide();
				}
				return false;
			}).addClass("btn-color-css").children(".xi-radiobox-blank").addClass("xi-check-circle").removeClass("xi-radiobox-blank");
		} else {
			$(".selectByCategory").removeClass("btn-color-css");
		}
		if (keyword != null) {
			$("#keyword").val(keyword);
		}
		
		/* 입력할 때 내용 지우기 */
		if ($("#keyword").val() !== '') {
			$(".icon").addClass("xi-close-circle");
		} else {
			$(".icon").removeClass("xi-close-circle");
		}
		$(document).on("input", "#keyword", function(){
			if ($("#keyword").val() !== '') {
				$(".icon").addClass("xi-close-circle");
			} else {
				$(".icon").removeClass("xi-close-circle");
			}
		});
		$(document).on("click", ".deleteSearch", function(){
			$(".icon").removeClass("xi-close-circle");
			$("#keyword").val('').focus();
		});
		
		/* 병원 총 개수 세기 */
	    hospitalCount();

		/* 접수 여부 표시하기 */
		$(".hospitalStatus_text").each(function() {
	        let $this = $(this);
	        let text = $this.text().trim();
	        if (text === '진료 중') {
	            $this.closest(".hospitalList").find(".receptionStatus").text('접수 가능');
	            $this.closest(".hospitalList").find(".receptionStatus").addClass("reservationStatus");
	        } else {
	            $this.closest(".hospitalList").find(".receptionStatus").text('접수 마감');
	            $this.closest(".hospitalList").find(".receptionStatus").removeClass("reservationStatus");
	        }
	    });
		
		/* 진료 중인 병원만 보기 */
		$(document).on("click", ".selectByAvailable", function(){
			let inTreatment = $(".hospitalListContainer").filter(function() {
			    return $(this).find(".hospitalStatus_text").text().trim() === '진료 중';
			});
			if ( $(this).hasClass("filter-btn-css") ) {
				$(this).removeClass("filter-btn-css");
				$(".hospitalListContainer").show();
			} else {
				$(this).addClass("filter-btn-css");
		        $(".hospitalListContainer").hide();

		        inTreatment.show();
			    }
		    hospitalCount();
		});
		
		/* 진료과, 증상 모달 */
		$(document).on("click", ".selectByDepartmentText", function(){
	    	if( symptomKeyword != null ) {
	    		$(".modalSymptom").addClass("modal-title-css");
				$(".modalDepartment").removeClass("modal-title-css");
				$(".departmentGroup").hide();
				$(".symptomContainer").show();
			} else {
				$(".modalDepartment").addClass("modal-title-css");
				$(".modalSymptom").removeClass("modal-title-css");
				$(".departmentGroup").show();
				$(".symptomContainer").hide();
			}
			$(".symptomModal").modal("show");
		});

		/* 진료과 선택했을 때 */
		$(document).on("click", ".modalDepartment", function(){
			$(this).addClass("modal-title-css");
			$(".modalSymptom").removeClass("modal-title-css");
			$(".departmentGroup").show();
			$(".symptomContainer").hide();
		});
		
		/* 진료과 검색하기 */
		$(document).on("click", ".departmentKind", function(){
			let departmentKind = $(this).text();
			if(optionKeyword != null) {
				$(this).prop("disabled", true);
				changeURL("kindKeyword", departmentKind);
			} else {
				$('#keyword').val(departmentKind);
			}
		});
		
		/* 증상 선택했을 때 */
		$(document).on("click", ".modalSymptom", function(){
			$(this).addClass("modal-title-css");
			$(".modalDepartment").removeClass("modal-title-css");
			$(".departmentGroup").hide();
			$(".symptomContainer").show();
		});
		
		/* 증상이 들어와있을 경우 */
		if ($(".symptomKind").hasClass("btn-color-css")) {
			let keywordClass = $(".symptomKindButton").find(".btn-color-css").parent();
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
			if(optionKeyword != null) {
				$(this).prop("disabled", true);
				changeURL("symptomKeyword", symptomKind);
			} else {
				$('#keyword').val(symptomKind);
			}
		});
		
		/* 유형 모달 */
		$(document).on("click", ".selectByCategory", function(){
			//$(".optionModal").modal("show");
		      $('#openCategory').toggleClass('max');
		      $('.optionGroup').toggle('fast');
			
			
		});
		
		/* 유형 검색하기 */
		$(document).on("click", ".optionKind", function(){
			/* 유형값이 들어와있을 경우 */
			if ($(this).hasClass("btn-color-css")) {
				$(this).removeClass("btn-color-css");
				let optionClass = $(this).children(".xi-check-circle");
				optionToggleIcon(optionClass);
				let optionKeyword = $(this).children().text();
				/* optionKeywordBox 지우기 */
				deleteOptionKeyword = (separationString(optionKeywordBox)).filter(item => item !== optionKeyword);
				optionKeywordBox = deleteOptionKeyword.join(",");
				
			} else {
				$(this).addClass("btn-color-css");
				let optionClass = $(this).children(".xi-radiobox-blank");
				optionToggleIcon(optionClass);
				/* optionKeywordBox 넣기 */
				let optionKeyword = $(this).children().text();
				if (optionKeywordBox == '') {
					optionKeywordBox += optionKeyword;
				} else {
					optionKeywordBox += "," + optionKeyword;
				}
			}
		});
		
		$(document).on("click", ".optionSubmit", function(){
			$("#optionKeywordBox").val(optionKeywordBox);
		});
		
		/* 병원 찜하기 */
		$(document).on("click", ".hospitalLike", function(){
			
			let hospitalName = '';
			let hospitalDelName = '';
			let sessionId = "<%=session.getAttribute("mid")%>"
			
			/* 로그인 체크 */
			if( sessionId == "null" || sessionId == '' ) {
				if (confirm("로그인을 해야 이용할 수 있는 서비스입니다. 로그인 하시겠습니까?")) {
					return location.href= '/login';
				} else {
					return false;
				}
			} else {
				/* 빈 하트 눌렀을 때 -> 채워진 하트 */
				if ( $(this).hasClass("xi-heart-o") ) {
					hospitalName = $(this).siblings().find($(".hospitalName")).text();
					$(this).addClass("xi-heart").removeClass("xi-heart-o")
					
				/* 채워진 하트 눌렀을 때 -> 빈 하트 */
				} else {
					hospitalDelName = $(this).siblings().find($(".hospitalName")).text();
					$(this).addClass("xi-heart-o").removeClass("xi-heart")
				}
				$.ajax({
			         url: "./hospital",
			         type: "post",
			         dataType: "json",
			         data: {hospitalName : hospitalName, hospitalDelName : hospitalDelName},
			         success: function(data){
			         },
			         error: function(error){
			            alert("Error");
			         }
			      });
			}
		    
		});

		/* 접수 페이지 이동 */
		$(document).on("click", ".receptionStatus", function(){
			let hno = $(this).siblings().val();
			let treatmentText = $(this).text().trim();
			if (treatmentText === '접수 가능') {
				return location.href= '/reception/' + hno;
			} else {
				alert("접수가 마감되었습니다.")
				return false;
			}
		});
		

		/* 정렬 */
		$(".sortHospital").change(function(){
			let selectedOption = $(this).find("option:selected").text();
			
			/* 별점 순 정렬 */
			if (selectedOption === '별점 순') {
				let hospitalContainers = $(".hospitalListContainer");
				hospitalContainers.sort(function(a, b) {
	                let ratingA = parseFloat($(a).find(".reviewScore").text());
	                let ratingB = parseFloat($(b).find(".reviewScore").text());
	                return ratingB - ratingA;
	            });
				$(".hospitalListContainerBox").html(hospitalContainers);
			}
			
			/* 리뷰 순 */
			if (selectedOption === '리뷰 순') {
				let hospitalContainers = $(".hospitalListContainer");
				hospitalContainers.sort(function(a, b) {
	                let ratingA = parseInt($(a).find(".reviewCount").text().replace(/[()]/g, ''));
	                let ratingB = parseInt($(b).find(".reviewCount").text().replace(/[()]/g, ''));
	                return ratingB - ratingA;
	            });
				$(".hospitalListContainerBox").html(hospitalContainers);
			}
			
			/* 기본 순 */
			if (selectedOption === '기본 순') {
				let hospitalContainers = $(".hospitalListContainer");
				hospitalContainers.sort(function(a, b) {
	                let ratingA = parseInt($(a).find(".hno").val());
	                let ratingB = parseInt($(b).find(".hno").val());
	                return ratingA - ratingB;
	            });
				$(".hospitalListContainerBox").html(hospitalContainers);
			}
		});
		
		/* 카테고리 선택 해제 */
		let selectByDepartment = $(".selectByDepartment");
		deselect(selectByDepartment);
		let selectByCategory = $(".selectByCategory");
		deselect(selectByCategory);
		
		/* 유형 검색했을 때 검색어 추가하기 */
		if ($(".addSelectByDepartment").length > 0) {
			$(".addSelectByDepartment").show();
		} else {
			$(".addSelectByDepartment").hide();
		}
		
		/* 카테고리, 유형 지웠을 때 삭제하기 */	
		$(document).on("click", ".deleteKeyword", function(){
			if ($(this).parent().is($(".selectByDepartment"))) {
				if(kindKeyword != null) {
					deleteURL("kindKeyword");
				} else {
					deleteURL("symptomKeyword");
				}
			} else {
				let delOptionKeyword = $(this).siblings(".selectByDepartmentText").text();
				changeOptionURL(delOptionKeyword);
			}
		});
		
		/* Collection of functions */
		
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
		        keyword.siblings().children(".symptomGroupText").removeClass("font-css");
		        toggle.removeClass("xi-angle-up-thin").addClass("xi-angle-down-thin");
		    } else {
		    	let toggle = keyword.siblings().children(".xi-angle-down-thin");
		    	keyword.siblings().children(".symptomGroupText").addClass("font-css");
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
		
		/* 목록에 있는 병원 개수 세기 */
		function hospitalCount() {
			let divCount = $(".hospitalListContainer:visible").length;
			$(".countNumber").text("총 " + divCount + "개");
		}
		
		/* String 잘라서 배열로 만들기 */
		function separationString(stringList) {
		    if (stringList) {
		        return stringList.split(",").map(function(item) {
		            return item.trim();
		        });
		    } else {
		        return [];
		    }
		}
		
		/* 카테고리 선택 해제하기 */
		function deselect(select) {
			if (select.hasClass("filter-btn-css")) {
				let toggleDepartment = select.children(".xi-angle-down-min");
				toggleDepartment.removeClass("xi-angle-down-min").addClass("xi-close-circle");
			} else {
				let toggleDepartment = select.children(".xi-close-circle");
				toggleDepartment.removeClass("xi-close-circle").addClass("xi-angle-down-min");
			}
		}
		
		/* url 지우기 */
		function deleteURL(deleteParams) {
			urlParams.delete(deleteParams);
			urlString = urlParams.toString();
			location.href= "hospital?"+urlString;
		}
		
		/* url 변경하기 */
		function changeURL(paramName, paramValue) {
			urlParams.set(paramName,paramValue);
			if(paramName === "symptomKeyword") {
				urlParams.delete("kindKeyword");
			} else {
				urlParams.delete("symptomKeyword");
			}
			location.href= "hospital?" + urlParams.toString();
		}
		
		/* 옵션 url 변경 */
		function changeOptionURL(deleteKeyword) {
			/* optionKeyword 뽑아내기 */
			let optionKeywordValue = urlParams.get("optionKeyword");
			/* 배열화 하기 */
			let optionKeywords = optionKeywordValue.split(',');
			/* 키워드 지우기 */
			if (optionKeywords.includes(deleteKeyword.trim())) {
				optionKeywords = optionKeywords.filter(keyword => keyword.trim() !== deleteKeyword.trim());
			}
			/* 다시 합치기 */
			if (optionKeywords.length > 0) {
			    urlParams.set("optionKeyword", optionKeywords.join(','));
			  } else {
			    urlParams.delete("optionKeyword");
			  }
			location.href = "hospital?" + urlParams.toString();
		}
	});
	
	/* 병원 상세보기 페이지 이동 */
	function hospitalDetail(hno) {
		location.href= '/hospitalDetail/' + hno;
	}
	
	/* 예약 상세보기 페이지 이동 */
	function hospitalAppointment(hno) {
		location.href= '/appointment/' + hno;
	}
	
</script>

</head>
<body>
	<form id="searchForm" action="/search" method="post">

		<!-- header -->
		<header>
			<i class="xi-angle-left xi-x"></i>
			<div class="headerTitle">병원 검색</div>
			<div class="blank"></div>
		</header>

		<main class="hospitalBox container">

			<!-- search -->
			<div class="search">
				<div class="searchInput">
					<input placeholder="진료과, 증상, 병원을 검색하세요." name="keyword"
						id="keyword">
					<div class="deleteSearch">
						<i class="icon"></i>
					</div>
				</div>
				<button class="searchButton">
					<img src="./img/search.png">
				</button>
			</div>

			<!-- filter -->
			<div class="filter">
				<div class="filterGroup">
					<!-- <button type="button" class="selectByLocal select"><span class="xi-my-location margin-right"></span> 위치</button> -->
					<button type="button" class="selectByAvailable select">
						<span class="xi-time-o margin-right"></span> 진료중
					</button>
					<button type="button" class="selectByDepartment select">
						<div class="xi-plus-square-o margin-right"></div>
						<div class="selectByDepartmentText">진료과/증상</div>
						<div class="xi-angle-down-min deleteKeyword"></div>
					</button>
				</div>


				<div class=""></div>




				<button type="button" class="selectByCategory">
					<span class="xi-tune"></span>
				</button>
			</div>

			<div id="openCategory">
			
				<div class="optionGroup" style="display: none;">
					<button type="button" class="optionKind">
						<span class="optionKindText">전문의</span> <span
							class="xi-radiobox-blank"></span>
					</button>
					<button type="button" class="optionKind">
						<span class="optionKindText">여의사</span> <span
							class="xi-radiobox-blank"></span>
					</button>
					<button type="button" class="optionKind">
						<span class="optionKindText">주차장</span> <span
							class="xi-radiobox-blank"></span>
					</button>
					<button type="button" class="optionKind" value="휴일진료">
						<span class="optionKindText">휴일진료</span> <span
							class="xi-radiobox-blank"></span>
					</button>
					<button type="button" class="optionKind" value="야간진료">
						<span class="optionKindText">야간진료</span> <span
							class="xi-radiobox-blank"></span>
					</button>
				</div>



			</div>



			<!-- title -->
			<div class="hospitalBar bar">
				<div class="hospitalCount count">
					병원 <span class="countNumber"></span>
				</div>
				<select class="sortHospital sortByList">
					<option class="sortByExact">기본 순</option>
					<option class="sortByRate">별점 순</option>
					<option class="sortByReview">리뷰 순</option>
				</select>
			</div>

			<!-- list -->
			<div class="nightCare">
				<div>오늘 야간진료 병원</div>
			</div>
			<div class="hospitalListContainerBox">
				<c:forEach items="${hospitalList}" var="row">
					<div class="hospitalListContainer">
						<div class="listContainer">
							<div class="hospitalList">
								<div class="hospitalStatus">

									<!-- 공휴일 -->
									<c:if test="${currentDay == '토요일' || currentDay == '일요일'}">
										<c:choose>
											<c:when test="${row.hholiday == 1}">
												<c:choose>
													<c:when
														test="${currentTime ge row.hopentime && currentTime le row.hholidayendtime}">
														<span class="availableCircle">● </span>
														<span class="hospitalStatus_text">진료 중</span>
													</c:when>
													<c:otherwise>
														<span class="unavailableCircle">● </span>
														<span class="hospitalStatus_text">진료 종료</span>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<span class="unavailableCircle">● </span>
												<span class="hospitalStatus_text">휴진</span>
											</c:otherwise>
										</c:choose>
									</c:if>

									<!-- 평일 -->
									<c:if test="${ !(currentDay == '토요일' || currentDay == '일요일') }">
										<c:choose>
											<c:when test="${row.hnightday == currentDay}">
												<c:choose>
													<c:when
														test="${currentTime ge row.hopentime && currentTime le row.hnightendtime}">
														<span class="availableCircle">● </span>
														<span class="hospitalStatus_text">진료 중</span>
													</c:when>
													<c:when
														test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
														<span class="unavailableCircle">● </span>
														<span class="hospitalStatus_text">점심시간</span>
													</c:when>
													<c:otherwise>
														<span class="unavailableCircle">● </span>
														<span class="hospitalStatus_text">진료 종료</span>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise>
												<c:choose>
													<c:when
														test="${currentTime ge row.hopentime && currentTime le row.hclosetime}">
														<span class="availableCircle">● </span>
														<span class="hospitalStatus_text">진료 중</span>
													</c:when>
													<c:when
														test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
														<span class="unavailableCircle">● </span>
														<span class="hospitalStatus_text">점심시간</span>
													</c:when>
													<c:otherwise>
														<span class="unavailableCircle">● </span>
														<span class="hospitalStatus_text">진료 종료</span>
													</c:otherwise>
												</c:choose>
											</c:otherwise>
										</c:choose>
									</c:if>
								</div>

								<div class="hospitalHeader" onclick="hospitalDetail(${row.hno})">
									<div class="hospitalName">${row.hname}</div>
									<div class="hospitalDepartment">${row.dpkind}</div>
								</div>
								<div class="hospitalBody" onclick="hospitalDetail(${row.hno})">
									<!-- <div class="hospitalDistance">뺄지말지고민</div> -->
									<div class="hospitalAddress">${row.haddr}</div>
								</div>
								<div class="hospitalReview" onclick="hospitalDetail(${row.hno})">
									<img src="./img/star.png" style="width: 18px;">
									<div class="reviewScore">${row.hReviewAverage}</div>
									<div class="reviewCount">(${row.hReviewCount})</div>
								</div>
								<div class="hospitalReserve">
									<div class="receptionStatus"
										onclick="hospitalReception(${row.hno})"></div>
									<input type="hidden" class="hno" value="${row.hno}">
									<div class="reservationStatus"
										onclick="hospitalAppointment(${row.hno})">예약 가능</div>
								</div>
							</div>
							<c:choose>
								<c:when test="${sessionScope.mno ne null}">
									<c:choose>
										<c:when test="${fn:contains(hospitalLikeList, row.hname)}">
											<div class="hospitalLike xi-heart"></div>
										</c:when>
										<c:otherwise>
											<div class="hospitalLike xi-heart-o"></div>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<div class="hospitalLike xi-heart-o"></div>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="graySeperate"></div>
					</div>
				</c:forEach>

				<c:if test="${notTodayNightHospital.size() gt 0 }">
					<div class="nightCare">
						<div>다른 요일 야간진료 병원</div>
					</div>
					<c:forEach items="${notTodayNightHospital}" var="row">

						<div class="hospitalListContainer">
							<div class="listContainer">
								<div class="hospitalList">
									<div class="hospitalStatus">

										<!-- 공휴일 -->
										<c:if test="${currentDay == '토요일' || currentDay == '일요일'}">
											<c:choose>
												<c:when test="${row.hholiday == 1}">
													<c:choose>
														<c:when
															test="${currentTime ge row.hopentime && currentTime le row.hholidayendtime}">
															<span class="availableCircle">● </span>
															<span class="hospitalStatus_text">진료 중</span>
														</c:when>
														<c:otherwise>
															<span class="unavailableCircle">● </span>
															<span class="hospitalStatus_text">진료 종료</span>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<span class="unavailableCircle">● </span>
													<span class="hospitalStatus_text">휴진</span>
												</c:otherwise>
											</c:choose>
										</c:if>
										<!-- 평일 -->
										<c:if
											test="${ !(currentDay == '토요일' || currentDay == '일요일') }">
											<c:choose>
												<c:when test="${row.hnightday == currentDay}">
													<c:choose>
														<c:when
															test="${currentTime ge row.hopentime && currentTime le row.hnightendtime}">
															<span class="availableCircle">● </span>
															<span class="hospitalStatus_text">진료 중</span>
														</c:when>
														<c:when
															test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
															<span class="unavailableCircle">● </span>
															<span class="hospitalStatus_text">점심시간</span>
														</c:when>
														<c:otherwise>
															<span class="unavailableCircle">● </span>
															<span class="hospitalStatus_text">진료 종료</span>
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise>
													<c:choose>
														<c:when
															test="${currentTime ge row.hopentime && currentTime le row.hclosetime}">
															<span class="availableCircle">● </span>
															<span class="hospitalStatus_text">진료 중</span>
														</c:when>
														<c:when
															test="${currentTime ge row.hbreaktime && currentTime le row.hbreakendtime}">
															<span class="unavailableCircle">● </span>
															<span class="hospitalStatus_text">점심시간</span>
														</c:when>
														<c:otherwise>
															<span class="unavailableCircle">● </span>
															<span class="hospitalStatus_text">진료 종료</span>
														</c:otherwise>
													</c:choose>
												</c:otherwise>
											</c:choose>
										</c:if>
									</div>
									<div class="hospitalHeader"
										onclick="hospitalDetail(${row.hno})">
										<div class="hospitalName">${row.hname}</div>
										<div class="hospitalDepartment">${row.dpkind}</div>
									</div>
									<div class="hospitalBody" onclick="hospitalDetail(${row.hno})">
										<!-- <div class="hospitalDistance">뺄지말지고민</div> -->
										<div class="hospitalAddress">${row.haddr}</div>
									</div>
									<div class="hospitalReview"
										onclick="hospitalDetail(${row.hno})">
										<img src="./img/star.png" style="width: 18px;">
										<div class="reviewScore">${row.hReviewAverage}</div>
										<div class="reviewCount">(${row.hReviewCount})</div>
									</div>
									<div class="hospitalReserve">
										<div class="receptionStatus"></div>
										<input type="hidden" class="hno" value="${row.hno}">
										<div class="reservationStatus"
											onclick="hospitalAppointment(${row.hno})">예약 가능</div>
									</div>
								</div>
								<c:choose>
									<c:when test="${sessionScope.mno ne null}">
										<c:choose>
											<c:when test="${fn:contains(hospitalLikeList, row.hname)}">
												<div class="hospitalLike xi-heart"></div>
											</c:when>
											<c:otherwise>
												<div class="hospitalLike xi-heart-o"></div>
											</c:otherwise>
										</c:choose>
									</c:when>
									<c:otherwise>
										<div class="hospitalLike xi-heart-o"></div>
									</c:otherwise>
								</c:choose>
							</div>
							<div class="graySeperate"></div>
						</div>
					</c:forEach>
				</c:if>
			</div>


			<!-- 진료과/증상 모달 -->
			<div class="modal fade symptomModal" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<!-- 모달 헤더 -->
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">
								<button type="button" class="modalDepartment">진료과</button>
								<button type="button" class="modalSymptom">증상·질환</button>
							</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
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
											<c:set var="keywords" value="${row.dpkeyword.split(',')}" />
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

			<!-- 유형 모달 -->
			<div class="modal fade optionModal" id="exampleModal" tabindex="-1"
				aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<!-- 모달 헤더 -->
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">
								<button type="button" class="modalOption">유형</button>
							</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"></button>
						</div>
						<!-- 모달 바디 -->
						<div class="modal-body">
							<div class="optionGroup">
								<button type="button" class="optionKind">
									<span class="optionKindText">전문의</span> <span
										class="xi-radiobox-blank"></span>
								</button>
								<button type="button" class="optionKind">
									<span class="optionKindText">여의사</span> <span
										class="xi-radiobox-blank"></span>
								</button>
								<button type="button" class="optionKind">
									<span class="optionKindText">주차장</span> <span
										class="xi-radiobox-blank"></span>
								</button>
								<button type="button" class="optionKind" value="휴일진료">
									<span class="optionKindText">휴일진료</span> <span
										class="xi-radiobox-blank"></span>
								</button>
								<button type="button" class="optionKind" value="야간진료">
									<span class="optionKindText">야간진료</span> <span
										class="xi-radiobox-blank"></span>
								</button>
							</div>

							<input type="hidden" name="optionKeywordBox"
								id="optionKeywordBox">
							<div class="optionSubmit">
								<button>선택완료</button>
							</div>

						</div>
					</div>
				</div>
			</div>
		</main>
	</form>


	<!— Bootstrap core JS —>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
</body>
</html>