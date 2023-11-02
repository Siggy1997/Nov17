<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="./js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">
	
</script>

</head>
<body>
	<h1>main</h1>
	<div>
		<img alt="의사사진" src="${doctorDetail.dimg }">
	</div>
	<div class="doctorName">${doctorDetail.dname }</div>
	<c:if test="${doctorDetail.dspecialist ==1 }">전문의</c:if>

	<div class="doctorTitle">소개글</div>
	<div class="doctorInfo">${doctorDetail.dinfo }</div>

	<div class="doctorTitle">학력 및 격력</div>
	<div class="doctorCareer">${doctorDetail.dcareer }</div>

	<div class="doctorTitle">소속병원</div>
	<div class="doctorHospital">${doctorDetail.hname}</div>
	<div class="hospitalAddr">${doctorDetail.haddr }</div>
</body>
</html>