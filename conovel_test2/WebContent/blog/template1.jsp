<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<body class="w3-light-grey">

<!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
<div class="w3-content" style="max-width:1400px">
<div class="w3-row">
<%
	if(session.getAttribute("isLogon") != null) {
		boolean isLogon = (boolean)session.getAttribute("isLogon");
		if (isLogon) {
%>
	<a href="${contextPath }/main/logout.do" style="float:right;">로그아웃</a>
	<span style="float:right;"><b><%=session.getAttribute("login.id") %> |&nbsp;&nbsp;</b></span>
<%
		} 
	} else {
%>
	<a href="${contextPath }/login/login.jsp" style="float:right;">로그인</a>
<%
	}
%>
</div>
<!-- Header -->
<header class="w3-container w3-center w3-padding-32"> 
  <a href="${contextPath }/main" style="text-decoration:none;"><h1><b>MY BLOG</b></h1></a>
  <p>Welcome to the blog of <span class="w3-tag">unknown</span></p>
</header>

<!-- Grid -->
<div class="w3-row">