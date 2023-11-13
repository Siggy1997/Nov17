<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="./css/boardSearch.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>

<header>
    <i class="xi-angle-left xi-x"></i>
    <div class="header title">상담하기</div>
    <div class="blank"></div>
</header>

<main>


	<form action="/searchWord" method="post" onsubmit="searchForm()">
		<select name = "selectOption">
          <option value = "all" selected>제목+내용</option>
          <option value = "title">제목만</option>
          <option value = "content">내용만</option>
       </select>	
		<input type="text" name="searchWord" id="searchWordInput"
			placeholder="검색 할 내용을 입력하세요">		
		<button type="submit">검색</button>
	</form>

	<br>
	[상담 게시판]
	<br><br>
	<c:forEach items="${boardSearchData}" var="search">
		<c:if test="${search.btype eq 0}">
		<div onclick="location.href='/qnaDetail?bno=${search.bno}'">
			<div class="btitle">${search.btitle}</div>
			<div class="bcontent">${search.bcontent}</div>
			<div class="ccontent">${search.ccontent}</div>
			</div>
			<br>
		</c:if>
	</c:forEach>
	
	<br> [자유 게시판]
	<br><br>
	<c:forEach items="${boardSearchData}" var="search">
		<c:if test="${search.btype eq 1}">
		<div onclick="location.href='/freeDetail?bno=${search.bno}'">
			<div class="btitle">${search.btitle}</div>
			<div class="bcontent">${search.bcontent}</div>
			</div>
			<br>
		</c:if>
	</c:forEach>

</main>

<footer></footer>

	<script>
		var maxLength = 30; // 최대 문자열 길이
		var contentElements = document.querySelectorAll(".bcontent");

		contentElements.forEach(function(contentElement) {
			var text = contentElement.textContent;

			if (text.length > maxLength) {
				var truncatedText = text.slice(0, maxLength) + "...";
				contentElement.textContent = truncatedText;
			}
		});

		function searchForm() {
			var searchWordInput = document.getElementById("searchWordInput");
			var searchWord = searchWordInput.value.trim(); // 입력값 앞뒤 공백 제거
			//var selectOption = document.getElementById("selectOption").value; // 선택된 값 가져오기

			if (searchWord === "") {
				alert("검색어를 입력하세요.");
				event.preventDefault(); // 폼 전송 막기

			}
		}
	</script>
</body>
</html>