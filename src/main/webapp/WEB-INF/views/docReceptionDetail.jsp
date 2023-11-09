<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<head>
<meta charset="UTF-8">
<title>DocReceptionDetail</title>

<script src="/js/jquery-3.7.0.min.js"></script> 
<script src="/js/wnInterface.js"></script> 
<script src="/js/mcore.min.js"></script> 
<script src="/js/mcore.extends.js"></script> 

<script type="text/javascript">

function scrollPatient() {
    // 환자 정보 위치
    var patientInfoSection = document.getElementById("patientInfo");
    
    // 환자 정보로 스크롤
    if (patientInfoSection) {
        patientInfoSection.scrollIntoView({ behavior: "smooth" });
    }
}

function scrollSymptom() {
    var symptomInfoSection = document.getElementById("symptomInfo");
    
    if (symptomInfoSection) {
    	symptomInfoSection.scrollIntoView({ behavior: "smooth" });
    }
}

function scrollDiagnosis() {
    var diagnosisInfoSection = document.getElementById("diagnosisInfo");
    
    if (diagnosisInfoSection) {
    	diagnosisInfoSection.scrollIntoView({ behavior: "smooth" });
    }
}  
		
$(function() {
	$("#completeDiagnosis").click(function(){
		
		let tdiagnosisdetail = $("#tdiagnosisdetail").val();
		if(tdiagnosisdetail === "" ) {
			alert("진단기록을 입력해주세요.");
			$("#tdiagnosisdetail").focus();
			return false;
		}
		
	});

	document.getElementById("callIcon").addEventListener("click", function() {
	  let phoneNumber = $("#phoneNumber").val();
	  // 현재 화면 정보를 변수에 저장
	  M.sys.call(phoneNumber);

	});
	
});




</script>

</head>
<body>
	<a href="/docReception/${sessionScope.mno}/${sessionScope.dno}">&nbsp;&nbsp;←뒤로가기</a>
	<h1>DocReceptionDetail</h1>
	<h3>${docMainDetail.hname}</h3>
	<button id="scrollPatient" onclick="scrollPatient()">환자정보</button><button id="scrollSymptom" onclick="scrollSymptom()">증상기록</button><button id="scrollDiagnosis" onclick="scrollDiagnosis()">진단기록</button>
	<h3 id="patientInfo">환자정보</h3>
	<h5>이름</h5>
	${patientDetail.mname}
	<h5>생년월일</h5>
	${patientDetail.mbirth}
	<h5>휴대폰번호</h5>
	<input id="phoneNumber" value="${patientDetail.mphonenumber}">
	<h5>이메일주소</h5>
	${patientDetail.memail}
	<h5>질병특이사항</h5>
	<c:choose>
	    <c:when test="${empty patientDetail.hrissue}">
	        없음
	    </c:when>
	    <c:otherwise>
	        ${patientDetail.hrissue}
	    </c:otherwise>
	</c:choose>
	<h5>우리병원 이용 횟수</h5>
	${hospitalCount}
	<h3 id="symptomInfo">증상기록</h3>
	<input style="width:300px;  height: 300px;" value="${patientDetail.tsymptomdetail}">
	<form action="/updateTelehealth/${sessionScope.mno}/${sessionScope.dno}" method="post">
	<h3 id="diagnosisInfo">진단기록</h3>
	<input id="tdiagnosisdetail" name="tdiagnosisdetail" style="width:300px;  height: 300px;">
	<i class="xi-call xi-2x" id="callIcon"></i>
	<br>
	<input id="tno" value="${patientDetail.tno}" name="tno"><br>
	<button id="completeDiagnosis" type="submit">진료완료</button>
	</form>
</body>
</html>