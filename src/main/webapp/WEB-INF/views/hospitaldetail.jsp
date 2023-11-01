<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/hospitaldetail.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="../js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">
	$(function() {
		let hospitalname = $('.hospitalName').text()
		let openTime = timeToNumber($('.openTime').text());
		let closeTime = timeToNumber($('.closeTime').text());
		let nowTime = timeToNumber($('#nowTime').val());
		let sortValue;
		let currentReview = 0; 
		let maxReview = 5;
		let reviwer;

		sortReview(0)
		
		if (($('.openTime').text() == '') || ($('.closeTime').text() == '')) {
			$('#todayHours').html('휴진')
		} else {
			$('#todayHours').html(
					$('.openTime').text() + " ~ " + $('.closeTime').text())

		}

		//찜하기
		$(document).on("click", ".xi-heart, .xi-heart-o", function() {
			if ($(this).hasClass("xi-heart")) {
				$(this).parent().html('<i class="xi-heart-o xi-2x"></i>');
				$.ajax({
					type : "POST",
					url : "../unlike",
					data : {
						hospitalname : hospitalname
					}
				});

			} else {
				$(this).parent().html('<i class="xi-heart xi-2x"></i>');
				$.ajax({
					type : "POST",
					url : "../like",
					data : {
						hospitalname : hospitalname
					}
				});
			}
		});
		
		//진료 가능 여부
		if (nowTime > openTime && nowTime < closeTime) {
			$('#available').show()
		} else {
			$('#unavailable').show()
		}
		
		//정렬기준
		$("#sort1").click(function() {
			sortValue = $(this).val();
			sortReview(sortValue);
		});
		$("#sort2").click(function() {
			sortValue = $(this).val();
			sortReview(sortValue);
		});
		$("#sort3").click(function() {
			sortValue = $(this).val();
			sortReview(sortValue);
		});
		$("#sort4").click(function() {
			sortValue = $(this).val();
			sortReview(sortValue);
		});

	
		
	//시간 숫자로
	function timeToNumber(time) {
		let parts = time.split(":");
		return parseInt(parts[0] + parts[1]);
	}
	

	
	// 정렬 메소드
	function sortReview(sortValue) {
	    $.ajax({
	        url: "/sort/" + ${hospital.hno},
	        type: "GET",
	        data: {"sortValue": sortValue},
	        success: function (data) {
	            let newData = JSON.parse(data);

	            if (currentReview === 0) {
	                $("#reviewContainer").empty();
	            }


	            for (let i = currentReview; i < maxReview && i < newData.review.length; i++) {
	                let n = newData.review[i];
	                let rateInt = n.rrate;

	                let item = "<div class='reviewList'>";
	                item += "<div class='reviewRate'>";

	                for (let j = 1; j <= rateInt; j++) {
	                    item += "<i class='star xi-star xi-x'></i>";
	                }

	                for (let k = 1; k <= 5 - rateInt; k++) {
	                    item += "<i class='star xi-star-o xi-x'></i>";
	                }
	                item += "</div>";
	                item += "<div class='reviewKeyword'>";

	                let keywords = n.rkeyword.split(',');
	                for (let l = 0; l < keywords.length; l++) {
	                    item += "<div class='keyword'>" + keywords[l] + "</div>";
	                }

	                item += "</div>";
	                item += "<div class='reviewContent'>" + n.rcontent + "</div>";
	                item += "<div class='reviewDate'>" + n.rdate + "</div>";
	                item += "<div class='reviewer'>" + n.mname + "</div>";
	                item += "<button class='reviewLike'>추천해요<i class='xi-thumbs-up xi'>"+n.rlike +"</i></button>";
	                item += "<input class='rno' type='hidden' value='"+ n.rno +"'>"
	                item += "<input class='sortValue' type='hidden' value='"+ sortValue +"'>"
	                
	                item += "<hr></div>";

	            $('#reviewContainer').append(item);
	            }


	            // 보여질게 있으면 버튼 생성
	            if (maxReview < newData.review.length) {
	                
	                $('#reviewContainer').append("<button id='moreReview'>더보기</button>");

	                //클릭 maxreview +5
	                $('#moreReview').one('click', function () {
	                    maxReview += 5;
	                    sortReview(sortValue);
	                });
	            }
	        }
	    });
	}
	
	//리뷰 좋아요
	$(document).on("click", ".reviewLike", function() {
		reviewer =  $(this).siblings(".rno").val()
		let sortnum = $(this).siblings(".sortValue").val()
		
		   $.ajax({
	        url: "/countReviewLike",
	        type: "POST",
	        data: {"reviewer" :reviewer },
	        success: function (data) {
	        	
	        	sortReview(sortnum);
	        	
	        }
	     
		   });		
	});


	});


</script>


