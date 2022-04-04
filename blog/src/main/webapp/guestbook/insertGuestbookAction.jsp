<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.Guestbook"%>
<%@ page import = "dao.GuestbookDao"%>
<%@ page import = "java.util.*" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 방명록 입력값 받아오기
	String writer = request.getParameter("writer");
	String guestbookPw = request.getParameter("guestbookPw");
	String guestbookContent = request.getParameter("guestbookContent");	
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