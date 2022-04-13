<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	BoardDao boardDao = new BoardDao();
	// 카테고리(category)
	String categoryName = ""; // request.getParameter로 null값을 받을 수 없기 때문에 ""
	if(request.getParameter("categoryName")!=null) { // categoryList를 통해 받은 값이 있다면
		System.out.println("선택한 카테고리 : " + categoryName);
		categoryName = request.getParameter("categoryName"); // categoryName에 받은 값 대입
	}
	// 페이지(page)
	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage")!=null) { // 이전 또는 다음 버튼을 통해 들어왔다면
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 이전 -1, 다음 +1 값 대입
	}
	System.out.println("현재 페이지 : " + currentPage);
	int rowPerPage = 10; // 한 페이지당 게시글 개수
	int beginRow = (currentPage-1) * rowPerPage; // 페이지 별 첫 게시글 ex) 한페이지당 10이라면 1p -> 0, 2p -> 10, 3p -> 20
	int totalRow = 0; // 전체 게시글 개수
	if(categoryName.equals("")) {
		totalRow = boardDao.selectBoardTotalRow();
	} else if(request.getParameter("categoryName") != null) {
		totalRow = boardDao.selectCategoryBoardTotal(categoryName); // totalRow에 category 게시글 수 값 대입	
	}
	int lastPage = (int)(Math.ceil((double)totalRow / (double)rowPerPage)); // 마지막페이지 = (올림)전체페이지 / 한 페이지당 개수 

	// categoryList 불러오기
	ArrayList<HashMap<String, Object>> categoryList = boardDao.selectCategoryList();
	// 게시글 목록(boardList) 불러오기
	ArrayList<Board> boardList = boardDao.selectBoardListByPage(categoryName, beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<br>
	<div class="container-fluid">
	<div class="row">
	
	<!-- category별 게시글 링크 메뉴 -->
	<div class="col-sm-3">
	<div>
		<br><br><br><br>
		<ul>
				<li class="list-group text-center">
					<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="list-group-item text-dark">전체보기</a>
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
	
	<!-- 게시글 리스트 -->
	<div class="col-sm-8">
	<h1>게시글 목록 <span class="badge badge-warning badge-pill text-light"><%=totalRow%></span> </h1>
	<div>
		<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-light text-danger">게시글 입력</a>
	</div>
	<table class="table table-hover">
		<thead class="bg-warning text-light text-center">
			<tr>
				<th>카테고리</th> <!-- categoryName -->
				<th>글 제목</th> <!-- boardTitle -->
				<th>작성일</th> <!-- createDate -->
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : boardList) {
			%>
					<tr>
						<td class="text-secondary text-center"><%=b.getCategoryName()%></td>
						<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>" class="text-body"><%=b.getBoardTitle()%></a></td>
						<td class="text-secondary text-center"><%=b.getCreateDate()%></td>
					</tr>
			<%		
				}
			%>
		</tbody>
	</table>
		<div>
			<!-- 페이지가 만약 10페이지였다면 이전을 누르면 9페이지, 다음을 누르면 11페이지  -->
			<%
				if(currentPage > 1) { // 현재페이지가 1이면 이전페이지가 존재해서는 안된다.
			%>
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&&categoryName=<%=categoryName%>" class="btn btn-warning text-light">이전</a>
			<%
				}
			%>

			<%			 	
			 	if(currentPage < lastPage) { // 현재페이지가 마지막 페이지보다 클 수 없다.
			%>
			 		<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&&categoryName=<%=categoryName%>" class="btn btn-warning text-light">다음</a>
			<%
			 	}
			%>
		</div>
		</div>
	</div>
	</div>
</body>
</html>