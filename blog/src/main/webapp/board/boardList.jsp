<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%@ page import = "java.util.*" %>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩

	BoardDao boardDao = new BoardDao();
	// 검색 내용 받아오기
	String boardSearch = "";
	if(request.getParameter("boardSearch")!=null) {
		boardSearch = request.getParameter("boardSearch");
	}
	// 카테고리(category)
	String categoryName = ""; // request.getParameter로 null값을 받을 수 없기 때문에 ""
	if(request.getParameter("categoryName")!=null) { // categoryList를 통해 받은 값이 있다면
		categoryName = request.getParameter("categoryName"); // categoryName에 받은 값 대입
		System.out.println("선택한 카테고리 : " + categoryName);
	}
	
	// category 목록 불러오기
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<String> selectCategory = categoryDao.insertCategoryName();
	
	// 페이지(page)
	int currentPage = 1; // 현재 페이지
	if(request.getParameter("currentPage")!=null) { // 이전 또는 다음 버튼을 통해 들어왔다면
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 이전 -1, 다음 +1 값 대입
	}
	System.out.println("현재 페이지 : " + currentPage);
	int rowPerPage = 10;
	if(request.getParameter("rowPerPage")!=null) { // 사용자가 페이지당 개수를 지정했다면 변경
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		// System.out.println("사용자 지정 한 페이지당 출력 게시글 개수 : " + rowPerPage);
	}
	int beginRow = (currentPage-1) * rowPerPage; // 페이지 별 첫 게시글 ex) 한페이지당 10이라면 1p -> 0, 2p -> 10, 3p -> 20
	int totalRow = 0; // 전체 게시글 개수
	if(categoryName.equals("")) {
		totalRow = boardDao.selectBoardTotalRow(boardSearch);
	} else if(request.getParameter("categoryName") != null) {
		totalRow = boardDao.selectCategoryBoardTotal(categoryName, boardSearch); // totalRow에 category 게시글 수 값 대입	
	}
	int lastPage = (int)(Math.ceil((double)totalRow / (double)rowPerPage)); // 마지막페이지 = (올림)전체페이지 / 한 페이지당 개수 
	
	// 게시글 목록(boardList) 불러오기
	ArrayList<Board> boardList = boardDao.selectBoardListByPage(categoryName, boardSearch, beginRow, rowPerPage);
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
				for(String s : selectCategory) {
			%>
					
						<li class="list-group text-center"> <!-- request.getContextPath()는 프로젝트의 context path명을 반환 -->
							<a href="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=s%>" class="list-group-item text-dark">
								<%=s%>(<%=boardDao.selectCategoryBoardTotal(s, "")%>) <!-- 카테고리(카테고리 별 개수(검색기능 관계 없이)) -->
							</a>
						</li>
			<%		
				}
			%>
		</ul>
	</div>
	</div>
	<!-- 게시글 리스트 구간 -->
	<div class="col-sm-8">
	<h1>게시글 목록 <span class="badge badge-warning badge-pill text-light"><%=totalRow%></span> </h1>
	<!-- 한페이지에 보고싶은 개수 선택(totalRow) -->
	<form method="post" action="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=categoryName%>">
		<select name="rowPerPage" onchange="this.form.submit()" class="form-control col-lg-1" style="float:left">
			<option value="5" <%if(rowPerPage==5){%>selected="selected"<%}%>>5개씩</option>
			<option value="10" <%if(rowPerPage==10){%>selected="selected"<%}%>>10개씩</option>
			<option value="15" <%if(rowPerPage==15){%>selected="selected"<%}%>>15개씩</option>
			<option value="20" <%if(rowPerPage==20){%>selected="selected"<%}%>>20개씩</option>
			<option value="25" <%if(rowPerPage==25){%>selected="selected"<%}%>>25개씩</option>
			<option value="30" <%if(rowPerPage==30){%>selected="selected"<%}%>>30개씩</option>
			<option value="40" <%if(rowPerPage==40){%>selected="selected"<%}%>>40개씩</option>
			<option value="50" <%if(rowPerPage==50){%>selected="selected"<%}%>>50개씩</option>
		</select>
	</form>
	<!-- 게시글 입력 버튼 -->
	<div style="float:left">
		&nbsp;<a href="<%=request.getContextPath()%>/board/insertBoardForm.jsp" class="btn btn-light text-danger">게시글 입력</a>
	</div>
	<!-- 게시글 제목 검색 -->
	<form method="post" action="<%=request.getContextPath()%>/board/boardList.jsp?categoryName=<%=categoryName%>">
		<div class="col-lg-4 input-group mb-3" style="float:right">
			<%
				if("".equals(boardSearch)){
			%>
					<input type="text" name="boardSearch" placeholder="검색어를 입력하세요" class="form-control">
			<%
				} else {
			%>
					<input type="text" name="boardSearch" value="<%=boardSearch%>" class="form-control">
			<%
				}
			%>
			<button type="submit" class="btn btn-outline-warning" style="float:right">검색</button>
		</div>
	</form>
	<!-- 게시글 테이블 -->
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
				if(totalRow == 0) { // 게시글이 0개라면
			%>
					<tr class="text-danger text-center">
						<td colspan="3">게시글이 존재하지 않습니다</td>
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
					<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage-1%>&&categoryName=<%=categoryName%>&&totalRow=<%=totalRow%>&&boardSearch=<%=boardSearch%>&&rowPerPage=<%=rowPerPage%>" class="btn btn-warning text-light">이전</a>
			<%
				}
			%>

			<%			 	
			 	if(currentPage < lastPage) { // 현재페이지가 마지막 페이지보다 클 수 없다.
			%>
			 		<a href="<%=request.getContextPath()%>/board/boardList.jsp?currentPage=<%=currentPage+1%>&&categoryName=<%=categoryName%>&&totalRow=<%=totalRow%>&&boardSearch=<%=boardSearch%>&&rowPerPage=<%=rowPerPage%>" class="btn btn-warning text-light">다음</a>
			<%
			 	}
			%>
		</div>
		</div>
	</div>
	</div>
</body>
</html>