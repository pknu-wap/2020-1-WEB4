var KEY_F1 = 0x70;
var KEY_F2 = 0x71;
var KEY_F3 = 0x72;
var KEY_F4 = 0x73;
var KEY_F5 = 0x74;
var KEY_F6 = 0x75;
var KEY_F7 = 0x76;
var KEY_F8 = 0x77;
var KEY_F9 = 0x78;
var KEY_F10 = 0x79;
var KEY_F11 = 0x7A;
var KEY_F12 = 0x7B;
var KEY_ESC = 0x1B;

var KEY_LEFT = 37;
var KEY_UP = 38;
var KEY_RIGHT = 39;
var KEY_DOWN = 40;

var KEY_F2_VALID = true; // Default 'true'이며 F2 Key 사용여부

// 일반 KEY의 ASCII 코드값을 선언한다.
var KEY_TAB = 0x09;
var KEY_ENTER = 0x0D;
var KEY_SPACE = 0x20;
var KEY_BACKSPACE = 0x08;
var KEY_DELETE = 0x2E;
var KEY_ETC = '0x010000002F6BC673E04B0820FD92A74CC8CF7B3EC27699FD8C54B3E7';

var browser = (function() {
	var s = navigator.userAgent.toLowerCase();
	var match = /(webkit)[ \/](\w.]+)/.exec(s) || /(opera)(?:.*version)?[ \/](\w.]+)/.exec(s) || /(msie) ([\w.]+)/.exec(s) || /(mozilla)(?:.*? rv:([\w.]+))?/.exec(s) || [];
	return {
		name : match[1] || "",
		version : match[2] || "0"
	};
}());

var defaultArray = [{id:'*', value:'전체'}];

(function() {
	if (!window['console']) {
		window['console'] = {
			log : function() {
			}
		};
	}

	if (!window['initPage']) {
		window['initPage'] = function() {
			//console.log(initPage);
		}
	}

	// CSS 에서 브라우저 구분용 html[data-useragent*='MSIE 9.0'] #element
	document.documentElement.setAttribute('data-useragent', navigator.userAgent);

//	console.log("funcion initialize");
})();

function disableAllControl(disabled) {
	if (disabled) {
		$(':input').each(function() {
			var $this = $(this);
			$this.prop('orgDisabled', $this.prop('disabled'));
			$this.prop('disabled', true);
		});
	} else {
		$(':input').each(function() {
			var $this = $(this);
			$this.prop('disabled', $this.prop('orgDisabled'));
		});
	}
	if (disabled) {
		$('.webix_dtable').each(function() {
			var $this = $(this);
			$this.parent().webix_datatable().disable();
		});
	} else {
		$('.webix_dtable').each(function() {
			var $this = $(this);
			$this.parent().webix_datatable().enable();
		});
	}
}

/*
 * 자바스크립트 Date format()
 * //2011년 09월 11일 오후 03시 45분 42초
 * console.log(new Date().format("yyyy년 MM월 dd일 a/p hh시 mm분 ss초"));
 * //2011-09-11
 * console.log(new Date().format("yyyy-MM-dd"));
 * //'11 09.11
 * console.log(new Date().format("'yy MM.dd"));
 * //2011-09-11 일요일
 * console.log(new Date().format("yyyy-MM-dd E"));
 * //현재년도 : 2011
 * console.log("현재년도 : " + new Date().format("yyyy"));
 */
Date.prototype.format = function(f) {
	if (!this.valueOf())
		return " ";

	var weekName = [
		"일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"
	];
	var d = this;

	return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
		switch ($1) {
			case "yyyy":
				return d.getFullYear();
			case "yy":
				return (d.getFullYear() % 1000).zf(2);
			case "MM":
				return (d.getMonth() + 1).zf(2);
			case "dd":
				return d.getDate().zf(2);
			case "E":
				return weekName[d.getDay()];
			case "HH":
				return d.getHours().zf(2);
			case "hh":
				return ((h = d.getHours() % 12) ? h : 12).zf(2);
			case "mm":
				return d.getMinutes().zf(2);
			case "ss":
				return d.getSeconds().zf(2);
			case "a/p":
				return d.getHours() < 12 ? "오전" : "오후";
			default:
				return $1;
		}
	});
};

String.prototype.string = function(len) {
	var s = '', i = 0;
	while (i++ < len) {
		s += this;
	}
	return s;
};
String.prototype.zf = function(len) {
	return "0".string(len - this.length) + this;
};
Number.prototype.zf = function(len) {
	return this.toString().zf(len);
};

