package dao;
import java.sql.*;
import vo.Photo;
import java.util.*;

public class PhotoDao {
	public PhotoDao() {}
	
	// 이미지 이름을 반환하는 메서드
	public String selectPhotoName(int photoNo) throws Exception {
		String photoName = "";
		// SELECT photo_name From photo WHERE photo_no=?
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 접속
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT photo_name photoName From photo WHERE photo_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		if(rs.next()) {
			photoName = rs.getString("photoName");
		}
		
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return photoName;
	}
	
	// 이미지 입력
	// 입력 매개값 : Photo photo 반환
	// insertPhotoAction.jsp
	public void insertPhoto(Photo photo) throws Exception {
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 접속
		Connection conn = null;
		PreparedStatement stmt = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "INSERT INTO photo(photo_name, photo_original_name, photo_type, photo_pw, writer, create_date, update_date)VALUES(?,?,?,?,?,NOW(),NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, photo.getPhotoName());
		stmt.setString(2, photo.getPhotoOriginalName());
		stmt.setString(3, photo.getPhotoType());
		stmt.setString(4, photo.getPhotoPw());
		stmt.setString(5, photo.getWriter());
		int row = stmt.executeUpdate();
		
		if(row==1) {
			System.out.println("사진 등록 성공");
		} else {
			System.out.println("사진 등록 실패");
		}
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
	}
	
	// 이미지 삭제 -> int 삭제 행 수 반환
	// 입력 매개값 : int photoNo, String photoPw
	// deletePhotoAction.jsp
	public int deletePhoto(int photoNo, String photoPw) throws Exception {
		int row = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 접속
		Connection conn = null;
		PreparedStatement stmt = null;
		String dburl = "jdbc:mariadb://localhost:3306/blog";
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "DELETE FROM photo WHERE photo_no=? AND photo_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		stmt.setString(2, photoPw);
		row = stmt.executeUpdate();
		
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();		
	
		return row;
	}
	
	// 이미지 목록보기 & N행씩 반환(LIMIT) -> ArrayList<Photo>반환(photoNo, photoName, photoOriginalName, writer, createDate)
	// 입력 매개값 : int beginRow, int rowPerPage
	// photoList.jsp
	public ArrayList<Photo> selectPhotoListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Photo> list = new ArrayList<Photo>();
		Photo photo = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT photo_no photoNo, photo_name photoName, photo_original_name PhotoOriginalName, writer, create_date createDate FROM photo ORDER BY create_date DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		while(rs.next()) {
			photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setPhotoOriginalName(rs.getString("photoOriginalName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			list.add(photo);
		}
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	
	// 전체 행의 수 -> int 반환
	// photoList.jsp
	public int selectPhotoTotalRow() throws Exception {
		int total = 0;
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT COUNT(*) cnt FROM photo";
		stmt = conn.prepareStatement(sql);
		System.out.println("[SQL selectPhotoTotalRow] : " + stmt);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		if(rs.next()) {
			total = rs.getInt("cnt");
		}
		
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return total;
	}
	
	// 이미지 상세보기 -> Photo반환 (photoNo, photoName, photoOriginalName, writer, createDate, updateDate)
	// 입력 매개값 : int photoNo
	// selectPhotoOne.jsp
	public Photo selectPhotoOne(int photoNo) throws Exception {
		Photo photo = null;
		
		Class.forName("org.mariadb.jdbc.Driver");
		// 데이터베이스 자원 준비
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String dburl = "jdbc:mariadb://localhost:3306/blog"; 
		String dbuser = "root";
		String dbpw = "java1234";
		conn = DriverManager.getConnection(dburl, dbuser, dbpw);
		
		String sql = "SELECT photo_no photoNo, photo_name photoName, photo_original_name photoOriginalName, writer, create_date createDate, update_date updateDate FROM photo WHERE photo_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, photoNo);
		rs = stmt.executeQuery();
		
		// 데이터 변환(가공)
		if(rs.next()) {
			photo = new Photo();
			photo.setPhotoNo(rs.getInt("photoNo"));
			photo.setPhotoName(rs.getString("photoName"));
			photo.setPhotoOriginalName(rs.getString("photoOriginalName"));
			photo.setWriter(rs.getString("writer"));
			photo.setCreateDate(rs.getString("createDate"));
			photo.setUpdateDate(rs.getString("updateDate"));
		}
	
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return photo;
	}
}
