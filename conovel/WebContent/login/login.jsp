<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<div class="w3-container">
	<div class="w3-container w3-blue">
	  <h2>Input Form</h2>
	</div>
	
	<form class="w3-container">
	  <p>
	  <label>아이디</label>
	  <input class="w3-input" type="text"></p>
	  <p>
	  <label>비밀번호</label>
	  <input class="w3-input" type="password"></p>
	  <p>
	  <input type="submit" class="w3-button w3-black" value="로그인">
	  <a class="w3-button w3-black" href="">회원가입</a>
	</form>
</div>

</div>
<jsp:include page="/blog/common_footer.jsp" flush="true" />
</body>
</html>