<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html> 
<head>
  <title>W3.CSS Template</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
  <script src="https://cdn.ckeditor.com/ckeditor5/12.2.0/classic/ckeditor.js"></script>
  <style>
  body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
  #articleForm {
  	padding: 10px;
  }
  </style>
</head>
<jsp:include page="/blog/template1.jsp" flush="true"></jsp:include>
<!-- Blog entries -->
<div class="w3-col l12 s12">
  <!-- Blog entry -->
  <div class="w3-card-4 w3-margin w3-white">
  	<form name="articleForm" id="articleForm" class="w3-container" method="post" action="${contextPath }/main/addPost.do" enctype = "multipart/form-data">
  	<input name="title" class="w3-input w3-border" type="text" maxlength = "500" placeholder="제목" />
  	<textarea name="content" id="editor"></textarea>

    <script>
	    ClassicEditor
	        .create( document.querySelector( '#editor' ) )
	        .catch( error => {
	            console.error( error );
	        } );
	</script>
	<div class="w3-margin">
      <button class="w3-button w3-black w3-padding-large w3-margin-bottom">등록</button>
    </div>
  	</form>
  <!-- End of Blog entry -->
  </div>
  
<!-- End of Blog entries -->
</div>
<jsp:include page="/blog/template2.jsp" flush="true"></jsp:include>
</html>