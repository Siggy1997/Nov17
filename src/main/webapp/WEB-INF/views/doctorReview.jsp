<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/doctorReview.css">
<script src="./js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">

	$(function(){
		
		/* url 값 가져오기 */
		let urlString = location.search;
		let urlParams = new URLSearchParams(urlString);
		let mno = urlParams.get("mno");
		let dno = urlParams.get("dno");
		
		let rrate = '';
		let rkeyword = '';
		let reviewAnswer1 = ''
		let reviewAnswer2 = ''
		
		/* 별점 매기기 */
		$(document).on("click", ".star", function(){
			rrate = $(this).val();
			$(".reviewQuestion1Box").show();
			$(".star").each(function() {
				if($(this).val() <= rrate) {
					$(this).removeClass("xi-star-o").addClass("xi-star");
				} else {
					$(this).removeClass("xi-star").addClass("xi-star-o");
				}
			});
		});
		
		/* 진료 결과 답변 누르기 */
		$(document).on("click", ".reviewAnswer1", function(){
			$(this).addClass("btn-color-css");
			$(".reviewQuestion2Box").show();
			$(".reviewAnswer1").not(this).removeClass("btn-color-css");
			reviewAnswer1 = $(this).val();
		});
		
		/* 친절도 답변 누르기 */
		$(document).on("click", ".reviewAnswer2", function(){
			$(this).addClass("btn-color-css");
			$(".reviewQuestion3Box").show();
			$(".reviewWriteSubmit").show();
			$(".reviewAnswer2").not(this).removeClass("btn-color-css");
			reviewAnswer2 = $(this).val();
		});
		
		/* 입력 다 했을 경우 버튼 효과 */
		$(document).on("input", "#rcontent", function(){
		    if ($(this).val().length >= 10) {
		    	$(".reviewWriteSubmit").addClass("btn-color-css");
		    } else {
		    	$(".reviewWriteSubmit").removeClass("btn-color-css");
		    }
		});
		
		/* 리뷰 보내기 */
		$(document).on("click", ".reviewWriteSubmit", function(event) {
			rkeyword = reviewAnswer1 + "," + reviewAnswer2;
			let rcontent = $("#rcontent").val();
			if ( rrate != '' && rkeyword != '' && rcontent.length >= 10) {
				$.ajax({
			         url: "./doctorReview",
			         type: "post",
			         dataType: "json",
			         data: {rrate : rrate, rkeyword : rkeyword, mno : mno, dno : dno, rcontent : rcontent},
			         success: function(data){
			        	 location.href = "/doctorDetail/"+dno;
			         },
			         error: function(error){
			            alert("Error");
			         }
			      });
			} else {
				event.preventDefault();
				alert("10글자 이상 입력하셔야 합니다.")
			}
		});
	});
	
</script>

</head>
<body>
	<h1>reviewWrite</h1>
	<div class="reviewWriteContainer">
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
				<div class="reviewStar">
					<button type="button" class="star xi-star-o" value="1"></button>
					<button type="button" class="star xi-star-o" value="2"></button>
					<button type="button" class="star xi-star-o" value="3"></button>
					<button type="button" class="star xi-star-o" value="4"></button>
					<button type="button" class="star xi-star-o" value="5"></button>
				</div>
			</div>
		</div>
		<div class="reviewContainer">
			<div class="reviewQuestionBox">
				<div class="reviewQuestion1Box">
					<div class="reviewQuestion1">진료 결과는 어때요?</div>
					<div class="reviewAnswerBox1">
						<button class="reviewAnswer1" type="button" name="result" value="효과 없어요"><img src="./img/bad.png" style="width: 15%;"> 효과 없어요</button>
						<button class="reviewAnswer1" type="button" name="result" value="보통이에요"><img src="./img/fine.png" style="width: 15%;"> 보통이에요</button>
						<button class="reviewAnswer1" type="button" name="result" value="효과 없어요"><img src="./img/good.png" style="width: 15%;"> 효과 좋아요</button>
					</div>
				</div>
				<div class="reviewQuestion2Box">
					<div class="reviewQuestion2">선생님은 친절하셨나요?</div>
					<div class="reviewAnswerBox2">
						<button class="reviewAnswer2" type="button" name="kind" value="불친절해요"><img src="./img/unkind.png" style="width: 15%;"> 불친절해요</button>
						<button class="reviewAnswer2" type="button" name="kind" value="보통이에요"><img src="./img/normal.png" style="width: 15%;"> 보통이에요</button>
						<button class="reviewAnswer2" type="button" name="kind" value="친절해요"><img src="./img/kind.png" style="width: 15%;"> 친절해요</button>
					</div>
				</div>
				<div class="reviewQuestion3Box">
					<div class="reviewQuestion3">상세한 리뷰를 써주세요</div>
					<div class="reviewAnswer3">
						<input placeholder="최소 10자 이상 입력해 주세요." name="content" id="rcontent">
					</div>
				</div>
			</div>
		</div>
		<div><button class="reviewWriteSubmit">완료</button></div>
	</div>
</body>
</html>