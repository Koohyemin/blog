<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "newBadge.*" %>
<%@ page import = "java.util.ArrayList" %>
<%@page import="java.net.URLDecoder"%>
<%
	int currentPage = 1;

	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 5;
	int beginRow = (currentPage-1) * rowPerPage;
	
	GuestbookDao guestbookDao = new GuestbookDao();
	ArrayList<Guestbook> list = guestbookDao.selectGuestbookListByPage(beginRow, rowPerPage);
	
	int lastPage = 0;
	int totalCount = guestbookDao.selectGuestbookTotalRow();

	/*
	lastPage = totalCount / rowPerPage;
	if(totalCount % rowPerPage != 0) {
		lastPage++;
	}
	*/
	lastPage = (int)(Math.ceil((double)totalCount / (double)rowPerPage)); 
	// 4.0 / 2.0 = 2.0
	// 5.0 / 2.0 = 2.5 -> 3.0
	
	// 최근 일주일 날짜 목록 불러오기
	Badge badge = new Badge();
	ArrayList<String> currentSevenDays = badge.currentSevenDays();
	
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
<title>guestbookList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 스킨+메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 스킨+메인 메뉴 끝 -->
	<br>
	<div class="container">
	<h1>방명록<span class="badge badge-warning badge-pill text-light"><%=totalCount%></span></h1>
	<div class="text-danger"><%=msg %></div>
		<!-- 방명록 입력 -->
		<form method="post" action="<%=request.getContextPath()%>/guestbook/insertGuestbookAction.jsp"><br>
			<table border="1" class="table table-borderless">
				<tr>
					<td class="align-middle">글쓴이</td>
					<td><input type="text" name="writer" class="form-control"></td>
					<td class="align-middle">비밀번호</td>
					<td><input type="password" name="guestbookPw" class="form-control"></td>
				</tr>
				<tr>
					<td colspan="5">
						<textarea name="guestbookContent" rows="2" cols="60" class="form-control"></textarea>
					</td>
					<td><button type="submit" class="btn btn-outline-secondary">등록</button></td>
			</table>
		</form>
		<!-- 방명록 리스트 -->
		<%
			for(Guestbook g : list) {
		%>
				<div>
					<a href="<%=request.getContextPath()%>/guestbook/updateGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn text-primary float-right">수정</a>
					<a href="<%=request.getContextPath()%>/guestbook/deleteGuestbookForm.jsp?guestbookNo=<%=g.getGuestbookNo()%>" class="btn text-danger float-right">삭제</a>
				</div>
				<table border="1" class="table table-striped">
					<tr>
						<td class="text-secondary table-warning"><%=g.getWriter() %>
							<%
								// 최근 7일 방명록에 new 뱃지 추가
								for(String s : currentSevenDays) {
									if(s.equals(g.getCreateDate().substring(0,10))) {
							%>
									 <span class="badge badge-warning">new</span>
							<%
									}
								}
							%>
						</td>
						<td class="text-secondary table-warning" align="right"><%=g.getCreateDate() %></td>
					</tr>
					<tr>
						<td colspan="2" ><%=g.getGuestbookContent() %></td>
					</tr>
				</table>
				<%
					}
		
					if(currentPage > 1) {
				%>
						<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage-1 %>" class="btn btn-outline-warning btn-sm text-dark">이전</a>
				<%	
					}
					if(currentPage < lastPage) {
				%>
						<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?currentPage=<%=currentPage+1 %>" class="btn btn-outline-warning btn-sm text-dark">다음</a>
				<%
					}
				%>
	</div>
		<br>
		<br>
	<div>
	</div>
</body>
</html>