<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Guestbook"%>
<%@ page import = "dao.GuestbookDao"%>
<%@ page import = "java.util.*" %>
<%@page import="java.net.URLEncoder"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 유효성 판별
	if(request.getParameter("writer").equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp?msg="+URLEncoder.encode("글쓴이를 입력해주세요"));
		return;
	} else if (request.getParameter("guestbookPw").equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp?msg="+URLEncoder.encode("비밀번호를 입력해주세요"));
		return;
	} else if(request.getParameter("guestbookContent").equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp?msg="+URLEncoder.encode("본문을 입력해주세요"));
		return;
	}
	// 방명록 입력값 받아오기
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	 // replaceAll : "\r\n"을 <br>로 바꿈 -> gusestBookList페이지에서 줄바꿈도 보이도록 개행 처리
	String guestbookContent = request.getParameter("guestbookContent").replaceAll("\r\n","<br>");	
	System.out.println("guestbook insert writer : "+writer);
	System.out.println("guestbookPw : "+guestbookPw);
	System.out.println("guestbookContent : "+guestbookContent);
	// 하나의 변수로 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.setWriter(writer);
	guestbook.setGuestbookPw(guestbookPw);
	guestbook.setGuestbookContent(guestbookContent);
	
	GuestbookDao guestbookDao = new GuestbookDao();
	guestbookDao.insertGuestbook(guestbook);
	
	// 입력 후 guestbookList.jsp로 돌아가기
	response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
	
%>