<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%
	// boardNo값 받아오기
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	System.out.println("게시글 상세보기 : " + boardNo);

	BoardDao boardDao = new BoardDao();
	Board board = new Board();
	// 카테고리 목록 불러오기
	ArrayList<HashMap<String,Object>> categoryList = boardDao.selectCategoryList();
	// 전체 행의 수(카테고리 전체보기)
	int totalRow = boardDao.selectBoardTotalRow();
	// 게시글 상세보기 불러오기
	board  = boardDao.selectBoardOne(boardNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container-fluid">
<div class="row">
	<!-- 스킨+메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 스킨+메인 메뉴 끝 -->
	<br>
	<!-- 카테고리 목록 -->
	<div class="col-sm-3">
	<div>
		<br><br><br><br>
		<ul>
				<li class="list-group text-center">
					<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="list-group-item text-dark">전체보기(<%=totalRow%>)</a>
				</li>
			<%
				for(HashMap<String, Object> m : categoryList) {
			%>
					
						<li class="list-group text-center"> <!-- request.getContextPath()는 프로젝트의 context path명을 반환 -->
							<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=m.get("categoryName")%>" class="list-group-item text-dark"><%=m.get("categoryName")%>(<%=m.get("cnt")%>)</a>
						</li>
			<%		
				}
			%>
		</ul>
	</div>
	</div>
	<!-- 게시글 상세보기 -->
	<div class="col-sm-8">
	<br>
	<h1>게시글 상세보기</h1>
	<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="btn btn-light float-right">목록</a>
	<table class="table table-bordered">
		<tr>
			<td class="text-secondary text-center" style="width: 10%">번호</td>
			<td><%=board.getBoardNo() %></td>
		</tr>
		<tr>
			<td class="text-secondary text-center">카테고리</td>
			<td><%=board.getCategoryName() %></td>
		</tr>
		<tr>
			<td class="text-secondary text-center">제목</td>
			<td><%=board.getBoardTitle() %></td>
		</tr>
		<tr>
			<td class="text-secondary text-center">본문</td>
			<td><%=board.getBoardContent() %></td>
		</tr>
		<tr>
			<td class="text-secondary text-center">작성일</td>
			<td><%=board.getCreateDate() %></td>
		</tr>
		<tr>
			<td class="text-secondary text-center">수정일</td>
			<td><%=board.getUpdateDate() %></td>
		</tr>
	</table>
	<div>
		<a href="<%=request.getContextPath()%>/board/updateBoardForm.jsp?boardNo=<%= board.getBoardNo() %>" class="btn btn-warning text-light ">수정</a>
		<a href="<%=request.getContextPath()%>/board/deleteBoardForm.jsp?boardNo=<%= board.getBoardNo() %>" class="btn btn-warning text-light">삭제</a>
	</div>
	</div>
</div>
</div>
</body>
</html>