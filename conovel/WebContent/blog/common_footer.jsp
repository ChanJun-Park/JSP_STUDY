<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- Footer -->
<footer class="w3-container w3-dark-grey w3-padding-32 w3-margin-top">
  <button class="w3-button w3-black w3-disabled w3-padding-large w3-margin-bottom">Previous</button>
  <button class="w3-button w3-black w3-padding-large w3-margin-bottom">Next »</button>
  <c:choose>
  	<c:when test="${isLogOn == null }" >
  	  <a href="${contextPath }/main/loginForm.do" class="w3-button w3-black w3-padding-large w3-margin-bottom">로그인</a>
  	</c:when>
  	<c:when test="${isLogOn != null }" >
  	  <div class="w3-container" style="float:right;">
  	  	<span>소중한 ${login_id } 님 | </span>
  	    <a href="${contextPath }/main/logout.do" class="w3-button w3-black w3-padding-large w3-margin-bottom">로그아웃</a>
  	  </div>
  	  <c:if test="${login_id == 'admin' }">
  	  <a href="${contextPath }/main/writePost.do" class="w3-button w3-black w3-padding-large w3-margin-bottom">
	  	글쓰기
	  </a>
	  <a href="${contextPath }/main/admin.do" class="w3-button w3-black w3-padding-large w3-margin-bottom">
	  	회원관리
	  </a>
	  </c:if>
  	</c:when>
  </c:choose>
  <p>Powered by <a href="https://www.w3schools.com/w3css/default.asp" target="_blank">w3.css</a></p>
</footer>