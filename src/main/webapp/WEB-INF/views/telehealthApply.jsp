<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/hospital.css">
<script src="./js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">
	$(function(){
		/* 내용이 없을 때 막기 */
		$(document).on("submit", "#telehealthApply", function(event){
			if ($("#content").val().length < 1) {
		        event.preventDefault();
		        alert("내용을 입력해 주세요.")
		    }
		});
		
		/* 입력 다 했을 경우 버튼 효과 */
		$(document).on("input", "#content", function(){
		    if ($(this).val().length < 1 || $(this).val().length > 200) {
		    	$(".next").removeClass("btn-color-css");
		    } else {
		    	$(".next").addClass("btn-color-css");
		    }
		});
	});
</script>

</head>
<body>
	<h1>비대면 접수 신청</h1>
	<div class="telehealthApplyContainerBox">
	<form id="telehealthApply" action="/telehealthApply" method="post">
		<div class="telehealthApplyHeader">
			<div class="xi-angle-left"></div>
		</div>
		<div class="body">
			<div class="information">
				<div class="infoText">${telehealthApply.dpkind} 증상을 알려주세요</div>
				<div class="infoImg"><img src="./img/dp${telehealthApply.dpno}.png"></div>
			</div>
			<div class="medicalExpenses">${telehealthApply.dpkind} 진료비 : 
				<c:choose>
					<c:when test="${telehealthApply.dspecialist == 1}">15,000원</c:when>
					<c:otherwise>10,000원</c:otherwise>
				</c:choose>
			</div>
			<div class="symptom">
				대표적 증상
				<c:forEach items="${telehealthApply.dpkeyword.split(',')}" var="keyword">
					<div>${keyword}</div>
				</c:forEach>
			</div>
			<input id="content" name="tsymptomdetail" placeholder="최대 200자까지 입력할 수 있습니다.">
			<div class="caution">
				• 증상에 대해서 자세히 설명해 주세요.
				• 현재 복용중인 약이 있다면 기재해 주세요.
				• 기저질환이 있으시다면 못 드시는 약 등을 꼭 기재해 주세요.
			</div>
			<input type="hidden" name="hno" value="${telehealthApply.hno}">
			<input type="hidden" name="dno" value="${telehealthApply.dno}">
			<input type="hidden" name="dpno" value="${telehealthApply.dpno}">
			<input type="hidden" name="pay" value="${telehealthApply.dspecialist}">
			<button class="next">다음</button>
		</div>
	</form>
   </div>
</body>
</html>