if (!("platform" in window)) {
	window.platform = {
		_version: "0.1",
	};
}

// 상수값 지정
platform.constants = {
	PLATFORM: "[PLATFORM]",
	errorCode: {}
};

// 경보 팝업 구성
platform.initAlertPopup = function() {
	$("#alertPopup").draggable({
		handle: "#alertPopupTitle",
		cursor: "move",
		containment: "#container"
	});
};


// 초기 설정
platform.initConfig = function() {
	_.templateSettings.interpolate = /\{\{([\s\S]+?)\}}/g;
	_.templateSettings.evaluate = /\<\@([\s\S]+?)\@\>/g;
	_.templateSettings.escape = /\<\@-([\s\S]+?)\@\>/g;
};

(window.platform.init = function() {
	$(document).ready(function() {
		console.info("platform init");

		platform.initConfig();

		initPage();
	});
})();