<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="conovel.*"
    isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="articlesList" value="${articlesMap.articlesList }" />
<c:set var="totArticles" value="${articlesMap.totArticles }" />
<c:set var="section" value="${articlesMap.section }" />
<c:set var="pageNum" value="${articlesMap.pageNum }" />
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<title>Conovel's blog</title>
<style>
body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
.no-uline {text-decoration:none;}
.sel-page {text-decoration:none; color:red;}
.cls1 {text-decoration:none;}
.cls2 {text-align:center; font-size:30px;}
</style>
<jsp:include page="common_head.jsp" flush="true" />
</head>
<body class="w3-light-grey">

<!-- w3-content defines a container for fixed size centered content, 
and is wrapped around the whole page content, except for the footer in this example -->
<div class="w3-content" style="max-width:1400px">
<jsp:include page="common_header.jsp" flush="true" />

<!-- Grid -->
<div class="w3-row">

<!-- Blog entries -->
<div class="w3-col l8 s12">

  <c:choose>
  	<c:when test="${articlesList.size() == 0 }">
  	  <!-- Blog entry -->
	  <div class="w3-card-4 w3-margin w3-white">
	    <img src="/w3images/woods.jpg" alt="Nature" style="width:100%">
	    <div class="w3-container">
	      <h3><b>아직 등록된 게시물이 없습니다.</b></h3>
	    </div>
	  </div>
	  <hr>
  	</c:when>
  	<c:when test="${articlesList != null }">
  	  <c:forEach var="article" items="${articlesList }" >
  	  <!-- Blog entry -->
	  <div class="w3-card-4 w3-margin w3-white">
	    <img src="/w3images/woods.jpg" alt="Nature" style="width:100%">
	    <div class="w3-container">
	      <h3><b>${article.title }</b></h3>
	      <h5><span class="w3-opacity"><fmt:formatDate value="${article.writeDate }" /></span></h5>
	    </div>
	
	    <div class="w3-container">
	      <div class="w3-row">
	        <div class="w3-col m8 s12">
	          <p><a href="${contextPath }/main/viewPost.do?articleNO=${article.articleNO}" class="w3-button w3-padding-large w3-white w3-border"><b>READ MORE »</b></a></p>
	        </div>
	        <div class="w3-col m4 w3-hide-small">
	          <p><span class="w3-padding-large w3-right"><b>Comments  </b> <span class="w3-tag">0</span></span></p>
	        </div>
	      </div>
	    </div>
	  </div>
	  <hr>
  	  </c:forEach>
  	</c:when>
  </c:choose>
<!-- END BLOG ENTRIES -->
<div style="text-align:center; font-size:25px;">
	<c:if test="${totArticles != null }">
		<c:choose>
			<c:when test="${ totArticles > 100 }">
				<c:forEach var="page" begin="1" end="10" step="1">
					<c:if test="${section > 1 && page==1 }">
						<a class="no-uline" 
						href="${contextPath }/main/listPost.do?section=${section-1 }&pageNum=10">
							&nbsp; pre
						</a>
					</c:if>
					<c:choose>
						<c:when test="${page==pageNum }">
							<a class="sel-page" href="${contextPath }/main/listPost.do?section=${section}&pageNum=${page}">
								${(section-1)*10 + page}
							</a>
						</c:when>
						<c:otherwise>
							<a class="no-uline" href="${contextPath }/main/listPost.do?section=${section}&pageNum=${page}">
								${(section-1)*10 + page}
							</a>
						</c:otherwise>
					</c:choose>
					<c:if test="${page == 10 }">
						<a class="no-uline" href="${contextPath }/main/listPost.do?section=${section+1}&pageNum=1">
							&nbsp; next
						</a>
					</c:if>
				</c:forEach>
			</c:when>
			<c:when test="${totArticles == 100 }">
				<c:forEach var="page" begin="1" end="10" step="1">
					<c:choose>
						<c:when test="${page==pageNum }">
							<a class="sel-page" href="${contextPath }/main/listPost.do?section=${section}&pageNum=${page}">
								${page }
							</a>
						</c:when>
						<c:otherwise>
							<a class="no-uline" href="${contextPath }/main/listPost.do?section=${section}&pageNum=${page}">
								${page }
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
			
			<c:when test="${totArticles < 100 }">
				<c:forEach var="page" begin="1" end="${ totArticles/10 + 1}" step="1">
					<c:choose>
						<c:when test="${page==pageNum }">
							<a class="sel-page" href="${contextPath }/main/listPost.do?section=${section}&pageNum=${page}">
								${page }
							</a>
						</c:when>
						<c:otherwise>
							<a class="no-uline" href="${contextPath }/main/listPost.do?section=${section}&pageNum=${page}">
								${page }
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</c:when>
		</c:choose>
	</c:if>
</div>
</div>

<jsp:include page="common_side.jsp" flush="true" />
<!-- END GRID -->
</div><br>

<!-- END w3-content -->
</div>
<jsp:include page="common_footer.jsp" flush="true" />
</body>
</html>