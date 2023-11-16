<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<script src="./js/jquery-3.7.0.min.js"></script>


<link rel="stylesheet" href="./css/boardSearch.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>
</head>
<body>
<header>
    <i class="xi-angle-left xi-x"></i>
    <div class="header title">검색결과</div>
    <div class="blank"></div>
</header>

<main>

<div id="boardButtonsContainer">
<button id="qnaBoardButton" onclick="toggleBoard('qnaBoard')" style="display: none;">QnA게시판</button>
<button id="qnaBoardBoldButton">QnA게시판</button>
<button id="freeBoardButton" onclick="toggleBoard('freeBoard')">자유게시판</button>
<button id="freeBoardBoldButton" style="display: none;">자유게시판</button>
</div>

<div class="space">
	<form action="/searchWord" method="post" onsubmit="searchForm()">
	<div class="searchForm">
		<select name = "selectOption">
          <option value = "all" selected>제목+내용</option>
          <option value = "title">제목만</option>
          <option value = "content">내용만</option>
       </select>	
		<input type="text" name="searchWord" id="searchWordInput"
			placeholder="검색 할 내용을 입력하세요">		
		<button type="submit" class="xi-search xi-x"></button>
	</div>
	</form>
	</div>


	<div id="qnaBoard" style="display:block;"> 
	<c:forEach items="${boardSearchData}" var="search">
		<c:if test="${search.btype eq 0}">
		<div onclick="location.href='/qnaDetail?bno=${search.bno}'">
		<div class="space">
			<div class="btitle">${search.btitle}</div>
			<div class="bcontent">${search.bcontent}</div>
			<div class="ccontent">${search.ccontent}</div>
			</div>
			</div>
		<div class ="line"></div>
		</c:if>
	</c:forEach>
	</div>
	
	
	<div id="freeBoard" style="display:none;">
	<c:forEach items="${boardSearchData}" var="search">
		<c:if test="${search.btype eq 1}">
		<div class="space">
		<div onclick="location.href='/freeDetail?bno=${search.bno}'">
			<div class="btitle">${search.btitle}</div>
			<div class="bcontent">${search.bcontent}</div>
			</div>
			</div>
					<div class ="line"></div>
		</c:if>
	</c:forEach>
	</div>

</main>

<footer></footer>


</body>
</html>