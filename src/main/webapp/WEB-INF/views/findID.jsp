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
		
		$(".findIDBtn").click(function(){
			let notNum = /[^0-9]/g;
			let kor = /[가-힣]/;
			let mname = $(".mname").val();
			let phoneNumber = $(".firstNumber").val() + $(".MiddleNumber").val() + $(".lastNumber").val();
			let mphonenumber = $(".firstNumber").val() + "-" + $(".MiddleNumber").val() + "-" + $(".lastNumber").val();
			
			$(".nameInfo").text("");
			$(".phoneInfo").text("");
			$(".findIDInfo").text("");
			$(".findIDInfo2").text("");
			
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
		    
		    if (phoneNumber == "") {
		        $(".phoneInfo").text("전화번호를 입력해주세요.");
		        $(".phoneInfo").css("color","red");
		        return;
		    }
			
		    if(notNum.test(phoneNumber) || phoneNumber.length !== 11) {
		        $(".phoneInfo").text("올바른 전화번호를 입력해주세요.");
		        $(".phoneInfo").css("color","red");
		        return;
		    }
		    
		    //ajax
		    $.ajax({
                url: "./findID",
                type: "post",
                data: {"mname": mname, "mphonenumber": mphonenumber},
                dataType: "json",
                success: function(data){
                	
                    if(data.findID.mname != null || data.findID.mid != null){
                        $(".findIDInfo").css("color","green");
                        $(".findIDInfo").text(data.findID.mname +" 님의 아이디는 " + data.findID.mid + " 입니다.  "); 
						let id = data.findID.mid;
                        
                        if ($(".copyIDBtn").length === 0) {
                            const copyBtn = $("<button id='copyIDBtn'>복사하기</button>");
                            $(".findIDInfo").append(copyBtn);
                            
                            copyBtn.click(function() {
                                const idText = id;
                                copyToClipboard(idText);
                                alert("아이디가 클립보드에 복사되었습니다.");
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
                    	    $(".findIDInfo").css("color","blue");
                    	    $(".findIDInfo").text("회원가입이 필요하신가요? -> ");
                    	    $(".findIDInfo2").html("<a href='./join'>회원가입 하러 가기</a>");
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
	<h1>아이디가 기억나지 않으세요?</h1>
	<h5>이름</h5>
	<input type="text" class="mname" name="mname" placeholder="이름을 입력해주세요." maxlength="11">
    <br>
    <span class="nameInfo"></span>
	<br>
	<h5>전화번호</h5>
		<input type="text" class="firstNumber" name="firstNumber" maxlength="3" placeholder="010">-
		<input type="text" class="MiddleNumber" name="MiddleNumber" maxlength="4" placeholder="xxxx">
		<input type="text" class="lastNumber" name="lastNumber" maxlength="4" placeholder="xxxx">
		<br>
		<span class="phoneInfo"></span>
		<br>
		<button type="button" class="findIDBtn">아이디 찾기</button>
		<br>
		<span class="findIDInfo"></span>
		<span class="findIDInfo2"></span>
		<br>
		<br> 
		<a href="./login">&nbsp;&nbsp;로그인 하러가기</a>
</body>
</html>