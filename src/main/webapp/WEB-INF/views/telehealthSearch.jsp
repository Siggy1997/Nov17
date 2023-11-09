<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Calendar, java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/telehealthSearch.css">
<script src="./js/jquery-3.7.0.min.js"></script> 
<!-- <script src="./js/wnInterface.js"></script> 
<script src="./js/mcore.min.js"></script> 
<script src="./js/mcore.extends.js"></script>  -->
<script type="text/javascript">
	$(function(){
		
		/* 진료과 선택했을 때 */
		$(document).on("click", ".optionDepartment", function(){
			$(".seletedDepartmentBox").show();
			$(".seletedSymptomBox").hide();
		});
		
		/* 진료과 검색하기 */
		$(document).on("click", ".departmentBox", function(){
			let departmentKind = $(this).find($(".departmentKeyword")).text();
			$("#keyword").val(departmentKind).submit();
			$("#searchForm").submit();
		});
		
		/* 증상 선택했을 때 */
		$(document).on("click", ".optionSymptom", function(){
			$(".seletedDepartmentBox").hide();
			$(".seletedSymptomBox").show();
		});
		
		/* 증상 그룹별로 보여주기 */
		$(document).on("click", ".symptomText", function(){
			let togglKeyword = $(this).siblings();
			toggleClass(togglKeyword);
		});
		
		/* 증상 검색하기 */
		$(document).on("click", ".symptomKind", function(){
			let symptomKind = $(this).text();
			$("#keyword").val(symptomKind);
		});
		
		/* 자주 찾는 버튼 선택해서 검색하기 */
		$(document).on("click", ".randomKeyword", function(){
			let randomKeyword = $(this).text();
			$('#keyword').val(randomKeyword);
		});
		
		
	});

	
	/* Collection of functions */
	
	/* 모달에서 증상별 토글 효과 */
	function toggleClass(keyword) {
		let otherKeyword = $(".symptomExample").not(keyword);
		if (otherKeyword.is(":visible")) {
			otherKeyword.slideUp();
			toggleIcon(otherKeyword);
		}
		if (keyword.is(":visible")) {
	        toggleIcon(keyword);
	        keyword.slideUp();
	    } else {
	        toggleIcon(keyword);
	        keyword.slideDown();
	    }
	}
	
	/* 증상별 토글 아이콘 변경 */
	function toggleIcon(keyword) {
		if (keyword.is(":visible")) {
	        let toggle = keyword.siblings().children(".xi-angle-up-thin");
	        toggle.removeClass("xi-angle-up-thin").addClass("xi-angle-down-thin");
	    } else {
	    	let toggle = keyword.siblings().children(".xi-angle-down-thin");
	    	toggle.removeClass("xi-angle-down-thin").addClass("xi-angle-up-thin");
	    }
	}

</script>

</head>
<body>
	<h1>Non-face-to-face Search</h1>
	<div class="telehealthSearchContainer">
		<form id="searchForm" action="telehealthSearch" method="post">
			<div class="searchDoctor">
				<div class="xi-angle-left"></div>
				<input placeholder="의사, 과목, 증상을 검색하세요." name="keyword" id="keyword">
				<button class="xi-search"></button>
			</div>
			<div class="selectedOption">
				<div class="optionDepartment">과목</div>
				<div class="optionSymptom">증상</div>
			</div>
			<!-- 진료과 -->
			<div class="seletedDepartmentBox">
				<div class="favoriteBox">
					<div class="favoriteTitle">자주 찾는 과목</div>
					<div class="favoriteKeyword">
						<c:forEach items="${departmentRandomKeyword}" var="row">
							<button class="randomKeyword">${row}</button>
						</c:forEach>
					</div>
					<c:forEach items="${departmentKeyword}" var="row">
					<div class="departmentBox">
						<div class="departmentText">
							<div class="departmentKeyword">${row.dpkind}</div>
							<div class="departmentExample">${row.dpexample}</div>
						</div>
						<div class="departmentImg"><img src="./img/dp${row.dpno}.png" style="width: 10%;"></div>
					</div>
					</c:forEach>
				</div>
			</div>
			<!-- 증상 -->
			<div class="seletedSymptomBox">
				<div class="favoriteBox">
					<div class="favoriteTitle">자주 찾는 증상</div>
					<div class="favoriteKeyword">
						<c:forEach items="${symptomRandomKeyword}" var="row">
							<button class="randomKeyword">${row}</button>
						</c:forEach>
					</div>
					<c:forEach items="${departmentKeyword}" var="row">
					<div class="symptomBox">
						<div class="symptomText">
							<div class="departmentImg"><img src="./img/dp${row.dpno}.png" style="width: 10%;"></div>
							<div class="departmentKeyword">${row.dpsymptom}</div>
							<div class="xi-angle-down-thin"></div>
						</div>
						<div class="symptomExample">
						<c:set var="keywords" value="${row.dpkeyword.split(',')}"/>
				        <c:forEach var="keyword" items="${keywords}">
			            	<button class="symptomKind">${keyword}</button>
				        </c:forEach>
						</div>
					</div>
					</c:forEach>
				</div>
			</div>
		</form>
	</div>
</body>
</html>