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
<title>telehealthApply</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/doctorReview.css">
<script src="./js/jquery-3.7.0.min.js"></script> 
<script type="text/javascript">
	$(function(){
		
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function(){
			history.back();
		});
		
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
		    	$(".next").removeClass("submit-btn-css");
		    } else {
		    	$(".next").addClass("submit-btn-css");
		    }
		});
	});
</script>

</head>
<body>

	<!-- header -->
	<header>
		<i class="xi-angle-left xi-x"></i>
		<div class="headerTitle">비대면 진료 접수</div>
		<div class="blank"></div>
	</header>
	
	<!-- main -->
	<form id="telehealthApply" action="/telehealthApply" method="post">
	<main class="telehealthApplyContainerBox container">
		<div class="infoSection">
			<div class="information">
				<div class="infoText">${telehealthApply.dpkind} 증상을 알려주세요</div>
				<div class="infoImg"><img src="./img/dp${telehealthApply.dpno}.png"></div>
			</div>
			<div class="symptom">
				<div class="symptomTitle"><img src="https://cdn-icons-png.flaticon.com/512/119/119060.png">대표적 증상</div>
				<div class="keywordGroup">
				<c:forEach items="${telehealthApply.dpkeyword.split(',')}" var="keyword">
					<div class="symptomKeyword">${keyword}</div>
				</c:forEach>
				</div>
			</div>
			<div class="medicalExpenses"><span class="symptomTitle"><img src="https://cdn-icons-png.flaticon.com/512/119/119060.png">${telehealthApply.dpkind} 진료비
				<span style="color: #5c5c5c; font-size: 15px; margin-left: 7px;">
				<c:choose>
					<c:when test="${telehealthApply.dspecialist == 1}">15,000원</c:when>
					<c:otherwise>10,000원</c:otherwise>
				</c:choose>
				</span>
				</span>
			</div>
		</div>
		<div class="graySeperate"></div>
		<div class="profile">
			<img src="./img/user.png">
			${sessionScope.mname} 님
		</div>
		<div class="graySeperate"></div>
		<div class="symptomContent">
			<textarea id="content" name="tsymptomdetail" placeholder="최대 200자까지 입력할 수 있습니다."></textarea>
		</div>
		<div class="caution">
			<p>• 증상에 대해서 자세히 설명해 주세요.</p>
			<p>• 현재 복용중인 약이 있다면 기재해 주세요.</p>
			<p>• 기저질환이 있으시다면 못 드시는 약 등을 꼭 기재해 주세요.</p>
		</div>
		<input type="hidden" name="hno" value="${telehealthApply.hno}">
		<input type="hidden" name="dno" value="${telehealthApply.dno}">
		<input type="hidden" name="dpno" value="${telehealthApply.dpno}">
		<input type="hidden" name="pay" value="${telehealthApply.dspecialist}">
   </main>
   
   <!-- footer -->
   <footer>
   		<button class="next">다음</button>
   </footer>
   </form>
</body>
</html>