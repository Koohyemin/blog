<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Guestbook" %>
<%@ page import = "dao.GuestbookDao" %>

<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	
	// 수정버튼을 통해 guestbookNo값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	
	GuestbookDao guestbookDao = new GuestbookDao();
	Guestbook guestbook = guestbookDao.selectGuestbookOne(guestbookNo);
	
	// 수정폼에서 <br>로 보이는 부분 다시 "\r\n"으로 변경하여 개행처리 (insertAction에서 <br>로 바꿔놓은 부분 다시 안보이도록 처리)
	guestbook.setGuestbookContent(guestbook.getGuestbookContent().replaceAll("<br>","\r\n"));
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateGuestbookForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 스킨+메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 스킨+메인 메뉴 끝 -->
	<br>
	<div class="container">
	<h1>방명록 수정</h1>
	<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp?guestbookNo=<%=guestbookNo %>" class="btn btn-light float-right">이전으로</a> 
	<form method="post" action="<%=request.getContextPath()%>/guestbook/updateGuestbookAction.jsp?guestbookNo=<%=guestbookNo %>">
		<table border="1" class="table table-bordered">
			<tr>
				<td>글쓴이</td>
				<td><input type="text" name="writer" readonly="readonly" value= "<%=guestbook.getWriter() %>" class="form-control"></td>
				<td>비밀번호</td>
				<td><input type="password" name="guestbookPw" class="form-control"></td>
			</tr>
			<tr>
				<td colspan="4"><textarea name="guestbookContent" rows="2" cols="60" class="form-control"><%=guestbook.getGuestbookContent() %></textarea></td>
			</tr>
		</table>
		<button type="submit" class="btn btn-warning text-light">수정</button>
	</form>
	</div>
</body>
</html>