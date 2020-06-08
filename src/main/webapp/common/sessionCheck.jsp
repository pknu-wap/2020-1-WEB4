<%@page import="egovframework.platform.module.common.vo.UserVO"%>
<%@page language="java" pageEncoding="utf-8"%>
<%
	String USER_ID = "";
	String USER_NAME = "";

	boolean DEBUG_MODE = false;

	UserVO user = (UserVO) session.getAttribute("userInfoPlatform");
	String errorPage = "/loginPage.do";

	if (user == null) {// 세션이 널일때
%>
<script>
top.document.location = "<%=errorPage%>";
</script>
<%
		return;
	} else {
		USER_ID = user.USER_ID;
		USER_NAME = user.USER_NAME;
	}
%>
<script>
var USER_INFO = {
	USER_ID: "<%=USER_ID%>",
	USER_NAME: "<%=USER_NAME%>",
}
</script>