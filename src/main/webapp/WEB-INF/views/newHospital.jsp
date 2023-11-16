<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>병원 등록</title>
<link rel="stylesheet" href="../css/hosDoc.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		let rhholiday = $("#rhholiday");
		let rhholidayendtime = $("#rhholidayendtime");
		let rhparking = $("#rhparking");
		let rhnightday = $("#rhnightday").val();
		let rhnightendtime = $("#rhnightendtime");
		let rhbreaktime = $("#rhbreaktime").val();
		let rhbreakendtime = $("#rhbreakendtime");

		rhholidayendtime.hide();

		rhholiday.change(function() {
			if ($(this).is(":checked")) {
				rhholiday.val(1);
				rhholidayendtime.show();
			} else {
				rhholidayendtime.hide();
			}
		});

		rhparking.change(function() {
			if ($(this).is(":checked")) {
				rhparking.val(1);
			}
		});

		if (rhnightday == "") {
			rhnightendtime.hide();
		} else {
			rhnightendtime.show();
		}

		$("#rhnightday").change(function() {
			if ($(this).val() != "") {
				rhnightendtime.show();
			} else {
				rhnightendtime.hide();
			}
		});

		if (rhbreaktime == "") {
			rhbreakendtime.hide();
		} else {
			rhbreakendtime.show();
		}

		$("#rhbreaktime").change(function() {
			if ($(this).val() != "") {
				rhbreakendtime.show();
			} else {
				rhbreakendtime.hide();
			}
		});
	});
</script>
</head>
<body>
<form action="/hospitalAdd" method="POST">

	<header>

		<a href="/login"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">병원개설</div>
		<div class="blank"></div>
	</header>

<main>
    <div class="main-area">
	<div class="article">
		<span><img src="../img/DrHome_logo_side.png" /></span>
		<div class="content">
			닥터홈에 오신것을 환영합니다!<br> 
			병원 개설을 위해 아래 내용을 입력해주세요.
		</div>
			<div class="Group">
				<p>병원명</p>
				<input class="vector" type="text" placeholder="병원명" name="rhname">
			</div>
			<div class="Group">
				<p>설립연도</p>	
				<input class="vector" type="date" name="rhopendate">
			</div>
			<div class="Group">
				<p>주 소</p>	
				<input class="vector" type="text" placeholder="주 소" name="rhaddr">
			</div>
			<div class="Group">
				<p>전화번호</p>
				<input class="vector" type="text" placeholder="전화번호" name="rhtelnumber">
			</div>
			<div class="Group">
				<p>소 개</p>
				<input class="vector" type="text" placeholder="소 개" name="rhinfo">
			</div>
			<div class="Group">
				<p>시작시간</p>
				<input class="vector" type="text" placeholder="시작시간" name="rhopentime">
			</div>
			<div class="Group">
				<p>종료시간</p>
				<input class="vector" type="text" placeholder="종료시간" name="rhclosetime">
			</div>
			<div class="Group">
				<p>야간 진료 요일</p>
				<input class="vector" id="rhnightday" type="text" placeholder="야간 진료요일" name="rhnightday">
			</div>
			<div class="Group" id="rhnightendtime">
				<p>야간 종료시간</p>
				<input class="vector" type="text" placeholder="야간 종료시간" name="rhnightendtime">
			</div>
			<div class="Group">
				<p>브레이크 타임</p>
				<input class="vector" id="rhbreaktime" type="text" placeholder="브레이크 타임" name="rhbreaktime">
			</div>
			<div class="Group" id="rhbreakendtime">
				<p>브레이크 종료시간</p>
				<input class="vector" type="text" placeholder="브레이크 종료시간" name="rhbreakendtime">
			</div>
			<div class="Group">
				<p>공휴일 진료여부</p>
				<input type="checkbox" id="rhholiday" name="rhholiday" class="vector cm-toggle">
			</div>
			<div class="Group" id="rhholidayendtime">
				<p>공휴일 종료시간</p>
				<input class="vector" type="text" placeholder="공휴일 종료시간" name="rhholidayendtime">
			</div>
			<div class="Group">
				<p>주차 여부</p>
				<input type="checkbox" id="rhparking" name="rhparking" class="vector cm-toggle">
			</div>
			<div class="Group">
				<p>종료시간</p>
				<input class="vector" type="text" placeholder="종료시간" name="rhclosetime">
			</div>
			<div class="Group">
				<p>야간 진료 요일</p>
				<input class="vector" id="rhnightday" type="text" placeholder="야간 진료요일" name="rhnightday">
			</div>
			<div class="Group" id="rhnightendtime">
				<p>야간 종료시간</p>
				<input class="vector" type="text" placeholder="야간 종료시간" name="rhnightendtime">
			</div>
			<div class="Group">
				<p>브레이크 타임</p>
				<input class="vector" id="rhbreaktime" type="text" placeholder="브레이크 타임" name="rhbreaktime">
			</div>
			<div class="Group" id="rhbreakendtime">
				<p>브레이크 종료시간</p>
				<input class="vector" type="text" placeholder="브레이크 종료시간" name="rhbreakendtime">
			</div>
			<div class="Group">
				<p>공휴일 진료여부</p>
				<input type="checkbox" id="rhholiday" name="rhholiday" class="vector cm-toggle">
			</div>
			<div class="Group" id="rhholidayendtime">
				<p>공휴일 종료시간</p>
				<input class="vector" type="text" placeholder="공휴일 종료시간" name="rhholidayendtime">
			</div>
			<div class="Group">
				<p>주차 여부</p>
				<input type="checkbox" id="rhparking" name="rhparking" class="vector cm-toggle">
			</div>
		</div>
		</div>
		</div>
	<div style="height: 9vh"></div>
</main>
<footer>
	<button class="btn" type="submit">병원 개설하기 ▷</button>
</footer>
</form>
</body>
</html>
