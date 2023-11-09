<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Join</title>

<script src="./js/jquery-3.7.0.min.js"></script> 
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript">

$(function(){
       $("#joinMemberBtn").attr('disabled', true);
	
	   $("#midCheck").click(function(){
		   		
			$("#idInfo").text("");	
		   		
		      let mid = $("#mid").val();
		      let special = /[^a-zA-Z0-9가-힣]/; //특수문자 확인
		      
		      if (mid == "") {
		         $("#mid").focus();
		         $("#idInfo").text("아이디를 입력해주세요.");
		         $("#idInfo").css("color", "red");
		         return false;
		      }
		      
		      if (mid.length < 4) {
			         $("#mid").focus();
			         $("#idInfo").text("아이디를 4글자 이상 입력해주세요.");
			         $("#idInfo").css("color", "red");
			         return false;
			      }
		      
			  if (special.test(mid)) {
			        $("#idInfo").text("아이디에 특수문자는 허용되지 않습니다.");
			        $("#idInfo").css("color", "red");
			        return false;
			  }
			  
		  //ajax 
	      $.ajax({
	          url:"./midCheck",
	          type:"post",
	          data:{"mid":mid},
	          dataType:"json",
	          success:function(data){
	             if(data.midCheck==1){
	                $("#idInfo").text("중복된 아이디입니다. 다시 입력해주세요.");
	                $("#idInfo").css("color","red");
	                $("#joinMemberBtn").attr('disabled', true);
	             } 
	             else{
	                $("#idInfo").text("사용가능한 아이디입니다.");
	                $('#joinMemberBtn').attr('disabled', false);
	                $("#idInfo").css("color","green");
	             }
	          },
	          error:function(request, status, error){
	             $("#idInfo").text("오류가 발생함")
	          }
	       });//ajax끝
		      
		   }); //midCheck아이디체크
		   
		   $("#joinMemberBtn").click(function(){
			   event.preventDefault(); //폼 전송 막기
			   
				let mid = $("#mid").val();
				let mrrn = $("#firstMrrn").val() + "-" + $("#lastMrrn").val();
				
				$("#idInfo").text("");
				$("#pwInfo").text("");
				$("#pwInfo2").text("");
				$("#nameInfo").text("");
				$("#mrrnInfo").text("");
				$("#mrrnInfo2").text("");
				$("#mrrnInfo3").text("");
				$("#emailInfo").text("");
				$("#homeAddrInfo").text("");
				$("#birthInfo").text("");
				$("#phoneInfo").text("");
				$("#joinInfo").text("");
			   
			      $.ajax({
			          url:"./midCheck",
			          type:"post",
			          data:{"mid":mid},
			          dataType:"json",
			          success:function(data){
			             if(data.midCheck==1){
			                $("#idInfo").text("중복된 아이디입니다. 다시 입력해주세요.");
			                $("#idInfo").css("color","red");
			                $("#joinMemberBtn").attr('disabled', true);
			                return false;
			             } 
			             else{
			             } //else끝
			          },
			          error:function(request, status, error){
			             $("#idInfo").text("오류가 발생함")
			          }
			       });//midCheck ajax끝
			       
	                $.ajax({
				          url:"./mrrnCheck",
				          type:"post",
				          data:{"mrrn":mrrn},
				          dataType:"json",
				          success:function(data){
				             if(data.mrrnCheck==1){
				            	$("#firstMrrn").focus();
				                $("#mrrnInfo").html("이미 등록된 주민등록번호입니다.<br>");
				                $("#mrrnInfo").css("color","red");
	                    	    $("#mrrnInfo2").css("color","blue");
	                    	    $("#mrrnInfo2").text("아이디 찾기가 필요하신가요? -> ");
	                    	    $("#mrrnInfo3").html("<a href='./findID'>아이디 찾으러 가기</a>");
	            				$("#idInfo").text("");
	            				$("#pwInfo").text("");
	            				$("#pwInfo2").text("");
	            				$("#nameInfo").text("");
	            				$("#emailInfo").text("");
	            				$("#homeAddrInfo").text("");
	            				$("#birthInfo").text("");
	            				$("#phoneInfo").text("");
	            				$("#joinInfo").text("");
	                    	    $("#joinMemberBtn").attr('disabled', true);
	                    	    return false;
				             } 
				             else{
				     			let mpw = $("#mpw").val();
				    			let mpwDuplication = $("#mpwDuplication").val();
				    			let mname = $("#mname").val();
				    			let firstMrrn = $("#firstMrrn").val();
				    			let lastMrrn = $("#lastMrrn").val();
				    			let memail = $("#memail").val();
				    			let mhomeaddr = $("#mhomeaddr").val();
				    			let mhomeaddr2 = $("#mhomeaddr2").val();
				    			let mcompanyaddr = $("#mcompanyaddr").val();
				    			let mcompanyaddr2 = $("#mcompanyaddr2").val();
				    		    let mgender = document.getElementById("mgender").value;
				    		    let mbirth = document.getElementById("mbirth").value;
				    			let firstNumber = $("#firstNumber").val();
				    			let MiddleNumber = $("#MiddleNumber").val();
				    			let lastNumber = $("#lastNumber").val();
				    			let checkMrrn = $("#firstMrrn").val() + $("#lastMrrn").val();
				    			let phoneNumber = $("#firstNumber").val() + $("#MiddleNumber").val() + $("#lastNumber").val();
				    			let special = /[^a-zA-Z0-9가-힣]/; //특수문자 확인
				    			let kor = /[가-힣]/; //한글 확인
				    			let notNum = /[^0-9]/g; //숫자아닌지 확인
				    			
				    			//mid == "" || mpw == "" || mpwDuplication == "" || mname =="" || firstMrrn =="" || lastMrrn =="" || memail=="" || mhomeaddr=="" || mbirth=="" || firstNumber =="" || MiddleNumber=="" || lastNumber==""
				    			
				    		      if (mid == "") {
				    		         $("#mid").focus();
				    		         $("#idInfo").text("아이디를 입력해주세요.");
				    		         $("#idInfo").css("color", "red");
				    		         return false;
				    		      }
				    		      
				    		      if (mid.length < 4) {
				    			         $("#mid").focus();
				    			         $("#idInfo").text("아이디를 4글자 이상 입력해주세요.");
				    			         $("#idInfo").css("color", "red");
				    			         return false;
				    			      }
				    			
				    			  if (special.test(mid)) {
				    			        $("#idInfo").text("아이디에 특수문자는 허용되지 않습니다.");
				    			        $("#idInfo").css("color", "red");
				    			        return false;
				    			  }
				    			  
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
				    		       
				    		       if (mpwDuplication == "") {
				    		           $("#mpw").focus();
				    		           $("#pwInfo2").text("비밀번호를 확인해주세요.");
				    		           $("#pwInfo2").css("color", "red");
				    		           return false;
				    		        } 
				    		       
				    		       if (mpw != mpwDuplication) {
				    		           $("#mpwDuplication").focus();
				    		           $("#pwInfo2").text("비밀번호가 일치하지 않습니다. 다시 확인해주세요.");
				    		           $("#pwInfo2").css("color", "red");
				    		           return false;
				    		        } else{
				    			           $("#pwInfo2").text("비밀번호가 일치합니다.");
				    			           $("#pwInfo2").css("color", "green");
				    		        }
				    		       
				    		        if (mname == "") {
				    			           $("#mname").focus();
				    			           $("#nameInfo").text("이름을 입력해주세요.");
				    			           $("#nameInfo").css("color", "red");
				    			           return false;
				    			        }
				    		        
				    			    if (!kor.test(mname)) {
				    			        $("#nameInfo").text("한글만 입력 가능합니다.");
				    			        $("#nameInfo").css("color","red");
				    			        return false;
				    			    }
				    			    
				    		         if (firstMrrn == "" || lastMrrn=="") {
				    		              $("#mrrnInfo").text("주민번호를 모두 입력해주세요.");
				    		              $("#mrrnInfo").css("color", "red");
				    		              return false;
				    		           } else{
				    		        	   
				    		           }
				    		         
				    				    if(notNum.test(checkMrrn) || checkMrrn.length !== 13) {
				    				        $("#mrrnInfo").text("올바른 주민번호를 입력해주세요.");
				    				        $("#mrrnInfo").css("color","red");
				    				        return;
				    				    } else{
				    				    	
				    				    }
				    		        
				    		        if (memail == "" ) {
				    		           $("#memail").focus();
				    		           $("#emailInfo").text("이메일을 입력해주세요.");
				    		           $("#emailInfo").css("color", "red");
				    		           return false;
				    		        } 
				    		        
				    		        if (memail.indexOf("@") === -1) {
				    			           $("#memail").focus();
				    			           $("#emailInfo").text("올바른 이메일을 입력해주세요.");
				    			           $("#emailInfo").css("color", "red");
				    			           return false;
				    			        } 

				    		           if (mgender === "") {
				    			              $("#mgender").focus();
				    			              $("#genderInfo").text("성별을 선택하세요.");
				    			              $("#genderInfo").css("color","red");
				    			              return false;
				    			           }
				    		           
				    		           if (mhomeaddr === "") {
				    			              $("#mhomeaddr").focus();
				    			              $("#homeAddrInfo").text("주소를 입력하세요.");
				    			              $("#homeAddrInfo").css("color","red");
				    			              return false;
				    			           }
				    		           
				    		           if (mbirth === "") {
				    		              $("#mbirth").focus();
				    		              $("#birthInfo").text("생년월일을 선택하세요");
				    		              $("#birthInfo").css("color","red");
				    		              return false;
				    		           }
				    		           
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
				             }//esle 끝
				    				    $("#join").submit();
				          },//success 끝
				          error:function(request, status, error){
				             $("#mrrnInfo").text("오류가 발생함")
				          }//error끝
				       });//mrrnCheck ajax끝        
	});//joinMemberBtn끝
});//function끝
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
</script>

