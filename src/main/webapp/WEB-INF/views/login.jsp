<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<link href="./css/login.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/clipboard.js/2.0.8/clipboard.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">

//getCookie() 사용 전 미리 로드할 수 있도록 배치 필요!!
function getCookie(cookieName){
   let x, y;
   let val = document.cookie.split(";");
   for(let i =0; i < val.length; i++){
      x = val[i].substr(0, val[i].indexOf("="));
      y = val[i].substr(val[i].indexOf("=") +1); // 저 시작위치부터 끝까지
      //x = x.replace(/^\s+|\s+$/g, '');
      x = x.trim();
      if(x == cookieName){
         return y;
      }
   }
}

//setCookie()
function setCookie(cookieName, value, exdays){
   let exdate = new Date();
   exdate.setDate(exdate.getDate() + exdays);
   let cookieValue = value + ((exdays == null) ? "" : ";expires=" + exdate.toGMTString());
   document.cookie = cookieName+"="+cookieValue;
}

//deleteCookie()
function deleteCookie(cookieName){
   let expireDate = new Date();
   expireDate.setDate(expireDate.getDate() - 1);
   document.cookie = cookieName+"= "+";expires="+expireDate.toGMTString();
}

    $(function() {
    	   //쿠키 값 가져오기
			let userID = getCookie("userID");
			let setCookieY = getCookie("setCookie");
			console.log(userID, setCookieY);
    	   
    	   //쿠키 검사 -> 쿠키가 있다면 해당 쿠키에서 id값 가져와서 id칸에 붙여넣기
			if (setCookieY == 'Y') {
			    $("#saveID").prop("checked", true);
			    $("#mid").val(userID);
			    $("#mpw").focus();
			} else {
			    $("#saveID").prop("checked", false);
			}
    	
        $('.loginBtn').click(function(event) {
            let mid = $("#mid").val();
            let mpw = $("#mpw").val();
            let notNum = /[^0-9]/g;
            
            $(".info").text("");
            
            if($("#saveID").is(":checked")){
            	//setCookie
            	setCookie("userID", mid, 7);
            	setCookie("setCookie", "Y", 7);
            } else{
            	//deleteCookie()
            	deleteCookie("userID");
            	deleteCookie("setCookie");
            	
            }
            
            if(mid == ""){
                $("#mid").val("");
                $("#mpw").val("");
                $(".info").css("color","red");
                $(".info").text("아이디를 입력하세요.");         
                $("#mid").focus();
                return false;
            }
            
            if( mpw==""){
                $("#mpw").val("");
                $(".info").css("color","red");
                $(".info").text("비밀번호를 입력해주세요.");         
                $("#mpw").focus();
                return false;
            }
            
            if(notNum.test(mpw)){
                $("#mpw").val("");
                $(".info").css("color","red");
                $(".info").text("숫자를 입력해주세요.");         
                $("#mpw").focus();
                return false;
            }
            
            //ajax
            $.ajax({
                url: "./loginCheck",
                type: "post",
                data: {"mid": mid, "mpw": mpw},
                dataType: "json",
                success: function(data){
                	
                    if(data.PWresult == 1){
                       let form = $('<form></form>')
                       form.attr("action", "./main");
                       form.attr("method", "get");
                       
                       form.appendTo("body");
                       
                       form.submit();
                      }
                	
                    if(data.IDresult == 0){
                        alert("일치하는 아이디가 없습니다.");
                        $(".info").css("color","red");
                        $(".info").text("아이디를 다시 확인해주세요.");            
                        $("#mid").focus();
                    }
                    
                    if(data.PWresult == 0){
                        alert("비밀번호를 잘못 입력하셨습니다.");
                        $(".info").css("color","red");
                        $("#mid").focus();
                        $(".info").text("비밀번호를 다시 확인해주세요.");
                    } 
                }, 
                error : function(error){
                    alert("에러가 발생했습니다." + error);
                }//에러끝
            });//ajax 끝

        });//로그인 버튼 클릭            
    });
    
 
    
</script>

</head>
<body>
		<div id='search' class='search'>
	<div id='icon' class='icon'>
	<img id='personfilled' class='personfilled' src='data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAACXBIWXMAAAsTAAALEwEAmpwYAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAYSURBVHgB7cABDQAAAMKg90/t7AEFAMANCRgAAbQRseIAAAAASUVORK5CYII='/>
	</div>
	</div>
    <h1 class="logo-title">DR.HOME</h1>
    <div class="login-form">
	        <input type="text" id="mid" name="mid" placeholder="아이디" maxlength="11"> <br>
	        <input type="password" id="mpw" name="mpw" placeholder="패스워드" maxlength="8">
        <br> 
	        <a href="./findID"  class="findID">&nbsp;&nbsp;아이디 찾기</a> 
	        <a href="./findPW" class="findPW">&nbsp;&nbsp;비밀번호 찾기</a> 
	        <a href="./join" class="join"> &nbsp;&nbsp;회원가입</a> <br>
	        <input id="saveID" type="checkbox">아이디 저장하기
      	    <span class="info"></span><br>
       		<button class="loginBtn">Sign In →</button>
        <br>
    </div>
    <div class=joinHospital-form">
   		 	<span>병원 개설이 필요하신가요?</span>
    		<a href="./joinHospital" class="joinHospital">&nbsp;&nbsp;병원 등록하러 가기</a>
    </div>
</body>
</html>
