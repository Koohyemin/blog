<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deletePdfForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<br>
	
	<div class="container">
	<form method="post" action="<%=request.getContextPath()%>/pdf/deletePdfAction.jsp">
	<table class="table">
	<h1>pdf 삭제</h1>
	<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp" class="btn btn-light float-right">이전으로</a>
	<tr>
		<td>pdfNo</td>
		<td>
			<input type="number" name="pdfNo" value="<%=pdfNo%>" readonly="readonly" class="form-control">
	</tr>
	<tr>
		<td>pdfPw</td>
		<td>
			<input type="password" name="pdfPw" class="form-control" placeholder="Enter password">
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