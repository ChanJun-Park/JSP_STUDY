<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="conovel.*"
    isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/blog/common_head.jsp" flush="true" />
<title>회원 정보 수정</title>
</head>
<body>
<div class="w3-content" style="max-width:1400px">
	<div class="w3-row">
		<form method="post" action="${contextPath }/main/userInfoMod.do?user_id=${memInfo.id}" class="w3-container w3-card-4 w3-light-grey w3-text-blue" style="width:50%; margin:0 auto;">
			<h2 class="w3-center">회원 정보 수정</h2>
			<div class="w3-row w3-section">
			  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-info"></i></div>
			    <div class="w3-rest">
			      <input class="w3-input w3-border" name="user_id" type="text" value="${memInfo.id }" disabled>
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
			      <input class="w3-input w3-border" name="user_name" type="text" value="${memInfo.name }">
			    </div>
			</div>
			
			<div class="w3-row w3-section">
			  <div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-envelope-o"></i></div>
			    <div class="w3-rest">
			      <input class="w3-input w3-border" name="user_email" type="email" value="${memInfo.email }">
			    </div>
			</div>
			<input type="submit" class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding" value="정보수정">
			<!-- <button class="w3-button w3-block w3-section w3-blue w3-ripple w3-padding">정보 수정</button>  -->
		</form>
	<!-- END OF ROW -->
	</div>
<!-- END OF CONTENT -->
</div>
</body>
</html>