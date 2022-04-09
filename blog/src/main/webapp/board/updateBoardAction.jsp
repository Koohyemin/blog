<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	BoardDao boardDao = new BoardDao();

	request.setCharacterEncoding("utf-8"); // utf-8 인코딩
	
	// 하나로 묶기(boardNo, categoryName, boardTitle, boardContent, boardPw)
	Board board = new Board();
	board.setBoardNo(Integer.parseInt(request.getParameter("boardNo")));
	board.setCategoryName(request.getParameter("categoryName"));
	board.setBoardTitle(request.getParameter("boardTitle"));
	 // replaceAll : "\r\n"을 <br>로 바꿈 -> boardOne페이지에서 줄바꿈도 보이도록 개행 처리
	board.setBoardContent(request.getParameter("boardContent").replaceAll("\r\n","<br>"));
	board.setBoardPw(request.getParameter("boardPw"));
	System.out.println("수정 게시글 번호 : "+board.getBoardNo()); // 수정boardNo 디버깅
	System.out.println("수정 비밀번호 : "+board.getBoardPw());
	
	
	int row = boardDao.updateBoard(board);
	
	if(row==1) {
		System.out.println("게시글 수정 성공"); // 수정 성공 시 boardList.jsp로 돌아가기
		response.sendRedirect(request.getContextPath()+"/board/boardList.jsp"); 
	} else { // 수정 실패 시 해당 번호 updateBoardForm.jsp으로 돌아가기
		System.out.println("게시글 수정 실패");
		response.sendRedirect(request.getContextPath()+"/board/updateBoardForm.jsp?boardNo="+board.getBoardNo()); 
	}
	

	
%>