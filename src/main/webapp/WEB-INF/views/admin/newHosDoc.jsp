<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의사 관리</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
    let hname = "";
	let dname = "";
    
	
	$("#searchHos").click(function() {
		$("#searchDiv").html("");
		searchN = $("#searchN option:selected").val();     
		searchV = $("input[name=searchV]").val();
		
		
		$.ajax({
			url : "./search",
			type : "POST",
			data : {
				"searchN" : searchN,
				"searchV" : searchV,
			},
			dataType: "json",
			success : function(data) {
				let search = data.search;
				let tabkeMake = "";
								
				$("#searchTable").empty();
				tableMake = "<table border='1' style='margin: 0 auto;' id='searchTable'><tr><th id='thHno'>번호</th><th>병원명</th><th>의사명</th><th>전문여부</th><th>비대면진료여부</th><th>진료과</th></tr>";
						
				for (let i = 0; i < search.length; i++) {
					tableMake += "<tr class='chkData'>";
					tableMake += "<td class='div-cell' id='hnoHide' style='display: none;'>"+search[i].hno+"</td>";
					tableMake += "<td class='div-cell' id='data-hname'>"+search[i].hname+"</td>";
					tableMake += "<td class='div-cell' id='data-dname'>"+search[i].dname+"</td>";
					tableMake += "<td class='div-cell' id='data-dspecialist'>"+(search[i].dspecialist == 0 ? '일반의' : '전문의')+"</td>";
					tableMake += "<td class='div-cell' id='data-dtelehealth'>"+(search[i].dtelehealth == 0 ? 'X' : 'O')+"</td>";
					tableMake += "<td class='div-cell' id='dpkind'>"+search[i].dpkind+"</td>";
				}
				tableMake += "</table>";
				
				$("#searchDiv").append(tableMake);
				
				$("#thHno").css("display", "none");
				$("#th1").css("width", "4%");
				$("#th2").css("width", "3%");
				$("#th3").css("width", "2%");
				$("#th4").css("width", "3%");
				$("#th5").css("width", "2%");
				
			},
			error : function(error) {
				alert("잘못된 에러입니다.");
			}
		});
	});

	$(document).on("click", ".chkData" ,function() {
		
		let hno = $(this).children().first().html();
		
		$.ajax({
			url : "./doctorView",
			type : "POST",
			data : {
				"hno" : hno,
			},
			dataType: "json",
			success : function(data) {
				let viewDoctor = data.viewDoctor;
				let doctorMake = "";
				
				$(".modal-body").empty();
			

				for (let i = 0; i < viewDoctor.length; i++) {
					doctorMake = "<table border='1' style='margin: 0 auto;' class='view-table'>";
					doctorMake += "<tr><td colspan='6' class='td2' id='data-dname'><b>"+viewDoctor[i].dname+"</b></td></tr>";
					doctorMake += "<tr><td class='td3'><b>번호</b></td><td colspan='2' id='data-hno' class='td4'>"+viewDoctor[i].hno+"</td><td class='td3'><b>사진</b></td><td colspan='2' class='td4' id='data-dimg'>"+viewDoctor[i].dimg+"</td></tr>";
					doctorMake += "<tr><td colspan='6' class='td2'><b>의사 정보</b></td></tr>";
					doctorMake += "<tr><td class='td3'><b>소개</b></td><td colspan='6' class='td4' id='data-dinfo'>"+viewDoctor[i].dinfo+"</td></tr>";
					doctorMake += "<tr><td class='td3'><b>성별</b></td><td class='td4' id='data-dgender'>"+(viewDoctor[i].dgender == 0 ? '남자' : '여자')+"</td><td class='td3'><b>학력</b></td><td class='td4' id='data-dcareer'>"+viewDoctor[i].dcareer+"</td><td class='td3'><b>전문 여부</b></td><td class='td4' id='data-dspecialist'>"+(viewDoctor[i].dspecialist == 0 ? '일반의' : '전문의')+"</td></tr>";
					doctorMake += "<tr><td class='td3'><b>진료과</b></td><td class='td4' id='data-dpkind'>"+viewDoctor[i].dpkind+"</td><td class='td3'><b>증상</b></td><td class='td4' id='data-dpsymptom'>"+viewDoctor[i].dpsymptom+"</td><td class='td3'><b>키워드</b></td><td class='td4' id='data-dpkeyword'>"+viewDoctor[i].dpkeyword+"</td></tr>";
					doctorMake += "<tr id='tr-atregcomment1'><td colspan='6' class='td2'><b>비대면 진료 여부</b></td></tr>";
					doctorMake += "<tr id='tr-atregcomment2'><td colspan='6' id='data-dtelehealth'>"+(viewDoctor[i].dtelehealth == 0 ? 'X' : 'O')+"</td></tr>";
					doctorMake += "</table>";
				}

				$(".modal-body").append(doctorMake);
				
				$("#viewModal").modal("show");
			
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
	margin-top: 30px;
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

.btnCenter {
	width: 100%;
	margin: 0 auto;
}
</style>
</head>
<body>
	<h1 style="text-align: center;">의사 관리</h1>
	<div class="content">
		<div style="text-align: center;">
			<select id="searchN" name="searchN" style="width: 100px;">
				<option value="" selected="selected">전체</option>
				<option value="hname">병원명</option>
				<option value="dname">의사명</option>
			</select>
			<input type="text" name="searchV" maxlength="2" />
			<button id="searchHos" type="button">검색</button>
			<div id="searchDiv">
			<table id="searchTable" border="1" style="margin: 0 auto;">
				<tr>
					<th id="thHno" style="width: 0%; display: none;">번호</th>
					<th id="th1" style="width: 4%;">병원명</th>
					<th id="th2" style="width: 3%;">의사명</th>
					<th id="th3" style="width: 2%;">전문여부</th>
					<th id="th4" style="width: 3%;">비대면진료여부</th>
					<th id="th5" style="width: 2%;">진료과</th>
				</tr>
				<c:forEach items="${newHospital}" var="nh">
					<tr class="chkData">
						<td class="div-cell" id="hnoHide" style="display: none;">${nh.hno }</td>
						<td class="div-cell" id="data-hname">${nh.hname }</td>
						<td class="div-cell" id="data-dname">${nh.dname}</td>
						<td class="div-cell" id="data-dspecialist">
							<c:choose>
								<c:when test="${nh.dspecialist eq 0}">
									일반의
								</c:when>
								<c:otherwise>
									전문의
								</c:otherwise>
							</c:choose>
						</td>
						<td class="div-cell" id="data-dtelehealth">
							<c:choose>
								<c:when test="${nh.dtelehealth eq 0}">
									X
								</c:when>
								<c:otherwise>
									O
								</c:otherwise>
							</c:choose>
						</td>
						<td class="div-cell" id="data-dpkind">${nh.dpkind}</td>
					</tr>
				</c:forEach>
			</table>
			</div>
		<div class="btnCenter">
			<button class="dhBtn" onclick="location.href='./adminMain'">돌아가기</button>
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
					<h1 class="modal-title" id="exampleModalLabel">의사 상세 내역</h1>
				</div>
				<div class="modal-body view-body">
					<table border="1" style="margin: 0 auto;" class="view-table">
						<tr>
							<td colspan="6" class="td2" id="data-dname"><b></b></td>
						</tr>
						<tr>
							<td class="td3">번호</td>
							<td colspan="2" id="data-hno" class="td4"></td>
							<td class="td3">사진</td>
							<td colspan="2" class="td4" id="data-dimg"></td>
						</tr>
               			<tr>
               				<td colspan="6" class="td2"><b>의사 정보</b></td>
               			</tr>
               			<tr>
               				<td class="td3">소개</td>
               				<td colspan="6" class="td4" id="data-dinfo"></td>
               			</tr>
               			<tr>
               				<td class="td3">성별</td>
               				<td class="td4" id="data-dgender"></td>
               				<td class="td3">학력</td>
               				<td class="td4" id="data-dcareer"></td>
               				<td class="td3">전문 여부</td>
               				<td class="td4" id="data-dspecialist"></td>
               			</tr>
               			<tr>
               				<td class="td3">진료과</td>
               				<td class="td4" id="data-dpkind"></td>
               				<td class="td3">증상</td>
               				<td class="td4" id="data-dpsymptom"></td>
               				<td class="td3">키워드</td>
               				<td class="td4" id="data-dpkeyword"></td>
               			</tr>
               			<tr id="tr-atregcomment1">
               				<td colspan="6" class="td2"><b>비대면 진료 여부</b></td>
               			</tr>
               			<tr id="tr-atregcomment2">
               				<td colspan="6" id="data-dtelehealth"></td>
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
