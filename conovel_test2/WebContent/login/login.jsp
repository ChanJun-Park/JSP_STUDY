<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
  <title>W3.CSS Template</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
  <style>
  body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
  </style>
</head>
<jsp:include page="/blog/template1.jsp" flush="true"></jsp:include>
<%
	if(request.getAttribute("login_fail") != null) {
		boolean login_fail = (boolean)request.getAttribute("login_fail");
		if (login_fail) {
%>
	<div class="w3-panel w3-red w3-display-container">
	  <span onclick="this.parentElement.style.display='none'"
	  class="w3-button w3-large w3-display-topright">&times;</span>
	  <h3>아이디가 존재하지 않거나, 비밀번호가 일치하지 않습니다.</h3>
	  <p>다시 로그인 하세요.</p>
	</div>
<%
		}
	}
%>

<%
	if(request.getAttribute("needLogin") != null) {
		boolean needLogin = (boolean)request.getAttribute("needLogin");
		if (needLogin) {
%>
	<div class="w3-panel w3-yellow w3-display-container">
	  <span onclick="this.parentElement.style.display='none'"
	  class="w3-button w3-large w3-display-topright">&times;</span>
	  <h3>로그인 하신후 이용가능합니다.</h3>
	</div>
<%
		}
	}
%>
<div style="width:50%; margin:0 auto;"	>
	<div class="w3-container w3-blue">
	  <h2>로그인</h2>
	</div>
	<form class="w3-container" method="post" action="${contextPath }/main/login.do">
		<label>아이디</label>
		<input class="w3-input" type="text" name="user_id">
		
		<label>비밀번호</label>
		<input class="w3-input" type="password" name="user_pwd">
		<input type="submit" class="w3-button w3-black" value="로그인">
		<a class="w3-button w3-black" href="${contextPath }/register/register.jsp">회원가입</a>
	</form>
</div>
<jsp:include page="/blog/template2.jsp" flush="true"></jsp:include>
</html>