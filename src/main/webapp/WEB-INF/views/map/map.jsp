<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/resources/template/header.jsp"/>

<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=B1WWhcm83cbR035epxJu"></script>
<div class="jumbotron" style="margin-top: 25px;color:black;">
	<div class="container" style="text-align: center;">
		<h1>오시는길</h1>
	</div>
</div>

<style>
	.moveToCello, .moveToCello:VISITED, .moveToCello:FOCUS {
		background-color: #b4b2ca;
		color:#fff;
	}
	
	.moveToCello:HOVER {
		background-color: #6256ff;
		color:#fff;
	}
	
	#mapWrapper {
		position: relative;
	}
	
	#roadviewControl {
		position: absolute;
		top: 5px;
		left: 25px;
		width: 80px;
		height: 28px;
		padding: 2px;
		z-index: 1;
		background: #f7f7f7;
		border-radius: 4px;
		border: 1px solid #c8c8c8;
		box-shadow: 0px 1px #888;
		cursor: pointer;
	}
	
	#roadviewControl span {background: url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/mapworker.png) no-repeat;  padding-left:23px;height:24px;font-size: 12px;display: inline-block;line-height: 2;font-weight: bold;}
	#roadviewControl.active {background: #ccc;box-shadow: 0px 1px #5F616D;border: 1px solid #7F818A;}
	#roadviewControl.active span {background: url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/mapworker_on.png) no-repeat;color: #4C4E57;}
	
	
	.placeinfo_wrap {position:absolute;bottom:28px;left:-150px;width:300px;}
