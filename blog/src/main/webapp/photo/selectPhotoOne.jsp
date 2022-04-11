<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%
	PhotoDao photoDao = new PhotoDao();
	Photo photo = null;

	int photoNo = Integer.parseInt(request.getParameter("photoNo")); // 상세보기 번호 받아오기
	System.out.println("photo.one : " + photoNo);
	
	photo = photoDao.selectPhotoOne(photoNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectPhotoOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<!-- 스킨+메인 메뉴 -->
<jsp:include page="/inc/upMenu.jsp"></jsp:include>
<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
<!-- 스킨+메인 메뉴 끝 -->
<br>
	<div class="container">
	<h1>이미지 상세보기</h1>
	<div class="btn-group float-right">
		<a href="<%=request.getContextPath()%>/photo/deletePhotoForm.jsp?photoNo=<%= photo.getPhotoNo() %>" class="btn btn-warning text-light">삭제</a>
	</div>
		<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="btn btn-light">이전으로</a>
	<table class="table table-bordered">
		<tr>
			<td class="text-secondary" nowrap>번호</td>
			<td><%=photo.getPhotoNo() %></td>
		</tr>
		<tr>
			<td class="text-secondary" nowrap>작성자</td>
			<td><%=photo.getWriter()%></td>
		</tr>
		<tr>
			<td class="text-secondary" nowrap>제목</td>
			<td><%=photo.getPhotoOriginalName()%></td> 
		</tr>
		<tr>
			<td class="text-secondary" nowrap>사진</td>
			<td>
				<img src="<%=request.getContextPath() %>/uploadPhoto/<%=photo.getPhotoName()%>" class="img-fluid">
			</td>
		</tr>
		<tr>
			<td class="text-secondary" nowrap>작성일</td>
			<td><%=photo.getCreateDate()%></td>
		</tr>
		<tr>
			<td class="text-secondary" nowrap>수정일</td>
			<td><%=photo.getUpdateDate()%></td>
		</tr>
	</table>
</div>
</body>
</html>