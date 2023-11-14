<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="./css/hospitalMap.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="./js/wnInterface.js"></script>
<script src="./js/mcore.min.js"></script>
<script src="./js/mcore.extends.js"></script>
<script src="/js/jquery.plugin.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">



<title>Insert title here</title>

  <style>

/* 기본 틀 */
* {
	font-family: "Pretendard Variable";
	box-sizing: border-box;
	margin: 0;
	padding: 0;
}

body {
	background-color: white;
	overflow: auto
}

header {
	position: fixed;
	height: 8vh;
	display: flex;
	justify-content: space-between;
	width: 100%;
	align-items: center;
	z-index: 1000;
	background-color: white;
	padding-inline-end: 22px;
	padding-inline-start: 24px;
}

.xi-angle-left, .xi-angle-right {
	color: #757575;
}

.headerTitle {
	font-family: "NanumSquare" !important;
	font-size: 18px;
	text-align: center;
	font-weight: 900;
	margin: 20px 50px;
}

footer {
	bottom: 0;
	position: fixed;
	height: 9vh;
	width: 100%;
	z-index: 1000;
	background-color: white;
}

main {
	padding-top: 9vh;
}

.blank {
	width: 21px;
}

.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {
    position: relative;
    width: 100%;
    height: 100%; 
    
  }

#infoDiv a {
    color: black;
}

/* 애니메이션 정의 */
@keyframes slideInFromBottom {
    0% {
        transform: translateY(100%);
        opacity: 0;
    }
    100% {
        transform: translateY(0);
        opacity: 1;
    }
}

/* 애니메이션 적용 */
#infoDiv {
    /* 기본 스타일 설정 */
    position: fixed;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 300px;
    background-color: white;
    z-index: 1000;
    overflow: hidden;
    
    /* 애니메이션 설정 */
    animation: slideInFromBottom 0.3s ease-in-out;
}


     .wrap {overflow: hidden;}
     .info .title {position: absolute;margin: 5px 0 0 100px; bottom:62%;}
  .info .desc {position: absolute;margin: 5px 0 0 100px; bottom:30%;}
      .info .img {position: absolute; left: 5%;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden; bottom:30%;}
  .info .status {position: absolute;margin: 10px 10px 0 250px; bottom:30%;}
  
#searchInput {
  position: absolute;
    top: 22%;
    left: 13%;
    width: 255px;
    height: 37px;
    padding: 5px;
    z-index: 1000; 
    	background: rgba(217, 217, 217, 0.3);
	border-radius: 5px;
		border: none;
	box-shadow: none;
}

#searchButton {
	float: right;
    width: 50px;
    height: 37px;
    padding: 2%;
    margin: 2%;
    	background-color: #00C9FF;
	color: white;
	border-radius: 5px;
	border: none;
	box-shadow: none;
	font-weight: bold;
  
}

#searchResults {
    position: absolute;
    top: -5px;
    left: 0px;
    width: 100%;
    list-style: none;
    padding: 0;
    margin: 0;
    background-color: white;
    border: 1px solid lightgrey;
    display: none;
    max-height: 200px;
    overflow-y: auto;
    z-index: 1000; 
}

 
     #map {
    width: 100%;
    height: 800px;
    position: absolute;
    top: 0;
    left: 0;
    z-index: 1; 
}

#currentLocation {
 position: absolute;
    bottom: 30px;
    left: 3%;
    z-index: 1000;
width: 50px;
height: 50px;
background: #FFFFFF;
box-shadow: 2px 2px 2px rgba(0, 0, 0, 0.25);
border-radius: 50%; 
border-color: lightgrey;
}
        
</style>

</head>
<body>

<header>
    <div class="xi-angle-left xi-x"></div>
 
    <div id="searchContainer">
        <input type="text" id="searchInput" placeholder="병원 이름 검색">
        <button id="searchButton">검색</button>
    </div>
</header>
<main>


 

 <button onclick="refreshPage()" id="currentLocation" class="xi-gps xi-x"></button>
 
<div class="map_wrap">
    <div id="map"></div>
<ul id="searchResults"></ul>   
</div>

