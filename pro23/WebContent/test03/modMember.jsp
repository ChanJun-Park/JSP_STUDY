<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form name="frmLogin" method="post" action="../mem4.do?action=updateMember">
		<label for="id">아이디</label>
		<input type="text" id="id" name="id"><br>
		<label for="pwd">비밀번호</label>
		<input type="password" id="pwd" name="pwd"><br>
		<label for="name">이름</label>
		<input type="text" id="name" name="name"><br>
		<label for="email">이메일</label>
		<input type="email" id="email" name="email"><br>
		<input type="submit" value="제출">
	</form>
</body>
</html>