.placeinfo {position:relative;width:100%;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;padding-bottom: 10px;background: #fff;}
.placeinfo:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.placeinfo_wrap .after {content:'';position:relative;margin-left:-12px;left:50%;width:22px;height:12px;background:url('http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.placeinfo a, .placeinfo a:hover, .placeinfo a:active{color:#fff;text-decoration: none;}
.placeinfo a, .placeinfo span {display: block;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
.placeinfo span {margin:5px 5px 0 5px;cursor: default;font-size:13px;}
.placeinfo .title {font-weight: bold; font-size:14px;border-radius: 6px 6px 0 0;margin: -1px -1px 0 -1px;padding:10px; color: #fff;background: #d95050;background: #d95050 url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.placeinfo .tel {color:#0f7833;}
.placeinfo .jibun {color:#999;font-size:11px;margin-top:0;}
	
	
</style>


<div id="wrapper">
<div class="container">
	<div>
		지번주소 : 인천시 계양구 계산1동 961-4<br/>
		도로명주소 : 인천시 계양구 경명대로 계산천동로23번길 3-1<br/>
	</div>
	<div>
		<label>주변검색 : </label>
		<input type="text" id="keyword" /><button class="btn" id="find" onclick="find()">찾기</button>
	</div>
	<button onclick="panTo()" class="btn moveToCello" >첼로로 이동하기</button>
</div>
<div id="mapWrapper" class="container">
	
	<div id="map" style="height:400px;"></div>
	<div id="roadviewControl" onclick="setRoadviewRoad()"><span>로드뷰</span></div>
</div>

<div id="rvWrapper" class="container">
	<div id="roadview" style="height:300px;margin-bottom:20px;">
	
	</div>
</div>



</div>

<div style="height:30px;"></div>

<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=d0bd441c88cf6c72e2ddf1f2df012b23"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/lib/daummap/services.js"></script>
<script>
var overlayOn = false;
var container = document.getElementById('wrapper');
var mapContainer = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var rvContainer = document.getElementById('roadview');
var celloPosition = new daum.maps.LatLng(37.53831109500722, 126.7254276076119);
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: celloPosition, //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new daum.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴

var rv = new daum.maps.Roadview(rvContainer);

// 좌표로부터 로드뷰 파노라마 ID를 가져올 로드뷰 클라이언트 객체를 생성합니다
var rvClient = new daum.maps.RoadviewClient();

// 로드뷰에 좌표가 바뀌었을 때 발생하는 이벤트를 등록합니다
daum.maps.event.addListener(rv, 'position_changed', function() {
	// 현재 로드뷰의 위치 좌표를 얻어옵니다.
	var rvPosition = rv.getPosition();
	
	// 지도의 중심을 현재 로드뷰의 위치로 설정합니다.
	map.setCenter(rvPosition);
	
	// 지도 위에 로드뷰 도로 오버레이가 추가된 상태이면
	if(overlayOn) {
		// 마커의 위치를 현재 로드뷰의 위치로 설정합니다.
		marker.setPosition(rvPosition);
	}
});

var mapTypeControl = new daum.maps.MapTypeControl();
map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
var zoomControl = new daum.maps.ZoomControl();
map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
map.addOverlayMapTypeId(daum.maps.MapTypeId.TRAFFIC);

var celloMarker = new daum.maps.Marker({
	position: celloPosition
});

celloMarker.setMap(map);

var markImage = new daum.maps.MarkerImage(
	    'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/roadview_wk.png',
	    new daum.maps.Size(35,39), {
	    //마커의 좌표에 해당하는 이미지의 위치를 설정합니다.
	    //이미지의 모양에 따라 값은 다를 수 있으나, 보통 width/2, height를 주면 좌표에 이미지의 하단 중앙이 올라가게 됩니다.
	    offset: new daum.maps.Point(14, 39)
	});

	// 드래그가 가능한 마커를 생성합니다
	var marker = new daum.maps.Marker({
	    image : markImage,
	    position: celloPosition,
	    draggable: true
	});



var iwContent = '<div style="padding:5px;width:150px;text-align:center;">첼로모텔</div>',
	  iwPosition = celloPosition,
	  iwRemoveable = false;

var infowindow = new daum.maps.InfoWindow({
	map : map,
	position : iwPosition,
	content : iwContent,
	removable : iwRemoveable
});

infowindow.open(map, marker);



function panTo() {
	map.panTo(celloPosition);
}


//마커에 dragend 이벤트를 등록합니다
daum.maps.event.addListener(marker, 'dragend', function(mouseEvent) {

    // 현재 마커가 놓인 자리의 좌표입니다 
    var position = marker.getPosition();

    // 마커가 놓인 위치를 기준으로 로드뷰를 설정합니다
    toggleRoadview(position);
});



daum.maps.event.addListener(map, 'click', function(mouseEvent){
    
    // 지도 위에 로드뷰 도로 오버레이가 추가된 상태가 아니면 클릭이벤트를 무시합니다 
    if(!overlayOn) {
        return;
    }

    // 클릭한 위치의 좌표입니다 
    var position = mouseEvent.latLng;

    // 마커를 클릭한 위치로 옮깁니다
    marker.setPosition(position);

    // 클릭한 위치를 기준으로 로드뷰를 설정합니다
    toggleRoadview(position);
});

function toggleRoadview(position){
    rvClient.getNearestPanoId(position, 50, function(panoId) {
        // 파노라마 ID가 null 이면 로드뷰를 숨깁니다
        toggleMapWrapper(position);
         

            // panoId로 로드뷰를 설정합니다
            rv.setPanoId(panoId, position);
        }
    );
}

function toggleMapWrapper(position) {
	// 지도의 크기가 변경되었기 때문에 relayout 함수를 호출합니다
    map.relayout();

    // 지도의 너비가 변경될 때 지도중심을 입력받은 위치(position)로 설정합니다
    map.setCenter(position);
}



function toggleOverlay(active) {
    if (active) {
        overlayOn = true;

        // 지도 위에 로드뷰 도로 오버레이를 추가합니다
        map.addOverlayMapTypeId(daum.maps.MapTypeId.ROADVIEW);

        // 지도 위에 마커를 표시합니다
        marker.setMap(map);

        // 마커의 위치를 지도 중심으로 설정합니다 
        marker.setPosition(map.getCenter());

        // 로드뷰의 위치를 지도 중심으로 설정합니다
        toggleRoadview(map.getCenter());
    } else {
        overlayOn = false;

        // 지도 위의 로드뷰 도로 오버레이를 제거합니다
        map.removeOverlayMapTypeId(daum.maps.MapTypeId.ROADVIEW);
		map.setCenter(celloPosition);
		toggleRoadview(celloPosition);
        // 지도 위의 마커를 제거합니다
        marker.setMap(null);
    }
}


function setRoadviewRoad() {
    var control = document.getElementById('roadviewControl');

    // 버튼이 눌린 상태가 아니면
    if (control.className.indexOf('active') === -1) {
        control.className = 'active';

        // 로드뷰 도로 오버레이가 보이게 합니다
        toggleOverlay(true);
    } else {
        control.className = '';

        // 로드뷰 도로 오버레이를 제거합니다
        toggleOverlay(false);
    }
}

// 마커를 클릭했을 때 해당 장소의 상세정보를 보여줄 커스텀오버레이입니다.
var placeOverlay = new daum.maps.CustomOverlay({zIndex:1}),
	  contentNode = document.createElement('div'), // 커스텀 오버레이의 컨텐츠 엘리먼트 입니다
	  markers = []; // 마커를 담을 배열입니다.

// 장소 검색 객체를 생성합니다.
var ps = new daum.maps.services.Places(map);
contentNode.className = 'placeinfo_wrap';

addEventHandle(contentNode, 'mousedown', daum.maps.event.preventMap);
addEventHandle(contentNode, 'touchstart', daum.maps.event.preventMap);

placeOverlay.setContent(contentNode);

// 중심 좌표나 확대 수준이 변경되면 발생한다.
// 단, 애니메이션 도중에는 발생하지 않는다.
//daum.maps.event.addListener(map, 'idle', searchPlaces);

function addEventHandle(target, type, callback) {
	if(target.addEventListener) {
		target.addEventListener(type, callback);
	} else {
		target.attachEvent('on' + type, callback);
	}
}


function removeMarker() {
	for (var i=0; i<markers.length; i++) {
		markers[i].setMap(null);
	}
	markers = [];
}

function find() {
	removeMarker();
	placeOverlay.setMap(null);
	var keyword = document.getElementById("keyword").value;
	keyword = keyword.replace(/^\s+|\s+$/g, '');
	if (keyword == '') {
        alert('키워드를 입력해주세요!');
        return false;
    }
	ps.keywordSearch(keyword, placesSearchCB);
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다.
function placesSearchCB(status, data, pagination) {
	if(status == daum.maps.services.Status.OK) {
		displayPlaces(data.places);
	}
}

function displayPlaces(places) {
	for(var i=0; i<places.length; i++) {
		// 마커를 생성하고 지도에 표시합니다.
		var marker = addMarker(new daum.maps.LatLng(places[i].latitude, places[i].longitude));
		
		// 마커와 검색결과 항목을 클릭 했을 때
		// 장소정보를 표출하도록 클릭 이벤트를 등록합니다.
		(function(marker, place) {
			daum.maps.event.addListener(marker, 'click', function() {
				displayPlaceInfo(place);
			});
		})(marker, places[i]);
	}
}

function addMarker(position) {
	var marker = new daum.maps.Marker({
	    position: position,
	    draggable: false
	});

	marker.setMap(map); // 지도 위에 마커를 표출합니다
	markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	return marker;

}

function displayPlaceInfo (place) {
    var content = '<div class="placeinfo">' +
                    '   <a class="title" href="' + place.placeUrl + '" target="_blank" title="' + place.title + '">' + place.title + '</a>';   

    if (place.newAddress) {
        content += '    <span title="' + place.newAddress + '">' + place.newAddress + '</span>' +
                    '  <span class="jibun" title="' + place.address + '">(지번 : ' + place.address + ')</span>';
    }  else {
        content += '    <span title="' + place.address + '">' + place.address + '</span>';
    }                
   
    content += '    <span class="tel">' + place.phone + '</span>' + 
                '</div>' + 
                '<div class="after"></div>';

    contentNode.innerHTML = content;
    placeOverlay.setPosition(new daum.maps.LatLng(place.latitude, place.longitude));
    placeOverlay.setMap(map);  
}

function enter(e) {
	if(e.keyCode == 13) {
		find();
	}
}

var keywordInput = document.getElementById("keyword");
if(keywordInput.addEventListener) {
	keywordInput.addEventListener("keydown", enter);
} else {
	keywordInput.attachEvent("onkeydown", enter);
}

toggleRoadview(map.getCenter());












</script>
<jsp:include page="/resources/template/footer.jsp" />