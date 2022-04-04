<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "vo.*" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "dao.*" %>
<%
	request.setCharacterEncoding("UTF-8"); //인코딩
	
	BoardDao boardDao = new BoardDao();
	Board board = null;

	// 하나의 변수로 묶기(boardNo, boardPw)
	board = new Board();
	board.setBoardNo(Integer.parseInt(request.getParameter("boardNo")));// 입력받은 boardNo
	board.setBoardPw(request.getParameter("boardPw"));// 입력받은 비밀번호
	System.out.println("삭제 게시글 번호 : "+ board.getBoardNo());
	System.out.println("삭제 비밀번호 : "+ board.getBoardPw());
	
	int row = boardDao.deleteBoard(board); // boardNo, boardPw 값 대입
	
	if(row==1) {  // 삭제 성공 시 boardList.jsp로 돌아가기
		System.out.println("게시글 삭제 성공");
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp");
	} else{ // 실패 시 해당 번호 deleteBoardForm.jsp으로 돌아가기
		System.out.println("게시글 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/board/deleteBoardForm.jsp?boardNo=" + board.getBoardNo());
	}
%>