function toQueryString(obj) {
	var result = "";

	try {
		for (var key in obj) {
			result += "&" + key + "=" + encodeURIComponent(obj[key]);
		}
	} catch (err) {
		console.error(err);
	}

	return result;
}

function isNull(data) {
	if (typeof data !== "undefined" && data !== null) {
		return false;
	} else {
		return true;
	}
}

function checkNull(val, rep) {
	if (isNull(val)) {
		return rep;
	} else {
		return val;
	}
}

function isEmpty(val) {
	if (typeof(val) === "string" || typeof(val) === "number" || val == null) {
		if (isNull(val) || val == "" || (val+"").toLowerCase() === "null") {
			return true;
		} else {
			return false;
		}
	} else if (typeof(val) === "array" || typeof(val) === "object") {
		if (val.length === 0) {
			return true;
		}

		return false;
	} else {
		return true;
	}
}

function checkEmpty(val, rep) {
	if (isNull(val) || val === "") {
		return rep;
	} else {
		return val;
	}
}

/**
 * 숫자체크
 * @param val 입력값
 * @returns [boolean] true: 숫자포멧, false: 숫자포멧 아님
 */
function checkNumber(val){
	if(typeof(va) === "undefined" || val == null || !val) return true;
	return (/^-?\d*\.?\d+$/.test(val.toString()));
}

var telRegExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/;
var timeRegExp = /^(0[0-9]|1[0-9]|2[0-3]):?([0-5][0-9])$/;
var positiveIntRegExp = /^0$|^[1-9][0-9]*$/;
var negativeIntRegExp = /^0$|^-[1-9][0-9]*$/;
var intRegExp = /^0$|^-?[1-9][0-9]*$/;
var positivePercentRegExp = /^0( ?%)?$|^[1-9][0-9]*%?$/;
var negativePercentRegExp = /^0( ?%)?$|^-[1-9][0-9]*%?$/;
var percentRegExp = /^0( ?%)?$|^-?[1-9][0-9]*%?$/;
var positiveNumberRegExp = /^0$|^0.[0-9]*[1-9]$|^[1-9][0-9]*(.[0-9]*[1-9])?$/;
var negativeNumberRegExp = /^0$|^-0.[0-9]*[1-9]$|-[1-9][0-9]*(.[0-9]*[1-9])?$/;
var numberRegExp = /^-?[0-9]+(.[0-9]*[1-9])?$/;
var yearMonthRegExp = /^([\d]{4})-?(0[1-9]|1[0-2])$/;
var dateRegExp = /^(19[0-9][0-9]|20\d{2})-?(0[0-9]|1[0-2])-?(0[1-9]|[1-2][0-9]|3[0-1])$/;

function getSelectList(code, param, total) {
	var selectList = null;
	var callback = new Callback(function(result) {
		//console.log("result selectlist", result);
		selectList = JSON.parse(result);
	});

	callback.async = false;
	CodeService.getSelectList("HELP", code, param, total, callback);

	return selectList
}

function downloadForm(PGMID) {
	var frame = $('<iframe class="downloadFrame" style="display: none;"></iframe>');
	frame.attr('src', "/jsp/common/downloadForm.jsp?PGMID=" + PGMID);
	$("body").after(frame);

	setTimeout(function() {
		$("iframe.downloadFrame").remove();
	}, 1000);
}

function rpad(value, length, str) {
	var addLen = length - value.length;
	for (var i = 0; i < addLen; i++) {
		value += str;
	}
	return value;
}

function lpad(value, len, str) {
	var v = value + "";
	var size = len - v.length;

	if (v.length < len) {
		for (var i = 0; i < size; i++) {
			v = str + v;
		}
	}

	return v;
}

function getQuarter(strDate) {
	var result = "";

	if (isEmpty(strDate)) {
		strDate = new Date().format("yyyy-MM");
	}

	var month = Number(strDate.substring(5, 7));

	if (month > 12 || month < 1) {
		month =  Number(new Date().format("yyyy-MM").substring(5, 7));
	}

	if (month >= 1 && month <= 3) {
		result = "1";
	} else if (month >= 4 && month <= 6) {
		result = "2";
	} else if (month >= 7 && month <= 9) {
		result = "3";
	} else if (month >= 10 && month <= 12) {
		result = "4";
	}

	return result;
}

Array.prototype.remove = function(idx) {
	this.splice(idx, 1);
};

/**
 * 비동기 통신
 * @param url
 * @param params
 * @param callback
 * @param async
 */
