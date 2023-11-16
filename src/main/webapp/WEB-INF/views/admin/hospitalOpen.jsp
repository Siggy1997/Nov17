<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>hospitalOpen</title>
<link rel="stylesheet" href="../css/hospitalOpen.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://unpkg.com/swiper/css/swiper.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						let rhno = 0;

						$(document)
								.on(
										"click",
										".chkData",
										function() {
											rhno = $(this).children().first()
													.html();

											$
													.ajax({
														url : "./detail",
														type : "POST",
														data : {
															"rhno" : rhno,
														},
														dataType : "json",
														success : function(data) {
															let detail = data.detail;

															for (let i = 0; i < detail.length; i++) {
																$("#data-rhno")
																		.text(
																				detail[i].rhno);
																$(
																		"#data-rhname")
																		.text(
																				detail[i].rhname);
																$(
																		"#data-rhopendate")
																		.text(
																				detail[i].rhopendate);
																$(
																		"#data-rhaddr")
																		.text(
																				detail[i].rhaddr);
																$(
																		"#data-rhtelnumber")
																		.text(
																				detail[i].rhtelnumber);
																$("#data-rhimg")
																		.text(
																				detail[i].rhimg);
																$(
																		"#data-rhinfo")
																		.text(
																				detail[i].rhinfo);
																$(
																		"#data-rhopentime")
																		.text(
																				detail[i].rhopentime);
																$(
																		"#data-rhclosetime")
																		.text(
																				detail[i].rhclosetime);
																$(
																		"#data-rhnightday")
																		.text(
																				detail[i].rhnightday);
																$(
																		"#data-rhnightendtime")
																		.text(
																				detail[i].rhnightendtime);
																$(
																		"#data-rhbreaktime")
																		.text(
																				detail[i].rhbreaktime);
																$(
																		"#data-rhbreakendtime")
																		.text(
																				detail[i].rhbreakendtime);
																$(
																		"#data-rhholiday")
																		.text(
																				detail[i].rhholiday == 0 ? 'X'
																						: 'O');
																$(
																		"#data-rhholidayendtime")
																		.text(
																				detail[i].rhholidayendtime);
																$(
																		"#data-rhparking")
																		.text(
																				detail[i].rhparking == 0 ? 'X'
																						: 'O');
																$("#approve")
																		.val(
																				detail[i].rhno);
															}

															$("#viewModal")
																	.modal(
																			"show");

															$("#data-rhname")
																	.css(
																			"font-weight",
																			"bold");
														},
														error : function(error) {
															alert("잘못된 에러입니다.");
														}
													});
										});

						$("#searchHos")
								.click(
										function() {
											$("#searchDiv").html("");
											searchN = $(
													"#searchN option:selected")
													.val();
											searchV = $("input[name=searchV]")
													.val();

											$
													.ajax({
														url : "./searchHos",
														type : "POST",
														data : {
															"searchN" : searchN,
															"searchV" : searchV,
														},
														dataType : "json",
														success : function(data) {
															let searchHos = data.searchHos;
															let tableMake = "";

															$("#searchTable")
																	.empty();

															for (let i = 0; i < searchHos.length; i++) {
																tableMake += "<div class='chkData' id='searchTable'>";
																tableMake += "<div style='display: none; text-align: left; margin-left: 10px;'>"
																		+ searchHos[i].rhno
																		+ "</div>";
																tableMake += "<div style='text-align: left; font-weight: bold; margin-left: 10px;'>"
																		+ searchHos[i].rhname
																		+ "</div>";
																tableMake += "<div style='text-align: left; margin-left: 10px; font-size: 12px;'>"
																		+ searchHos[i].rhaddr
																		+ "</div>";
																tableMake += "<div style='text-align: left; margin-left: 10px; font-size: 12px;'>"
																		+ searchHos[i].rhtelnumber;
																tableMake += "<span style='text-align: right; margin-left: 180px;'>"
																		+ searchHos[i].rhopendate
																		+ "</span></div>";
																tableMake += "<div class='graySeperate'></div></div>";
															}

															$("#searchDiv")
																	.append(
																			tableMake);

														},
														error : function(error) {
															alert("잘못된 에러입니다.");
														}
													});
										});

						$(document).on("click", "#cancel", function() {
							rhno = $("#data-rhno").html();
							alert(rhno);

							if (confirm("삭제하시겠습니까?")) {
								$.ajax({
									url : "./deleteHos",
									type : "POST",
									data : {
										"rhno" : rhno,
									},
									dataType : "json",
									success : function(data) {
										location.reload();
									},
									error : function(error) {
										alert("잘못된 에러입니다.");
									}
								});
							} else {
								return false;
							}
						});
					});
