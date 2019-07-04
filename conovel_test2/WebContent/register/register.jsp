<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<jsp:include page="/blog/template1.jsp" flush="true"></jsp:include>
<%
	if(request.getAttribute("idExist") != null) {
		boolean idExist = (boolean)request.getAttribute("idExist");
		if (idExist) {
%>
	<div class="w3-panel w3-yellow w3-display-container">
	  <span onclick="this.parentElement.style.display='none'"
	  class="w3-button w3-large w3-display-topright">&times;</span>
	  <h3>이미 존재하는 아이디 입니다.</h3>
	</div>
<%
		}
	}
%>
<form action="${contextPath }/main/register.do" class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin">
<h2 class="w3-center">회원가입</h2>
<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-info"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="user_id" type="text" placeholder="아이디">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-lock"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="user_pwd" type="password" placeholder="비밀번호">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-user"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="user_name" type="text" placeholder="이름">
    </div>
</div>

<div class="w3-row w3-section">
  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope-o"></i></div>
    <div class="w3-rest">
      <input class="w3-input w3-border" name="user_email" type="email" placeholder="email">
    </div>
</div>

<button class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding">회원가입</button>

</form>
<jsp:include page="/blog/template2.jsp" flush="true"></jsp:include>
</html>