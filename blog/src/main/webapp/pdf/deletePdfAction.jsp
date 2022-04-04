<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.PdfDao"%>
<%@ page import = "java.io.File" %>
<%
	int pdfNo = Integer.parseInt(request.getParameter("pdfNo"));
	String pdfPw = request.getParameter("pdfPw");
	
	System.out.println("삭제 pdf 번호 : " + pdfNo);
	System.out.println("삭제 비밀번호 : " + pdfPw);
	
	PdfDao pdfDao = new PdfDao();
	String pdfName = pdfDao.selectPdfName(pdfNo); // pdfName 받아오기
	
	// 1) 테이블 데이터 삭제
	int delRow = pdfDao.deletePdf(pdfNo, pdfPw);
	
	// 2) 폴더 pdf 삭제
	if(delRow == 1) { // 테이블 데이터 삭제 성공 시
		System.out.println("pdf 삭제 성공");
		String path = application.getRealPath("uploadPdf");
		File file = new File(path +"\\" + pdfName); // pdf 파일 불러오기
		file.delete(); // pdf 파일 삭제
		response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp"); // pdfList.jsp로 이동
	} else { // pdf 삭제 실패 시 
		System.out.println("pdf 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/pdf/deletePdfForm.jsp?pdfNo="+pdfNo); // 비밀번호 입력 페이지
	}
%>