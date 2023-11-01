<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/navigation.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<title>Insert title here</title>

<script src="./js/jquery-3.7.0.min.js"></script>

<script type="text/javascript">
	$(function() {
		let ncgoto = 0;
		let item = '';

		$(document).on('click', '.choice', function() {
			ncgoto = $(this).children('.ncgoto').val();
			getQuestion(ncgoto);
			$(this).addClass('selectedChoice');
			$(this).siblings('.choice').addBack().attr('disabled', 'disabled');
		});

		$('#startNavigation').click(function() {
			$(this).attr('disabled', 'disabled');
			$(this).text("시작중...");
			$('#resetQuestions').show();
			getQuestion(1);
		})

		$('#resetQuestions').click(function() {
			$('#startNavigation').attr('disabled', false);
			$('#startNavigation').text("시작하기");
			$('#resetQuestions').hide();
			item = '';
			$('.navigationContainer').empty();
		})

		function getQuestion(ncgoto) {
			$
					.ajax({
						url : "/getQuestion",
						type : "GET",
						data : {
							"ncgoto" : ncgoto
						},
						success : function(data) {

							let jsonData = JSON.parse(data);
							let question = jsonData.nextQuestion.nqquestion;
							let choices = jsonData.nextChoices;
							let hospitalList =jsonData.hospitalList;

							item = "<div class='qna'>";
							item += "<div class='question'>" + question
									+ "</div>";

							if (ncgoto >= 29 && ncgoto <= 40) {
								for (let i = 0; i < hospitalList.length; i++) {
									let hospital = hospitalList[i];
									
									item += "<div class='hospitalname'>" + hospital.hname + hospital.reviewCount + hospital.reviewAverage
									+ "</div>";
									
									item += "<button onclick=\"location.href='/hospitaldetail/" + hospital.hno + "'\">goto</button>";

										
								}
								
							} else {

								for (let i = 0; i < choices.length; i++) {
									let choice = choices[i];
									item += "<button class='choice'>"
											+ choice.ncchoice;
									item += "<input type='hidden' class='ncgoto' value=" + choice.ncgoto + "></button>";
								}
							}

							item += "</div><br>";

							$('.navigationContainer').append(item);
						}
					});
		}
	});
</script>

</head>
<body>
	<div id="introduction">${sessionScope.mname}님
		안녕하세요
		<button id="startNavigation">시작하기</button>
		<button id="resetQuestions">초기화</button>
	</div>

	<div class="navigationContainer"></div>

</body>
</html>