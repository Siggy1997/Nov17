<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$(".login").click(function() {		
		if($("#id").val() == "" || $("#id").val().length < 4) {
			alert("올바른 아이디를 입력하세요");
			$("#id").focus();
			return false;
		}
		
		if($("#pw").val() == "" || $("#pw").val().length < 4) {
			alert("올바른 아이디를 입력하세요");
			$("#pw").focus();
			return false;
		}
		
	var form = document.createElement("form");       
		form.setAttribute("action" , "./login");
		form.setAttribute("method" , "post");
	
	var id = document.createElement("input");
		id.setAttribute("type", "hidden");
		id.setAttribute("name", "id");
		id.setAttribute("value", $("#id").val());
		form.appendChild(id);
	
	var pw = document.createElement("input");
		pw.setAttribute("type", "hidden");
		pw.setAttribute("name", "pw");
		pw.setAttribute("value", $("#pw").val());
		form.appendChild(pw);

	document.body.appendChild(form);
 	form.submit();
	
	});
});
</script>
<title>admin</title>
</head>
<body>
	<div class="continer">
		<div class="main">
			<div class="article">
				<div class="login-box">
					<div class="login-image"></div>
					<div class="login-form">
						<input type="text" name="id" id="id" required="required" maxlength="10"> 
						<input type="password" name="pw" id="pw" required="required" maxlength="15">
						<button class="login">LOGIN</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>