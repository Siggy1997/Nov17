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

		/* 	$(".trDetail").click(function(){
		
		 let mname = $(this).closest('tr').find('.mname').text();
		 alert(mname);
		 }); */

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
			row.push(tno);
		});

	    if (row.length > 0) {
	        $.ajax({
	            url: "/deleteRows", // 서버의 URL을 입력하세요.
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
	        });
	    } else {
	        alert("진료취소할 행을 선택해주세요.");
	    }
	}

	$(function() {
		$("#allCheck").click(function() {
			if ($("#allCheck").is(":checked"))
				$("input[name=check]").prop("checked", true);
			else
				$("input[name=check]").prop("checked", false);
		});
	});
</script>

</head>
<body>
	<a href="/docMain/${sessionScope.mno}/${sessionScope.dno}">&nbsp;&nbsp;←뒤로가기</a>
	<h1>DocReception</h1>
	<h3>실시간 비대면 접수내역</h3>
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
					type="checkbox" id="allCheck"></th>
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
				<tr class="trDetail" style="background-color: yellow">
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
					<td style="width: 100px; min-width: 100px; max-width: 100px;"
						class="tstatus">${row.tstatus}</td>
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
	<button type="button" id="progress">진료처리</button>
</body>
</html>