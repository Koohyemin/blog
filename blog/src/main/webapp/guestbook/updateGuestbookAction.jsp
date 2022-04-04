<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");

	// guestbookNo, guestbookPw 값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookContent = request.getParameter("guestbookContent");
	String guestbookPw = request.getParameter("guestbookPw");
	
	System.out.println("방명록 수정 번호 "+ guestbookNo);
	System.out.println("수정 비밀번호 "+ guestbookPw);
	
	// guestbook 하나의 변수로 묶기
	Guestbook guestbook = new Guestbook();
	guestbook.setGuestbookNo(guestbookNo);
	guestbook.setGuestbookContent(guestbookContent);
	guestbook.setGuestbookPw(guestbookPw);
	
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.updateGuestbook(guestbook);
	
	// 수정 성공, 실패 디버깅 후 guestbookList.jsp로 돌아가기
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		System.out.println("방명록 수정 성공");
	} else {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp");
		System.out.println("방명록 수정 실패");
	}
	
%>