<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<jsp:include page="common_head.jsp" flush="true" />
<title>Conovel's blog</title>
</head>
<body>
<div class="w3-content" style="max-width:1400px">
<div class="w3-row">
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
<!-- End of ROW -->
</div>
<!-- End of content -->
</div>
<jsp:include page="common_footer.jsp" flush="true" />
</body>
</html>