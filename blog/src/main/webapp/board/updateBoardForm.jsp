<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@page import="java.net.URLDecoder"%>
<%
	BoardDao boardDao = new BoardDao();
	CategoryDao categoryDao = new CategoryDao();
	
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));	 // boardNo 형변환 후 받아오기
	
	// 수정되기 전 게시글 보여주기
	Board board = boardDao.selectBoardOne(boardNo); // boardNo 대입
	// 수정폼에서 <br>로 보이는 부분 다시 "\r\n"으로 변경하여 개행처리 (insertAction에서 <br>로 바꿔놓은 부분 다시 안보이도록 처리)
	board.setBoardContent(board.getBoardContent().replaceAll("<br>","\r\n"));
	// 게시글 수정 시 카테고리 목록
	ArrayList<String> categoryList = categoryDao.insertCategoryName();
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
<title>updateBoardForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>
<body>
	<!-- 스킨+메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 스킨+메인 메뉴 끝 -->
	<br>
	<div class="container">
	<h1>게시글 수정</h1>
	<div class="text-danger"><%=msg %></div>
	<a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=boardNo %>" class="btn btn-light float-right">이전으로</a> 
	<form method="post" action="<%=request.getContextPath()%>/board/updateBoardAction.jsp">
		<table class="table">
			<tr>
				<td>번호</td>
				<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly="readonly" class="form-control"></td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="categoryName" class="custom-select">
						<%
							for(String s : categoryList) {
								if(s.equals(board.getCategoryName())) {
						%>
									<option selected="selected" value="<%=s%>"><%=s%></option>
						<%
								} else {
						%>
									<option value="<%=s%>"><%=s%></option>
						<%		
								}
							}
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td>제목</td>
				<td>
					<input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>" class="form-control">
				</td>
			</tr>
			<tr>
				<td>본문</td>
				<td>
					<textarea id="summernote" name="boardContent" class="form-control"><%=board.getBoardContent()%></textarea>
					<script>
						$('#summernote').summernote({
						  tabsize: 2,
						  height: 400
						});
						$(".note-editor button[aria-label='Picture']").hide();
						$(".note-editor button[aria-label='Video']").hide();
						$(".note-editor .note-view").hide();
					</script>
				</td>
			<tr>	
				<td>비밀번호</td>
				<td><input type="password" name="boardPw" value="" class="form-control" placeholder="Enter password"></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-warning text-light">수정</button>
	</form>
</div>
</body>
</html>