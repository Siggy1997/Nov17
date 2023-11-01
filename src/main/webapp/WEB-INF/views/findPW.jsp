<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Find ID</title>

<script src="./js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">

	$(function(){
		$("#copyPW").hide();

		
		$(".findPWBtn").click(function(){
			let notNum = /[^0-9]/g;
			let kor = /[가-힣]/;
			let special = /[^a-zA-Z0-9가-힣]/;
			let mname = $(".mname").val();
			let mid = $(".mid").val();
			let checkMrrn = $(".firstMrrn").val() + $(".lastMrrn").val();
			let mrrn = $(".firstMrrn").val() + "-" + $(".lastMrrn").val();
			
			$(".nameInfo").text("");
			$(".idInfo").text("");
			$(".mrrnInfo").text("");
			$(".findPWInfo").text("");
			$(".findPWInfo2").text("");
			
		    if (mname == "") {
		        $(".nameInfo").text("이름을 입력해주세요.");
		        $(".nameInfo").css("color","red");
		        return;
		    }
		    
		    if (!kor.test(mname)) {
		        $(".nameInfo").text("한글만 입력 가능합니다.");
		        $(".nameInfo").css("color","red");
		        return;
		    }
		    
		    if (mid == "") {
		        $(".idInfo").text("아이디를 입력해주세요.");
		        $(".idInfo").css("color","red");
		        return;
		    }
		    
		    if (mid.length < 4) {
		        $(".idInfo").text("아이디는 4글자 이상입니다.");
		        $(".idInfo").css("color","red");
		        return;
		    }
		    
		    if (special.test(mid)) {
		        $(".idInfo").text("아이디에 특수문자는 허용되지 않습니다.");
		        $(".idInfo").css("color", "red");
		        return;
		    }
		    
		    if (checkMrrn == "") {
		        $(".mrrnInfo").text("주민번호를 입력해주세요.");
		        $(".mrrnInfo").css("color","red");
		        return;
		    }
		    
		    if(notNum.test(checkMrrn) || checkMrrn.length !== 13) {
		        $(".mrrnInfo").text("올바른 주민번호를 입력해주세요.");
		        $(".mrrnInfo").css("color","red");
		        return;
		    }
		    
		    //ajax
		    $.ajax({
                url: "./findPW",
                type: "post",
                data: {"mname": mname, "mid": mid, "mrrn" : mrrn},
                dataType: "json",
                success: function(data){
                	
                    if(data.findPW.mname != null || data.findPW.mid != null || data.findPW.mrrn !=null){
                        $(".findPWInfo").css("color","green");
                        $(".findPWInfo").html(data.findPW.mname + " 님의 비밀번호는" + data.findPW.mpw + "입니다.  ");
                        let pw = data.findPW.mpw;
                        
                        if ($(".copyPWBtn").length === 0) {
                            const copyBtn = $("<button id='copyPWBtn'>복사하기</button>");
                            $(".findPWInfo").append(copyBtn);
                            
                            copyBtn.click(function() {
                                const pwText = pw;
                                copyToClipboard(pwText);
                                alert("비밀번호가 클립보드에 복사되었습니다.");
                            });
                        }

                        function copyToClipboard(text) {
                            const textarea = document.createElement("textarea");
                            textarea.value = text;
                            document.body.appendChild(textarea);
                            textarea.select();
                            document.execCommand("copy");
                            document.body.removeChild(textarea);
                        }
                        
                      } else {
                    	    alert("일치하는 정보가 없습니다.");
                    	    $(".findPWInfo").css("color","blue");
                    	    $(".findPWInfo").text("회원가입이 필요하신가요? -> ");
                    	    $(".findPWInfo2").html("<a href='./join'>회원가입 하러 가기</a>");
                    	}

                }, 
                error : function(error){
                    alert("에러가 발생했습니다." + error);
                }//에러끝
            });//ajax 끝
		}); //findIDBtn 끝
	}); //function 끝
</script>

</head>
<body>
	<h1>비밀번호가 기억나지 않으세요?</h1>
	<h5>이름</h5>
	<input type="text" class="mname" name="mname" placeholder="이름을 입력해주세요." maxlength="11">
    <br>
    <span class="nameInfo"></span>
	<br>
	<h5>아이디</h5>
	<input type="text" class="mid" name="mid" placeholder="아이디를 입력해주세요." maxlength="11">
    <br>
    <span class="idInfo"></span>
	<br>
	<h5>주민등록번호</h5>
		<input type="text" class="firstMrrn" name="firstMrrn" maxlength="6">-
		<input type="text" class="lastMrrn" name="lastMrrn" maxlength="7">
		<br>
		<span class="mrrnInfo"></span>
		<br>
		<button type="button" class="findPWBtn">비밀번호 찾기</button>
		<br>
		<span class="findPWInfo"></span>
		<span class="findPWInfo2"></span>
		<br>
		<br> 
		<a href="./login">&nbsp;&nbsp;로그인 하러가기</a>
</body>
</html>