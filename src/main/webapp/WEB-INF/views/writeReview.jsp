<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./css/writeReview.css">

<script src="./js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">
	$(function() {
		let rate;
		let dno;
		let keyword;
		let keyword1;
		let keyword2;

		$('.hospitalInfo').find('.xi-star-o').click(function() {
			rate = parseInt($(this).children('#rate').val());
			for (let i = 1; i <= rate; i++) {
				$('.star' + i).addClass('xi-star')
				$('.star' + i).removeClass('xi-star-o')
			}
			;
			for (let i = (rate + 1); i <= 5; i++) {
				$('.star' + i).addClass('xi-star-o')
				$('.star' + i).removeClass('xi-star')
			}
			;
			slideUpAndShrink();
			setTimeout(function() {
				$('.goUp').show();
				$('#ask').remove()
				$('.totalDoctor').show();
				$('#finish').show();
			}, 700);
		});

		$('.xi-star-o').click(function() {

			rate = parseInt($(this).children('#rate').val());
			for (let i = 1; i <= rate; i++) {
				$('.star' + i).addClass('xi-star')
				$('.star' + i).removeClass('xi-star-o')
			}
			;
			for (let i = (rate + 1); i <= 5; i++) {
				$('.star' + i).addClass('xi-star-o')
				$('.star' + i).removeClass('xi-star')
			}
			;

		})

		$('.selectDoctorInfo').click(function() {
			dno = $(this).children('#doctor').val()
			$('.selectDoctorInfo').removeClass('selectedDoc')
			$('.doctor' + dno).addClass('selectedDoc')
			$('.totalTreatment').show();
		});

		$('.treatment').click(function() {
			keyword1 = $(this).val();
			$('.treatment').removeClass('selectedTreatment')
			$(this).addClass('selectedTreatment')
			$('.totalFeedback').show();

		});
		$('.feedback').click(function() {
			keyword2 = $(this).val()
			keyword = keyword1 + ',' + keyword2;
			$('.feedback').removeClass('selectedFeedback')
			$(this).addClass('selectedFeedback')

			$('.reviewContent').show()
		});

		$('#finish').click(function() {
			if (rate !== undefined && dno !== undefined && keyword !== undefined && $('#content').val().length > 10) {
		    	alert(rate)
		    	alert("!!!!")
		        let form = $('<form></form>');
		        form.attr("action", "./writeReview");
		        form.attr("method", "post");
		        form.append($("<input>", {
		            type: 'hidden',
		            name: "rate",
		            value: rate
		        }));
		        form.append($("<input>", {
		            type: 'hidden',
		            name: "dno",
		            value: dno
		        }));
		        form.append($("<input>", {
		            type: 'hidden',
		            name: "keyword",
		            value: keyword
		        }));
		        form.append($("<input>", {
		            type: 'hidden',
		            name: "content",
		            value: $('#content').val()
		        }));
		        form.append($("<input>", {
		            type: 'hidden',
		            name: "hno",
		            value: $('#hno').val()
		        }));
		        form.append($("<input>", {
		            type: 'hidden',
		            name: "mno",
		            value: $('#mno').val()
		        }));
		        form.appendTo("body");
		        form.submit();
		    } else {
		        alert("필수 정보를 모두 입력해주세요!");
		        return false; // 버튼 클릭 이벤트를 중단합니다.
		    }
		});


		function slideUpAndShrink() {
			$('.hospitalInfo').slideUp().animate({
				width : '0px',
				height : '0px'
			}, 500);
		}
	});
</script>

</head>
<body>
	<input id="mno" type="hidden" value="${parameter.mno }">
	<input id="hno" type="hidden" value="${parameter.hno }">
	<div class="total">
		<div class="hospitalInfo">
			<img alt=""
				src="https://cdn0.iconfinder.com/data/icons/medical-flat-20/58/006_Hospital-1024.png">
			<div id="hospitalName">
				<span>${hospital.hname }</span>

				<div class="selectStars">
					<c:forEach var="i" begin="1" end="5">
						<i class="star${i } xi-star-o xi-x"> <input id="rate"
							type="hidden" value="${i }"></i>
					</c:forEach>
				</div>
			</div>
		</div>
		<div class="goUp">
			<img alt=""
				src="https://cdn0.iconfinder.com/data/icons/medical-flat-20/58/006_Hospital-1024.png">
			<div id="hospitalName">
				<span>${hospital.hname }</span>

				<div class="selectStars">
					<c:forEach var="i" begin="1" end="5">
						<i class="star${i } xi-star-o xi-x"> <input id="rate"
							type="hidden" value="${i }"></i>
					</c:forEach>
				</div>
			</div>
			<hr>
		</div>

		<div class="totalDoctor">
			<div class="title">진료 받으신 의사를 선택해주세요</div>
			<div class="selectDoctor">
				<c:forEach var="doctor" items="${doctor}">
					<div class="selectDoctorInfo doctor${doctor.dno }">
						<img alt="의사사진" src="${doctor.dimg }"><br>
						${doctor.dname } <input type="hidden" id="doctor"
							value="${doctor.dno }">
					</div>
				</c:forEach>
			</div>
		</div>

		<div class="totalTreatment">
			<div class="title">진료 결과는 어때요?</div>
			<button class="treatment t1" value="효과없어요">효과 없어요</button>
			<button class="treatment t2" value="보통이에요">보통이에요</button>
			<button class="treatment t3" value="효과좋아요">효과 좋아요</button>
		</div>

		<div class="totalFeedback">
			<div class="title">선생님은 친절하셨나요?</div>
			<button class="feedback f1" value="불친절해요">불친절해요</button>
			<button class="feedback f2" value="보통이에요">보통이에요</button>
			<button class="feedback f3" value="친절해요">친절해요</button>
		</div>

		<div class="reviewContent">
			<div class="title">상세한 리뷰를 써주세요</div>
			<input id="content" placeholder="최소 10자 이상 입력해주세요">
		</div>
	</div>
	<div class="blank"></div>
	<footer>
		<button id="finish">완료</button>
	</footer>
</body>
</html>