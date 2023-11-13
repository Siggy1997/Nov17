<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hospitalOpen</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	let rhno = 0;
	
	$("#hosStatus").change(function() {
        var selectedValue = $(this).val();
        if (selectedValue == "0") {
            $(".chkData").show();
        } else if (selectedValue == "1") {
            $(".chkData").hide();
            $(".chkData[data-rhresult='0']").show();
        } else if (selectedValue == "2") {
            $(".chkData").hide();
            $(".chkData[data-rhresult='1']").show();
        }
    });	

	$(".chkData").click(function() {
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
				let tabkeMake = "";
								
				$("#searchTable").empty();
				tableMake = "<table border='1' style='margin: 0 auto;' id='searchTable'><tr><th>번호</th><th>병원명</th><th>개원일</th><th>주소</th><th>전화번호</th><th>공휴일 진료여부</th><th>공휴일 종료시간</th></tr>";
						
				for (let i = 0; i < searchHos.length; i++) {
					tableMake += "<tr class='chkData'>";
					tableMake += "<td class='div-cell' >"+searchHos[i].rhno+"</td>";
					tableMake += "<td class='div-cell' >"+searchHos[i].rhname+"</td>";
					tableMake += "<td class='div-cell' >"+searchHos[i].rhopendate+"</td>";
					tableMake += "<td class='div-cell' >"+searchHos[i].rhaddr+"</td>";
					tableMake += "<td class='div-cell' >"+searchHos[i].rhtelnumber+"</td>";
					tableMake += "<td class='div-cell' >"+(searchHos[i].rhholiday == 0 ? 'X' : 'O')+"</td>";
					tableMake += "<td class='div-cell' >"+searchHos[i].rhholidayendtime+"</td></tr>";
				
				}
				tableMake += "</table>";
				
				$("#searchDiv").append(tableMake);
				
				$("th").css("width", "7%");
				
			},
			error : function(error) {
				alert("잘못된 에러입니다.");
			}
		});
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

.modal-footer {
	display: flex;
	text-align: center;
	margin: 0 auto;
}

#closeBtn {
	margin: 0 auto;
}

#confirm {
	margin-right: 5px;
	margin-left: 368px;
}

#searchTable {
	width: 700px;
	
}

#searchHos {
	margin-bottom: 30px;
}

.btn {
	border: 0;
	background-color: #00C9FF;
	border-radius: 15px;
	color: white;
	width: 130px;
	height: 30px;
	margin-bottom: 30px;
}

.dhBtn {
	margin: 0 auto;
}
</style>
</head>
<body>
	<h1 style="text-align: center;">병원 등록 관리</h1>
	<div class="content">
		<div style="text-align: center;">
			<select id="searchN" name="searchN" style="width: 120px;">
				<option value="" selected="selected">전체</option>
				<option value="rhname">병원명</option>
				<option value="rhaddr">주소</option>
			</select>
			<input type="text" name="searchV" maxlength="10" />
			<button id="searchHos" type="button">검색</button>
			<div id="searchDiv">
			<table border="1" style="margin: 0 auto;" id="searchTable">
				<tr>
					<th style="width: 1%;">병원번호</th>
					<th style="width: 4%;">병원명</th>
					<th style="width: 3%;">개원일</th>
					<th style="width: 4%;">주소</th>
					<th style="width: 3%;">전화번호</th>
					<th style="width: 2%;">공휴일 진료여부</th>
					<th style="width: 1%;">공휴일 종료시간</th>
				</tr>
				<c:forEach items="${hospitalOpen}" var="hospitalOpen">
					<tr class="chkData" >
						<td class="div-cell">${hospitalOpen.rhno }</td>
						<td class="div-cell">${hospitalOpen.rhname }</td>
						<td class="div-cell">${hospitalOpen.rhopendate}</td>
						<td class="div-cell">${hospitalOpen.rhaddr}</td>
						<td class="div-cell">${hospitalOpen.rhtelnumber}</td>
						<td class="div-cell">
						<c:choose>
							<c:when test="${hospitalOpen.rhholiday eq 0}">
								X
							</c:when>
							<c:otherwise>
								O
							</c:otherwise>
						</c:choose>
						</td>
						<td class="div-cell">${hospitalOpen.rhholidayendtime}</td>
					</tr>
				</c:forEach>
			</table>
			</div>
		</div>
	</div>
	<br>
	<div class="dhBtn">
		<button class="btn" onclick="location.href='./adminMain'">돌아가기</button>
	</div>
	
	<div class="modal" id="viewModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true"
		data-bs-backdrop="static" data-keyboard="false">
		<!-- 모달 내용 -->
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="edit-header">
					<h1 class="modal-title" id="exampleModalLabel">병원 상세 내역</h1>
				</div>
				<div class="modal-body view-body">
					<table border="1" style="margin: 0 auto;" class="view-table">
						<tr>
							<td colspan="6" class="td2" id="data-rhname"><b></b></td>
						</tr>
						<tr>
							<td class="td3"><b>번호</b></td>
							<td colspan="2" id="data-rhno" class="td4"></td>
							<td class="td3"><b>개원일</b></td>
							<td colspan="2" class="td4" id="data-rhopendate"></td>
						</tr>
               			<tr>
               				<td colspan="6" class="td2"><b>병원 정보</b></td>
               			</tr>
               			<tr>
               				<td class="td3"><b>주소</b></td>
               				<td colspan="6" class="td4" id="data-rhaddr"></td>
               			</tr>
               			<tr>
               				<td class="td3"><b>야간 진료 요일</b></td>
               				<td class="td4" id="data-rhnightday"></td>
               				<td class="td3"><b>브래이크 시간</b></td>
               				<td class="td4" id="data-rhbreaktime"></td>
               				<td class="td3"><b>공휴일 진료 여부</b></td>
               				<td class="td4" id="data-rhholiday"></td>
               			</tr>
               			<tr>
               				<td class="td3"><b>야간 종료 시간</b></td>
               				<td class="td4" id="data-rhnightendtime"></td>
               				<td class="td3"><b>브래이크 종료</b></td>
               				<td class="td4" id="data-rhbreakendtime"></td>
               				<td class="td3"><b>공휴일 종료</b></td>
               				<td class="td4" id="data-rhholidayendtime"></td>
               			</tr>
               			<tr id="tr-atregcomment1">
               				<td colspan="6" class="td2"><b>주차 여부</b></td>
               			</tr>
               			<tr id="tr-atregcomment2">
               				<td colspan="6" id="data-rhparking"></td>
               			</tr>
               		</table>
				</div>
				<div style="margin-top: 30px;" class="modal-footer view-footer">
					<form action="/admin/realHospital" method="POST">
						<input type="hidden" id="approve" name="rhno" value="" />
						<button type="submit" class="dhBtn" id="confirm">승인</button>
					</form>
					<button type="button" class="dhBtn" id="cancel">취소</button>					
				</div>
					<button type="button" class="dhBtn" id="closeBtn" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>

</body>
</html>
