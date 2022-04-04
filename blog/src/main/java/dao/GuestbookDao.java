package dao;
import java.sql.*;
import java.util.*;
import vo.Guestbook;

public class GuestbookDao {
	// 생성자 메서드
	public GuestbookDao() {}
	
	// 입력
	// GuestbookDao guestbookDao = new GuestbookDao();
	// Guestbook guestbook = new Guestbook();
	// guestbookDao.insertGuestbook(guestbook); 호출
	public void insertGuestbook(Guestbook guestbook) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "INSERT INTO guestbook(guestbook_content, writer, guestbook_pw, create_date, update_date) VALUES(?,?,?,NOW(),NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setString(2, guestbook.getWriter());
		stmt.setString(3, guestbook.getGuestbookPw());
		System.out.println("sql insertGuestbook : " + stmt);
		int row = stmt.executeUpdate();
		
		if(row==1) {
			System.out.println("입력성공");
		} else {
			System.out.println("입력실패");
		}
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
	}
	
	// 수정(guestbookOne, updateGuestbook) 프로세스 구현
	// updateGuestbookForm.jsp에서 호출
	public Guestbook selectGuestbookOne(int guestbookNo) throws Exception {
		Guestbook guestbook = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT guestbook_no guestbookNo, writer, guestbook_content guestbookContent FROM guestbook WHERE guestbook_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		System.out.println("sql selectOne : " + stmt);
		rs = stmt.executeQuery();
		// 데이터베이스 변환(가공)
		if(rs.next()) {
			guestbook = new Guestbook(); // 생성자
			guestbook.setGuestbookNo(rs.getInt("guestbookNo"));
			guestbook.setWriter(rs.getString("writer"));
			guestbook.setGuestbookContent(rs.getString("guestbookContent"));
		}
		// 데이터베이스 자원 반환
		rs.close(); // 생성된 순서 반대로 close
		stmt.close();
		conn.close(); 
		return guestbook;
	}
	// updateGuestbookAction.jsp에서 호출
	// 이름 : updateGuestbook
	// 반환타입 : 수정한 행의 수 반환 -> 0수정실패, 1수정성공 -> int
	// 입력매개값 : guestbookNo, guestbookContent, guestbookPw 3개 -> 하나의 타입 매개변수로 받고싶다 -> Guestbook 타입을 사용
	public int updateGuestbook(Guestbook guestbook) throws Exception {
		int row = 0;

		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;	
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "UPDATE guestbook SET guestbook_content=? WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, guestbook.getGuestbookContent());
		stmt.setInt(2, guestbook.getGuestbookNo());
		stmt.setString(3, guestbook.getGuestbookPw());
		System.out.println("sql updateGuestbook : " + stmt);
		row = stmt.executeUpdate();
		
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// 삭제(deleteGuestbook) 프로세스 deleteGuestbookAction.jsp 호출
	// 이름 : deleteGuestbook
	// 반환값 : 삭제한 행의 수 반환 -> 0수정실패, 1수정성공 -> int
	// 입력 매개값 : guestbookNo, guestbookPw 2개 -> int, String 타입을 사용 (Guestbook타입을 사용해도 된다)
	public int deleteGuestbook(int guestbookNo, String guestbookPw) throws Exception {
		int row = 0;

		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "DELETE FROM guestbook WHERE guestbook_no=? AND guestbook_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, guestbookNo);
		stmt.setString(2, guestbookPw);
		System.out.println("sql deleteGuestbook : " + stmt);
		row = stmt.executeUpdate();
		
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// guestbook 전체 행의 수를 반환 메서드
	public int selectGuestbookTotalRow() throws Exception{
		int row = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw); 
		
		String sql = "SELECT COUNT(*) cnt FROM guestbook";
		stmt = conn.prepareStatement(sql);
		System.out.println("sql selectGuestbookTotalRow : " + stmt);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt("cnt");
		}
		
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return row;
	}
	
	// guestbook n행씩 반환 메서드(10행)
	public ArrayList<Guestbook> selectGuestbookListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Guestbook> list = new ArrayList<Guestbook>();
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT guestbook_no guestbookNo, guestbook_content guestbookContent, writer, create_date createDate, update_date updateDate FROM guestbook ORDER BY create_date DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("sql selectGuestbookListByPage : " + stmt);
		rs = stmt.executeQuery();
		// 데이터베이스 로직 끝
		
		// 데이터 변환(가공)
		while(rs.next()) {
			Guestbook g = new Guestbook();
			g.setGuestbookNo(rs.getInt("guestbookNo"));
			g.setGuestbookContent(rs.getString("guestbookContent"));
			g.setWriter(rs.getString("writer"));
			g.setCreateDate(rs.getString("createDate"));
			list.add(g);
		}
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
