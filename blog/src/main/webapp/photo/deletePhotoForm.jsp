<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int photoNo = Integer.parseInt(request.getParameter("photoNo")); // 삭제할 번호 받아오기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePhotoForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<br>
	
	<div class="container">
	<form method="post" action="<%=request.getContextPath()%>/photo/deletePhotoAction.jsp">
	<table class="table">
	<h1>이미지 삭제</h1>
	<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp?photoNo=<%=photoNo %>" class="btn btn-light float-right">이전으로</a>
	<tr>
		<td>photoNo</td>
		<td>
			<input type="number" name="photoNo" value="<%=photoNo%>" readonly="readonly" class="form-control">
	</tr>
	<tr>
		<td>photoPw</td>
		<td>
			<input type="password" name="photoPw" class="form-control" placeholder="Enter password">
		</td>
	</tr>
	<tr>
		<td>
			<button type="submit" class="btn btn-warning text-light">삭제</button>
		</td>
	</tr>
	</table>
	</form>
	</div>
</body>
</html>