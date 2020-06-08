<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>[PLATFORM]관리</title>
<%@include file="/common/sessionCheck.jsp" %>
<link rel="stylesheet" href="/css/font/notosanskr.css" type="text/css" />
<link rel="stylesheet" href="/css/font/NotoSansKR-Hestia.css" type="text/css" />
<link rel="stylesheet" href="/js/jqueryui/jquery-ui.min.css" type="text/css" />
<link rel="stylesheet" href="/css/admin.css" type="text/css" />
<script type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?version=2.0&apiKey=020B8E79-EF48-3CB8-9C83-3A65B735CD80"></script>
<script>
var $$ = jQuery.noConflict();
</script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=kUHvfk_Eh4Gny7kjwIRV&submodules=geocoder"></script>
<script type="text/javascript" src="/js/jquery/jquery-3.3.1.min.js"></script>
<script>
var $ = jQuery.noConflict();
</script>
<script type="text/javascript" src="/js/jqueryui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/loadsh/lodash.min.js"></script>
<script type="text/javascript" src="/js/convert.js"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/jquery-custom.js"></script>
<script type="text/javascript" src="/js/platformMap.js"></script>
<script type="text/javascript" src="/js/platformUtil.js"></script>
<script type="text/javascript" src="/js/iscroll/iscroll.js"></script>

<link type="text/css" rel="stylesheet" href="/js/jsgrid-1.5.3/jsgrid.css" />
<link type="text/css" rel="stylesheet" href="/js/jsgrid-1.5.3/jsgrid-theme.css" />
<script type="text/javascript" src="/js/jsgrid-1.5.3/jsgrid.js"></script>
<script type="text/javascript" src="/js/jsgrid-1.5.3/i18n/jsgrid-ko.js"></script>
<script type="text/javascript">
var initPage = function() {
	console.log("admin page");

	initGrid1();

	$("#btnSearch").click(function() {
		btnSearchClick();
	});

	$("#btnSave").click(function() {
		btnSaveClick();
	});

	$("#btnAddRow").on("click", function() {
		btnAddRow();
	});
};

var grid1;
var initGrid1 = function() {
	grid1 = $("#grid1");

	var data = [];
	jsGrid.locale("ko");

	grid1.jsGrid({
		width: "100%",
		height: "100%",
		sorting: true,
		fields: [
			{title: "장치구분", name: "DEV_TYPE_NM", type: "text", width: 100, validate: "required", align:"center"},
			{title: "장치ID", name: "DEV_ID", type: "text", width: 80, align:"center"},
			{title: "장치명", name: "DEV_NM", type: "text", width: 100},
			{title: "주소", name: "ADDR_1", type: "text", width: 400},
			{name: "COMP_CD", css:"hidden", width:0},
			{name: "DEV_TYPE_CD", css:"hidden", width:0},
			{name: "LOC_1", css:"hidden", width:0},
			{name: "LOC_2", css:"hidden", width:0},
			{name: "ADDR_1", css:"hidden", width:0},
			{name: "USE_YN", css:"hidden", width:0},
			{name: "RMK", css:"hidden", width:0},
			{name: "IS_NEW", css:"hidden", width:0},
		],
		rowClick: function(args) {
			grid1.find('table tr.highlight').removeClass("highlight");
			this.rowByItem(args.item).addClass("highlight");

			var rowData = args.item;
			$("#postForm1").setData(rowData);
		},
		controller: {
			loadData: loadDataFunc
		},
		onItemInserted : function(args) {
			console.log("inserted", args, args.grid, args.item);
			var gridBody = $("#grid1").find('.jsgrid-grid-body');
			gridBody.find('.jsgrid-table tr:last-child').trigger('click');
		},
	});

	/*
	_.each(result, function(item) {
		grid.jsGrid("insertItem", item);
	});
	*/
};

var btnSearchClick = function() {
	$("#postForm1").clear();

	var formData = $("#searchArea").getData();
	grid1.jsGrid("loadData");
};

