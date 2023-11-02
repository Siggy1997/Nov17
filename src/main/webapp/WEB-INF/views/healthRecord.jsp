<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HealthRecord</title>

<script src="./js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">
</script>

</head>
<body>
	<a href="../main">&nbsp;&nbsp;←뒤로가기</a>
	<h1>HealthRecord</h1>
	<h3>내 건강기록 확인하기</h3>
	<h4>키</h4>
	<input type="text" id="height" name="height" placeholder="ex)155" maxlength="5">cm
	<h4>몸무게</h4>
	<input type="text" id="weight" name="weight" placeholder="ex)47" maxlength="5">kg
	<h4>수축 혈압</h4>
	<input type="text" id="systolicPressure" name="systolicPressure" placeholder="ex)100" maxlength="3">mmHg
	<h4>이완 혈압</h4>
	<input type="text" id="diastolicPressure" name="diastolicPressure" placeholder="ex)100" maxlength="3">mmHg
	<h4>기타 특이사항</h4>
	<input type="text" id="issue" name="issue" placeholder="특이사항을 적어주세요.">
	<br>
</body>
</html>