</script>
</head>

<header>
	<i class="xi-angle-left xi-x" onclick="history.back()"></i>

	<div class="blank"></div>

	<div>
		<h3 style="text-align: center; margin-right: 40px; font-size: 25px;">병원
			등록 관리</h3>
	</div>

	<div class="blank"></div>
</header>

<body>
	<main>
		<div class="content">
			<div class="searchTab">
				<select id="searchN" name="searchN" style="width: 60px;">
					<option value="" selected="selected">전체</option>
					<option value="rhname">병원명</option>
					<option value="rhaddr">주소</option>
				</select> <input type="text" id="searchV" name="searchV" maxlength="10"
					style="width: 70px;" />
				<button id="searchHos" type="button">검색</button>
				<div id="searchDiv">
					<c:forEach items="${hospitalOpen}" var="hospitalOpen">
						<div class="chkData" id="searchTable">
							<div style="text-align: left; margin-left: 10px; display: none;">${hospitalOpen.rhno }</div>
							<div
								style="text-align: left; margin-left: 10px; margin-top: 5px; font-weight: bold;">${hospitalOpen.rhname }</div>
							<div
								style="text-align: left; margin-left: 10px; font-size: 12px;">${hospitalOpen.rhaddr}</div>
							<div
								style="text-align: left; margin-left: 10px; font-size: 12px;">${hospitalOpen.rhtelnumber}
								<span style="text-align: right; margin-left: 220px;">${hospitalOpen.rhopendate}</span>
							</div>
							<div class="graySeperate"></div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		<div class="modal" id="viewModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true"
			data-bs-backdrop="static" data-keyboard="false">
			<!-- 모달 내용 -->
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="edit-header">
								<h1
									style="position: fixed; float: left; left: 54px; font-weight: bold; top: 150px;"
									class="modal-title" id="data-rhname"></h1>
								<span style="right: 62px; position: fixed; top: 154px;"
									class="xi-close xi-x" data-bs-dismiss="modal"></span>
							</div>
							<div style="margin-top: 20px;" class="line"></div>
							<div class="modal-body swiper-slide view-body">
								<div class="modal-div"
									style="text-align: left; margin-top: 10px; margin-left: 30px;">
									<div style="text-decoration: underline; font-size: 20px;">
										번호 <span
											style="position: fixed; font-weight: bold; font-size: 18px; text-align: right; right: 85px;"
											id="data-rhno"></span>
									</div>
									<br>
									<div style="font-size: 18px;">
										개원일 <span
											style="position: fixed; font-weight: bold; font-size: 14px; text-align: right; right: 85px;"
											id="data-rhopendate"></span>
									</div>
									<br>
									<div style="font-size: 18px;">
										전화번호 <span
											style="position: fixed; font-weight: bold; font-size: 14px; text-align: right; right: 85px;"
											id="data-rhtelnumber"></span>
									</div>
									<br>
									<div style="font-size: 18px;">
										주소 <span
											style="position: fixed; font-weight: bold; font-size: 14px; text-align: right; right: 85px;"
											id="data-rhaddr"></span>
									</div>
									<br>
									<div style="font-size: 18px;">
										주차 여부 <span
											style="position: fixed; font-weight: bold; font-size: 14px; text-align: right; right: 85px;"
											id="data-rhparking"></span>
									</div>

									<br>
									<div style="font-size: 18px;">진료시간</div>
									<span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhopentime"></span> ~ <span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhclosetime"></span> <br> <br>
									<div style="font-size: 18px;">야간진료 요일 및 종료시간</div>
									<span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhnightday"></span> / <span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhnightendtime"></span> <br> <br>
									<div style="font-size: 18px;">브래이크 시간 및 종료</div>
									<span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhbreaktime"></span> ~ <span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhbreakendtime"></span> <br> <br>
									<div style="font-size: 18px;">공휴일 진료여부 및 종료</div>
									<span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhholiday"></span> / <span
										style="font-weight: bold; font-size: 14px; text-align: right;"
										id="data-rhholidayendtime"></span>
								</div>
							</div>
							<div style="margin-top: 10px;" class="line"></div>
							<div class="modal-footer view-footer">
								<form action="/admin/newHosDoc" method="POST">
									<input type="hidden" id="approve" name="rhno" value="" />
									<button type="submit" class="dhBtn" id="confirm">승인</button>
								</form>
								<button type="button" class="dhBtn" id="cancel">삭제</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div style="height: 9vh"></div>
	</main>
	<footer> </footer>
</body>
</html>
