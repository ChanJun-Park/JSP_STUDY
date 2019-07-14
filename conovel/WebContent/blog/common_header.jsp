<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- Header -->
<header class="w3-container w3-center w3-padding-32"> 
  <h1>
  <b><a href="${contextPath }/main/listPost.do">Conovel</a></b>
  </h1>
  <p>Welcome to the blog of <span class="w3-tag">conovel</span></p>
</header>