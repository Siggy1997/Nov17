<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/doctorReview.css">
<script src="./js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">

	$(function(){
		
		let reviewAnswer1 = '';
		let reviewAnswer2 = '';
		
		/* 진료 결과 답변 누르기 */
		$(".reviewAnswer1").click(function(){
			$(this).addClass("btn-color-css");
			$(".reviewAnswer1").not(this).removeClass("btn-color-css");
			reviewAnswer1= $(this).val();
		});
		
		/* 친절도 답변 누르기 */
		$(".reviewAnswer2").click(function(){
			$(this).addClass("btn-color-css");
			$(".reviewAnswer2").not(this).removeClass("btn-color-css");
			reviewAnswer2= $(this).val();
		});
		
	});
	
</script>

</head>
<body>
	<h1>reviewWrite</h1>
	<div class="reviewWriteContainer">
		<form id="searchForm" action="/search" method="post">
			<div class="doctorContainer">
				<div class="doctorImg"><img src="${doctor.dimg}" style="width:10%"></div>
				<div class="doctorInfo">
					<div class="doctorHospitalName">${doctor.hname}</div>
					<div class="doctorDepartment">${doctor.dpkind}</div>
					<div class="doctorName">
					<c:choose>
						<c:when test="${doctor.dpno == 9}">한의사 ${doctor.dname}</c:when>
						<c:otherwise>의사 ${doctor.dname}</c:otherwise>
					</c:choose>
					</div>
					<div class="reviewStar">별 넣기</div>
				</div>
			</div>
			<div class="reviewContainer">
				<div class="reviewQuestionBox">
					<div class="reviewQuestion1">진료 결과는 어때요?</div>
					<div class="reviewAnswerBox1">
						<button class="reviewAnswer1" type="button" name="result" value="효과 없어요"><img src="./img/bad.png" style="width: 15%;"> 효과 없어요</button>
						<button class="reviewAnswer1" type="button" name="result" value="보통이에요"><img src="./img/fine.png" style="width: 15%;"> 보통이에요</button>
						<button class="reviewAnswer1" type="button" name="result" value="효과 없어요"><img src="./img/good.png" style="width: 15%;"> 효과 좋아요</button>
					</div>
					<div class="reviewQuestion2">선생님은 친절하셨나요?</div>
					<div class="reviewAnswerBox2">
						<button class="reviewAnswer2" type="button" name="kind" value="불친절해요"><img src="./img/unkind.png" style="width: 15%;"> 불친절해요</button>
						<button class="reviewAnswer2" type="button" name="kind" value="보통이에요"><img src="./img/normal.png" style="width: 15%;"> 보통이에요</button>
						<button class="reviewAnswer2" type="button" name="kind" value="친절해요"><img src="./img/kind.png" style="width: 15%;"> 친절해요</button>
					</div>
					<div class="reviewQuestion3">상세한 리뷰를 써주세요</div>
					<div class="reviewAnswer3">
						<textarea placeholder="최소 10자 이상 입력해 주세요."></textarea>
					</div>
				</div>
			</div>
			<div><button>완료</button></div>
		</form>
	</div>
	
</body>
</html>