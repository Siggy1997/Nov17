<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>hospitalOpen</title>
<link rel="stylesheet" href="../css/hospitalOpen.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	let rhno = 0;
	
	$(document).on("click", ".chkData" ,function() {
		rhno = $(this).children().first().html();
		
		$.ajax({
			url : "./detail",
			type : "POST",
			data : {
				"rhno" : rhno,
			},
			dataType: "json",
			success : function(data) {
				let detail = data.detail;
				
				
				$("#data-rhno").text(detail.rhno);
				$("#data-rhname").text(detail.rhname);
				$("#data-rhopendate").text(detail.rhopendate);
				$("#data-rhaddr").text(detail.rhaddr);
				$("#data-rhtelnumber").text(detail.rhtelnumber);
				$("#data-rhimg").text(detail.rhimg);
				$("#data-rhinfo").text(detail.rhinfo);
				$("#data-rhopentime").text(detail.rhopentime);
				$("#data-rhclosetime").text(detail.rhclosetime);
				$("#data-rhnightday").text(detail.rhnightday);
				$("#data-rhnightendtime").text(detail.rhnightendtime);
				$("#data-rhbreaktime").text(detail.rhbreaktime);
				$("#data-rhbreakendtime").text(detail.rhbreakendtime);
				$("#data-rhholiday").text(detail.rhholiday == 0 ? 'X' : 'O');
				$("#data-rhholidayendtime").text(detail.rhholidayendtime);
				$("#data-rhparking").text(detail.rhparking == 0 ? 'X' : 'O');
				$("#approve").val(detail.rhno);
				
				$("#viewModal").modal("show");
				
				$("#data-rhname").css("font-weight", "bold");
			},
			error : function(error) {
				alert("잘못된 에러입니다.");
			}
		});
	});



	$("#searchHos").click(function() {
		$("#searchDiv").html("");
		searchN = $("#searchN option:selected").val();     
		searchV = $("input[name=searchV]").val();
		
		
		$.ajax({
			url : "./searchHos",
			type : "POST",
			data : {
				"searchN" : searchN,
				"searchV" : searchV,
			},
			dataType: "json",
			success : function(data) {
				let searchHos = data.searchHos;
				let tableMake = "";
								
				$("#searchTable").empty();

				for (let i = 0; i < searchHos.length; i++) {
					tableMake += "<div class='chkData' id='searchTable'>";
					tableMake += "<div style='display: none; text-align: left; margin-left: 10px;'>"+searchHos[i].rhno+"</div>";
					tableMake += "<div style='text-align: left; font-weight: bold; margin-left: 10px;'>"+searchHos[i].rhname+"</div>";
					tableMake += "<div style='text-align: left; margin-left: 10px; font-size: 12px;'>"+searchHos[i].rhaddr+"</div>";
					tableMake += "<div style='text-align: left; margin-left: 10px; font-size: 12px;'>"+searchHos[i].rhtelnumber;
					tableMake += "<span style='text-align: right; margin-left: 180px;'>"+searchHos[i].rhopendate+"</span></div>";
					tableMake += "<div class='graySeperate'></div></div>";
				}
				
				
				$("#searchDiv").append(tableMake);
				
			},
			error : function(error) {
				alert("잘못된 에러입니다.");
			}
		});
	});

	$(document).on("click", "#cancel" ,function() {
		rhno = $("#data-rhno").html();
		alert(rhno);
		
		if(confirm("삭제하시겠습니까?")) {
			$.ajax({
				url : "./deleteHos",
				type : "POST",
				data : {
					"rhno" : rhno,
				},
				dataType: "json",
				success : function(data) {
					location.reload();					
				},
				error : function(error) {
					alert("잘못된 에러입니다.");
				}
			});
		} else {
			return false;
		}
	});
});
</script>
</head>

<header>
    <i class="xi-angle-left xi-x" onclick="history.back()"></i>

	<div class="blank"></div>

	<div><h3 style="text-align: center; margin-right: 40px; font-size: 25px;">병원 등록 관리</h3></div>
	
	<div class="blank"></div>
