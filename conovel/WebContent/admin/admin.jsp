<%@ page language="java" contentType="text/html; charset=UTF-8"
    import="java.util.*, conovel.*"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="/blog/common_head.jsp" />
<title>관리자 페이지</title>
</head>
<body>
<div class="w3-container">
<div class="w3-row">
	<h1 style="text-align:center;">관리자 페이지</h1>
	<table class="w3-table-all w3-card-4 w3-hoverable">
    <thead>
      <tr class="w3-light-grey">
        <th>아이디</th>
        <th>비밀번호</th>
        <th>이름</th>
        <th>이메일</th>
        <th>가입일</th>
        <th>수정</th>
        <th>삭제</th>
      </tr>
    </thead>
    <c:choose>
    	<c:when test="${membersList == null}">
    		<tr>
		    	<th colspan="7">아직 등록된 회원이 없습니다.</th>
		    </tr>
    	</c:when> 
    	<c:otherwise>
    		<c:forEach var="mem" items="${membersList }">
    		<tr>
				<th>${mem.id }</th>
				<th>${mem.pwd }</th>
				<th>${mem.name }</th>
				<th>${mem.email }</th>
				<th>${mem.joinDate }</th>
				<th><a href="${contextPath }/main/userInfoModForm.do?user_id=${mem.id}">수정</a></th>
				<th><a href="${contextPath }/main/userInfoDel.do?user_id=${mem.id}">삭제</a></th>
		    </tr>
    		</c:forEach>
    	</c:otherwise>
    </c:choose>
  </table>
</div>
</div>

</body>
</html>