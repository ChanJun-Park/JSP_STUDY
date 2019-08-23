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
	<h1>회원 검색</h1>
	<form action="../mem4.do">
		<input type="hidden" name="action" value="searchMember" />
		이름 : <input type="text" name="name" /><br>
		이메일 : <input type="text" name="email" /><br>
		<input type="submit" value="검색" />
	</form>
</body>
</html>