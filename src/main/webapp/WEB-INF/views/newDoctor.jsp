<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="initial-scale=1, width=device-width, user-scalable=no" />
<title>의사 등록</title>
<link rel="stylesheet" href="../css/newDoctor.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	let man = $("#man");
	let woman = $("#woman");
	let rdgender = $("input[name='rdgender']");
	let rdspecialist = $("#rdspecialist");
    let rdtelehealth = $("#rdtelehealth");
    
    man.change(function () {
    	if ($(this).is(":checked")) {
            rdgender.val('0');
        }
    });
    
    woman.change(function () {
    	if ($(this).is(":checked")) {
            rdgender.val('1');
        }
    });
	
    rdspecialist.change(function() {
        if ($(this).is(":checked")) {
        	rdspecialist.val(1);
        } 
    });
   	
	rdtelehealth.change(function() {
        if ($(this).is(":checked")) {
        	rdtelehealth.val(1);
        }
    });
	
});
</script>
</head>

<header>

		<a href="/login"><i class="xi-angle-left xi-x"></i></a>
		<div class="headerTitle">의사등록</div>
		<div class="blank"></div>
	</header>

<body>
<form action="/completeHosDoc" class="GroupCenter" method="post">
	<main>

	<div class="article">
		<span><img src="../img/DrHome_logo_side.png" style="width: 200px;" /></span>
		<div class="content" style="font-weight: bold;">${rhnoDoctor.rhname}의
			의사 등록을 위해 <br>아래 내용을 입력해주세요.
		</div>
		
		
		
		
		<div class="Group">
			<p>성 명</p>
			<input class="vector" type="text" placeholder="성 명" name="rdname">
		</div>
		<div class="Group">
			<p>소 개</p>	
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
			<input class="vector" type="text" placeholder="성명" name="rdname">
		</div>
		<div class="Group">
			<input class="vector" type="text" placeholder="소개" name="rdinfo">
		</div>
		<div class="Group">
			<div style="font-size: 17px; margin-left: -175px; color: gray;">성별</div>
			<div class="gender">
				<div class="man">
					<input type="radio" id="rdgender" name="rdgender" value="0" checked>남성
				</div>
				<div class="woman">
					<input type="radio" id="rdgender" name="rdgender" value="1">여성
				</div>
			</div>
		</div>
		<div class="Group">
			<input class="vector" type="text" placeholder="학력" name="rdcareer">
		</div>
		<div class="Group">
			<div class="vector"
				style="text-align: left; margin-left: 100px; font-size: 17px; color: gray; text-decoration: underline;">전문
				여부</div>
			<input type="checkbox" id="rdspecialist" name="rdspecialist" class="cm-toggle">
		</div>
		<div class="Group">
			<select name="dpno"
				style="width: 227px; height: 22px; text-align: left; margin-left: 100px; font-size: 17px; color: gray;">
				<option value="">진료과를 선택해주세요.</option>
				<option value="1">소아과</option>
				<option value="2">치과</option>
				<option value="3">내과</option>
				<option value="4">이비인후과</option>
				<option value="5">피부과</option>
				<option value="6">산부인과</option>
				<option value="7">안과</option>
				<option value="8">정형외과</option>
				<option value="9">한의학과</option>
				<option value="10">비뇨기과</option>
				<option value="11">신경과</option>
				<option value="12">외과</option>
				<option value="13">정신의학과</option>
			</select>
		</div>
		<input class="vector" type="hidden" placeholder="병원번호" name="rhno" id="checkRhno" value="${rhnoDoctor.rhno }">
		<input class="vector" type="hidden" placeholder="병원이름" name="rhname" value="${rhnoDoctor.rhname }">
		<div class="Group">
			<div class="vector" style="text-align: left; margin-left: 100px; font-size: 17px; color: gray; text-decoration: underline;">비대면진료 여부</div>
			<input type="checkbox" id="rdtelehealth" name="rdtelehealth" class="cm-toggle">
			<!-- <input class="vector" type="text" placeholder="비대면진료 여부(0:진료x / 1:진료o)" name="dtelehealth"> -->
		</div>
	</div>
	<div style="height: 9vh"></div>
	</main>
	<footer>
		<button class="btn" id="btnAdd" type="submit">등록 ▷</button>
	</footer>
	</form>
</body>
</html>
