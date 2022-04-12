package dao;

import java.sql.*;
import java.util.*;

import util.DBUtil;
import vo.Pdf;

public class PdfDao {
	public PdfDao() {}
	
	// pdf 입력
	// 입력 매개값 : Pdf pdf 반환
	// insertPdfAction.jsp
	public void insertPdf(Pdf pdf) throws Exception {
		// 데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "INSERT INTO pdf(pdf_name, pdf_original_name, pdf_type, pdf_pw, writer, create_date, update_date) VALUES(?,?,?,?,?,NOW(),NOW())";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, pdf.getPdfName());
		stmt.setString(2, pdf.getPdfOriginalName());
		stmt.setString(3, pdf.getPdfType());
		stmt.setString(4, pdf.getPdfPw());
		stmt.setString(5, pdf.getWriter());
		System.out.println("[SQL insertPdf] : " + stmt);
		int row = stmt.executeUpdate();
		
		if(row == 1) {
			System.out.println("pdf 입력 성공");
		} else {
			System.out.println("pdf 입력 실패");
		}
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();
	}
	
	// pdf 목록보기 & N행씩 반환(LIMIT) -> ArrayList<Pdf>반환(pdfNo, pdfOriginalName, writer, createDate)
	// 입력 매개값 : int beginRow, int rowPerPage
	// pdfList.jsp
	public ArrayList<Pdf> selectPdfListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Pdf> list = new ArrayList<Pdf>();
		Pdf pdf = null;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT pdf_no pdfNo, pdf_name pdfName, pdf_original_name pdfOriginalName, writer, create_date createDate FROM pdf ORDER BY create_date DESC LIMIT ?,?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		System.out.println("[SQL selectPdfListByPage] : " + stmt);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		while(rs.next()) {
			pdf = new Pdf();
			pdf.setPdfNo(rs.getInt("pdfNo"));
			pdf.setPdfName(rs.getString("pdfName"));
			pdf.setPdfOriginalName(rs.getString("pdfOriginalName"));
			pdf.setWriter(rs.getString("writer"));
			pdf.setCreateDate(rs.getString("createDate"));
			list.add(pdf);
		} 
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return list;
	}
	// 전체 행의 수 -> int 반환
	// pdfList.jsp
	public int selectPdfTotalRow() throws Exception {
		int total = 0;
		
		// 데이터베이스 자원 준비
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT COUNT(*) cnt FROM pdf"; 
		stmt = conn.prepareStatement(sql);
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
	
	// pdf 삭제 -> int 삭제 행 수 반환
	// 입력 매개값 : int pdfNo, String pdfPw
	// deletePdfAction.jsp
	public int deletePdf(int pdfNo, String pdfPw) throws Exception {
		int row = 0;
		// 데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		String sql = "DELETE FROM pdf WHERE pdf_no=? AND pdf_pw=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		stmt.setString(2, pdfPw);
		row = stmt.executeUpdate();
		
		// 데이터베이스 자원 반환
		stmt.close();
		conn.close();	
		
		return row;
	}
	// pdf 이름을 반환하는 메서드
	public String selectPdfName(int pdfNo) throws Exception {
		String pdfName = "";
		
		// 데이터베이스 접속
		Connection conn = null;
		conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT pdf_name pdfName From pdf WHERE pdf_no=?";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, pdfNo);
		rs = stmt.executeQuery();
		// 데이터 변환(가공)
		if(rs.next()) {
			pdfName = rs.getString("pdfName");
		}
		
		// 데이터베이스 자원 반환
		rs.close();
		stmt.close();
		conn.close();
		
		return pdfName;
	}
}
