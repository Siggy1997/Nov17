<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyInfo</title>
<script src="../js/jquery-3.7.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
$(function(){
    let mphonenumber = "${myInfo.mphonenumber}";

    let phoneNumberParts = mphonenumber.split('-');

    $('#firstNumber').val(phoneNumberParts[0]);
    $('#MiddleNumber').val(phoneNumberParts[1]);
    $('#lastNumber').val(phoneNumberParts[2]);

	$("#changePW").click(function(){
		
		$("#pwInfo").text("");
		
		let mpw = $("#mpw").val();
		
		if (mpw == "") {
		    $("#mpw").focus();
		    $("#pwInfo").text("비밀번호를 입력해주세요.");
		    $("#pwInfo").css("color", "red");
		    return false;
		 } 
		   if (mpw.length < 4) {
			         $("#mpw").focus();
			         $("#pwInfo").text("비밀번호를 4글자 이상 입력해주세요.");
			         $("#pwInfo").css("color", "red");
			         return false;
			      }
	});
	
	$("#changeHomeAddr").click(function(){
		
		$("#homeAddrInfo").text("");
		
		let mhomeaddr = $("#mhomeaddr").val();
		
        if (mhomeaddr === "") {
            $("#mhomeaddr").focus();
            $("#homeAddrInfo").text("주소를 입력하세요.");
            $("#homeAddrInfo").css("color","red");
            return false;
         }
	});
	
	$("#changeCompanyAddr").click(function(){
		
		$("#companyAddrInfo").text("");
		
		let mcompanyaddr = $("#mcompanyaddr").val();
		
        if (mcompanyaddr === "") {
            $("#mcompanyaddr").focus();
            $("#companyAddrInfo").text("주소를 입력하세요.");
            $("#companyAddrInfo").css("color","red");
            return false;
         }
	});
	
	$("#changePhoneNumber").click(function(){
		
		$("#phoneInfo").text("");
		
		let firstNumber = $("#firstNumber").val();
		let MiddleNumber = $("#MiddleNumber").val();
		let lastNumber = $("#lastNumber").val();
		let phoneNumber = $("#firstNumber").val() + $("#MiddleNumber").val() + $("#lastNumber").val();
		let notNum = /[^0-9]/g; //숫자아닌지 확인
		
	    if (phoneNumber == "") {
	        $("#phoneInfo").text("전화번호를 입력해주세요.");
	        $("#phoneInfo").css("color","red");
	        return false;
	    }
		
	    if(notNum.test(phoneNumber) || phoneNumber.length !== 11) {
	        $("#phoneInfo").text("올바른 전화번호를 입력해주세요.");
	        $("#phoneInfo").css("color","red");
	        return false;
	    }
	});
	
	
	
});

</script>

<script type="text/javascript">
window.onload = function(){
    document.getElementById("mhomeaddr").addEventListener("click", function(){ //주소입력칸을 클릭하면
        //카카오 지도 발생
        new daum.Postcode({
            oncomplete: function(data) { //선택시 입력값 세팅
                document.getElementById("mhomeaddr").value = data.address; // 주소 넣기
                document.querySelector("input[name=mhomeaddr2]").focus(); //상세입력 포커싱
            }
        }).open();
    });
    
    document.getElementById("mcompanyaddr").addEventListener("click", function(){
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById("mcompanyaddr").value = data.address;
                document.querySelector("input[name=mcompanyaddr2]").focus();
            }
        }).open();
    });
}

new daum.Postcode({
    oncomplete: function(data) {
        console.log("Selected address:", data.address); // 주소가 올바르게 선택되었는지 확인
        document.getElementById("mhomeaddr").value = data.address; // 주소 넣기
        console.log("mhomeaddr value:", document.getElementById("mhomeaddr").value); // 값을 올바르게 설정했는지 확인
        document.querySelector("input[name=mhomeaddr2]").focus(); // 상세입력 포커싱
    }
});
</script>


</head>
<body>
	<a href="../main">&nbsp;&nbsp;←뒤로가기</a>
	<h1>MyInfo</h1>
	<h3>내 정보 확인하기</h3>
	<br>
	<h4>이름</h4>
	${myInfo.mname }
	<h4>닉네임</h4>
	${myInfo.mnickname }
	<h4>아이디</h4>
	${myInfo.mid }
	<form action="../changePW/${sessionScope.mno}" method="post">
	<h4>패스워드</h4>
	<input type="text" id="mpw" name="mpw" placeholder="비밀번호를 입력해주세요." maxlength="8" value="${myInfo.mpw }">
	<br>
	<span id="pwInfo"></span>
	<button id="changePW">비밀번호 변경</button>
	</form>
	<h4>이메일</h4>
	${myInfo.memail }
	<form action="../changeHomeAddr/${sessionScope.mno}" method="post">
	<h4>집주소</h4>
	<input type="text" id="mhomeaddr" name="mhomeaddr" placeholder="집주소를 입력해주세요." value="${myInfo.mhomeaddr}">
	<input type="text" id="mhomeaddr2" name="mhomeaddr2" placeholder="상세주소를 입력해주세요." value="${myInfo.mhomeaddr2}">
	<br>
	<span id="homeAddrInfo"></span>
	<button id="changeHomeAddr">집주소 변경</button>
	</form>
	<form action="../changeCompanyAddr/${sessionScope.mno}" method="post">
	<h4>회사주소(선택)</h4>
	<input type="text" id="mcompanyaddr" name="mcompanyaddr" placeholder="회사 주소를 입력해주세요." value="${myInfo.mcompanyaddr}">
	<input type="text" id="mcompanyaddr2" name="mcompanyaddr2" placeholder="상세주소를 입력해주세요." value="${myInfo.mcompanyaddr2}">
	<br>
	<span id="companyAddrInfo"></span>
	<button id="changeCompanyAddr">회사주소 변경</button>
	</form>
	<h4>생년월일</h4>
	${myInfo.mbirth }
	<form action="../changePhoneNumber/${sessionScope.mno}" method="post">
	<h4>전화번호</h4>
	<input type="text" id="firstNumber" name="firstNumber" maxlength="3" placeholder="010"> -
	<input type="text" id="MiddleNumber" name="MiddleNumber" maxlength="4" placeholder="xxxx"> -
	<input type="text" id="lastNumber" name="lastNumber" maxlength="4" placeholder="xxxx">
	<br>
	<span id="phoneInfo"></span>
	<button id="changePhoneNumber">전화번호 변경</button>
	</form>
</body>
</html>