<%@ page import="java.net.URL" %>
<%@ page import="org.springframework.web.client.RestTemplate" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.io.IOException" %><%--
  Created by IntelliJ IDEA.
  User: clarscent
  Date: 2018-07-15
  Time: 오후 5:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String BASE_URL = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastGrib";
	String SERVICE_KEY = "Pr0%2BvJO7KbzOHi5F7PvzLXMofGyO45VCWPPrIOYOYb7JKgca79HgMktrjbE1QD73LXdmcUjixUN5rlteYxI5JQ%3D%3D";

	String WEATHER_URL = BASE_URL + "?ServiceKey=" + SERVICE_KEY;
	WEATHER_URL += "&base_date=20180715";
	WEATHER_URL += "&base_time=1700";
	WEATHER_URL += "&nx=55";
	WEATHER_URL += "&ny=127";
	WEATHER_URL += "&pageNo=1";
	WEATHER_URL += "&numOfRows=1";

	StringBuilder urlBuilder = new StringBuilder(WEATHER_URL); /*URL*/
	HttpURLConnection conn = null;
	BufferedReader rd = null;
	StringBuilder sb = null;
	try {
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + SERVICE_KEY); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode("20180906", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("1700", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode("55", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode("127", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));
		urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8"));

		/*각각의 base_time 로 검색 참고자료 참조 : 규정된 시각 정보를 넣어주어야 함 */
		URL url = new URL(urlBuilder.toString());
		conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		System.out.println("Response code: " + conn.getResponseCode());

		if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}

		System.out.println("RESULT:" + sb);
	}
	catch (IOException ex) {
		ex.printStackTrace();
	}
	finally {
		if(conn != null) {
			conn.disconnect();
		}
		if(rd != null) {
			try {
				rd.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
%>

<%=sb%>
가망ㄹ망람ㄴㅇㄹ231423