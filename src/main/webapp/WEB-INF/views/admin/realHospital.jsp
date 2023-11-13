<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>realHospital</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	let hno = 0;
	/* let hname = ''; */
	
	$(".chkData").click(function() {
		hno = $(this).children().first().html();
		/* hname = $(this).find('td:eq(1)').html(); */
		
		location.href="./newDoctor?hno="+hno;
		
		/* $.ajax({
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
				$("#data-rhholiday").text(detail.rhholiday);
				$("#data-rhholidayendtime").text(detail.rhholidayendtime);
				$("#data-rhparking").text(detail.rhparking);
				$("#approve").val(detail.rhno);
				
				$("#viewModal").modal("show");
			},
			error : function(error) {
				alert("잘못된 에러입니다.");
			}
		}); */
	});
});
</script>
<style type="text/css">
.modal {
   display: none;
   position: fixed;
   padding-top: 50px;
   top: calc(20vh - 50px);
   left: calc(26vw - 50px);
   width: 1000px;
   height: 500px;
   background-color: white;
   justify-content: center;
   align-items: center;
   text-align: center;
   border-radius: 15px;
   border: 0;
   box-shadow: rgba(0, 0, 0, 0.5) 0 0 0 9999px;
}

.dhBtn {
	border: 0;
	background-color: #00C9FF;
	border-radius: 15px;
	color: white;
	width: 130px;
	height: 30px;
	margin-bottom: 30px;
}
</style>
</head>
<body>
	<h1 style="text-align: center;">신규 병원 관리</h1>
	<div class="content">
		<div style="text-align: center;">
			<table border="1" style="margin: 0 auto;">
				<tr>
					<th style="width: 7%;">병원번호</th>
					<th style="width: 7%;">병원명</th>
					<th style="width: 7%;">개원일</th>
					<th style="width: 7%;">주소</th>
					<th style="width: 15%;">전화번호</th>
					<th style="width: 7%;">시작시간</th>
					<th style="width: 7%;">종료시간</th>
					<th style="width: 7%;">야간 진료 요일</th>
					<th style="width: 7%;">야간 종료시간</th>
					<th style="width: 7%;">브레이크타임</th>
					<th style="width: 7%;">브레이크 종료시간</th>
					<th style="width: 7%;">공휴일 진료여부</th>
					<th style="width: 7%;">공휴일 종료시간</th>
				</tr>
				<c:forEach items="${finalHospital}" var="fh">
					<tr class="chkData" >
						<td class="div-cell">${fh.hno }</td>
						<td class="div-cell">${fh.hname }</td>
						<td class="div-cell">${fh.hopendate}</td>
						<td class="div-cell">${fh.haddr}</td>
						<td class="div-cell">${fh.htelnumber}</td>
						<td class="div-cell">${fh.hopentime}</td>
						<td class="div-cell">${fh.hclosetime}</td>
						<td class="div-cell">${fh.hnightday}</td>
						<td class="div-cell">${fh.hnightendtime}</td>
						<td class="div-cell">${fh.hbreaktime}</td>
						<td class="div-cell">${fh.hbreakendtime}</td>
						<td class="div-cell">${fh.hholiday}</td>
						<td class="div-cell">${fh.hholidayendtime}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<br>
	<div>
		<button onclick="location.href='./adminMain'">돌아가기</button>
	</div>

	
	<div class="modal" id="viewModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		data-bs-backdrop="static" data-keyboard="false">
		<!-- 모달 내용 -->
		<div class="modal-dialog">
			<form action="admin/newDoctor" method="POST">
			<div class="modal-content">
				<div class="edit-header">
					<h1 class="modal-title" id="exampleModalLabel">병원 상세 내역</h1>
				</div>
				<div class="modal-body view-body">
					<table border="1" style="margin: 0 auto;" class="view-table">
						<tr>
							<td colspan="6" class="td2"><b>병원명이 들어가는 곳</b></td>
						</tr>
						<tr>
							<td class="td3">번호</td>
							<td colspan="2" id="data-rhno" class="td4">${hl.rhno }</td>
							<td class="td3">개원일</td>
							<td colspan="2" class="td4" id="data-rhopendate">${hl.rhopendate }</td>
						</tr>
               			<tr>
               				<td colspan="6" class="td2"><b>병원 정보</b></td>
               			</tr>
               			<tr>
               				<td class="td3">주소</td>
               				<td colspan="6" class="td4" id="data-rhaddr">${hl.rhaddr }</td>
               			</tr>
               			<tr>
               				<td class="td3">야간 진료 요일</td>
               				<td class="td4" id="data-rhnightday">${hl.rhnightday }</td>
               				<td class="td3">브래이크 시간</td>
               				<td class="td4" id="data-rhbreaktime">${hl.rhbreaktime }</td>
               				<td class="td3">공휴일 진료 여부</td>
               				<td class="td4" id="data-rhholiday">${hl.rhholiday }</td>
               			</tr>
               			<tr>
               				<td class="td3">야간 종료 시간</td>
               				<td class="td4" id="data-rhnightendtime">${hl.rhnightendtime }</td>
               				<td class="td3">브래이크 종료</td>
               				<td class="td4" id="data-rhbreakendtime">${hl.rhbreakendtime }</td>
               				<td class="td3">공휴일 종료</td>
               				<td class="td4" id="data-rhholidayendtime">${hl.rhholidayendtime }</td>
               			</tr>
               			<tr id="tr-atregcomment1">
               				<td colspan="6" class="td2"><b>주차 여부</b></td>
               			</tr>
               			<tr id="tr-atregcomment2">
               				<td colspan="6" id="data-rhparking">${hl.rhparking }</td>
               			</tr>
               		</table>
				</div>
				<div style="margin-top: 30px;" class="modal-footer view-footer">
					<button type="submit" class="dhBtn" id="confirm">승인</button>
					<button type="button" class="dhBtn" id="cancel">취소</button>					
				</div>
					<button type="button" class="dhBtn" id="closeBtn" data-bs-dismiss="modal">닫기</button>
			</div>
			</form>
		</div>
	</div>

</body>
</html>
