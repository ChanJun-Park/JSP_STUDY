<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    isELIgnored="false"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="articlesList" value="${articlesMap.articlesList }" />
<c:set var="totArticles" value="${articlesMap.totArticles }" />
<c:set var="section" value="${articlesMap.section }" />
<c:set var="pageNum" value="${articlesMap.pageNum }" />
<!DOCTYPE html>
<html>
<head>
  <title>W3.CSS Template</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
  <style>
  body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
  .no-uline {text-decoration:none;}
  .sel-page {text-decoration:none; color:red;}
  .cls1 {text-decoration:none;}
  .cls2 {text-align:center; font-size:30px;}
  </style>
</head>
<jsp:include page="/blog/template1.jsp" flush="true"></jsp:include>
<!-- Blog entries -->
<div class="w3-col l8 s12">
	<c:choose>
		<c:when test="${articlesList.size() == 0 }">
		  <!-- Blog entry -->
		  <div class="w3-card-4 w3-margin w3-white">
		    <img src="/w3images/woods.jpg" alt="Nature" style="width:100%">
		    <div class="w3-container">
		      <h3><b>아직 등록된 글이 없습니다.</b></h3>
		    </div>
		  </div>
		  <hr>
		</c:when>
		<c:when test="${articlesList != null }">
			<c:forEach var="article" items="${articlesList }" varStatus="articleNum">
			  <!-- Blog entry -->
			  <div class="w3-card-4 w3-margin w3-white">
			  <img src="/w3images/bridge.jpg" alt="Norway" style="width:100%">
			    <div class="w3-container">
			      <h3><b>${article.title }</b></h3>
			      <h5><span class="w3-opacity"><fmt:formatDate value="${article.writeDate }"/></span></h5>
			    </div>
			
			    <div class="w3-container">
			      <p>${article.content }</p>
			      <div class="w3-row">
			        <div class="w3-col m8 s12">
			          <p>
			          	<a href="${contextPath }/main/viewPost.do?articleNO=${article.articleNO}">
			          		<button class="w3-button w3-padding-large w3-white w3-border"><b>READ MORE »</b></button>
			          	</a>
			          </p>
			        </div>
			        <div class="w3-col m4 w3-hide-small">
			          <p><span class="w3-padding-large w3-right"><b>Comments  </b> <span class="w3-badge">2</span></span></p>
			        </div>
			      </div>
			    </div>
			  </div>
			</c:forEach>
		</c:when>
	</c:choose>
<!-- END BLOG ENTRIES -->
<div class="txt_center">
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

<!-- Introduction menu -->
<div class="w3-col l4">
  <!-- About Card -->
  <div class="w3-card w3-margin w3-margin-top">
  <img src="/w3images/avatar_g.jpg" style="width:100%">
    <div class="w3-container w3-white">
      <h4><b>My Name</b></h4>
      <p>Just me, myself and I, exploring the universe of uknownment. I have a heart of love and a interest of lorem ipsum and mauris neque quam blog. I want to share my world with you.</p>
    </div>
  </div><hr>
  
  <!-- Posts -->
  <div class="w3-card w3-margin">
    <div class="w3-container w3-padding">
      <h4>Popular Posts</h4>
    </div>
    <ul class="w3-ul w3-hoverable w3-white">
      <li class="w3-padding-16">
        <img src="/w3images/workshop.jpg" alt="Image" class="w3-left w3-margin-right" style="width:50px">
        <span class="w3-large">Lorem</span><br>
        <span>Sed mattis nunc</span>
      </li>
      <li class="w3-padding-16">
        <img src="/w3images/gondol.jpg" alt="Image" class="w3-left w3-margin-right" style="width:50px">
        <span class="w3-large">Ipsum</span><br>
        <span>Praes tinci sed</span>
      </li> 
      <li class="w3-padding-16">
        <img src="/w3images/skies.jpg" alt="Image" class="w3-left w3-margin-right" style="width:50px">
        <span class="w3-large">Dorum</span><br>
        <span>Ultricies congue</span>
      </li>   
      <li class="w3-padding-16 w3-hide-medium w3-hide-small">
        <img src="/w3images/rock.jpg" alt="Image" class="w3-left w3-margin-right" style="width:50px">
        <span class="w3-large">Mingsum</span><br>
        <span>Lorem ipsum dipsum</span>
      </li>  
    </ul>
  </div>
  <hr> 
 
  <!-- Labels / tags -->
  <div class="w3-card w3-margin">
    <div class="w3-container w3-padding">
      <h4>Tags</h4>
    </div>
    <div class="w3-container w3-white">
    <p><span class="w3-tag w3-black w3-margin-bottom">Travel</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">New York</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">London</span>
      <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">IKEA</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">NORWAY</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">DIY</span>
      <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">Ideas</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">Baby</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">Family</span>
      <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">News</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">Clothing</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">Shopping</span>
      <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">Sports</span> <span class="w3-tag w3-light-grey w3-small w3-margin-bottom">Games</span>
    </p>
    </div>
  </div>
  
<!-- END Introduction Menu -->
</div>
<jsp:include page="/blog/template2.jsp" flush="true"></jsp:include>
</html>