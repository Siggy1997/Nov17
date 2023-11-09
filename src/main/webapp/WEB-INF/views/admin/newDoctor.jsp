<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>의사 영입</title>
<link rel="stylesheet" href="../css/hosDoc.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
function addNewDoctor() {
	$.ajax({
        url: "./anotherDoctor",
        type: "post",
        data: {"" : },
        dataType: "json",
        success: function(data){
        	if (data.result == 1) {
       			alert("!");
				location.reload();
        	}
        },
        error: function(request, status, error){
           alert("통신 실패");
        }
     });
	
    // 여기에 필요한 추가 로직을 넣어야해
}
</script>
<style type="text/css">
.article {
	width: 1000px;
}

.Group2 {
	width: 430px;
	height: 40px;
	margin-left: 400px;	
}

.Group {
	margin-left: 100px;
}

.allGroup2 {
	margin-top: -205px;
}

.btn {
	margin-top: 60px;
}
</style>
</head>
<body>
	<div class="article">
		<h1>DR.Home</h1>
		<div class="content" style="font-weight: bold">
			의사 등록을 위해 아래 내용을 입력해주세요.
		</div>
		<form action="/admin/hospitalOpen" method="post">
			<div class="Group">
				<input class="vector" type="text" placeholder="성명" name="dname">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="사진" name="dimg">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="소개" name="dinfo">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="성별" name="dgender">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="학력" name="dcareer">
			</div>
			<div class="allGroup2">
				<div class="Group2">
					<input class="vector" type="text" placeholder="전문의(0:일반의 / 1:전문의)" name="dspecialist">
				</div>
				<div class="Group2">
					<input class="vector" type="text" placeholder="진료과" name="dpno">
				</div>
				<div class="Group2">
					<input class="vector" type="text" placeholder="병원번호" name="hno">
				</div>
				<div class="Group2">
					<input class="vector" type="text" placeholder="비대면진료 여부(0:진료x / 1:진료o)" name="dtelehealth">
				</div>
			</div>
			<button class="btn" type="submit">등록 ▷</button>
			<button class="btn" type="submit" onclick="location.reload()">의사 추가 등록 ▷</button>
		</form>
	</div>
</body>
</html>
