<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HealthRecord</title>

<script src="../js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">
$(function(){
	$("#changeHealthRecordBtn").click(function(){
		
		$("#heightInfo").text("");
		$("#weightInfo").text("");
		$("#systolicPressureInfo").text("");
		$("#diastolicPressureInfo").text("");
		
		let height = $("#hrheight").val();
		let weight = $("#hrweight").val();
		let systolicPressure = $("#hrsystolicpressure").val();
		let diastolicPressure = $("#hrdiastolicpressure").val();
		let issue = $("#hrissue").val();
		
		let notNum = /[^0-9]/g; //숫자아닌지 확인
		
	    if(notNum.test(height)) {
	        $("#heightInfo").text("숫자만 입력 가능합니다.");
	        $("#heightInfo").css("color","red");
	        return false;
	    }
		
	    if(notNum.test(weight)) {
	        $("#weightInfo").text("숫자만 입력 가능합니다.");
	        $("#weightInfo").css("color","red");
	        return false;
	    }
	    
	    if(notNum.test(systolicPressure)) {
	        $("#systolicPressureInfo").text("숫자만 입력 가능합니다.");
	        $("#systolicPressureInfo").css("color","red");
	        return false;
	    }
	    
	    if(notNum.test(diastolicPressure)) {
	        $("#diastolicPressureInfo").text("숫자만 입력 가능합니다.");
	        $("#diastolicPressureInfo").css("color","red");
	        return false;
	    }
	});
});


</script>

</head>
<body>
	<a href="../main">&nbsp;&nbsp;←뒤로가기</a>
	<h1>HealthRecord</h1>
	<h3>내 건강기록 확인하기</h3>
	<form action="../changeHealthRecord/${sessionScope.mno}" method="post">
	<h4>키</h4>
	<input type="text" id="hrheight" name="hrheight" placeholder="ex)155" maxlength="3" value="${healthRecord.hrheight}">cm
	<br>
	<span id="heightInfo"></span>
	<h4>몸무게</h4>
	<input type="text" id="hrweight" name="hrweight" placeholder="ex)47" maxlength="3" value="${healthRecord.hrweight}">kg
	<br>
	<span id="weightInfo"></span>
	<h4>수축 혈압</h4>
	<input type="text" id="hrsystolicpressure" name="hrsystolicpressure" placeholder="ex)100" maxlength="3" value="${healthRecord.hrsystolicpressure}">mmHg
	<br>
	<span id="systolicPressureInfo"></span>
	<h4>이완 혈압</h4>
	<input type="text" id="hrdiastolicpressure" name="hrdiastolicpressure" placeholder="ex)100" maxlength="3" value="${healthRecord.hrdiastolicpressure}">mmHg
	<br>
	<span id="diastolicPressureInfo"></span>
	<h4>기타 특이사항</h4>
	<input type="text" id="hrissue" name="hrissue" placeholder="특이사항을 적어주세요." maxlength="30" value="${healthRecord.hrissue}">
	<br>
	<button id="changeHealthRecordBtn">내 건강기록 변경</button>
	</form>
</body>
</html>