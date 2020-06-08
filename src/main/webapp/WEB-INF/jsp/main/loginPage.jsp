<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
	request.setCharacterEncoding("utf-8");
	String comment = "";
	String commenter = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>[PLATFORM]LOGIN</title>
<link rel="stylesheet" href="/css/font/notosanskr.css" type="text/css" />
<link rel="stylesheet" href="/css/font/NotoSansKR-Hestia.css" type="text/css" />
<link rel="stylesheet" href="/js/jqueryui/jquery-ui.min.css" type="text/css" />
<link rel="stylesheet" href="/css/main.css" type="text/css" />
<script type="text/javascript" src="/js/jquery/jquery-3.3.1.min.js"></script>
<script type="text/javascript" src="/js/jqueryui/jquery-ui.min.js"></script>
<script type="text/javascript" src="/js/loadsh/lodash.min.js"></script>
<script type="text/javascript" src="/js/platform.js"></script>
<script type="text/javascript" src="/js/platformUtil.js"></script>
<style>
body {
	background-color: #f0f0f0;
	width: 100%;
	height: 100%;
}

#loginContainer {
	position: absolute;
	top: calc(50% - 158px);
	left: calc(50% - 200px);
	width: 400px;
	height: 315px;
	margin: 0 auto;
	text-align: center;
}

#loginTitle {
	text-align: center;
	font-weight: 500;
	font-size: 30px;
	margin-bottom: 43px;
}

#userId, #userPw, #btnLogin {
	font-size: 18px;
	width: 400px;
	height: 60px;
	margin-bottom: 20px;
	padding: 20px;
	border: 1px solid #CCCCCC;
}

input::placeholder {
	font-size: 18px;
	color: #aaaaaa;
}

#btnLogin {
	font-size: 20px;
	color: #fff;
	background-color: #008CE5;
	outline: 0;
	height: 65px;
	cursor: pointer;
}
</style>
<script type="text/javascript">
var checkValidation = function() {
	var $id = $("#userId");
	var $pw = $("#userPw");
	var $login = $("#btnLogin");

	if ($id.val() === "") {
		alert("아이디를 입력하세요.");
		$id.focus();
		return false;
	}

	if ($pw.val() === "") {
		alert("비밀번호를 입력하세요.");
		$pw.focus();
		return false;
	}

	return true;
}

var initPage = function() {
	var $id = $("#userId");
	var $pw = $("#userPw");
	var $login = $("#btnLogin");

	$id.focus();

	$id.on("keydown", function(evt){
		if (evt.keyCode == 13) {
			$pw.focus();
		}
	});

	$pw.on("keydown", function(evt){
		if (evt.keyCode == 13) {
			$login.trigger("click");
		}
	});

	$login.on("click", function() {
		if (!checkValidation()) {
			return;
		}

		var param = {
			COMP_CD : "01",
			USR_ID : $id.val(),
			USR_PW : $pw.val()
		};

		platform.postService("/loginProcess", param, function(result) {
			console.log("loginProcess", result);

			if (result["USR_OK"]) {
				$(location).attr("href", "/mainPage.do");
			} else {
				alert("로그인 정보를 확인하세요");
				$id.focus();
				$id.select();
				$pw.val("");
			}
		}, true);
	});
};
</script>
</head>
<body>
<div id="loginContainer">
	<h1 id="loginTitle">로그인</h1>
	<input id="userId" type="text" style="" placeholder="아이디" />
	<input id="userPw" type="password" style="width:400px; height:60px;" placeholder="비밀번호" />
	<button id="btnLogin">로그인</button>
</div>
</body>
</html>