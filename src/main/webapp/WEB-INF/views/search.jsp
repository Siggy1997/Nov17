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
<script src="./js/jquery-3.7.0.min.js"></script> 

<script type="text/javascript">
	window.onload = function() {
	    document.getElementById('keyword').focus();
	};
	
	$(function(){
		let recentKeywordCookies = getCookie("recentKeyword");
		if (recentKeywordCookies == null) {
			$(".searchRecentItems").html('');
		} else {
			let stringArray = separationString(recentKeywordCookies);
			let searchRecentItems = '';
			for(let item of stringArray) {
				searchRecentItems += '<div class="recentItemBox"><button class="recentItem">' + item + '</button><div class="xi-close-min"></div></div>';
			}
			$(".searchRecentItems").html(searchRecentItems);
		}
		
		$(".searchDelete").click(function(){
			deleteAllCookie("recentKeyword");
			$(".searchRecentItems").html('');
		});
		
		$(".recommendItem").click(function(){
			let keyword = $(this).text();
			$('#keyword').val(keyword);
		})
		
		$(".recommendRandomItem").click(function(){
			let keyword = $(this).text();
			$('#keyword').val(keyword);
		})
		
		$(".recentItem").click(function(){
			let keyword = $(this).text();
			$('#keyword').val(keyword);
		})
	});
	
	$(document).on("submit", "#searchForm", function(){
		let recentKeyword = $("#keyword").val();
		setCookie("recentKeyword", recentKeyword, 30);
	});
	
	$(document).on("click", ".xi-close-min", function(){
		let deleteKeyword = $(this).siblings().text();
		deleteCookie(deleteKeyword, "recentKeyword", 30);
		$(this).parent().html('');
	});
	
	
	// 쿠키 저장하기
	function setCookie(cookieName, cookieValue, exdays){
		
		let existingCookie = getCookie(cookieName);
		// 쿠키 배열로 바꾸기
		let arrayCookie = separationString(existingCookie);
		let exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);

		// 중복값 제거하고 추가하기
		if ( !(arrayCookie.includes(cookieValue)) ) {
			arrayCookie.push(cookieValue);
			let newCookie = arrayCookie.join(",");
	        let value = newCookie + ((exdays == null) ? "" : "; expires=" + exdate.toUTCString());
	        document.cookie = cookieName + "=" + value;
	    }
	}
	
	// 쿠키 한개 삭제하기
	function deleteCookie(deleteCookieName, cookieName, exdays) {
		let exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		let allCookie = getCookie(cookieName);// 모든 쿠키 뽑기
		let allCookieArray = separationString(allCookie);// 스트링 -> 배열
		let deleteCookieArray = allCookieArray.filter(item => item !== deleteCookieName);// 삭제하고 다시 배열
		let newCookie = deleteCookieArray.join(",");// 새로운 배열
	    document.cookie = cookieName + "=" + newCookie + "; expires=" + exdate.toUTCString();
	}
	
	// 쿠기 전체 삭제하기
	function deleteAllCookie(cookieName) {
	    var exdate = new Date(0);
	    document.cookie = cookieName + "=; expires=" + exdate.toUTCString();
	}
	
	// 쿠키 가져오기
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
	
	// String 잘라서 배열로 만들기
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
	<h1>search</h1>
	<div class="searchBox">
		<form id="searchForm" action="/search" method="post">
			<div class="searchHospital">
				<div class="xi-angle-left"></div>
				<input placeholder="질병, 진료과, 병원을 검색하세요." name="keyword" id="keyword">
				<button class="xi-search"></button>
			</div>
			<div class="serachItem">
				<!-- 최근 검색 -->
				<div class="searchRecent">
					<div class="searchTitle">최근 검색</div>
					<div class="searchDelete">전체삭제</div>
					<div class="searchRecentItems">
						<div class="recentItemBox">
							<button class="recentItem"></button>
							<div class="xi-close-min"></div>
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
						<button class="recommendItem">공휴일 진료</button>
						<!-- 추가하기 -->
						<c:forEach items="${randomKeyword}" var="row">
							<button class="recommendRandomItem">${row}</button>
						</c:forEach>
					</div>
				</div>
			</div>
		</form>
	</div>
	
</body>
</html>