<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "vo.Pdf" %>
<%@ page import = "dao.PdfDao" %>
<%@ page import = "java.io.File" %>
<%@page import="java.net.URLEncoder"%>
<%
	request.setCharacterEncoding("utf-8"); // 인코딩
	
	String path = application.getRealPath("uploadPdf");
	
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy());
	
	String writer = multiReq.getParameter("writer");
	String pdfPw = multiReq.getParameter("pdfPw");
	System.out.println("w :  "  + writer);
	System.out.println("p :  "  + pdfPw);
	
	// <input type="file" name="pdf">
	String pdfOriginalName = multiReq.getOriginalFileName("pdf"); // 원래 이름
	String pdfName = multiReq.getFilesystemName("pdf"); // 중복되었다면 변경된 이름 or 원래 이름
	String pdfType = multiReq.getContentType("pdf"); // 타입
	
	// 파일 유효성
	if("".equals(writer)) {
		response.sendRedirect(request.getContextPath()+"/pdf/insertPdfForm.jsp?msg="+URLEncoder.encode("작성자를 입력해주세요"));
		return;
	} else if(pdfType == null) {
		response.sendRedirect(request.getContextPath()+"/pdf/insertPdfForm.jsp?msg="+URLEncoder.encode("파일을 선택해주세요"));
		return;
	} else if("".equals(pdfPw)) {
		response.sendRedirect(request.getContextPath()+"/pdf/insertPdfForm.jsp?msg="+URLEncoder.encode("비밀번호를 입력해주세요"));
		return;
	}

	System.out.println("[pdf 입력]");
	System.out.println("writer : " + writer);
	System.out.println("pdfPw : " + pdfPw);
	System.out.println("pdfOriginalName : " + pdfOriginalName);
	System.out.println("pdfName : " + pdfName);
	System.out.println("pdfType : " + pdfType);
	
	// 파일 업로드 경우 pdf파일만 허용
	if(pdfType.equals("application/pdf")) {
		System.out.println("db 저장");
		PdfDao pdfDao = new PdfDao();
		Pdf pdf = new Pdf();
		pdf.setPdfName(pdfName);
		pdf.setPdfOriginalName(pdfOriginalName);
		pdf.setPdfType(pdfType);
		pdf.setPdfPw(pdfPw);
		pdf.setWriter(writer);
		pdfDao.insertPdf(pdf);
		response.sendRedirect(request.getContextPath()+"/pdf/pdfList.jsp");
	} else {
		System.out.println("pdf파일 아님");
		// 잘못들어온 파일이므로 업로드 된 파일 삭제
		File file = new File(path + "\\" + pdfName);
		file.delete();
		response.sendRedirect(request.getContextPath()+"/pdf/insertPdfForm.jsp?msg="+URLEncoder.encode("pdf파일만 업로드 가능합니다")); // 삭제 후 입력폼으로 돌아가기, pdf만 입력가능 msg 출력
		
	}
%>