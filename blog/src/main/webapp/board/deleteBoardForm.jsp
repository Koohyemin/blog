<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo")); // boardNo 받아오기(String->Int)
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
</head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<body>
	<!-- 스킨+메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 스킨+메인 메뉴 끝 -->
	<br>
	<div class="container">
	<h1>게시글 삭제</h1>
	<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo %>" class="btn btn-light float-right">이전으로</a> 
	<form method="post" action="<%=request.getContextPath()%>/board/deleteBoardAction.jsp">
	<table class="table">
		<tr>
			<td>boardNo</td>
			<td>
				<input type="number" name="boardNo" value="<%=boardNo %>" readonly="readonly" class="form-control">   <!-- 번호는 수정x -->
			</td>
		</tr>
		<tr>
			<td>boardPw</td>
			<td>
				<input type="password" name="boardPw" class="form-control" placeholder="Enter password">
			</td>
		</tr>
		<br>
		<tr>
			<td><button type="submit" class="btn btn-warning text-light">삭제</button></td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>