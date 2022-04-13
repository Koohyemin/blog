package dao;
import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.*;

public class BoardDao {
	// 생성자 메서드
	public BoardDao() {}
	// 카테고리 개수만 받는 테이블 -> 카테고리 페이징을 위해서
	// boardList.jsp, boardOne.jsp
	public int selectCategoryBoardTotal(String categoryName, String boardSearch) throws Exception {
		int row = 0;
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) cnt FROM board WHERE category_name=? AND board_title LIKE ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, categoryName);
		stmt.setString(2, "%"+boardSearch+"%");
		rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		return row;
	}

	// 게시글 목록보기 & N행씩 반환(LIMIT) -> ArrayList<Board> 반환 (boardNo, categoryName, boardTitle, createDate)
	// 입력 매개값 : String categoryName, int beginRow, int rowPerPage
	// boardList.jsp
	public ArrayList<Board> selectBoardListByPage(String categoryName, String boardSearch, int beginRow, int rowPerPage) throws Exception {
		ArrayList<Board> list = new ArrayList<Board>();
		Board board = null;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = null;
		if(categoryName.equals("")) { // 카테고리가 선택되어있지 않다면 전체 게시글 목록
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE board_title LIKE ? ORDER BY create_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+boardSearch+"%"); // WHERE board_title LIKE
			stmt.setInt(2, beginRow); // LIMIT beginRow, rowPerPage
			stmt.setInt(3, rowPerPage);
		} else { // 카테고리가 선택되어있다면 해당 카테고리 게시글 목록
			sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, create_date createDate FROM board WHERE category_name=? AND board_title LIKE ? ORDER BY create_date DESC LIMIT ?,?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName); // WHERE category_name = categoryName
			stmt.setString(2, "%"+boardSearch+"%"); // WHERE board_title LIKE 
			stmt.setInt(3, beginRow); // LIMIT beginRow, rowPerPage
			stmt.setInt(4, rowPerPage);
		}
		System.out.println("[SQL selectBoardListByPage] : " + stmt);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		while(rs.next()) {
			board = new Board();
			board.setBoardNo(rs.getInt("boardNo"));
			board.setCategoryName(rs.getString("categoryName"));
			board.setBoardTitle(rs.getString("boardTitle"));
			board.setCreateDate(rs.getString("createDate"));
			list.add(board);
		}
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 전체 행의 수 -> int 반환
	// boardList.jsp
	public int selectBoardTotalRow(String boardSearch) throws Exception {
		int row = 0;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) cnt FROM board WHERE board_title LIKE ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+boardSearch+"%");
		System.out.println("[SQL selectBoardTotalRow] : " + stmt);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 게시글 상세보기 - Board 반환 (boardNo, categoryName, boardTitle, boardContent, createDate, updateDate)
	// 입력 매개값 : int boardNo
	// boardOne.jsp, updateBoardForm.jsp
	public Board selectBoardOne(int boardNo) throws Exception{
		Board board = null;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT board_no boardNo, category_name categoryName, board_title boardTitle, board_content boardContent, create_date createDate, update_date updateDate FROM board WHERE board_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, boardNo);
		System.out.println("[SQL selectBoardOne] : " + stmt);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		if(rs.next()) {
			board = new Board();
			board.setBoardNo(rs.getInt("boardNo"));
			board.setCategoryName(rs.getString("categoryName"));
			board.setBoardTitle(rs.getString("boardTitle"));
			board.setBoardContent(rs.getString("boardContent"));
			board.setCreateDate(rs.getString("createDate"));
			board.setUpdateDate(rs.getString("updateDate"));
		}
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return board;
	}
	// 입력된 행의 수 -> int 반환
	// 입력 매개값 : Board board(categoryName, boardTitle, boardContent, boardPw)
	// insertBoardAction.jsp
	public int insertBoard(Board board) throws Exception {
		int row = 0;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO board(category_name, board_title, board_content, board_pw, create_date, update_date)VALUES(?,?,?,?,NOW(),NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle()); 
		stmt.setString(3, board.getBoardContent()); 
		stmt.setString(4, board.getBoardPw());
		System.out.println("[SQL insertBoard] : " + stmt);
		row = stmt.executeUpdate();
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
		
		return row;
	}
	// 수정된 행의 수 -> int 반환
	// 입력 매개 값 : Board board(categoryName, boardTitle, boardContent, boardNo, boardPw)
	// updateBoardAction.jsp
	public int updateBoard(Board board) throws Exception {
		int row = 0;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "UPDATE board SET category_name = ?, board_title = ?, board_content = ?, update_date = NOW() WHERE board_no = ? AND board_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, board.getCategoryName());
		stmt.setString(2, board.getBoardTitle());
		stmt.setString(3, board.getBoardContent());
		stmt.setInt(4, board.getBoardNo());
		stmt.setString(5, board.getBoardPw());
		System.out.println("[SQL updateBoard] : " + stmt);
		row = stmt.executeUpdate();
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
		
		return row;
	}
	// 삭제된 행의 수 -> int 반환
	// 입력 매개값 : Board board(boardNo, boardPw)
	// deleteBoardAction.jsp
	public int deleteBoard(Board board) throws Exception {
		int row = 0;
	
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM board WHERE board_no=? AND board_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, board.getBoardNo());
		stmt.setString(2, board.getBoardPw());
		System.out.println("[SQL deleteBoard] : " + stmt);
		row = stmt.executeUpdate();
		
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
		
		return row;
	}
}
