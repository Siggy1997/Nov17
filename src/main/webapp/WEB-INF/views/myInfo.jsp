<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MyInfo</title>
<link href="/css/modal.css" rel="stylesheet" />
<link href="/css/myInfo.css" rel="stylesheet" />
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<script src="/js/jquery-3.7.0.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
    $('.main i').on('click',function(){
        $('input').toggleClass('active');
        if($('input').hasClass('active')){
            $(this).attr('class',"xi-eye xi-2x")
            .prev('input').attr('type',"text");
        }else{
            $(this).attr('class',"xi-eye-off xi-2x")
            .prev('input').attr('type','password');
        }
    });
});

$(function(){
    let mphonenumber = "${myInfo.mphonenumber}";

    let phoneNumberParts = mphonenumber.split('-');

    $('#firstNumber').val(phoneNumberParts[0]);
    $('#MiddleNumber').val(phoneNumberParts[1]);
    $('#lastNumber').val(phoneNumberParts[2]);
    
	        
	        $("#changePWBtn").click(function(){
	    		
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
	    		 else{
	    		 $("#changePW").submit();
	    		 }
	    	});//changePWBtn 끝

	
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

function searchAddr() {
	 $("#modal").modal("show");
}

function searchComAddr() {
	 $("#modal2").modal("show");
}

</script>

<!-- <script type="text/javascript">
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
</script> -->


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
	<div class="main">
	<form action="../changePW/${sessionScope.mno}" method="post" id="changePW">
	<h4>패스워드</h4>
	<input type="password" id="mpw" name="mpw" placeholder="비밀번호를 입력해주세요." maxlength="8" value="${myInfo.mpw }">
	<i class="xi-eye xi-2x"></i>
	<br>
	<span id="pwInfo"></span>
	<br>
	<button id="changePWBtn">비밀번호 변경</button>
	</form>
	</div>
	<h4>이메일</h4>
	${myInfo.memail }
	<form action="../changeHomeAddr/${sessionScope.mno}" method="post">
	<h4>집주소</h4>
	<input type="text" id="mhomeaddr" name="mhomeaddr" placeholder="집주소를 입력해주세요." value="${myInfo.mhomeaddr}" onclick="searchAddr()">
	<input type="text" id="mhomeaddr2" name="mhomeaddr2" placeholder="상세주소를 입력해주세요." value="${myInfo.mhomeaddr2}">
	<br>
	<span id="homeAddrInfo"></span>
	<button id="changeHomeAddr">집주소 변경</button>
	</form>
	<form action="../changeCompanyAddr/${sessionScope.mno}" method="post">
	<h4>회사주소(선택)</h4>
	<input type="text" id="mcompanyaddr" name="mcompanyaddr" placeholder="회사 주소를 입력해주세요." value="${myInfo.mcompanyaddr}" onclick="searchComAddr()">
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
	
		<!-- 모달1 start -->
	<div class="modal" id="modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-lg">
	<div class="modal-content">
	<div class="header">
	<h5 class="title" id="exampleModalLabel"></h5>
	</div>
	<div class="modal-body">
	<!-- 내용 start -->
	<div class="card-body">
	<h5 class="card-title">우편번호 찾기</h5>
	</div>
	<!-- 내용 end -->
	</div>
	<div>
		<input type="text" id="sample2_postcode" placeholder="우편번호">
		<input type="button" onclick="sample2_execDaumPostcode()" value="주소 찾기"><br>
		<input type="text" id="sample2_address" placeholder="주소"><br>
		<input type="text" id="sample2_detailAddress" placeholder="상세주소">
		<input type="text" id="sample2_extraAddress" placeholder="참고항목">
		</div>
		<button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button>
		<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
		</div>
	<!-- <button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button> -->
	</div>
	</div>
	</div>
	<!-- 모달1 end -->

	<!-- 모달2 start -->
	<div class="modal" id="modal2" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static">
	<div class="modal-dialog modal-lg">
	<div class="modal-content">
	<div class="header">
	<h5 class="title" id="exampleModalLabel"></h5>
	</div>
	<div class="modal-body">
	<!-- 내용 start -->
	<div class="card-body">
	<h5 class="card-title">우편번호 찾기</h5>
	</div>
	<!-- 내용 end -->
	</div>
	<div>
		<input type="text" id="sample2_postcode2" placeholder="우편번호">
		<input type="button" onclick="sample2_execDaumPostcode2()" value="주소 찾기"><br>
		<input type="text" id="sample2_address2" placeholder="주소"><br>
		<input type="text" id="sample2_detailAddress2" placeholder="상세주소">
		<input type="text" id="sample2_extraAddress2" placeholder="참고항목">
		</div>
		<button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button>
		<div id="layer2" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
		<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode2()" alt="닫기 버튼">
		</div>
	<!-- <button type="button" class="btn btn-info" data-bs-dismiss="modal" aria-label="Close">X 닫기</button> -->
	</div>
	</div>
	</div>
	<!-- 모달2 end -->	
	
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="js/scripts.js"></script>
	<script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
	
</body>
</html>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_layer2 = document.getElementById('layer2');

    function closeDaumPostcode2() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer2.style.display = 'none';
    }

    function sample2_execDaumPostcode2() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr2 = ''; // 주소 변수
                var extraAddr2 = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr2 = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr2 = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr2 += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr2 += (extraAddr2 !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr2 !== ''){
                        extraAddr2 = ' (' + extraAddr2 + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress2").value = extraAddr2;
                    document.getElementById("mcompanyaddr2").value = extraAddr2;
                
                } else {
                    document.getElementById("sample2_extraAddress2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode2').value = data.zonecode;
                document.getElementById("sample2_address2").value = addr2;
                document.getElementById("mcompanyaddr").value = addr2;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("mcompanyaddr2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer2.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer2);

        // iframe을 넣은 element를 보이게 한다.
        element_layer2.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition2();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition2(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer2.style.width = width + 'px';
        element_layer2.style.height = height + 'px';
        element_layer2.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer2.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer2.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }
    
 // 우편번호 찾기 화면을 넣을 element
    var element_layer = document.getElementById('layer');

    function closeDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_layer.style.display = 'none';
    }

    function sample2_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample2_extraAddress").value = extraAddr;
                    document.getElementById("mhomeaddr2").value = extraAddr;
                
                } else {
                    document.getElementById("sample2_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample2_postcode').value = data.zonecode;
                document.getElementById("sample2_address").value = addr;
                document.getElementById("mhomeaddr").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("mhomeaddr2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // iframe을 넣은 element를 보이게 한다.
        element_layer.style.display = 'block';

        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
        initLayerPosition();
    }

    // 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
    function initLayerPosition(){
        var width = 300; //우편번호서비스가 들어갈 element의 width
        var height = 400; //우편번호서비스가 들어갈 element의 height
        var borderWidth = 5; //샘플에서 사용하는 border의 두께

        // 위에서 선언한 값들을 실제 element에 넣는다.
        element_layer.style.width = width + 'px';
        element_layer.style.height = height + 'px';
        element_layer.style.border = borderWidth + 'px solid';
        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
    }    
    
</script>  