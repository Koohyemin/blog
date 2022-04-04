<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<br>
	<div class = "container">
	     	<img src="<%=request.getContextPath()%>/home/garden.jpg"  width="1100" height="500">
	        	<h1 class="bg-warning text-light">Welcome to My BLOG</h1>
	        	<h4 class="bg-warning text-light">up-menu를 클릭해 다양한 blog의 컨텐츠를 구경해보세요.</h4>
	</div>
</body>
</html>