var loadDataFunc = function() {
	var result = [
		{"DEV_TYPE_NM":"기온","DEV_ID":"00007","DEV_NM":"온도계7","ADDR_1":"부산광역시 동래구 아시아드대로 153 도시철도사직역"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00011","DEV_NM":"온도계11","ADDR_1":"부산광역시 연제구 거제동 630"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00008","DEV_NM":"온도계8","ADDR_1":"부산광역시 연제구 중앙대로1226번길 4 한양아파트"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00003","DEV_NM":"온도계3","ADDR_1":"부산광역시 동래구 온천동 1774-1"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00005","DEV_NM":"온도계5","ADDR_1":"부산광역시 동래구 중앙대로 1325 이센타워"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00002","DEV_NM":"온도계2","ADDR_1":"부산광역시 동래구 온천동 444-1"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00013","DEV_NM":"온도계13","ADDR_1":"부산광역시 동래구 안락동 1063-25"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00004","DEV_NM":"온도계4","ADDR_1":"부산광역시 동래구 충렬대로107번길 54 럭키아파트"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00001","DEV_NM":"온도계1","ADDR_1":"부산광역시 동래구 온천장로 55"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00012","DEV_NM":"온도계12","ADDR_1":"부산광역시 연제구 안연로 33 더샵 파크시티"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00010","DEV_NM":"온도계10","ADDR_1":"부산광역시 연제구 거제천로269번길 41 온천천2차동원로얄듀크"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00009","DEV_NM":"온도계9","ADDR_1":"부산광역시 연제구 중앙대로1226번길 4 한양아파트"},
		{"DEV_TYPE_NM":"기온","DEV_ID":"00006","DEV_NM":"온도계6","ADDR_1":"부산광역시 동래구 아시아드대로 153 도시철도사직역"},
		{"DEV_TYPE_NM":"풍속","DEV_ID":"00001","DEV_NM":"풍속계1","ADDR_1":"부산광역시 동래구 명륜동 산28-1"},
		{"DEV_TYPE_NM":"풍속","DEV_ID":"00002","DEV_NM":"풍속계2","ADDR_1":"부산광역시 동래구 명안로85번길 33"},
		{"DEV_TYPE_NM":"강수","DEV_ID":"00001","DEV_NM":"강수계1","ADDR_1":"부산광역시 금정구 오시게로58번길 8"},
		{"DEV_TYPE_NM":"CCTV","DEV_ID":"00001","DEV_NM":"부곡사거리","ADDR_1":"부산광역시 금정구 부곡동 398"},
		{"DEV_TYPE_NM":"CCTV","DEV_ID":"00002","DEV_NM":"내성교차로","ADDR_1":"부산광역시 동래구 중앙대로 1324 도시철도 1호선 동래역"}
	];


	var url = "/ad020/list";
	url += "?deviceTypeCd=" + $("#s_deviceTypeCd").getVal();

	console.log("url", url);

	var data = [];

	platform.getService(url, function(result) {
		console.log("url", url, result);

		_.each(result, function(el) {
			el["IS_NEW"] = "N";
		});

		data = result;
	}, false);

	return data;
}

var btnAddRow = function() {
	var data = $("#grid1").jsGrid("option", "data");

	var isNew = true;

	_.each(data, function(item) {
		if (item.IS_NEW === "Y") {
			alert("저장되지 않은 자료가 있습니다.");
			isNew = false;
		}
	});

	if (!isNew) {
		return;
	}

	console.log("griddata", data)

	$("#grid1").jsGrid("insertItem", {IS_NEW:"Y"}).done(function(a,b,c,d) {
		console.log("insertion completed",a,b,c,d);
	});
};

var btnSaveClick = function() {
	console.log("btnSaveClick");
	var data = $("#postForm1").getData();

	console.log("data", data);

	var url = "/ad020/save";

	platform.postService(url, data, function(result) {
		if (result["resultCode"] === "00") {
			alert("저장되었습니다");
			btnSearchClick();
		} else {
			alert("저장 시 오류가 발생했습니다");
		}
	});
};
</script>
<style>

</style>
</head>
<body>
<div id="mainContainer" style="width:100%; height:100%;">
	<div id="topContainer">
		<h1 id="logo">통합재난관제시스템 [관리]</h1>
		<h5 id="loginUserName"><%=USR_NM%>[<%=USR_ID%>]님 안녕하세요</h5>
	</div>
	<div id="leftContainer">
		<h2 class="programGroup">시스템관리</h2>
		<ul>
			<li><a class="btnProgram" href="/ad010Page.do">사용자관리</a></li>
			<li><div class="btnProgram" style="font-weight:500;">장치관리</div></li>
		</ul>
	</div>
	<div id="programContainer">
		<div class="programTitleArea">
			<h2 class="programTitle">사용자관리</h2>
			<div class="programBtnArea">
				<button id="btnSearch" class="btnProgramAction">조회</button>
				<button id="btnSave" class="btnProgramAction">저장</button>
			</div>
		</div>
		<form id="searchArea" class="searchArea" onsubmit="return false;">
			<label for="s_deviceTypeCd">장치구분</label>
			<select id="s_deviceTypeCd" data-field="DEV_TYPE_CD">
				<option value="" selected="selected">전체</option>
				<option value="01" >기온</option>
				<option value="02" >풍속</option>
				<option value="03" >강우</option>
				<option value="04" >CCTV</option>
			</select>
		</form>
		<div class="contentArea">
			<div class="gridArea">
				<div class="gridTitleArea">
					<div class="gridBtnArea">
						<button id="btnAddRow" class="btnGridAction">행추가</button>
					</div>
				</div>
				<div id="grid1" class="dataGrid" style=""></div>
			</div>
			<div class="formArea">
				<div class="formTitleArea">
				</div>
				<form id="postForm1">
					<input type="hidden" id="isNew" data-field="IS_NEW" />
					<ul>
						<li>
							<label for="deviceTypeCd">장치구분</label>
							<select id="deviceTypeCd" data-field="DEV_TYPE_CD">
								<option value="01" selected="selected">기온</option>
								<option value="02">풍속</option>
								<option value="03">강우</option>
								<option value="04">CCTV</option>
							</select>
						</li>
						<li>
							<label>장치ID</label>
							<input type="text" id="devId" readonly data-field="DEV_ID" />
						</li>
						<li>
							<label>장치명</label>
 							<input type="text" id="devNm" data-field="DEV_NM" />
						</li>
						<li>
							<label for="loc_1">위치</label>
							<input type="text" id="loc_1" size="3" style="width:120px; font-size:11px;" data-field="LOC_1" />
							<input type="text" id="loc_2" size="3" style="width:120px; font-size:11px;" data-field="LOC_2" />
						</li>
						<li>
							<label>주소</label>
							<input type="text" id="addr_1" data-field="ADDR_1" style="width:260px; font-size:13px;"/>
						</li>
						<li>
							<label>사용여부</label>
							<input type="radio" id="userYN_Y" name="userYN" value="Y" data-field="USE_YN"><label for="userYN_Y">Y</label>
							<input type="radio" id="userYN_N" name="userYN" value="N" data-field="USE_YN"><label for="userYN_N">N</label>
						</li>
						<li>
							<label>비고</label>
							<input type="text" id="rmk" data-field="RMK" />
						</li>
					</ul>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
