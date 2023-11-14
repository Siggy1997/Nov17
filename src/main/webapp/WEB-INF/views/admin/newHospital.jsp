<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>병원 등록</title>
<link rel="stylesheet" href="../css/hosDoc.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
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

<header>
    <i class="xi-angle-left xi-x" onclick="history.back()"></i>

	<div class="headerTitle"><i></i></div>
	
	<div class="headerTitle"><i class="xi-hospital xi-3x"></i></div>
</header>

<main>
	<div class="article">
		<h1 style="text-align: left; margin-left: 20px;">Dr.Home<i class="xi-medicine xi-x"></i></h1>
		<div class="content" style="font-weight: bold; text-align: left; margin-left: 20px;">
			닥터홈에 오신것을 환영합니다!<br> 
			병원 개설을 위해 아래 내용을 입력해주세요.
		</div>
		<div class="tab">
		<form action="/admin/hospitalOpen" method="POST">
			<div class="Group">
				<input class="vector" type="text" placeholder="병원명" name="rhname">
			</div>
			<div class="Group">
				<input class="vector" type="date" placeholder="개원일" name="rhopendate">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="주소" name="rhaddr">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="전화번호" name="rhtelnumber">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="병원이미지" name="rhimg">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="소개" name="rhinfo">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="시작시간" name="rhopentime">
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="종료시간" name="rhclosetime">
			</div>
			<div class="Group">
				<input class="vector" id="rhnightday" type="text" placeholder="야간 진료요일" name="rhnightday">
			</div>
			<div class="Group" id="rhnightendtime">
				<input class="vector" type="text" placeholder="야간 종료시간" name="rhnightendtime">
			</div>
			<div class="Group">
				<input class="vector" id="rhbreaktime" type="text" placeholder="브레이크타임" name="rhbreaktime">
			</div>
			<div class="Group" id="rhbreakendtime">
				<input class="vector" type="text" placeholder="브레이크 종료시간" name="rhbreakendtime">
			</div>
			<div class="Group">
				<div class="vector" style="text-align: left; margin-left: 100px; font-size: 13px; color: gray; text-decoration: underline;">공휴일 진료여부</div>
				<input type="checkbox" id="rhholiday" name="rhholiday" class="cm-toggle">
				<!--  <input class="vector" id="hholiday" type="text" placeholder="공휴일 진료여부(0:진료X / 1:진료O)" name="hholiday"> -->
			</div>
			<div class="Group" id="rhholidayendtime">
				<input class="vector" type="text" placeholder="공휴일 종료시간" name="rhholidayendtime">
			</div>
			<div class="Group">
				<div class="vector" style="text-align: left; margin-left: 100px; font-size: 13px; color: gray; text-decoration: underline;">주차 여부</div>
				<input type="checkbox" id="rhparking" name="rhparking" class="cm-toggle">
				<!-- <input class="vector" type="text" placeholder="주차여부(0:불가능 / 1:가능)" name="hparking"> -->
			</div>
			<button class="btn" type="submit">병원 개설하기 ▷</button>
		</form>
		</div>
	</div>
	<div style="height: 9vh"></div>
</main>
<footer>
css 테스트
</footer>
</body>
</html>
