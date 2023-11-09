<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="./js/wnInterface.js"></script>
<script src="./js/mcore.min.js"></script>
<script src="./js/mcore.extends.js"></script>
<script src="/js/jquery.plugin.js"></script>



<title>Insert title here</title>

  <style>

.map_wrap, .map_wrap * {margin:0; padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap {position:relative;width:100%;height:350px;}

.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
 	
 	

 	

      .map_wrap {
            position: relative;
            width: 100%;
            height: 700px;
            overflow: hidden;
        }

        #map {
            width: 100%;
            height: 700px;
            position: absolute;
            top: 0;
            left: 0;
        }
</style>

</head>
<body>



<div class="map_wrap">
    <div id="map"></div>
</div>



<script>
    // 자바스크립트로 div 생성
    var newDiv = document.createElement("div");

    // div 속성 설정
    newDiv.id = "myDynamicDiv";
    newDiv.textContent = "This is a dynamic div!";
    newDiv.style.border = "1px solid black";
    newDiv.style.padding = "10px";
    newDiv.style.position = "absolute"; // 위치를 절대값으로 설정
    newDiv.style.bottom = "0px"; 
    newDiv.style.left = "0px"; // 페이지 상단으로부터 20px 아래에 위치
    newDiv.style.zIndex = "1000"; // 맵보다 위에 위치하도록 설정
    newDiv.style.backgroundColor = "#fff"; // 흰색 배경
    newDiv.style.width = "400px"; // 고정된 가로 크기
    newDiv.style.height = "150px"; // 고정된 세로 크기

    // body의 맨 뒤에 동적으로 생성한 div 추가
    document.body.appendChild(newDiv);
</script>

</body>
	
	<!--실제 지도를 그리는 javascript API를 불러오기-->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e6cca959046a32e36bfd9340bd8485&libraries=services"></script>
		<script type="text/javascript"
			src="//dapi.kakao.com/v2/maps/sdk.js?appkey=80e6cca959046a32e36bfd9340bd8485"></script>





<script>
var map; // map 변수를 전역 범위에서 정의

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

            // 지도의 확대 수준이 변경될 때마다 원의 크기를 조절
            kakao.maps.event.addListener(map, 'zoom_changed', function() {
                var currentLevel = map.getLevel();
                // 확대 레벨에 따라 반지름을 조절 (예시에서는 확대 레벨에 따라 반지름이 50에서 2000까지 변경)
                var radius = Math.pow(2, currentLevel - 3) * 10;

                // 기존의 원을 제거
                if (circle) {
                    circle.setMap(null);
                }

                circle = new kakao.maps.Circle({
                    center: new kakao.maps.LatLng(lat, lon),
                    radius: radius,
                    strokeWeight: 5,
                    strokeColor: '#FF0000',
                    strokeOpacity: 0.7,
                    fillColor: '#FF0000',
                    fillOpacity: 0.3
                });

                circle.setMap(map);
            });
           
           
          } else {
            console.log("It cann't get GPS Coords.");
          }
        }
      });
    });
   
   
   
 // 지도 초기화 함수
    function initializeMap(centerLat, centerLon) {
        var mapContainer = document.getElementById('map'); // 지도를 표시할 div
        var mapOption = {
            center: new kakao.maps.LatLng(centerLat, centerLon), // 지도의 중심좌표
            level: 5 // 지도의 확대 레벨
        };

        // 지도를 표시할 div와 지도 옵션으로 지도를 생성합니다
        map = new kakao.maps.Map(mapContainer, mapOption);


        //마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다
        var placeOverlay = new kakao.maps.CustomOverlay({ zIndex: 1 }),
            contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
            markers = [],
            currCategory = ''; // 현재 선택된 카테고리를 가지고 있을 변수입니다

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();
        var hospitals = []; // 병원 데이터를 저장하는 배열

        //커스텀 오버레이 변수를 전역 범위에서 정의합니다
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
            var himg = "${h.himg}";
            var hbreaktime = "${h.hbreaktime}";
            var hbreakendtime = "${h.hbreakendtime}";
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
                himg: himg,
                hbreaktime: hbreaktime,
                hbreakendtime: hbreakendtime,
                hHoliday : hHoliday,
                hHolidayEndTime : hHolidayEndTime
            });
        </c:forEach>


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
            const currentTime = now.getHours() * 60 + now.getMinutes(); // 현재 시간을 분 단위로 표시

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




        hospitals.forEach(function (position) {
            // 주소로 좌표를 검색합니다
            geocoder.addressSearch(position.address, function (result, status) {
                // 정상적으로 검색이 완료됐으면
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                    // 결과값으로 받은 위치를 마커로 표시합니다
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });

                    // 마커 클릭 이벤트 리스너를 추가합니다.
                    kakao.maps.event.addListener(marker, 'click', function () {
                        // 클릭한 마커의 정보를 가져옵니다.
                        var hospitalNumber = position.hospitalNumber;
                        var title = position.title;
                        var address = position.address;
                        var opentime = position.opentime;
                        var closetime = position.closetime;
                        var nightendtime = position.nightendtime;
                        var nightday = position.nightday;
                        var himg = position.himg;
                        var hbreaktime = position.hbreaktime;
                        var hbreakendtime = position.hbreakendtime;
                        var hHoliday = position.hHoliday;
                        var hHolidayEndTime = position.hHolidayEndTime;
                       
                        const currentDay = new Date().getDay(); // 0: 일요일, 1: 월요일, ..., 6: 토요일
           
                        // 영업 상태를 확인합니다.
                        var status = checkBusinessStatus(opentime, closetime, nightday, nightendtime, hHoliday, hHolidayEndTime);

                        // 동적으로 생성한 컨테이너에 정보 추가
                        var dynamicContainer = document.getElementById("myDynamicDiv");
                        dynamicContainer.innerHTML =
                            '<div class="wrap">' +
                            '    <div class="info"><a href="http://172.30.1.78:8080/hospitalDetail/' + hospitalNumber + '" target="_blank" class="link">' +
                            '        <div class="title">' +
                            '            ' + title +
                            '        </div>' +
                            '        <div class="body">' +
                            '            <div class="img">' +
                            '                <img src="' + himg + '" width="73" height="70">' +
                            '           </div>' +
                            '            <div class="desc">' +
                            '                <div class="ellipsis">' + address + '</div>' +
                            '                <div class="time">' + opentime + "~" + (nightday == currentDay ? nightendtime : closetime) + '</div>' +
                            '                <div class="status">' + status + '</div>' +
                            '            </div>' +
                            '        </div>' +
                            '    </a></div>' +
                            '</div>';   
                       
                    });
                }
            });
        });
    }
   
   
   
  })();



 
</script>




</html>