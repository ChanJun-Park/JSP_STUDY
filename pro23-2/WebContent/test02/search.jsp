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
	<form action="../mem3.do">
		입력: <input type="text" name="value"/>
		<select name="action">
			<option value="listMembers">전체</option>
			<option value="selectMemberById">아이디</option>
			<option value="selectMemberByPwd">비밀번호</option>
		</select><br>
		<input type="submit" value="검색"/>
	</form>
</body>
</html>