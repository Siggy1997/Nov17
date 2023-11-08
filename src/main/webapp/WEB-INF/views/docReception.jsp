<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DocReception</title>
<script src="/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#allCheck").click(function() {
			if ($("#allCheck").is(":checked"))
				$("input[name=check]").prop("checked", true);
			else
				$("input[name=check]").prop("checked", false);
		});

	});

	function cancel() {
		let row = [];

		$("input[name=check]:checked").each(function() {
			let tno = $(this).closest('tr').find('.tno').text();
			let tstatus = $(this).closest('tr').find('.tstatus').text();
			
			if(tstatus == "진료완료") {
				alert("처리완료된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else if(tstatus == "진료취소") {
				alert("취소된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else {
				row.push(tno);
			    if (row.length > 0) {
			        $.ajax({
			            url: "/updateRows", // 서버의 URL을 입력하세요.
			            type: "post",
			            data: { "row" : row },
			            dataType: "json",
			            success: function (data) {
			                alert("진료가 취소되었습니다.");
			                $("input[name=check]:checked").prop("checked", false);
			                location.href="/docReception/"+${sessionScope.mno}+"/"+${sessionScope.dno};
			            },
			            error: function (error) {
			                alert("진료 취소 중 오류가 발생했습니다.");
			            }
			        });//ajax끝
			        
			    }//행 1개 이상 선택
			    else {
			        alert("진료취소할 행을 선택해주세요.");
			    }//행 1개 이상 선택x else
			}
			
		});
	}
	
	function progress() {
		let count = $("input[name=check]:checked");
		
		if(count.length == 0){
	    	alert("진료 처리할 행을 선택해주세요.");
	    	return false;
		}
		
		if(count.length > 1){
	    	alert("진료 처리는 하나만 가능합니다.");
	    	$("input[name=check]:checked").prop("checked", false);
	    	$("input[name=allCheck]:checked").prop("checked", false);
	    	return false;
		}
		
		$("input[name=check]:checked").each(function() {
			let tno = $(this).closest('tr').find('.tno').text();
			let tstatus = $(this).closest('tr').find('.tstatus').text();
			
			if(tstatus == "진료완료") {
				alert("처리완료된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else if(tstatus == "진료취소") {
				alert("취소된 진료입니다.");
				$("input[name=check]:checked").prop("checked", false);
				return false;
			} else {
				location.href="/docReceptionDetail/"+${sessionScope.mno}+"/"+${sessionScope.dno}+"?tno="+tno;
			}
			
		});
	}
	

</script>

</head>
<body>
	<a href="/docMain/${sessionScope.mno}/${sessionScope.dno}">&nbsp;&nbsp;←뒤로가기</a>
	<h1>DocReception</h1>
	<h3>${docMainDetail.hname}</h3>
	<h3>실시간 비대면 접수내역</h3>
		<div class="consulationHours">
            <span>오늘&nbsp</span>
            <br>
            <c:if
               test="${!(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && now.dayOfWeek != hospital.hnightday}">
               <span class="openTime">${hospital.hopentime }</span> ~
         		<span class="closeTime">${hospital.hclosetime }</span>
            </c:if>

            <c:if test="${now.dayOfWeek == hospital.hnightday}">
               <span class="openTime">${hospital.hopentime }</span> ~ 
         		<span class="closeTime">${hospital.hnightendtime }</span>
            </c:if>

            <c:if
               test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday !=0}">
               <span class="openTime">${hospital.hopentime }</span> ~
         	<span class="closeTime">${hospital.hholidayendtime }</span>
            </c:if>

            <c:if
               test="${(now.dayOfWeek == '토요일' || now.dayOfWeek == '일요일') && hospital.hholiday ==0}">
               <span>휴진</span>
            </c:if>
         </div>
         
    	<div class="today todayBreakInfo">
               <div class="dayTitle">점심시간</div>
               <span id="todayBreak"> <c:if
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
            
	<form action="/docReception/${sessionScope.mno}/${sessionScope.dno}"
		method="get">
		<input id="mname" name="mname" placeholder="환자명을 입력하세요.">
		<button type="submit">조회</button>
	</form>
	<br>
	<table class="table">
		<thead>
			<tr>
				<th style="width: 40px; min-width: 40px; max-width: 40px;"><input
					type="checkbox" id="allCheck" name="allCheck"></th>
				<th style="width: 40px; min-width: 40px; max-width: 40px; display: none;">번호</th>
				<th style="width: 100px; min-width: 100px; max-width: 100px;">환자명</th>
				<th style="width: 100px; min-width: 100px; max-width: 100px;">신청과</th>
				<th style="width: 150px; min-width: 150px; max-width: 150px;">증상</th>
				<th style="width: 100px; min-width: 100px; max-width: 100px;">대기상태</th>
				<th style="width: 100px; min-width: 100px; max-width: 100px;">담당의</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${searchMname}" var="row">
				<tr class="trDetail">
					<td style="width: 40px; min-width: 40px; max-width: 40px;"
						class="checkboxDetail"><input type="checkbox" name="check"
						class="check"></td>
					<td style="width: 40px; min-width: 40px; max-width: 40px; display: none;"
						class="tno">${row.tno}</td>
					<td style="width: 100px; min-width: 100px; max-width: 100px;"
						class="mname">${row.mname}</td>
					<td style="width: 100px; min-width: 100px; max-width: 100px;"
						class="dpkind">${row.dpkind}</td>
					<td style="width: 150px; min-width: 150px; max-width: 150px;"
						class="tsymptomdetail">${row.tsymptomdetail}</td>
					<c:choose>
					<c:when test="${row.tstatus eq 0}">
					<td style="width: 100px; min-width: 100px; max-width: 100px;"
						class="tstatus">진료대기</td>
					</c:when>
					<c:when test="${row.tstatus eq 1}">
						<td style="width: 100px; min-width: 100px; max-width: 100px; color: blue"
						class="tstatus">진료완료</td>
					</c:when>
					<c:otherwise>
						<td style="width: 100px; min-width: 100px; max-width: 100px; color: red"
						class="tstatus">진료취소</td>
					</c:otherwise>
					</c:choose>
					<td style="width: 100px; min-width: 100px; max-width: 100px;"
						class="dname">${row.dname}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<h3>진료과목수 ${dpCount}개</h3>
	<c:forEach items="${dpKind}" var="row">
		<tr>
			<td style="width: 100px; min-width: 100px; max-width: 100px;">${row.dpkind}</td>
		</tr>
	</c:forEach>
	<br>
	<button type="button" id="cancel" onclick="cancel()">진료취소</button>
	<button type="button" id="progress" onclick="progress()">진료처리</button>
</body>
</html>