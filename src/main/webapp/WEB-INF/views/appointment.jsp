<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약하기</title>
<style type="text/css">
.container {
	display: flex;
	text-align: center;
}

table {
	margin: 0 auto;
}

.tableBtn {
	display: flex;
	flex-direction: column;
}
</style>
</head>
<body>
	<h1 style="text-align: center;">예약하기</h1>

	<div class="container">
		<table border="1">
			<tr class="row">
				<th class="col-1">이름</th>
				<th class="col-6">번호</th>
				<th class="col-1">내용</th>
				<th class="col-4">예약</th>
			</tr>
			<c:forEach items="${hospitals }" var="row">
				<tr>
					<td>${row.hname}</td>
					<td>${row.htelnumber}</td>
					<td>${row.hinfo}</td>
					<td>
						<form action="/adetail" method="POST">
							<input type="hidden" name="hno" value="${row.hno}" />
							<button type="submit">예약하기</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>