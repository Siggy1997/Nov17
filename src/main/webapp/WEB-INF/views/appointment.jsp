<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="../css/appointment.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="../js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		let time = '';
		let hno = '';
		let day = '';
		let date = '';
		let dno = '';
		
		$('.selectDoctorInfo').click(function() {
			dno = $(this).children('#doctor').val()
			$(this).siblings().removeClass('selectedDoc')
			$(this).addClass('selectedDoc')
			$('.dateContainer').show();
		});
		
		
		$('.chooseDate')
				.click(
						function() {
							$(this).siblings().removeClass('selectedDate');
							$(this).addClass('selectedDate');
							hno = $('#hno').val();
							day = $(this).children('.day').val();
							date = $(this).children('.date').val();
							$
									.ajax({
										url : "../getTime",
										type : "GET",
										data : {
											"hno" : hno,
											"day" : day,
											"date" : date
										},
										success : function(data) {
											let newdata = JSON.parse(data);
											let item = '시간<br>';
											$('.timeContainer').empty();

											if (newdata.timeSlots != null
													&& newdata.timeSlots.length > 0) {
												for (let i = 0; i < newdata.timeSlots.length; i++) {
													let isTimeAvailable = true;

													for (let j = 0; j < newdata.checkTime.length; j++) {
														if (newdata.timeSlots[i] == newdata.checkTime[j].atime) {
															isTimeAvailable = false;
															break;
														}
													}

													if (isTimeAvailable) {
														item += "<button class='timeAvaliable'>"
																+ newdata.timeSlots[i]
																+ "</button>";
													} else {
														item += "<button class='timeUnavaliable' disabled='disabled'>"
																+ newdata.timeSlots[i]
																+ "</button>";
													}
												}
											} else {
												item += "휴진입니다.";
											}

											$('.timeContainer').append(item);
										},
										error : function(error) {
											console.log(error);
										}
									});

						})

		$(document).on('click', '.timeAvaliable', function() {
			time = $(this).text()
			$(this).siblings().removeClass('selectedTime')
			$(this).addClass('selectedTime')
			$('.content').show();
			$('.finish').show();
		})

		$('.finish').click(function() {
			let form = $('<form></form>');
			form.attr("action", "../appointment");
			form.attr("method", "post");
			form.append($("<input>", {
				type : 'hidden',
				name : "hno",
				value : hno
			}));
			form.append($("<input>", {
				type : 'hidden',
				name : "dno",
				value : dno
			}));
			form.append($("<input>", {
				type : 'hidden',
				name : "date",
				value : date
			}));
			form.append($("<input>", {
				type : 'hidden',
				name : "day",
				value : day
			}));
			form.append($("<input>", {
				type : 'hidden',
				name : "time",
				value : time
			}));
			form.append($("<input>", {
				type : 'hidden',
				name : "content",
				value : $('.content').val()
			}));
			form.append($("<input>", {
				type : 'hidden',
				name : "mno",
				value : ${sessionScope.mno}
			}));
			form.appendTo("body");
			form.submit();
		})
	});
</script>

</head>
<body>
	<header>
		<ul>
			<li>
				<button onclick="location.href='../hospitalDetail/'+${hospital.hno}">
					<i class="xi-angle-left xi-2x"></i>
				</button>
			</li>

			<li>
				<div class="titleHospitalName">${hospital.hname }</div> <input
				type="hidden" id="hno" value="${hospital.hno }">
			</li>

		</ul>
	</header>

	<div>${sessionScope.mname }님</div>
	<hr>
	<div>
		<i class="xi-check xi">일반진료</i> <i class="xi-angle-down xi"></i>
	</div>
	<hr>


	<div class="doctorContainer">
			<div class="title">의사</div>
			<div class="selectDoctor">
				<c:forEach var="doctor" items="${doctor}">
					<div class="selectDoctorInfo">
						<img alt="의사사진" src="${doctor.dimg }"><br>
						${doctor.dname } <input type="hidden" id="doctor"
							value="${doctor.dno }">
					</div>
				</c:forEach>
			</div>
		</div>

	<hr>
	<div class="dateContainer">
		날짜<br>
		<c:forEach var="i" begin="0" end="${date.size()-1 }">
			<div class="chooseDate">
				<input type="hidden" class="day" value="${day[i] }"> <input
					type="hidden" class="date" value="${date[i] }"> <span>${day[i].substring(0,1) }
				</span> <br>
				<c:choose>
					<c:when test="${date[i].substring(8, 9) == '0'}">
						<div class="circle">${date[i].substring(9, 10)}</div>
					</c:when>
					<c:otherwise>
						<div class="circle">${date[i].substring(8, 10)}</div>
					</c:otherwise>
				</c:choose>


			</div>
		</c:forEach>
	</div>

	<hr>

	<div class="timeContainer"></div>
	<hr>

	<div class="symptomContainer">
		<input class="content">
	</div>

	<button class="finish">예약완료</button>



</body>
</html>