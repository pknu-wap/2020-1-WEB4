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
			{title: "사용자ID", name: "USR_ID", type: "text", width: 150, validate: "required"},
			{title: "사용자명", name: "USR_NM", type: "text", width: 200},
			{title: "사용자그룹", name: "USR_GRP_NM", type: "text", width: 200},
			{name: "COMP_CD", css:"hidden", width:0},
			{name: "USR_GRP_CD", css:"hidden", width:0},
			{name: "TMPL_TYPE_CD", css:"hidden", width:0},
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
	/*
	var result = [
		{"USER_ID": "admin1", "USER_NM": "관리자1", "USER_GRP_CD": "관리자"},
		{"USER_ID": "admin2", "USER_NM": "관리자2", "USER_GRP_CD": "관리자"}
	];
	*/
	var url = "/ad010/list";
	url += "?userId=" + $("#s_userId").getVal();

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

	var url = "/ad010/save";

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
			<li><div class="btnProgram" style="font-weight:500;" onclick="/ad010Page.do">사용자관리</div></li>
			<li><a class="btnProgram" href="/ad020Page.do">장치관리</a></li>
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
			<label for="s_userId">사용자ID/명</label>
			<input id="s_userId" type="text" style="width:200px;" data-field="USER_ID"/>
		</form>
		<div class="contentArea">
			<div class="gridArea">
				<div class="gridTitleArea">
					<div class="gridBtnArea">
						<button id="btnAddRow" class="btnGridAction">행추가</button>
						<%--<button id="btnRemoveRow" class="btnGridAction">행삭제</button>--%>
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
							<label for="userId">사용자ID</label>
							<input type="text" id="userId" data-field="USR_ID" />
						</li>
						<li>
							<label for="userPw">비밀번호</label>
							<input type="password" id="userPw" data-field="USR_PW" />
						</li>
						<li>
							<label>사용자명</label>
							<input type="text" id="userNm" data-field="USR_NM" />
						</li>
						<li>
							<label for="userGrpCd">사용자그룹</label>
							<select id="userGrpCd" data-field="USR_GRP_CD" >
								<option value="01">관리자</option>
								<option value="02">사용자</option>
							</select>
						</li>
						<li>
							<label for="tmplTypeCd">템플릿유형</label>
							<select id="tmplTypeCd" data-field="TMPL_TYPE_CD" >
								<option value="01">듀얼</option>
								<option value="02">싱글</option>
							</select>
						</li>
						<li>
							<label>비고</label>
							<input type="text" id="rmk" data-field="RMK" />
						</li>
						<li>
							<label>사용여부</label>
							<input type="radio" id="userYN_Y" name="userYN" data-field="USE_YN" value="Y"><label for="userYN_Y">Y</label>
							<input type="radio" id="userYN_N" name="userYN" data-field="USE_YN" value="N"><label for="userYN_N">N</label>
						</li>
					</ul>
				</form>
			</div>
		</div>
	</div>
</div>
</body>
</html>
