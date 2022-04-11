<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.GuestbookDao" %>
<%@ page import = "vo.Guestbook" %>
<%@page import="java.net.URLEncoder"%>
<%
	// 인코딩
	request.setCharacterEncoding("utf-8");
	// 유효성 판별
	if(request.getParameter("guestbookPw").equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo="+request.getParameter("guestbookNo")+"&msg="+URLEncoder.encode("비밀번호를 입력해주세요"));
		return;
	} else if (request.getParameter("guestbookContent").equals("")) {
		response.sendRedirect(request.getContextPath()+"/guestbook/updateGuestbookForm.jsp?guestbookNo="+request.getParameter("guestbookNo")+"&msg="+URLEncoder.encode("본문을 입력해주세요"));
		return;
	}
	
	// guestbookNo, guestbookPw 값 받아오기
	int guestbookNo = Integer.parseInt(request.getParameter("guestbookNo"));
	 // replaceAll : "\r\n"을 <br>로 바꿈 -> gusestBookList페이지에서 줄바꿈도 보이도록 개행 처리
	String guestbookContent = request.getParameter("guestbookContent").replaceAll("\r\n","<br>");
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