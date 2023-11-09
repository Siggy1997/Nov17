<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>hospitalOpen</title>
</head>
<body>
	<h1>병원 개설 관리</h1>
	<div class="content">
		<div style="text-align: center;">
			<table border="1" style="margin: 0 auto;">
				<tr>
					<th style="width: 7%;">병원번호</th>
					<th style="width: 7%;">병원명</th>
					<th style="width: 7%;">개원일</th>
					<th style="width: 7%;">주소</th>
					<th style="width: 15%;">전화번호</th>
					<th style="width: 7%;">시작시간</th>
					<th style="width: 7%;">종료시간</th>
					<th style="width: 7%;">야간 진료 요일</th>
					<th style="width: 7%;">야간 종료시간</th>
					<th style="width: 7%;">브레이크타임</th>
					<th style="width: 7%;">브레이크 종료시간</th>
					<th style="width: 7%;">공휴일 진료여부</th>
					<th style="width: 7%;">공휴일 종료시간</th>
				</tr>
				<c:forEach items="${hospitalOpen}" var="hospitalOpen">
					<tr>
						<td class="div-cell">${hospitalOpen.hno }</td>
						<td class="div-cell">${hospitalOpen.hname }</td>
						<td class="div-cell">${hospitalOpen.hopendate}</td>
						<td class="div-cell">${hospitalOpen.haddr}</td>
						<td class="div-cell">${hospitalOpen.htelnumber}</td>
						<td class="div-cell">${hospitalOpen.hopentime}</td>
						<td class="div-cell">${hospitalOpen.hclosetime}</td>
						<td class="div-cell">${hospitalOpen.hnightday}</td>
						<td class="div-cell">${hospitalOpen.hnightendtime}</td>
						<td class="div-cell">${hospitalOpen.hbreaktime}</td>
						<td class="div-cell">${hospitalOpen.hbreakendtime}</td>
						<td class="div-cell">${hospitalOpen.hholiday}</td>
						<td class="div-cell">${hospitalOpen.hholidayendtime}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<br>
	<div>
		<button onclick="location.href='./main'">돌아가기</button>
	</div>
</body>
</html>