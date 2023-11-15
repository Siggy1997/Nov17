<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>search</title>
<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">
<link rel="stylesheet" href="./css/telehealthSearch.css">
<script src="./js/jquery-3.7.0.min.js"></script> 
<script src="./js/wnInterface.js"></script>
<script src="./js/mcore.min.js"></script>
<script src="./js/mcore.extends.js"></script>
<script type="text/javascript">
	window.onload = function() {
	    document.getElementById('keyword').focus();
	};
	
	$(function(){
		
		/* 뒤로가기 버튼 */
		$(document).on("click", ".xi-angle-left", function(){
			location.href = '/main';
		});
		
		/* 최근 검색어 가져오기 */
		let storageKeyword = M.data.storage("recentKeyword");
		alert("처음 저장된 검색어 : " + M.data.storage("recentKeyword"));
		
		/* 최근 검색어 키워드 넣기 */
		if ( M.data.storage("recentKeyword") == null ) {
			$(".searchRecentItems").html('');
		} else {
			let stringArray = separationString(storageKeyword);
			let searchRecentItems = '';
			for(let item of stringArray) {
				searchRecentItems += '<div class="recentItemBox"><button class="recentItem">' + item + '</button><div class="deleteKeyword"><i class="xi-close-min"></i></div></div>';
			}
			$(".searchRecentItems").html(searchRecentItems);
		}

		/* 최근 검색어 전체 삭제 */
		$(".searchDelete").click(function(){
			M.data.removeStorage("recentKeyword");
			alert("검색어 전체 삭제 : " + M.data.storage("recentKeyword"));
			$(".searchRecentItems").html('');
		});
		
		/* 검색 */
		$(".recommendItem, .recommendRandomItem, .recentItem").click(function(){
		    let keyword = $(this).text();
		    $('#keyword').val(keyword);
		});

	});
	
	$(document).on("submit", "#searchForm", function(){
		let searchKeyword = $("#keyword").val();
		alert(searchKeyword);
		if ( M.data.storage("recentKeyword") != null ) {
			let combine = M.data.storage("recentKeyword") + "," + searchKeyword;
			alert(combine);
			M.data.storage("recentKeyword", combine);
			alert("저장된 검색어가 널이 아닐 때 저장 후 : " + M.data.storage("recentKeyword"));
		} else {
			M.data.storage("recentKeyword", searchKeyword);
			alert("저장된 검색어가 널일 때 저장: " + storageKeyword);
		}
	});
	
	/* 쿠키 한개 삭제 */
	$(document).on("click", ".deleteKeyword", function(){
		let deleteKeyword = $(this).siblings().text();
		let allCookieArray = separationString(storageKeyword);// 스트링 -> 배열
		let deleteCookieArray = allCookieArray.filter(item => item !== deleteKeyword);// 삭제하고 다시 배열
		let newCookie = deleteCookieArray.join(",");// 새로운 배열
		M.data.storage("recentKeyword", newCookie);
		alert("쿠키 한 개 삭제할 때" + storageKeyword);
		$(this).parent().html('');
	});
	
	/* 입력할 때 내용 지우기 */
	if ($("#keyword").val() !== '') {
		$(".icon").addClass("xi-close-circle");
	} else {
		$(".icon").removeClass("xi-close-circle");
	}
	$(document).on("input", "#keyword", function(){
		if ($("#keyword").val() !== '') {
			$(".icon").addClass("xi-close-circle");
		} else {
			$(".icon").removeClass("xi-close-circle");
		}
	});
	$(document).on("click", ".deleteSearch", function(){
		$(".icon").removeClass("xi-close-circle");
		$("#keyword").val('').focus();
	});
	
	/* 쿠키 저장하기 */
	function setCookie(cookieName, cookieValue, exdays){
		
		let existingCookie = getCookie(cookieName);
		/* 쿠키 배열로 바꾸기 */
		let arrayCookie = separationString(existingCookie);
		let exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);

		/* 중복값 제거하고 추가하기 */
		if ( !(arrayCookie.includes(cookieValue)) ) {
			arrayCookie.push(cookieValue);
			let newCookie = arrayCookie.join(",");
	        let value = newCookie + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
	        document.cookie = cookieName + "=" + value;
	    }
	}
	
	/* 쿠키 한개 삭제하기 */
	function deleteCookie(deleteCookieName, cookieName, exdays) {
		let exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		let allCookie = getCookie(cookieName);// 모든 쿠키 뽑기
		let allCookieArray = separationString(allCookie);// 스트링 -> 배열
		let deleteCookieArray = allCookieArray.filter(item => item !== deleteCookieName);// 삭제하고 다시 배열
		let newCookie = deleteCookieArray.join(",");// 새로운 배열
	    document.cookie = cookieName + "=" + newCookie + "; expires=" + exdate.toUTCString();
	}
	
	/* 쿠기 전체 삭제하기 */
	function deleteAllCookie(cookieName) {
	    var exdate = new Date(0);
	    document.cookie = cookieName + "=; expires=" + exdate.toUTCString();
	}
	
	/* 쿠키 가져오기 */
	function getCookie(cookieName) {
	    let x, y;
	    let val = document.cookie.split(";");
	    for (let i = 0; i < val.length; i++) {
	        x = val[i].substr(0, val[i].indexOf("="));
	        y = val[i].substr(val[i].indexOf("=") + 1);
	        x = x.trim();
	        if (x === cookieName) {
	            return decodeURIComponent(y);
		    }
		}
	}
	
	/* String 잘라서 배열로 만들기 */
	function separationString(stringList) {
	    if (stringList) {
	        return stringList.split(",").map(function(item) {
	            return item.trim();
	        });
	    } else {
	        return [];
	    }
	}
</script>

</head>
<body>
	<form id="searchForm" action="/search" method="post">
	<header>
		<i class="xi-angle-left xi-x"></i>
		<div class="headerTitle">병원 검색</div>
		<div class="blank"></div>
	</header>
	
	<main class="searchBox container">
		
			<!-- search -->
			<div class="search">
				<div class="searchInput">
					<input placeholder="진료과, 증상, 병원을 검색하세요." name="keyword" id="keyword">
					<div class="deleteSearch">
						<i class="icon"></i>
					</div>
				</div>
				<button class="searchButton"><img src="./img/search.png"></button>
			</div>
			
			<div class="serachItem">
				<!-- 최근 검색 -->
				<div class="searchRecent">
					<div class="titleSection">
						<div class="searchTitle">최근 검색</div>
						<div class="searchDelete">전체삭제</div>
					</div>
					<div class="searchRecentItems">
						<div class="recentItemBox">
							<button class="recentItem"></button>
							<div class="deleteKeyword"><i class="xi-close-min"></i></div>
						</div>
					</div>
				</div>
				<!-- 추천 검색어 -->
				<div class="searchRecommend">
					<div class="searchTitle">추천 검색어</div>
					<div class="searchRecommendItems">
						<button class="recommendItem">전문의</button>
						<button class="recommendItem">야간진료</button>
						<button class="recommendItem">여의사</button>
						<button class="recommendItem">휴일진료</button>
						<!-- 추가하기 -->
						<c:forEach items="${randomKeyword}" var="row">
							<button class="recommendRandomItem">${row}</button>
						</c:forEach>
					</div>
				</div>
			</div>
	</main>
		</form>
	
</body>
</html>