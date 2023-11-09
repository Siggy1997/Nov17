<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script src="../js/jquery-3.7.0.min.js"></script>
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />
<script
	src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>
</head>
<body>


	<header> icon icon </header>

	<div class="advertisment">

		<div class="swiper">
			<!-- Additional required wrapper -->
			<div class="swiper-wrapper">
				<!-- Slides -->
				<img class="swiper-slide" alt=""
					src="https://www.applovin.com/wp-content/uploads/2021/10/1440x810-in-app_advertising.jpeg">
				<img class="swiper-slide" alt=""
					src="https://www.applovin.com/wp-content/uploads/2022/07/1440x810_MAX_FB_Banner_ads-1440x810-1.jpg">
			</div>
		</div>


	</div>

	<div id="mainSearch">
		<i class="xi-search xi-x"></i>
		<div>질병, 진료과, 병원을 검색하세요</div>
	</div>

	<!-- 본문내용 -->
	<div class="container">

		<!-- 메뉴제일 상단 -->
		<div class="section" id="mainQuickSlot">
			<a class="mainTop" href="./hopital"> <img alt="병원사진"
				src="https://cdn2.iconfinder.com/data/icons/cornavirus-covid-19/64/_hospital_building_medical_healthcare_real_estate-512.png">
				<p>병원 예약</p>
			</a> <a class="mainTop" href="./hopital"> <img alt="비대면 사진"
				src="https://cdn2.iconfinder.com/data/icons/coronavirus-information/128/coronovirus_call_doctor_hospital-512.png">
				<p>비대면 진료</p>
			</a> <a class="mainTop" href="./hopital"> <img alt="주변 인기 병원"
				src="https://cdn4.iconfinder.com/data/icons/navigation-98/512/21_Location_map_pin_mark_navigation-512.png">
				<p>주변 인기 병원</p>
			</a> <a class="mainTop" href="./hopital"> <img alt="커뮤니티"
				src="https://cdn0.iconfinder.com/data/icons/business-startup-10/50/61-512.png">
				<p>커뮤니티</p>
			</a>
		</div>

		<div class="graySeperate"></div>

		<!-- 진료과별 -->
		<div class="section" id="selectDepartment">
			<div class="mainTitle">
				진료과별 <i class="xi-angle-right xi-x"></i>
			</div>
			<div id="departmentWrapper">
				<a href="./hopital?kindKeyword=소아과"> <img alt="소아과"
					src="https://cdn0.iconfinder.com/data/icons/business-startup-10/50/61-512.png">
					<span>소아과</span>
				</a> <a href="./hopital?kindKeyword=이비인후과"> <img alt="이비인후과"
					src="https://cdn0.iconfinder.com/data/icons/business-startup-10/50/61-512.png">
					<span>이비인후과</span>
				</a> <a href="./hopital?kindKeyword=피부과"> <img alt="피부과"
					src="https://cdn0.iconfinder.com/data/icons/business-startup-10/50/61-512.png">
					<span>피부과</span>
				</a> <a href="./hopital?kindKeyword=산부인과"> <img alt="산부인과"
					src="https://cdn0.iconfinder.com/data/icons/business-startup-10/50/61-512.png">
					<span>산부인과</span>
				</a>
			</div>

			<div>
				
			</div>

		</div>
		<div class="graySeperate"></div>


		<a href="./hospitalDetail/1">ㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇㅇ</a> <a href="./chatting">111111111111111ㅇㅇ</a>
		<a href="./login">111111111111111ㅇㅇ</a>
  


	</div>


	<script type="text/javascript">
		//스와이퍼 시작
		const swiper = new Swiper('.swiper', {
			// Optional parameters
			direction : 'horizontal',
			loop : true,
			autoplay : {
				delay : 2000, // 3초마다 변경
			},

		});
	</script>


</body>
</html>