<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>병원 등록</title>
<link rel="stylesheet" href="../css/hosDoc.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    let hholidayendtime = $("#hholidayendtime");
    let hholiday = $("#hholiday").val();
	
    if (hholiday == 1) {
        hholidayendtime.show();
    } else {
        hholidayendtime.hide();
    }

    $("#hholiday").change(function() {
        if ($(this).val() == 1) {
            hholidayendtime.show();
        } else {
            hholidayendtime.hide();
        }
    });
});
</script>
</head>
<body>
	<div class="article">
		<h1>DR.Home</h1>
		<div class="content" style="font-weight: bold">
			닥터홈에 오신것을 환영합니다!<br> 
			병원 개설을 위해 아래 내용을 입력해주세요.
		</div>
		<form action="/admin/newDoctor" method="post">
			<div class="Group">
				<input class="vector" type="text" placeholder="병원명" name="hname">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="개원일" name="hopendate">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="주소" name="haddr">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="전화번호"
					name="htelnumber">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="병원이미지"
					name="himg">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="소개" name="hinfo">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="시작시간"
					name="hopentime">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="종료시간"
					name="hclosetime">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="야간 진료요일"
					name="hnightday">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="야간 종료시간"
					name="hnightendtime">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="브레이크타임"
					name="hbreaktime">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="브레이크 종료시간"
					name="hbreakendtime">
			</div>
			<div class="Group">
				<input class="vector" id="hholiday" type="text" placeholder="공휴일 진료여부(0:진료X / 1:진료O)"
					name="hholiday">
			</div>
			<div class="Group" id="hholidayendtime">
				<input class="vector" type="text" placeholder="공휴일 종료시간"
					name="hholidayendtime">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="주차여부(0:불가능 / 1:가능)" name="hparking">
			</div>
			<button class="btn" type="submit">의사 영입하기 ▷</button>
		</form>
	</div>
</body>
</html>