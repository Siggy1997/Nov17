<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1, width=device-width, user-scalable=no"/> 
<link rel="stylesheet" href="./css/pharmacyMap.css">

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="./js/wnInterface.js"></script>
<script src="./js/mcore.min.js"></script>
<script src="./js/mcore.extends.js"></script>
<script src="/js/jquery.plugin.js"></script>
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/xeicon@2.3.3/xeicon.min.css">



<title>Insert title here</title>

<style>
</style>

</head>
<body>

	<header>
		 <i class="xi-angle-left xi-x" onclick="location.href = '/main'"></i>

		<div id="searchContainer">
			<input type="text" id="searchInput" placeholder="약국 이름 검색">
			<button id="searchButton">검색</button>
		</div>
	</header>
	<main>



		<button onclick="location.href='/hospitalMap';" id="hospitalMap">
			병원<br>지도
		</button>


		<button onclick="refreshPage()" id="currentLocation"
			class="xi-gps xi-x"></button>

		<div class="map_wrap">
			<div id="map"></div>
			<ul id="searchResults"></ul>
		</div>

		<div style="height: 9vh"></div>
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



<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e6cca959046a32e36bfd9340bd8485&libraries=services"></script>
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
              // gps off
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
        var pharmacies = [];

        var overlay = new kakao.maps.CustomOverlay({
            content: contentNode,
            map: map
        });


        <c:forEach items="${pharmacyList}" var="p">
        	var pharmacyNumber = "${p.pno}";
            var title = "${p.pname}";
            var address = "${p.paddr}";
            var opentime = "${p.popentime}";
            var closetime = "${p.pclosetime}";
           
           
            pharmacies.push({
            	pharmacyNumber: pharmacyNumber,
                title: title,
                address: address,
                opentime: opentime,
                closetime: closetime,
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


            pharmacies.forEach(function (pharmacy) {
                if (pharmacy.title.includes(keyword)) {
                    // 검색어가 일치하는 경우 결과 리스트에 추가
                    var listItem = document.createElement('li');
                    listItem.textContent = pharmacy.title;

                    listItem.addEventListener('click', function () {
                        // 주소로 좌표 검색
                        geocoder.addressSearch(pharmacy.address, function (result, status) {
                            
                            if (status === kakao.maps.services.Status.OK) {
                                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);


                                map.panTo(coords);

  
                                simulateMarkerClick(pharmacy);
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

        function checkBusinessStatus(opentime, closetime) {
            const now = new Date();
            const currentDay = now.getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
            const currentTime = now.getHours() * 60 + now.getMinutes(); 

            const openMinutes = timeToMinutes(opentime);
            const closeMinutes = timeToMinutes(closetime);
          

           
            if(currentDay == 0 || currentDay == 6) {
            
            		 return "휴업일";

            } else {          	
            	
                         if (currentTime >= openMinutes && currentTime <= closeMinutes) {
                             return "영업중";
                         } else { 
                             return "영업종료";
                         }
                  } 

        }


        function handleMarkerClick(position) {

            var pharmacyNumber = position.pharmacyNumber;
            var title = position.title;
            var address = position.address;
            var opentime = position.opentime;
            var closetime = position.closetime;
           

            const currentDay = new Date().getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일

            var status = checkBusinessStatus(opentime, closetime);

            var dotClass = "";

            if (status === "영업중") {
                dotClass = "availableDot";
            } else if (status === "영업종료" || status === "휴업일") {
                dotClass = "unavailableDot";
            }
            
            var dynamicContainer = document.getElementById("infoDiv");
            dynamicContainer.innerHTML =
                '<div class="wrap">' +
                '    <div class="info">' +
                '        <div class="title">' +
                '            ' + title +
                '        </div>' +
                '        <div class="body">' +
                '            <div class="desc">' +
                '                <div class="ellipsis">' + address + '</div>' +
                '                <div class="time">' + opentime + "~" + closetime + '</div>' +
                '            </div>' +
                '            <div class="' + dotClass + '">' + "●" + '</div>' +
                '                <div class="status">' + status + '</div>' +
                '        </div>' +
                '   </div>' +       
                '</div>';


            // 컨테이너를 표시
            dynamicContainer.style.display = 'block';
             
            var currentLocationButton = document.getElementById('currentLocation');
            currentLocationButton.style.bottom = '160px';
        }
        
     // 마커를 찾아서 클릭한 것처럼
        function simulateMarkerClick(pharmacy) {
        	pharmacies.forEach(function (pharmacyMarker) {
                if (pharmacyMarker.title === pharmacy.title) {
                    // 마커 클릭 이벤트
                    kakao.maps.event.trigger(pharmacyMarker.marker, 'click');

                    handleMarkerClick(pharmacy);
                }
            });
        }
        

        pharmacies.forEach(function (position) {
            // 주소로 좌표 검색
            geocoder.addressSearch(position.address, function (result, status) {
                // 검색 완료
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    

                    var imageSrc = '/img/pharmacyMarker.png',     
                        imageSize = new kakao.maps.Size(32, 37), 
                        imageOption = {offset: new kakao.maps.Point(30, 30)}; 
           
                    
                    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
                 
                    
                    // 위치 마커
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