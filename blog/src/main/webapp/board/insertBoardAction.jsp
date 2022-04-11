<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>

<%
	request.setCharacterEncoding("utf-8"); // 인코딩
	// 유효성 판별
	if(request.getParameter("boardTitle").equals("")) {
		response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?msg="+URLEncoder.encode("제목을 입력해주세요"));
		return;
	} else if (request.getParameter("boardContent").equals("")) {
		response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?msg="+URLEncoder.encode("본문을 입력해주세요"));
		return;
	} else if(request.getParameter("boardPw").equals("")) {
		response.sendRedirect(request.getContextPath()+"/board/insertBoardForm.jsp?msg="+URLEncoder.encode("비밀번호를 입력해주세요"));
		return;
	}
	BoardDao boardDao = new BoardDao();
	Board board = null;
	
	request.setCharacterEncoding("UTF-8"); //인코딩

	// 입력한 categoryName, boardTitle, boardContent, boardPw 값 불러오기
	// 하나의 변수로 묶어주기(categoryName, boardTitle, boardContent, boardPw)
	board = new Board();
	board.setCategoryName(request.getParameter("categoryName"));
	board.setBoardTitle(request.getParameter("boardTitle"));
	 // replaceAll : "\r\n"을 <br>로 바꿈 -> boardOne페이지에서 줄바꿈도 보이도록 개행 처리
	board.setBoardContent(request.getParameter("boardContent").replaceAll("\r\n", "<br>"));
	board.setBoardPw(request.getParameter("boardPw"));
	
	int row = boardDao.insertBoard(board);

	if(row == 1) { 	// 성공여부 디버깅
		System.out.println("게시물 입력 성공");
	} else { 
		System.out.println("게시물 입력 실패");
	}
	 // 게시글 목록(boardList)로 돌아가기
	response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
%>