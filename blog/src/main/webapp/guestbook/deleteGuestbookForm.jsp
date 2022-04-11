<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 스킨+메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 스킨+메인 메뉴 끝 -->
	<br>
	<div class="container">
	<h1>방명록 삭제</h1>
	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?guestbookNo=<%=guestbookNo %>" class="btn btn-light float-right">이전으로</a> 
	<form method="post" action="<%=request.getContextPath()%>/guestbook/deleteGuestbookAction.jsp?guestbookNo=<%=guestbookNo %>">
		<table class="table">
		<tr>
			<td>번호</td>
			<td><input type="text" name="guestbookNo" readonly="readonly" value="<%=guestbookNo %>" class="form-control"></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="password" name="guestbookPw" class="form-control"></td>
		</tr>
		<br>
		<tr>
			<td><button type="submit" class="btn btn-warning">삭제</button></td>
		</tr>
	</table>
	</form>
	</div>
</body>
</html>