// variables
var oMap;
var defaultNaverOffset = new nhn.api.map.Size(14, 37);
var defaultNaverSize = new nhn.api.map.Size(28, 37);
var defaultNaverIcon = new nhn.api.map.Icon("/images/naver_map_icon.png", defaultNaverSize, defaultNaverOffset);

// Info means if this map needs infoWindow(true) or labels(false).
function loadNaverMap(level, heightRatio){
	var defaultPoint = new nhn.api.map.LatLng(35.9707178, 127.8059249);
	var defaultLevel = level || 1;
	var heightRatio = heightRatio || 0.618

	// Set map's width and heigth.
	var deviceWidth = responsiveMapWidth();
	var mapHeight = deviceWidth * heightRatio;

	oMap = new nhn.api.map.Map(document.getElementById('naver_map'), { 
																	point : defaultPoint,
																	zoom : defaultLevel,
																	enableDragPan : true,  
																	enableWheelZoom : true,
																	enableDblClickZoom : true,
																	mapMode : 0,
																	size : new nhn.api.map.Size(deviceWidth, mapHeight),
																	minMaxLevel : [ 1, 14 ]
														});

	mapAndMarkers();
};

// Return responsive width of naver map for devices.
function responsiveMapWidth() {
	var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;

	if (width > 1200) {
		width = 540;
	} else if (width > 992) {
		width = 940;
	} else if (width > 768) {
		width = 750;
	}

	return width;
}

// Show MyMap's group markers and set center of those markers.
function mapAndMarkers(info) {
	var jsonUrl = window.location.href + '.json';

	$.getJSON( jsonUrl )
		.done( function(data) {
			displayMarkers(data);
			setMapCenter(data);
			setMapLevel(data);
			toggleLabels();
	});
}

// Attach group icon markers to map.
function displayMarkers(data) {
	$.each( data.stores, function( index, store ) {
		var oIcon = defaultNaverIcon;
		var oLatLng = new nhn.api.map.LatLng(store.lat, store.lng);
		var marker = new nhn.api.map.Marker(oIcon, { 
																					point: oLatLng,
																					zIndex: index,
																					title: store.name
																			 });
		oMap.addOverlay(marker);
	});
}

// Get json data of mymap and set center of the map.
function setMapCenter(data) {
	var div = 0, lat_sum = 0, lng_sum = 0;
	var ko_center_lat = 35.9707178, ko_center_lng = 127.8059249;

	$.each( data.stores, function( i, store ) {
		div += 1;
		lat_sum += parseFloat(store.lat);
		lng_sum += parseFloat(store.lng);
	});

	lat = lat_sum/div || ko_center_lat;
	lng = lng_sum/div || ko_center_lng;

	var centerLatLng = new nhn.api.map.LatLng(lat, lng)
	oMap.setCenter(centerLatLng);
}

// Get json data of mymap and set level for the map.
function setMapLevel(data) {
	var lat_max = 0, lat_min = 1000, lng_max = 0, lng_min = 1000;
	var lat_range = 0, lng_range = 0, level;

	$.each( data.stores, function( i, store ) {
		lat_max = Math.max(lat_max, store.lat);
		lat_min = Math.min(lat_min, store.lat);
		lng_max = Math.max(lng_max, store.lng);
		lng_min = Math.min(lng_min, store.lng);
	});

	lat_range = lat_max - lat_min;
	lng_range = lng_max - lng_min;

	if ( lat_range > 0.28 || lng_range > 0.18 ) {
		level = 5;
	} else if ( lat_range > 0.15  || lng_range > 0.09  ) {
	  level = 6;
	} else if ( lat_range > 0.075 || lng_range > 0.04  ) {
	  level = 7;
	} else if ( lat_range > 0.035 || lng_range > 0.02  ) {
	  level = 8;
	} else if ( lat_range > 0.02  || lng_range > 0.013 ) {
	  level = 9;
	} else if ( lat_range > 0.01  || lng_range > 0.005 ) {
	  level = 10;
	} else {
	  level = 11;
	};
	
	oMap.setLevel(level);
}


// label
function toggleLabels() {
	var oLabel = new nhn.api.map.MarkerLabel();
	var oMarker_new;
	var oMarker_old;
	oMap.addOverlay(oLabel);
	oMap.attach('click', function(oCustomEvent) {
		if (oCustomEvent.target instanceof nhn.api.map.Marker) {
			oMarker_old = oMarker_new;
			oMarker_new = oCustomEvent.target;

			if (oMarker_new == oMarker_old) {
				oLabel.setVisible(false, oMarker_new);
				oMarker_new = undefined;
			} else {
				oLabel.setVisible(true, oMarker_new);
			};
		};

		if (oCustomEvent.target instanceof nhn.api.map.Map) {
			oLabel.setVisible(false, oMarker_new);
			oMarker_new = undefined;
		};
	});
};