</main>
</body>

<script>

function refreshPage() {
   
    location.reload();
    var currentLocationButton = document.getElementById('currentLocation');
    currentLocationButton.style.bottom = '30px'; 
}

    var newDiv = document.createElement("div");

    newDiv.id = "infoDiv";
    newDiv.textContent = "";
    newDiv.style.border = "1px solid lightgrey";
    newDiv.style.padding = "10px";
    newDiv.style.position = "absolute";
    newDiv.style.bottom = "-7px"; 
    newDiv.style.left = "0px"; 
    newDiv.style.zIndex = "1000"; // 맵보다 위에 위치하도록 설정
    newDiv.style.backgroundColor = "#fff"; 
    newDiv.style.width = "100%"; 
    newDiv.style.height = "150px";
    newDiv.style.boxShadow = "0px 4px 4px rgba(0, 0, 0, 0.25)";
    newDiv.style.borderRadius = "20px";
 
    
    
    // body의 맨 뒤에 동적으로 생성한 div 추가
    document.body.appendChild(newDiv);
</script>


	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e6cca959046a32e36bfd9340bd8485&libraries=services"></script>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e6cca959046a32e36bfd9340bd8485"></script>





<script>
var map; // map 변수를 전역 범위에서 정의

document.addEventListener("DOMContentLoaded", function () {
    var dynamicContainer = document.getElementById("infoDiv");
    dynamicContainer.style.display = 'none';
});

