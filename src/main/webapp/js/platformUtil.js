if (!("platform" in window)) {
	window.platform = {
		_version: "0.1"
	};
}

platform.getService = function(url, callbackFunc, async) {
	if (!_.isBoolean(async)) {
		async = true;
	}

	$.ajax({
		type: "get",
		url: url,
		dataType: "json",
		async: async,
		success: function(data) {
			callbackFunc(data);
		},
		error: function(xhr, stat, err) {
			// 오류 메시지 표시 후 종료
			// showErrorMsg (overlay 사용);
			console.error(xhr, stat, err);
		}
	});
};

platform.postService = function(url, data, callbackFunc, async) {
	if (!_.isBoolean(async)) {
		async = true;
	}

	$.ajax({
		type: "post",
		url: url,
		contentType: "application/json",
		data: JSON.stringify(data),
		async: async,
		success: function(data) {
			var result = data;
			callbackFunc(data);
		},
		error: function(xhr, stat, err) {
			// 오류 메시지 표시 후 종료
			// showErrorMsg (overlay 사용);
			console.error(xhr, stat, err);
		}
	});
};

platform.putService = function(url, data, callbackFunc, async) {
	if (!_.isBoolean(async)) {
		async = true;
	}

	$.ajax({
		type: "put",
		url: url,
		contentType: "application/json",
		data: JSON.stringify(data),
		async: async,
		success: function(data) {
			var result = data;
			callbackFunc(data);
		},
		error: function(xhr, stat, err) {
			// 오류 메시지 표시 후 종료
			// showErrorMsg (overlay 사용);
			console.error(xhr, stat, err);
		}
	});
};

platform.deleteService = function(url, callbackFunc, async) {
	if (!_.isBoolean(async)) {
		async = true;
	}

	$.ajax({
		type: "delete",
		url: url,
		dataType: "json",
		async: async,
		success: function(data) {
			var result = data;
			callbackFunc(data);
		},
		error: function(xhr, stat, err) {
			// 오류 메시지 표시 후 종료
			// showErrorMsg (overlay 사용);
			console.error(xhr, stat, err);
		}
	});
};

// 3857 to addr
platform.getAddr = function(coord, callback_getAddr) {
	var url = "http://api.vworld.kr/req/address?service=address&request=getAddress&key=" + "020B8E79-EF48-3CB8-9C83-3A65B735CD80";
	url += "&type=BOTH";
	url += "&crs=EPSG:3857";
	url += "&point=" + coord[0] + "," + coord[1];

	$.ajax({
		type: "get",
		url: url,
		dataType: 'jsonp',
		async: false,
		success: function(data) {
			if (data.response.status === "NOT_FOUND") {
				console.log("검색결과가 없습니다.");
			} else {
				//console.log("data:", data);
				var addressText = data.response.result[data.response.result.length - 1].text;

				callback_getAddr(addressText, data);
			}
		},
		complete: function() {

		},
		error: function(xhr, stat, err) {
		}
	});
};

platform.createHtmlTemplate = function(templateId, data) {
	var fn_template = _.template($("#" + templateId).html());
	return fn_template(data);
}
