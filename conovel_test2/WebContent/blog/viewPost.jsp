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
<!-- Blog entries -->
<div class="w3-col l12 s12">
  <!-- Blog entry -->
  <div class="w3-card-4 w3-margin w3-white">
  <img src="/w3images/bridge.jpg" alt="Norway" style="width:100%">
  	<div class="w3-container">
      <h3><b>${article.title }</b></h3>
      <h5><span class="w3-opacity"><fmt:formatDate value="${article.writeDate }"/></span></h5>
    </div>
    <div class="w3-container">
      <p>${article.content }</p>
      <div class="w3-row">
        comment
      </div>
    </div>
  <!-- End of Blog entry -->
  </div>
<!-- End of Blog entries -->
</div>
<jsp:include page="/blog/template2.jsp" flush="true"></jsp:include>
</html>