(function () {
	
    $(function () {
    	
      $.getCurrentLocation().then((result) => {
        if (result.status === 'NS') {
          console.log('This Location Plugin is not supported');
         
        } else if (result.status !== 'SUCCESS') {
        
          if (result.message) {
              
        	  console.log(result.status + ':' + result.message);
              initializeMap(37.498599, 127.028575); // 기본 중심 좌표
       
          } else {
            console.log('Getting GPS coords is failed');
           
          }
        } else {
   
          if (result.coords) {
        	  
            var { latitude, longitude } = result.coords;
            var lat = parseFloat(latitude);
            var lon = parseFloat(longitude);
            console.log(lat, lon);
            initializeMap(lat, lon); // 현재 위치의 중심 좌표
           
            var circle;

         // 원을 그리는 함수
            function drawCircle() {
                var currentLevel = map.getLevel();
                // 확대 레벨에 따라 반지름을 조절
                var radius = Math.pow(2, currentLevel - 2) * 10;

                if (circle) {
                    circle.setMap(null);
                }

                circle = new kakao.maps.Circle({
                    center: new kakao.maps.LatLng(lat, lon),
                    radius: radius,
                    strokeWeight: 2,
                    strokeColor: 'skyblue',
                    strokeOpacity: 0.7,
                    fillColor: 'skyblue',
                    fillOpacity: 0.3
                });

                circle.setMap(map);
            }

           
            drawCircle();

            kakao.maps.event.addListener(map, 'zoom_changed', function() {
                drawCircle();
            });
           
          } else {
            console.log("It cann't get GPS Coords.");
          }
        }
      });
    });
   
   
   
 // 지도 초기화
    function initializeMap(centerLat, centerLon) {
        var mapContainer = document.getElementById('map'); 
        var mapOption = {
            center: new kakao.maps.LatLng(centerLat, centerLon), // 지도의 중심좌표
            level: 5 
        };

        // 지도
        map = new kakao.maps.Map(mapContainer, mapOption);


        // 장소의 상세정보
        var placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
            contentNode = document.createElement('div'),
            markers = [],
            currCategory = ''; 

        // 주소-좌표 변환 객체
        var geocoder = new kakao.maps.services.Geocoder();
        var hospitals = [];

        var overlay = new kakao.maps.CustomOverlay({
            content: contentNode,
            map: map
        });


        <c:forEach items="${hospitalList}" var="h">
        	var hospitalNumber = "${h.hno}";
            var title = "${h.hname}";
            var address = "${h.haddr}";
            var opentime = "${h.hopentime}";
            var closetime = "${h.hclosetime}";
            var nightday = "${h.hnightday}";
            var nightendtime = "${h.hnightendtime}";
            var hImg = "${h.himg}";
            var hBreakTime = "${h.hbreaktime}";
            var hBreakEndTime = "${h.hbreakendtime}";
            var hHoliday = "${h.hholiday}";
            var hHolidayEndTime = "${h.hholidayendtime}";

           
           
            hospitals.push({
            	hospitalNumber: hospitalNumber,
                title: title,
                address: address,
                opentime: opentime,
                closetime: closetime,
                nightday: nightday,
                nightendtime: nightendtime,
                hImg: hImg,
                hBreakTime: hBreakTime,
                hBreakEndTime: hBreakEndTime,
                hHoliday : hHoliday,
                hHolidayEndTime : hHolidayEndTime
            });
        </c:forEach>
        
        

     // 클릭 이벤트
        document.addEventListener('click', function (event) {
            if (event.target.closest('#searchResults') || event.target.closest('#searchButton')) {
                return;
            }


            if (searchResults.style.display === 'block') {
                searchResults.style.display = 'none';
            }
        });
        
        
        

        var searchButton = document.getElementById('searchButton');

     // 검색 버튼 클릭
        searchButton.addEventListener('click', function () {
            // 검색어 가져오기
            var keyword = searchInput.value.trim();

            // 결과 리스트 초기화
            searchResults.innerHTML = '';

            // 검색어가 비어있으면 아무 작업도 수행하지 않음
            if (!keyword) {
                return;
            }

            // 병원 데이터를 순회하면서 검색어와 일치하는 항목 찾기
            hospitals.forEach(function (hospital) {
                if (hospital.title.includes(keyword)) {
                    // 검색어가 일치하는 경우 결과 리스트에 추가
                    var listItem = document.createElement('li');
                    listItem.textContent = hospital.title;

                 // 클릭하면 해당 병원을 지도에 표시
                    listItem.addEventListener('click', function () {
                        // 주소로 좌표 검색
                        geocoder.addressSearch(hospital.address, function (result, status) {
                            
                            if (status === kakao.maps.services.Status.OK) {
                                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                                // 병원 좌표로 이동
                                map.panTo(coords);

                             // 해당 병원에 대한 마커를 찾아서 클릭한 것처럼 보이도록 설정
                                simulateMarkerClick(hospital);
                            }
                        });
                    });
                 
                 // 리스트 아이템에 간격 추가
                   listItem.style.marginTop = '5px';
                   listItem.style.marginBottom = '5px';
                    listItem.style.fontSize = '16px';
                    listItem.style.borderBottom = '1px solid lightgray'; 
                    listItem.style.padding = '2%';

                 
                    // 리스트 아이템을 결과 리스트에 추가
                    searchResults.appendChild(listItem);
                }
            });

            // 검색 결과가 있을 때만 결과 리스트를 보이도록 설정
            if (searchResults.children.length > 0) {
                searchResults.style.display = 'block';
            } else {
                searchResults.style.display = 'none';
            }
        });


        function timeToMinutes(time) {
            const parts = time.split(":");
            if (parts.length === 2) {
                const hours = parseInt(parts[0], 10);
                const minutes = parseInt(parts[1], 10);
                return hours * 60 + minutes;
            }
            return 0; // 예외 처리
        }

        function checkBusinessStatus(opentime, closetime, nightday, nightendtime, hHoliday, hHolidayEndTime) {
            const now = new Date();
            const currentDay = now.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
            const currentTime = now.getHours() * 60 + now.getMinutes(); 

            const openMinutes = timeToMinutes(opentime);
            const closeMinutes = timeToMinutes(closetime);
            const nightEndMinutes = timeToMinutes(nightendtime);
            const holidayEndMinutes = timeToMinutes(hHolidayEndTime);

           
            if(currentDay == 0 || currentDay == 6) {
            	if(hHoliday == 1){   		
            		if (currentTime >= openMinutes && currentTime <= holidayEndMinutes) {
                     return "진료중";        
                 } else {
              
                     return "진료종료";
                 }

            	} else {    		
            		 return "휴진일";
            	}
            	
            } else {          	
            	if(currentTime >= hBreakTime && currentTime <= hBreakEndTime){
                    return "점심시간";        
                } else {

                	 if (nightday == currentDay) {
                         if (currentTime >= openMinutes && currentTime <= nightEndMinutes) {
                             return "진료중";        
                         } else {
                             return "진료종료";
                         }
                     } else {
                         if (currentTime >= openMinutes && currentTime <= closeMinutes) {
                             return "진료중";
                         } else { 
                             return "진료종료";
                         }
                     }  
                }
          
            }
        }


        function handleMarkerClick(position) {

            var hospitalNumber = position.hospitalNumber;
            var title = position.title;
            var address = position.address;
            var opentime = position.opentime;
            var closetime = position.closetime;
            var nightendtime = position.nightendtime;
            var nightday = position.nightday;
            var hImg = position.hImg;
            var hBreakTime = position.hBreakTime;
            var hBreakEndTime = position.hBreakEndTime;
            var hHoliday = position.hHoliday;
            var hHolidayEndTime = position.hHolidayEndTime;

            const currentDay = new Date().getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일

            // 영업 상태를 확인
            var status = checkBusinessStatus(opentime, closetime, nightday, nightendtime, hHoliday, hHolidayEndTime);

            // 컨테이너에 정보 추가
            var dynamicContainer = document.getElementById("infoDiv");
            dynamicContainer.innerHTML =
                '<div class="wrap">' +
                '    <div class="info"><a href="http://172.30.1.61/hospitalDetail/' + hospitalNumber + '" target="_blank" class="link">' +
                '        <div class="title">' +
                '            ' + title +
                '        </div>' +
                '        <div class="body">' +
                '            <div class="img">' +
                '                <img src="' + hImg + '" width="73" height="70">' +
                '           </div>' +
                '            <div class="desc">' +
                '                <div class="ellipsis">' + address + '</div>' +
                '                <div class="time">' + opentime + "~" + (nightday == currentDay ? nightendtime : closetime) + '</div>' +
                '            </div>' +
                '                <div class="status">' + status + '</div>' +
                '        </div>' +
                '    </a></div>' +
                '</div>';


            // 컨테이너를 표시
            dynamicContainer.style.display = 'block';
            
            var currentLocationButton = document.getElementById('currentLocation');
            currentLocationButton.style.bottom = '160px';
        }
        
     // 해당 병원에 대한 마커를 찾아서 클릭한 것처럼 보이도록 설정하는 부분
        function simulateMarkerClick(hospital) {
            hospitals.forEach(function (hospitalMarker) {
                if (hospitalMarker.title === hospital.title) {
                    // 마커 클릭 이벤트를 트리거
                    kakao.maps.event.trigger(hospitalMarker.marker, 'click');

                    handleMarkerClick(hospital);
                }
            });
        }
        

        hospitals.forEach(function (position) {
            // 주소로 좌표 검색
            geocoder.addressSearch(position.address, function (result, status) {
                // 검색 완료
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    

                    var imageSrc = '/img/hospitalMarker.png', // 마커이미지의 주소입니다    
                        imageSize = new kakao.maps.Size(32, 34.5), // 마커이미지의 크기입니다
                        imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
           
                    
                 // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
                 
                    
                    // 위치 마커로 표시
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords,
                        image: markerImage
                    });

                    

                    // 마커 클릭
                    kakao.maps.event.addListener(marker, 'click', function () {
                        handleMarkerClick(position);
                    });


                    // 지도를 클릭했을 때 컨테이너 숨김
                    kakao.maps.event.addListener(map, 'click', function (mouseEvent) {
                        
                        if (!mouseEvent.target || !mouseEvent.target.toString().includes('Marker')) {
                            var dynamicContainer = document.getElementById("infoDiv");
                            dynamicContainer.style.display = 'none';
                            
                            var currentLocationButton = document.getElementById('currentLocation');
                            currentLocationButton.style.bottom = '30px'; 
                        }
                    });
                    
              
                }
            });
        });
    }
   
   
   
  })();



 
</script>




</html>