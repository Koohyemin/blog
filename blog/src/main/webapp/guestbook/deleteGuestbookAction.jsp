<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%
	// guestbookNo, guestbookPw 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	String guestbookPw = request.getParameter("guestbookPw");
	
	System.out.println("삭제 방명록 번호 : " + guestbookNo);
	System.out.println("삭제 비밀번호 : " + guestbookPw);
	
	GuestbookDao guestbookDao = new GuestbookDao();
	int row = guestbookDao.deleteGuestbook(guestbookNo, guestbookPw);
	
	// 삭제 성공, 실패 디버깅
	if(row == 1) {
		response.sendRedirect(request.getContextPath()+"/guestbook/guestbookList.jsp"); // 성공 시 guestbookList.jsp로 돌아가기
		System.out.println("방명록 삭제 성공");
	} else {
		response.sendRedirect(request.getContextPath() + "/guestbook/deleteGuestbookForm.jsp?guestbookNo=" + guestbookNo); // 실패 시 deleteGuestbookForm.jsp로 돌아가기
		System.out.println("방명록 삭제 실패");
	}
%>