<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약접수</title>
<style type="text/css">
.area {
	width: 500px;
	height: 500px;
	margin: 0 auto;
}

table {
	border: 1px solid black;
	margin: 0 atuo;
}

h4 {
	position: relative;
	left: 700px;
	bottom: -20px;
}

.btn {
	display: inline-flex;
}

.memberChange {
	margin: 0 atuo;
}
</style>
<link href='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.css'
	rel='stylesheet' />
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.js'></script>
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/locales/ko.js'></script>
<script src="./js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
//날짜별 출근 및 퇴근 정보를 저장할 객체
var attendanceData = {};
var attendance = {}; // 초기화
var attendance2 = {}; // 초기화

document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		dateClick : function(info) {
			var today = new Date();
			var selectedDate = info.dateStr;

			$.ajax({
				type : 'POST',
				url : '/adetail',
				data : {
					date : selectedDate,
					hospital : selectedHospital
				},
				success : function(data) {
					if (data.availableTimes) {
						calendar.addEvent({
							start : '2023-10-31T10:00:00',
							end : '2023-10-31T12:00:00'
						});
					}
				},
				error : function(error) {
					console.log('에러 발생: ' + error);
				}
			});
		}
	});

	calendar.render();

});
	
	
$(document).ready(function () {
    $('#dpnoSelect').change(function () {
        var dpno = $(this).val();
        var buttonContainer = $('#buttonContainer');
        
        if (dpno) {
            $.ajax({
                type: 'POST',
                url: '/getDoctors',
                data: {
                    dpno: dpno
                },
               
                dataType: "json",
                success: function (data) {
                	alert("!");
                    
          				/* value += "<c:forEach items='${doctor}' var='dc'>";
          				value += "<div style='text-align: center;'>";
          				value += "<form action='/adetail' method='POST'>";
          				value += "<input type='hidden' name='hno' vlaue='${dc.hno }' />";
          				value += "<button>";
          				value += "${dc.dname} 의사<br>"
          				value += "</button>";
          				value += "</form>";
        				value += "</div>";
         				value += "</c:forEach>"; */
         				
         				/* let doctors = data.doctors;
         				alert(doctors);
         				doctors.forEach(function() {
         					alert("테스트");
         				}); */
         				
          				var newButton = $('<button>')
       		        	.text(data.doctors + dpno)
       		        	.data('value', dpno);

         		    	buttonContainer.append(newButton);		
             					
         				
         				
         			/* $('#doctorSelect').empty();
                    $('#doctorSelect').append($('<option>', {
                        
                    
                    	value: '',
                        text: '의사를 선택하세요'
                    }));
                    $.each(data, function (key, value) {
                        $('#doctorSelect').append($('<option>', {
                            value: value.dno,
                            text: value.dname
                        }));
                    }); */
                },
                error: function (error) {
	                alert("에러발생");
                }
            });
        } else {
			alert("알수 없는 요청입니다.");
        	/* $('#doctorSelect').empty();
            $('#doctorSelect').append($('<option>', {
                value: '',
                text: '의사를 선택하세요'
            })); */
        }
    });
});
</script>
</head>
<body>
	<h1 style="text-align: center;">${hospital.hname}</h1>
	<div class="btn">
		<table border="1" style="margin: 0 atuo;">
			<tr>
				<th>이름</th>
				<th>일반진료</th>
			</tr>

			<c:forEach items="${detail }" var="d">
				<tr>
					<td>${d.mname}</td>
					<td>${d.adiagnosis}</td>
				</tr>
			</c:forEach>
		</table>
		<button class="memberChange">진료자 변경</button>
	</div>
	<h4>예약날짜</h4>
	<div class="area">
		<div>
			<div id="calendar"></div>
		</div>
	</div>

	<h4>예약시간</h4>
	<c:forEach items="${time }" var="t">
		<div style="text-align: center;">
			<form action="/adetail" method="POST">
				<input type="hidden" name="hno" vlaue="${t.hno }" /> 오전 :
				<button>${t.at1 }</button>
				<button>${t.at2 }</button>
				<button>${t.at3 }</button>
				<button>${t.at4 }</button>
				<button>${t.at5 }</button>
				<button>${t.at6 }</button>
				<br> 오후 :
				<button>${t.at7 }</button>
				<button>${t.at8 }</button>
				<button>${t.at9 }</button>
				<button>${t.at10 }</button>
				<button>${t.at11 }</button>
				<button>${t.at12 }</button>
				<button>${t.at13 }</button>
				<button>${t.at14 }</button>
				<button>${t.at15 }</button>
				<button>${t.at16 }</button>
			</form>
		</div>
	</c:forEach>

	<h4>의료진</h4>
	<!-- 진료과에 따라 각 의사들 표시 -->
	<!-- ajax로 가상태그로 생성하기 -->
	<div style="text-align: center;">
		<select id="dpnoSelect" name="dpno">
			<option value="">진료과를 선택하세요</option>
			<c:forEach items="${department}" var="dpinfo">
				<option value="${dpinfo.dpno}">${dpinfo.dpkind}</option>
			</c:forEach>
		</select>
	</div>
	
	<div id="buttonContainer">
		
	</div>

	<h4>전달사항</h4>
	<div style="text-align: center;">
		<textarea rows="10" cols="50" placeholder="증상을 상세하게 적어주세요."></textarea>
	</div>
	<br>
	<br>
	<div style="text-align: center;">
		<button>예약접수</button>
		<button onclick="location.href='./appointment'">돌아가기</button>
	</div>

</body>
</html>