function httpRequest(url, params, callback, async) {
	$.ajax({
		type : 'post',
		dataType : 'json',
		crossDomain:true,
		url : url,
		data : params,
		async : async,
		success : function(data, textStatus, jqXHR) {
			if (data) {
				callback(data);
			}
		},
		error : function(jqXHR, textStatus, errorThrown) {
			console.log("E", "server-side failure with response: ", jqXHR);
		},
		cache : false
	});
}

/**
 * 문자열의 Byte 길이를 구하는 함수.
 * @param str 입력 문자열
 * @returns {Number}
 */
function getByteSize(str){
	if(typeof str == "undefined" || str == null || !str) return 0;
	var b,i,c, s=str.toString();
	for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1); //DB 케릭터셋에 따라 한글 바이트 수 변경(기본 2 byte)
	return b;
}

/**
 * 문자열의 콤마포멧을 처리하는 함수
 * @param str 입력값
 * @param opt (on : comma 추가, off : comma 제거)
 * @param rpStr 대체문자 0
 */
function replcComma(str, opt, rpStr){
	if(typeof str == "undefined" || str == null || !str) return checkEmpty(rpStr,"");
	var rtnVal = str.toString().replace(/[^0-9|.]/g,"");
	var sIntgr = (rtnVal.lastIndexOf(".") == -1)?rtnVal:rtnVal.substring(0, rtnVal.lastIndexOf("."));
	var sDp = (rtnVal.lastIndexOf(".") == -1)?"":rtnVal.substring(rtnVal.lastIndexOf("."), rtnVal.length);
	return (opt == "on") ? sIntgr.replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,")+sDp : rtnVal;
}

/**
 * 문자열의 날짜포멧을 처리하는 함수
 * @param str 입력값
 * @param opt (on: [sprtr("-"), tmsprtr(":")] 추가, off: [sprtr("-"), tmsprtr(":")] 제거)
 * @param sprtr 일자구분자
 * @param tmsprtr 시간구분자
 */
function replcDate(str, opt, sprtr, tmsprtr){
	if(typeof str == "undefined" || str == null || !str) return "";
	var rtnVal = str.toString().replace(/[^0-9]/gi,"");
	var sSprtr = (sprtr) ? sprtr : "-";
	var sTmsprtr = (tmsprtr) ? tmsprtr : ":";

	if(opt == "on"){
		if(rtnVal.length == 14){
			rtnVal = rtnVal.replace(/(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})/, "$1"+sSprtr+"$2"+sSprtr+"$3 $4"+sTmsprtr+"$5"+sTmsprtr+"$6");
		}else if(rtnVal.length == 12){
			rtnVal = rtnVal.replace(/(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})/, "$1"+sSprtr+"$2"+sSprtr+"$3 $4"+sTmsprtr+"$5");
		}else if(rtnVal.length == 10){
			rtnVal = rtnVal.replace(/(\d{4})(\d{2})(\d{2})(\d{2})/, "$1"+sSprtr+"$2"+sSprtr+"$3"+" $4");
		}else if(rtnVal.length == 8){
			rtnVal = rtnVal.replace(/(\d{4})(\d{2})(\d{2})/, "$1"+sSprtr+"$2"+sSprtr+"$3");
		}else if(rtnVal.length == 6){
			rtnVal = rtnVal.replace(/(\d{4})(\d{2})/, "$1"+sSprtr+"$2");
		}else{
			rtnVal = str;
		}
	}
	return rtnVal;
}

/**
 * 문자열 특수문자 치환
 * @param val 문자열
 * @param len 길이
 * @param div (왼쪽:l, 오른쪽:r(기본))
 * @param spcchr 치환문자(기본:*)
 */
function replcTxt(val, len, div, spcchr) {
	if(isEmpty(val) || !checkNumber(len))
		return val;

	var sLen = val.length;
	if(sLen<=len)
		return val;

	var sDiv = (isEmpty(div))?"r":div;
	var sPcchr = (isEmpty(spcchr))?"*":spcchr;
	var sRpt = "";
	for(var i=0;i<len;i++){sRpt+=sPcchr;}
	return (sDiv=="l")?(sRpt+val.substring(len)):(val.substring(0,(sLen-len))+sRpt);
}

function getSystemEnv(envgbcd, envcd) {
	var rtn = {};
	var callback = new Callback(function(result) {
		rtn = result;
	});

	callback.async = false;
	CodeService.getSystemEnv(envgbcd, envcd, callback);

	return rtn;
}


