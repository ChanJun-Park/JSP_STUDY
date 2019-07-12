<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/blog/common_head.jsp" flush="true" />
<title>Conovel's blog</title>
</head>
<body>
<div class="w3-content" style="max-width:1400px">
	<c:if test="${registeredID == true }">
		<div class="w3-panel w3-pale-red w3-border w3-display-container">
		  <span onclick="this.parentElement.style.display='none'"
	  	  class="w3-button w3-large w3-display-topright">&times;</span>
		  <h3>이미 사용중인 아이디 입니다.</h3>
		  <p>다른 아이디를 사용하세요</p>
		</div>
	</c:if>
	<div class="w3-row">
		<form method="post" action="${contextPath }/main/register.do" class="w3-container w3-card-4 w3-light-grey w3-text-blue" style="width:50%; margin:0 auto;">
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
	<!-- END OF ROW -->
	</div>
<!-- END OF CONTENT -->
</div>
</body>
</html>