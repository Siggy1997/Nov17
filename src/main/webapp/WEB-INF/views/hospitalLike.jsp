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
<script type="text/javascript">
	$(function(){
		
		let optionKeywordBox = '';
		/* input창에 검색 키워드 넣기 */
		let urlString = window.location.search;
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
			$(".selectByDepartment").addClass(".filter-btn-css");
			$(".departmentKind").filter(function() {
			    return $(this).text().trim() === kindKeyword;
			}).addClass("btn-color-css");
		} else if (symptomKeyword != null) {
			$("#keyword").val(symptomKeyword);
			$(".selectByDepartmentText").text(symptomKeyword);
			$(".selectByDepartment").addClass(".filter-btn-css");
			$(".symptomKind").filter(function() {
			    return $(this).text().trim() === symptomKeyword;
			}).addClass("btn-color-css");
		} 
		if (optionKeyword != null) {
			$(".selectByCategory").addClass("btn-color-css");
			optionKeywordBox += optionKeyword;
			if( $("#keyword").val() == '' ) {
				$("#keyword").val(optionKeywordBox);
			}
			
			$(".optionKind").filter(function() {
			    let text = $(this).text().trim();
			    let keywords = optionKeyword.split(',');
			    for (let i = 0; i < keywords.length; i++) {
			        if (text.includes(keywords[i].trim())) {
			            return true;
			        }
			    }
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
		
		/* 진료 중인 병원만 보기 */
		$(document).on("click", ".selectByAvailable", function(){
			let inTreatment = $(".hospitalListContainer").filter(function() {
			    return $(this).find(".hospitalStatus_text").text().trim() === '진료 중';
			});
			if ( $(this).hasClass("btn-color-css") ) {
				$(this).removeClass("btn-color-css");
				$(".hospitalListContainer").show();
			} else {
				$(this).addClass("btn-color-css");
		        $(".hospitalListContainer").hide();
		        inTreatment.show();
			    }
		    hospitalCount();
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
		
		/* 유형 모달 */
		$(document).on("click", ".selectByCategory", function(){
			$(".optionModal").modal("show");
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
			$('#optionKeywordBox').val(optionKeywordBox);
		});
		
		/* 병원 찜하기 */
		$(document).on("click", ".hospitalLike", function(){
			
			let hospitalName = '';
			let hospitalDelName = '';
			let sessionId = "<%=session.getAttribute("mid") %>"
			
			/* 로그인 체크 */
			if( sessionId == "null" || sessionId == '' ) {
				if (confirm("로그인을 해야 이용할 수 있는 서비스입니다. 로그인 하시겠습니까?")) {
					return window.location.href= '/login';
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
		
		
		
		
		/* 검색 input창 */
		$("#keyword").click(function(){
			window.location.href= '/search';
		});
		
		
		
		
		
		
		
		
		
		
		
		
		
		

	});
	
		
		

		
		
		
		
		
			
			
			
	
	/* Collection of functions */
	
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

</script>

</head>
<body>
	<h1>hospital</h1>
	<div class="hospitalBox">
		<div class="hospitalLikeHeader">
			<div class="xi-angle-left"></div>
			<div class="hospitalLikeHeaderText">즐겨찾기</div>
			<button class="hospitalLikeHeaderButton" onclick="href='hospital'">추가하기</button>
		</div>
	
		
		<div class="hospitalLikeBar">
			<div class="hospitalCount">
				병원<span class="countNumber"></span>
			</div>
		</div>
	<div class="hospitalListContainerBox">
		<c:if test="${sessionScope.mno ne null}">
			<c:forEach items="${hospitalList}" var="row">
				<c:if test="${fn:contains(hospitalLikeList, row.hname)}">
			
			
			
			
				</c:if>
		
		
		
		</c:if>
		
		
				
			
	
	
	
		
		 	<div class="hospitalListContainer">
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
					</div>
					<div class="hospitalBody">
						<!-- <div class="hospitalDistance">뺄지말지고민</div> -->
						<div class="hospitalAddress">${row.haddr}</div>
					</div>
					<div class="hospitalReview">
						<img src="./img/star.png" style="width: 4%">
						<div class="reviewScore">${row.hReviewAverage}</div>
						<div class="reviewCount">(${row.hReviewCount})</div>
					</div>
					<div class="hospitalReserve">
						<div class="receptionStatus" style="color: blue"></div>
						<div class="reservationStatus">예약 가능</div>
					</div>
					<div class="hospitalLike xi-heart"></div>
				</div>
				
			</div>
		</c:forEach>
	</div>
		
		
	   
   </div>
   
   
   			
	


	
	
	
	
</body>
</html>