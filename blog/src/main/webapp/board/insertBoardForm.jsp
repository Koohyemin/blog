<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*"%>
<%@page import="java.net.URLDecoder"%>
<%
	request.setCharacterEncoding("utf-8");
	// 게시글 입력에 필요한 카테고리 목록
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<String> list = categoryDao.insertCategoryName();
	// 유효성 판별
	String msg = "";
	if(request.getParameter("msg") != null) {
		msg = request.getParameter(URLDecoder.decode("msg"));
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoardForm</title>

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 스킨+메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 스킨+메인 메뉴 끝 -->
	<br>
	<div class="container">
	<h1>게시글 입력</h1>
	<div class="text-danger"><%=msg %></div>
	<a href="<%=request.getContextPath()%>/board//boardList.jsp" class="btn btn-light float-right">이전으로</a> 
	<form method="post" action="<%=request.getContextPath() %>/board/insertBoardAction.jsp">
		<table class="table">
			<tr>
				<td>카테고리</td>
				<td>
					<select name="categoryName" class="custom-select">
						<%
							for(String s : list) {
						%>
								<option value="<%=s %>"><%=s %></option>
						<%		
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="boardTitle" class="form-control">
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="boardContent" rows="5" cols="80" class="form-control"></textarea>
				</td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td>
					<input type="password" name="boardPw" class="form-control">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit" class="btn btn-warning text-light">등록</button> 
				</td>
			</tr>
		</table>
	</form>
</div>
</body>
</html>