</head>
<body>
	<header>
		<nav>
			<ul>
				<li>
					<button>
						<i class="xi-angle-left xi-2x"></i>
					</button>
				</li>

				<li>
					<div class="titleHospitalName">${hospital.hname }</div>
				</li>

				<li><c:set var="found" value="false" /> <c:forEach
						var="hospitalLike" items="${sessionScope.hospitallike}">
						<c:if test="${hospitalLike == hospital.hname}">
							<div class="like" style="color: red">
								<i class="xi-heart xi-2x"></i>
							</div>
							<c:set var="found" value="true" />
						</c:if>
					</c:forEach> <c:if test="${not found}">
						<div class="notlike" style="color: red">
							<i class="xi-heart-o xi-2x"></i>
						</div>
					</c:if></li>
			</ul>
		</nav>
	</header>


	<div class="hospitalImage">
		<img alt="사진예정" src="">
	</div>

	<div class="hospitalName">${hospital.hname }</div>

	<div class="departmentList">
		<c:forEach var="department" items="${doctorList}">
			<span> ${department.dpkind } </span>
		</c:forEach>
	</div>

	<div class="status">
		<input type="hidden" id="nowTime" value="${now.time }">
		<div id="available">
			<i class="xi-check-circle xi">진료가능</i>
		</div>
		<div id="unavailable">
			<i class="xi-close-circle xi">진료불가능</i>
		</div>
	</div>

	<div class="consulationHours">
		<c:if
			test="${!(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && now.dayOfWeek != hospital.hnightday}">
			<span class="day">${now.dayOfWeek }</span>
			<span class="openTime">${hospital.hopentime }</span> ~
			<span class="closeTime">${hospital.hclosetime }</span>
		</c:if>

		<c:if test="${now.dayOfWeek == hospital.hnightday}">
			<span class="day">${now.dayOfWeek }</span>
			<span class="openTime">${hospital.hopentime }</span> ~ 
			<span class="closeTime">${hospital.hnightendtime }</span>
		</c:if>

		<c:if
			test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday !=0}">
			<span class="day">${now.dayOfWeek }</span>
			<span class="openTime">${hospital.hopentime }</span> ~
			<span class="closeTime">${hospital.hholidayendtime }</span>
		</c:if>

		<c:if
			test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==0}">
			<span>휴진</span>
		</c:if>
	</div>

	<div>
		<button value="${hospital.htelnumber }">전화하기</button>
		<!-- //나중에 -->
		<button>공유하기</button>
	</div>
	<div class="detailMenu">
		<ul>
			<li>진료정보</li>
			<li>병원정보</li>
			<li>의사정보</li>
			<li>리뷰</li>
		</ul>
	</div>


	<div class="medicalInfo">
		<div class="todayInfo">
			<div class="today todayTimeInfo">
				<span>오늘</span><br> <span id="todayHours"></span>
			</div>
			<div class="today todayBreakInfo">
				<span>점심시간</span><br> <span id="todayBreak"> <c:if
						test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==0}">
						휴진
					</c:if> <c:if
						test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==1}">
						없음
					</c:if> <c:if
						test="${now.dayOfWeek == '월요일' || now.dayOfWeek == '화요일' || now.dayOfWeek == '수요일' || now.dayOfWeek == '목요일' || now.dayOfWeek == '금요일'}">
				${hospital.hbreaktime } ~ ${hospital.hbreakendtime }
					</c:if>
				</span>
			</div>
		</div>

		<div class="timeInfo">
			<div class="day monday">
				<c:choose>
					<c:when test="${hospital.hnightday == '월요일'}">
						월요일(야간진료) <br> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
					<c:otherwise>
						월요일 <br> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
				</c:choose>
			</div>
			<div class="day tuesday">
				<c:choose>
					<c:when test="${hospital.hnightday == '화요일'}">
						화요일(야간진료) <br> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
					<c:otherwise>
						화요일 <br> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
				</c:choose>
			</div>
			<div class="day wednesday">
				<c:choose>
					<c:when test="${hospital.hnightday == '수요일'}">
						수요일(야간진료) <br> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
					<c:otherwise>
						수요일 <br> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
				</c:choose>
			</div>
			<div class="day thursday">
				<c:choose>
					<c:when test="${hospital.hnightday == '목요일'}">
						목요일(야간진료) <br> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
					<c:otherwise>
						목요일 <br> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
				</c:choose>
			</div>
			<div class="day friday">
				<c:choose>
					<c:when test="${hospital.hnightday == '금요일'}">
						금요일(야간진료) <br> ${hospital.hopentime } ~ ${hospital.hnightendtime }
					</c:when>
					<c:otherwise>
						금요일 <br> ${hospital.hopentime } ~ ${hospital.hclosetime }
					</c:otherwise>
				</c:choose>
			</div>
			<div class="day saturday">
				<c:choose>
					<c:when test="${hospital.hholiday == 1}">
						토요일 <br> ${hospital.hopentime } ~ ${hospital.hholidayendtime }
					</c:when>
					<c:otherwise>
						토요일 <br> 휴진
					</c:otherwise>
				</c:choose>
			</div>
			<div class="day sunday">
				<c:choose>
					<c:when test="${hospital.hholiday == 1}">
						일요일 <br> ${hospital.hopentime } ~ ${hospital.hholidayendtime }
					</c:when>
					<c:otherwise>
						일요일 <br> 휴진
					</c:otherwise>
				</c:choose>
			</div>
			<div class="day breaktime">
				평일 점심시간<br> ${hospital.hbreaktime } ~ ${hospital.hbreakendtime }
			</div>
		</div>

		<hr>

		<div class="department">
			<div class="hospitalTitle">진료 과목</div>
			총 ${doctorList.size() }개
			<div>
				<c:forEach var="department" items="${doctorList}">
					<span> ${department.dpkind } </span>
				</c:forEach>
			</div>
		</div>

	</div>

	<hr>

	<div class="hospitalInfo">
		<div class="hospitalIntro">
			<div class="hospitalTitle">병원 소개</div>
			<span>${hospital.hinfo }</span>
		</div>

		<hr>

		<div class="hospitalLocation">
			<div class="hospitalTitle">위치</div>
			<span> ${hospital.haddr }</span>
		</div>
		<div class="Map">~지도 예정</div>
	</div>

	<hr>

	<div class="doctorInfo">
		<div class="hospitalTitle">의사 정보</div>
		<c:forEach var="doctorList" items="${doctorList}">
			<div class="doctorDetail">
				<img alt="의사사진" src="${doctorList.dimg }"> <span>${doctorList.dname }</span>
				<button onclick="location.href='../doctorDetail/'+${doctorList.dno}">
					<i class="xi-angle-right xi-2x"></i>
				</button>
			</div>
		</c:forEach>

	</div>

	<hr>

	<div class="totalReviewList">
		<div class="hospitalTitle">리뷰</div>
		총 ${reviewList.size() }개<br> 이 병원을 ${(averageHospitalRate * 20) }%가
		추천하고 싶어해요

		<div class="averageHospitalRate">
			${averageHospitalRate }
			<c:set var="averageInt"
				value="${fn:substringBefore(averageHospitalRate, '.')}" />
			<c:forEach var="i" begin="1" end="${averageInt }">
				<i class="star xi-star xi-x"></i>
			</c:forEach>
			<c:forEach var="i" begin="1" end="${5 - averageInt }">
				<i class="star xi-star-o xi-x"></i>
			</c:forEach>


			<div class="barChart">
				<canvas id="myHorizontalBarChart"></canvas>
			</div>

			<button
				onclick="location.href='../writeReview?mno=${sessionScope.mno}&hno=${hospital.hno}'">리뷰
				작성</button>


		</div>
		<hr>

		<button id="sort1" style="width: 200px; height: 100px" value="1">최신순</button>
		<button id="sort2" style="width: 200px; height: 100px" value="2">오래된순</button>
		<button id="sort3" style="width: 200px; height: 100px" value="3">별점높은순</button>
		<button id="sort4" style="width: 200px; height: 100px" value="4">별점낮은순</button>

		<hr>
		<div id="reviewContainer"></div>


	</div>
	<script>
    // 만족도 데이터
    let labels = ['매우만족', '만족', '보통', '별로', '매우 별로'];
    let data = [${reviewCount.veryGood}, ${reviewCount.good}, ${reviewCount.normal}, ${reviewCount.bad}, ${reviewCount.veryBad}];

    // 차트 데이터 설정
    let chartData = {
        labels: labels,
        datasets: [{
            label: '만족도 갯수',
            backgroundColor: '#81D4FA',
            borderColor: '#81D4FA',
            borderWidth: 1,
            data: data
        }]
    };

    // 차트 옵션 설정
    let options = {
        indexAxis: 'y', // x축과 y축 바꾸기
        scales: {
            x: {
                beginAtZero: true,
                ticks: {
                    display: false // x축 눈금선 감추기
                },
                grid: {
                    display: false // x축 그리드 라인 감추기
                }
            },
            y: {
                grid: {
                    display: false // y축 그리드 라인 감추기
                },
                ticks: {
                    font: {
                        size: 30,
                        weight: 900// y축 눈금선 폰트 크기 설정
                    }
                }
            }
        },
        plugins: {
            legend: {
                display: false // 라벨 숨기기
            }
        }
    };

    // 캔버스 가져오기
    let ctx = document.getElementById('myHorizontalBarChart').getContext('2d');

    // 수평 막대 차트 생성
    let myHorizontalBarChart = new Chart(ctx, {
        type: 'bar',
        data: chartData,
        options: options
    });
</script>




</body>
</html>