function ckRegPwd(val){
	var regex = /^(?=.*[a-zA-Z])(?=.*[!@#$%^&*+=-])(?=.*[0-9]).{6,16}/;

	return regex.test(val);
}

/**
 * juso.go.kr에서 제공해 주는 주소검색 함수
 * @param param 주소값을 반환받을 객체정보
 */
function getJusoInfo(param) {
	var sZipId = param.zipcd;
	var sAddr1Id = param.addr1;
	var sAddr2Id = param.addr2;
	var sJibunAddr = param.jibun;
	var sCallBack = param.callback;
	var sOw = param.ow;

	var customCallback = function(result) {
		if(typeof result != "undefined")
		{
			if (typeof sJibunAddr != "undefined") {
				$("#"+sJibunAddr).val(result.jibunaddr);
			}
			$("#"+sZipId).val(result.zipno);
			$("#"+sAddr1Id).val(result.roadAddr);
			$("#"+sAddr2Id).focus();
		}
		else
		{
			if (typeof sJibunAddr != "undefined") {
				$("#"+sJibunAddr).val("");
			}
			$("#"+sJibunAddr).val("");
			$("#"+sZipId).val("");
			$("#"+sAddr1Id).val("");
			$("#"+sAddr2Id).val("");
		}

		try {
			if(!isNull(sCallBack)){
				var strFun = sCallBack+"(result)";
				eval(strFun);
			};
		} catch (e) {console.log(e);}
	}

	var param = new Array();
	param[0] = "";

	if (sOw && sOw == "true") {
		openWindow("/jsp/common/jusocode.jsp", "jusocode", {width:500, height:730, resizable:1}, {"ow":sOw, "callback":sCallBack});
	} else {
		customPopup.show("/jsp/common/jusocode.jsp", "주소 찾기", 500, 530, customCallback, param);
	}
}

/**
 * 동적폼 생성함수
 * @param act 폼의 action
 * @param prms 전송될 파라메터(JSON 형식)
 * @param trg 폼의 target
 * @param mth 폼의 method
 * @returns 폼객체
 */
function createForm(act, prms, trg, mth){
	var $form = $("<form></form>");

	$form.attr("action",act);
	$form.attr("method",checkEmpty(mth, "post"));
	$form.attr("target",checkEmpty(trg, ""));
	$form.appendTo("body");
	for(var key in prms) {
		if(prms.hasOwnProperty(key)) {
			var $input = $("<input type=\"hidden\" name=\""+key+"\" value=\""+prms[key]+"\">");
			$form.append($input);
		}
	}
	return $form;
}

function formatPhoneNumber(num) {
	if (num != null && num != undefined) {
		return num.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/, "$1-$2-$3");
	} else {
		return null;
	}
}

function getPhoneNumberArray(num) {
	var result = null;

	try {
		if (num != "") {
			result = formatPhoneNumber(num).split("-");
		}
	} catch (e) {
	}

	return result;
}

function getEMailArray(str) {
	var result = null;

	try {
		if (str != "") {
			result = str.split("@");
		}
	} catch (e) {
	}

	return result;
}

function getPermitNoArray(str) {
	var result = null;

	try {
		if (str != "" && str.length == 10) {
			result = new Array();
			result[0] = str.substring(0, 3);
			result[1] = str.substring(3, 5);
			result[2] = str.substring(5);
		}
	} catch (e) {
	}

	return result;
}

function getPostCodeArray(str) {
	var result = null;

	try {
		if (str != "" && str.length == 6) {
			result = new Array();
			result[0] = str.substring(0, 3);
			result[1] = str.substring(3, 6);
		} else if (str != "" && str.length == 7) {
			if (str.indexOf("-") > 0) {
				result = str.split("-");
			} else {
				result = new Array();
				result[0] = str.substring(0, 3);
				result[1] = str.substring(4, 7);
			}
		}
	} catch (e) {
	}

	return result;
}

function getNumberFormat(str) {
	return String(str).replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
}

function randomScalingFactor(min, max) {
	return parseInt(Math.random() * (max - min));
}

function getDateValue(val) {
	var result = val;

	if (result != null) {
		result = result.replace(/-/g, "");
	}

	return result;
}

function setDateFormat(value) {
	var res;
	var resStr = "";

	try {
		res = dateRegExp.exec(value);

		if (!isNull(res) && res.length === 4) {
			resStr = res[1] + '-' + res[2] + '-' + res[3];
		}

		return resStr;
	} catch (e) {
		console.error("setDateFormat:", value, res, e.message);
	}
}