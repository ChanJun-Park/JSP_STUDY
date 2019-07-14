<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 화면</title>
<jsp:include page="/blog/common_head.jsp" flush="true" />
</head>
<body class="w3-light-grey">
<!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
<div class="w3-content" style="max-width:1400px">

<div class="w3-container" style="width:50%; margin:0 auto;">
	<c:if test="${invalidLogin == true }">
		<div class="w3-panel w3-pale-red w3-border w3-display-container">
		  <span onclick="this.parentElement.style.display='none'"
	  	  class="w3-button w3-large w3-display-topright">&times;</span>
		  <h3>로그인 정보가 올바르지 않습니다</h3>
		  <p>다시 로그인 하세요</p>
		</div>
	</c:if>
	<div class="w3-container w3-blue">
	  <h2>로그인</h2>
	</div>
	
	<form method="post" action="${contextPath }/main/login.do" class="w3-container">
	  <p>
	  <label>아이디</label>
	  <input class="w3-input" type="text" name="user_id"></p>
	  <p>
	  <label>비밀번호</label>
	  <input class="w3-input" type="password" name="user_pwd"></p>
	  <p>
	  <input type="submit" class="w3-button w3-black" value="로그인">
	  <a class="w3-button w3-black" href="${contextPath }/main/registerForm.do">회원가입</a>
	</form>
</div>

</div>
</body>
</html>