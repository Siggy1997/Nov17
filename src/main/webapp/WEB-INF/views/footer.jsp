<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
@import
   url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.8/dist/web/variable/pretendardvariable-dynamic-subset.css")
   ;

@import
   url('https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css')
   ;

* {
   font-family: "Pretendard Variable";
   box-sizing: border-box;
   margin: 0;
   padding: 0;
}

body {
   background-color: white;
}


footer {
   bottom: 0;
   position: fixed;
   height: 9vh;
   width: 100%;
   z-index: 1000;
   background-color: white;
   border-top: 2px solid #DDDDDD;
}

.section{
    display: flex;
    align-items: center;
    flex-direction: row;
    justify-content: space-around;
    border-inline-start: 100px;
    margin: 2% 0%;
}

.footerMain
{
width: 40px;
height: 40px;
background: linear-gradient(180deg, rgba(131, 247, 146, 0.5) 0%, rgba(0, 201, 255, 0.5) 99.95%, rgba(82, 209, 187, 0.5) 99.96%, rgba(61, 193, 204, 0.5) 99.97%, rgba(49, 183, 214, 0.5) 99.98%, rgba(48, 183, 215, 0.5) 99.99%, rgba(0, 145, 255, 0.5) 100%);
box-shadow: 0px 12px 32px #979797;
border-radius: 100px;
padding: 0;
margin-bottom: 5px;
}

#mapIcon {
   margin: 8px;
}

.footerIcon img{
width: 25px;
}

</style>
<meta charset="UTF-8">
<title>Main</title>
<link rel="stylesheet"href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
</head>
<body>
<footer>
<div class="section">
<div class="footerIcon"><a href="./main"><img alt="없음" src="/img/home.png"></a></div>
<div class="footerIcon"><a href="./main"><img alt="없음" src="/img/medical-records.png"></a></div>
<div class="footerMain">
<div class="footerIcon" id="mapIcon"><a href="./main"><img alt="없음" src="/img/map.png"></a></div>
</div>
<div class="footerIcon"><a href="./main"><img alt="없음" src="/img/board.png"></a></div>
<div class="footerIcon"><a href="./main"><img alt="없음" src="/img/chat.png"></a></div>
</div>
</footer> 

</body>
</html>