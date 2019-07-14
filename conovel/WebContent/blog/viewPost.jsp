<%@ page language="java" contentType="text/html; charset=UTF-8"
	isELIgnored="false"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="common_head.jsp" flush="true"/>
<title>Conovel's blog</title>
</head>
<body class="w3-light-grey">
<!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
<div class="w3-content" style="max-width:1400px">
<jsp:include page="common_header.jsp" flush="true" />

<!-- Grid -->
<div class="w3-row">

<!-- Blog entries -->
<div class="w3-col l12 s12">
  <!-- Blog entry -->
  <div class="w3-card-4 w3-margin w3-white">
    <img src="/w3images/woods.jpg" alt="Nature" style="width:100%">
    <div class="w3-container">
      <h3><b>${article.title }</b></h3>
      <h5><span class="w3-opacity"><fmt:formatDate value="${article.writeDate }" /></span></h5>
    </div>

    <div class="w3-container">
      ${article.content }
    </div>
  </div>
  <hr>
<!-- END BLOG ENTRIES -->
</div>

<!-- END GRID -->
</div><br>

<!-- END w3-content -->
</div>
<jsp:include page="common_footer.jsp" flush="true" />

</body>
</html>