</head>
<body>
	<h1>DR.Home 💊</h1>
	<h2>닥터홈에 오신 것을 환영합니다!<br>계정 생성을 위해 아래 내용을 입력해주세요.</h2>
	<form action="./join" method="post" id="join">
	<h5>아이디</h5>
	<input type="text" id="mid" name="mid" placeholder="아이디를 입력해주세요." maxlength="11">
	<button type="button" id="midCheck"> 중복확인</button>
    <br>
    <span id="idInfo"></span>
	<h5>비밀번호</h5>
	<input type="text" id="mpw" name="mpw" placeholder="비밀번호를 입력해주세요." maxlength="8">
	<br>
	<span id="pwInfo"></span>
    <br>
   	<h5>비밀번호 중복확인</h5>
	<input type="text" id="mpwDuplication" name="mpwDuplication" placeholder="비밀번호를 입력해주세요." maxlength="8">
    <br>
    <span id="pwInfo2"></span>
    <h5>이름</h5>
	<input type="text" id="mname" name="mname" placeholder="이름을 입력해주세요." maxlength="11">
    <br>
    <span id="nameInfo"></span>
    <h5>주민등록번호</h5>
	<input type="text" id="firstMrrn" name="firstMrrn" maxlength="6"> -
	<input type="text" id="lastMrrn" name="lastMrrn" maxlength="7">
	<br>
	<span id="mrrnInfo"></span>
	<span id="mrrnInfo2"></span>
	<span id="mrrnInfo3"></span>
	<h5>이메일 주소</h5>
	<input type="text" id="memail" name="memail" placeholder="이메일 주소를 입력해주세요." maxlength="40">
    <br>
    <span id="emailInfo"></span>
    <h5>성별</h5>
    <select name="mgender" id="mgender">
	<option value="0">남자</option>
	<option value="1">여자</option>
    </select>
    <br>
    <span id="genderInfo"></span>    
    <h5>집주소</h5>
	<input type="text" id="mhomeaddr" name="mhomeaddr" placeholder="집주소를 입력해주세요." >
	<input type="text" id="mhomeaddr2" name="mhomeaddr2" placeholder="상세주소를 입력해주세요.">
    <br>
    <span id="homeAddrInfo"></span>
    <h5>회사주소(선택)</h5>
	<input type="text" id="mcompanyaddr" name="mcompanyaddr" placeholder="회사 주소를 입력해주세요.">
	<input type="text" id="mcompanyaddr2" name="mcompanyaddr2" placeholder="상세주소를 입력해주세요.">
    <br>
    <span id="companyAddrInfo"></span>
    <h5>생일</h5>
    <input type="date" id="mbirth" name="mbirth">
    <br>
    <span id="birthInfo"></span> 
    <h5>전화번호</h5>
	<input type="text" id="firstNumber" name="firstNumber" maxlength="3" placeholder="010">-
	<input type="text" id="MiddleNumber" name="MiddleNumber" maxlength="4" placeholder="xxxx">
	<input type="text" id="lastNumber" name="lastNumber" maxlength="4" placeholder="xxxx">
	<br>
	<span id="phoneInfo"></span>
	<span id="joinInfo"></span>
	<br>
	<button type="submit" id="joinMemberBtn">회원가입 -></button>
	</form>
	<br>
	<span>이미 닥터홈 회원이신가요?</span>
    <a href="./login">&nbsp;&nbsp;로그인 하러 가기</a>
</body>
</html>