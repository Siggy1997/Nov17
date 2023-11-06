<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>report</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
function resultCh(rpno, value) {
	if(confirm("변경하시겠습니까?")) {
		location.href="./resultChange?rpno="+rpno+"&rpresult="+value;		
	}
}
</script>
<style type="text/css">

.content{
	width: 70%;
	margin: 0 auto;
	text-align: center;
}

.rpcontent {
	width: 50%;
}
</style>
</head>
<body>
	<h1 style="text-align: center;">신고 관리</h1>
	<div class="content">
		<div style="text-align: center;">
			<table border="1" style="margin: 0 auto;">
				<tr>
					<th style="width: 7%;">신고번호</th>
					<th style="width: 10%;">신고자번호</th>
					<th style="width: 25%;">신고 글링크</th>
					<th style="width: 30%;">신고 상세설명</th>
					<th style="width: 15%;">신고 날짜/시각</th>
					<th style="width: 7%;">글쓴이</th>					
					<th style="width: 10%;">결과 여부</th>
				</tr>
				<c:forEach items="${report }" var="report">
					<tr>
						<td class="div-cell">${report.rpno }</td>
						<td class="div-cell">${report.rpreporterno }</td>
						<td class="div-cell">${report.rpurl }</td>
						<td class="div-cell">${report.rpcontent }</td>
						<td class="div-cell">${report.rpdate }</td>
						<td class="div-cell">${report.mno}</td>
						<td>
							<select class="result" onchange="resultCh('${report.rpno}', this.value)">
								<option value="0" <c:if test="${report.rpresult eq 0}">selected="selected"</c:if>>대기</option>
								<option value="1" <c:if test="${report.rpresult eq 1}">selected="selected"</c:if>>승인</option>
								<option value="2" <c:if test="${report.rpresult eq 2}">selected="selected"</c:if>>거절</option>
							</select>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>