</header>

<body>
	<main>
	<div class="content">
		<div class="searchTab">
			<select id="searchN" name="searchN" style="width: 60px;">
				<option value="" selected="selected">전체</option>
				<option value="rhname">병원명</option>
				<option value="rhaddr">주소</option>
			</select>
			<input type="text" id="searchV" name="searchV" maxlength="10" style="width: 70px;" />
			<button id="searchHos" type="button">검색</button>
			<div id="searchDiv">
				<c:forEach items="${hospitalOpen}" var="hospitalOpen">
					<div class="chkData" id="searchTable">
						<div style="text-align: left; margin-left: 10px; display: none;">${hospitalOpen.rhno }</div>
						<div style="text-align: left; margin-left: 10px; margin-top: 5px; font-weight: bold;">${hospitalOpen.rhname }</div>
						<div style="text-align: left; margin-left: 10px; font-size: 12px;">${hospitalOpen.rhaddr}</div>
						<div style="text-align: left; margin-left: 10px; font-size: 12px;">${hospitalOpen.rhtelnumber}
							<span style="text-align: right; margin-left: 220px; ">${hospitalOpen.rhopendate}</span>
						</div>
						<div class="graySeperate"></div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<div class="modal" id="viewModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		data-bs-backdrop="static" data-keyboard="false">
		<!-- 모달 내용 -->
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="edit-header">
					<h1 style="display: inline-block; margin-right: 20px;" class="modal-title" id="data-rhname"></h1>
					<span style="margin-right: -2px;" class="xi-close xi-x" data-bs-dismiss="modal"></span>
				</div>
				<div class="modal-body view-body">
					<div class="modal-div" style="text-align: left; margin-top: 30px; margin-left: 30px;">
						<div style="text-decoration: underline; font-size: 20px;">번호
							<span style="font-weight: bold; font-size: 18px; text-align: right; margin-left: 186px;" id="data-rhno"></span>
						</div>
						<br>
						<div style="font-size: 18px;">개원일
							<span style="font-weight: bold; font-size: 14px; text-align: right; margin-left: 110px;" id="data-rhopendate"></span>
						</div>
						<br>
						<div style="font-size: 18px;">전화번호
							<span style="font-weight: bold; font-size: 14px; text-align: right; margin-left: 85px;" id="data-rhtelnumber"></span>
						</div>
						<br>
						<div style="font-size: 18px;">주소
							<span style="font-weight: bold; font-size: 14px; text-align: right; margin-left: 50px;" id="data-rhaddr"></span>
						</div>
						<br>
						<div style="font-size: 18px;">진료시간</div>
							<span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhopentime"></span> ~ <span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhclosetime"></span>
						<br>
						<br>
						<div style="font-size: 18px;">야간진료 요일 및 종료시간</div>
							<span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhnightday"></span> / <span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhnightendtime"></span>
						<br>
						<br>
						<div style="font-size: 18px;">브래이크 시간 및 종료</div>
							<span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhbreaktime"></span> ~ <span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhbreakendtime"></span>
						<br>
						<br>	
						<div style="font-size: 18px;">공휴일 진료여부 및 종료</div>
							<span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhholiday"></span> / <span style="font-weight: bold; font-size: 14px; text-align: right;" id="data-rhholidayendtime"></span>
						<br>	
						<br>
						<div style="font-size: 18px;">주차 여부
							<span style="font-weight: bold; font-size: 14px; text-align: right; margin-left: 145px;" id="data-rhparking"></span>
						</div>			
					</div>
				</div>
				<div style="margin-top: 10px;" class="modal-footer view-footer">
					<form action="/admin/newHosDoc" method="POST">
						<input type="hidden" id="approve" name="rhno" value="" />
						<button type="submit" class="dhBtn" id="confirm">승인</button>
					</form>
					<button type="button" class="dhBtn" id="cancel">삭제</button>					
				</div>
			</div>
		</div>
	</div>
	<div style="height: 9vh"></div>
</main>
<footer>

</footer>
</body>
</html>
