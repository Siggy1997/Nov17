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
	$(document).ready(function() {
		$("#runIframe").click(function() {
			// 새로운 iframe 요소 생성
			var newIframe = $("<iframe>");
			newIframe.attr({
				id : "myIframe",
				width : "1000",
				height :"700",
				 style: "border: 3px solid black;",
				src : "../navigation"
			});

			// body에 추가
			$("body").append(newIframe);
		});
	});
</script>

</head>
<body>
	<button id="runIframe">IFrame 실행</button>

</body>
</html>