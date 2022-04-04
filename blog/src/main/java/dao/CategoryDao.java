package dao;

import java.sql.*;
import java.util.*;

public class CategoryDao {
	public CategoryDao() {} // 생성자 메서드
	
	// 게시글 작성 시 카테고리 목록 -> insertBoardForm.jsp, updateBoardForm.jsp
	public ArrayList<String> insertCategoryName() throws Exception {
		ArrayList<String> list = new ArrayList<String>();
		// 데이터베이스 자원 준비
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT category_name categoryName FROM category ORDER BY category_name ASC";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		while(rs.next()) {
			list.add(rs.getString("categoryName"));
		}
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
}
