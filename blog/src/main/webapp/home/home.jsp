<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "java.util.*" %>

<%
	// 최근 게시글 5개 불러오기
	BoardDao boardDao = new BoardDao();
	ArrayList<Board> boardList = boardDao.selectBoardListByPage("","", 0, 5); // 카테고리 상관없이 최근 5개 게시글 값 셋팅
	
	// 최근 방명록 3개 불러오기
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> guestbookList = guestbookDao.selectGuestbookListByPage(0, 3); 
	
	
	
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>home</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<br>
	<div class = "container">
	<div class="row">
		<div class="col-sm-2">
			<h4 class="text-center text-info"> ㅤㅤ프로필</h4>
				<img src="<%=request.getContextPath()%>/home/happy.png" height="300" width="200" class="rounded">
					<div class="text-info">구혜민(hyeminKoo)</div> <!-- 이름 -->
					<div class="text-info">kmys4007@naver.com</div> <!-- 이메일 -->
					<div>저의 블로그에 오신 걸 환영합니다! 상단의 메뉴를 통해 다양한 콘텐츠를 구경하세요!</div> <!-- 소개글 -->
		</div>
		<div class="col-sm-1">
		</div>
		<div class="col-sm-9">
			<h4 class="text-center text-info">최근 게시글 <span class="badge badge-warning">new</span></h4>
				<table class="table table-hover">
					<thead>
						<th>카테고리</th>
						<th>글 제목</th>
						<th>작성일</th>
					</thead>
					<tbody>
						<%
							for(Board b : boardList) {
						%>
								<tr>
									<td><%=b.getCategoryName()%></td>
									<td><a href="<%=request.getContextPath()%>/board/boardOne.jsp?boardNo=<%=b.getBoardNo()%>" class="text-body"><%=b.getBoardTitle()%></a></td>
									<td><%=b.getCreateDate()%></td>
								</tr>
						<%
							}
						%>
					</tbody>
				</table>
			<h4 class="text-center text-info">최근 방명록 <span class="badge badge-warning">new</span></h4>
					<%
						for(Guestbook g : guestbookList) {
					%>
							<table border="1" class="table table-striped">
								<tr>
									<td class="text-secondary text-center"><%=g.getWriter() %></td>
									<td class="text-secondary" align="right"><%=g.getCreateDate() %></td>
								</tr>
								<tr>
									<td colspan="2" ><%=g.getGuestbookContent() %></td>
								</tr>
							</table>
					<%
						}
					%>
		</div>
	</div>
	</div>
</body>
</html>