<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>의사 등록</title>
<link rel="stylesheet" href="../css/newDoctor.css">
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function () {
	let man = $("#man");
	let woman = $("#woman");
	let dgender = $("input[name='dgender']");
	let dspecialist = $("#dspecialist");
    let dtelehealth = $("#dtelehealth");

    man.change(function () {
    	if ($(this).is(":checked")) {
            dgender.val('0');
        }
    });
    
    woman.change(function () {
    	if ($(this).is(":checked")) {
            dgender.val('1');
        }
    });
	
	dspecialist.change(function() {
        if ($(this).is(":checked")) {
        	dspecialist.val(1);
        } 
    });
   	
	dtelehealth.change(function() {
        if ($(this).is(":checked")) {
        	dtelehealth.val(1);
        }
    });

	
	$("#btnAdd").click(function() {
		confirm("추가 등록하시겠습니까?");
		
	});
	
}
</script>
</head>

<header>
    <div class="xi-arrow x"></div>
    
    <i class="xi-angle-left xi-x" onclick="history.back()"></i>

	<div><h3 style="width: 110px; text-align: center; margin-left: 80px;">의사 등록</h3></div>
	
	<div class="headerTitle"><i class="xi-user xi-2x"></i></div>
</header>

<body>
	<main>
	<div class="article">
		<h1>DR.Home</h1>
		<div class="content" style="font-weight: bold">${hnoDoctor.hname }의
			의사 등록을 위해 <br>아래 내용을 입력해주세요.</div>
		<form action="/admin/newDoctor" class="GroupCenter" method="post">
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
				<div style="font-size: 13px; margin-left: -200px; color: gray;">성별</div>
				<div class="gender">
					<div class="man">
						<input type="radio" id="dgender" name="dgender" value="0" checked>남성
					</div>
					<div class="woman">
						<input type="radio" id="dgender" name="dgender" value="1">여성
					</div>
				</div>
			</div>
			<div class="Group">
				<input class="vector" type="text" placeholder="학력" name="dcareer">
			</div>
			<div class="Group">
				<div class="vector"
					style="text-align: left; margin-left: 100px; font-size: 13px; color: gray; text-decoration: underline;">전문
					여부</div>
				<input type="checkbox" id="dspecialist" name="dspecialist" class="cm-toggle">
				<!-- <input class="vector" type="text" placeholder="전문의(0:일반의 / 1:전문의)" name="dspecialist"> -->
			</div>
			<div class="Group">
				<!-- <input class="vector" type="text" placeholder="진료과" name="dpno"> -->
				<select name="dpno"
					style="width: 227px; height: 22px; text-align: left; margin-left: 100px; font-size: 13px; color: gray;">
					<option value="">진료과</option>
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
			<input class="vector" type="hidden" placeholder="병원번호" name="hno" value="${hnoDoctor.hno }">
			<input class="vector" type="hidden" placeholder="병원이름" name="hname" value="${hnoDoctor.hname }">
			<div class="Group">
				<div class="vector"
					style="text-align: left; margin-left: 100px; font-size: 13px; color: gray; text-decoration: underline;">비대면진료 여부</div>
				<input type="checkbox" id="dtelehealth" name="dtelehealth" class="cm-toggle">
				<!-- <input class="vector" type="text" placeholder="비대면진료 여부(0:진료x / 1:진료o)" name="dtelehealth"> -->
			</div>
			<button class="btn" id="btnAdd" type="submit">등록 ▷</button>
			<div class="btn2">
				<a onclick="location.href='/admin/newHosDoc?hno=${param.hno}'">등록된 의사 확인 하기 ▷</a>
			</div>
		</form>
	</div>
	<div style="height: 9vh"></div>
	</main>
	<footer>
	css 테스트
	</footer>
</body>
</html>
