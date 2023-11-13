<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HealthRecord</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="/css/healthRecord.css">
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
	<header>
		<a href="/main"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">건강기록</div>
		<div class="blank"></div>
	</header>
	
	<main>
		<div class="main-area">
		<p class="top-title">내 건강기록을 확인하기🏃‍♂️</p>
		<form action="../changeHealthRecord/${sessionScope.mno}" method="post">
		<div class="input-area">
			<p>키</p>
			<input type="text" id="hrheight" name="hrheight" placeholder="ex)155" maxlength="3" value="${healthRecord.hrheight}">cm
			<p id="heightInfo" class="info"></p>
		</div>
		<div class="input-area">
			<p>몸무게</p>
			<input type="text" id="hrweight" name="hrweight" placeholder="ex)47" maxlength="3" value="${healthRecord.hrweight}">kg
			<p id="weightInfo" class="info"></p>
		</div>
		<div class="input-area">
			<p>수축 혈압</p>
			<input type="text" id="hrsystolicpressure" name="hrsystolicpressure" placeholder="ex)100" maxlength="3" value="${healthRecord.hrsystolicpressure}">mmHg
			<p id="systolicPressureInfo" class="info"></p>
		</div>
		<div class="input-area">
			<p>이완 혈압</p>
			<input type="text" id="hrdiastolicpressure" name="hrdiastolicpressure" placeholder="ex)100" maxlength="3" value="${healthRecord.hrdiastolicpressure}">mmHg
			<p id="diastolicPressureInfo" class="info"></p>
		</div>
		<div class="input-area">
			<p>기타 특이사항</p>
			<input type="text" id="hrissue" name="hrissue" placeholder="특이사항을 적어주세요." maxlength="30" value="${healthRecord.hrissue}">
			<button id="changeHealthRecordBtn">변경하기</button>
		</div>
		</form>
		</div>
	</main>
</body>
</html>