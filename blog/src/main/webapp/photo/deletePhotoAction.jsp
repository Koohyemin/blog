<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "dao.*" %>
<%@ page import = "java.io.File" %>
<%
	// 1) 테이블 데이터 삭제 <- photoNO 필요
	// 2) upload폴더에 이미지도 삭제 <- photoName 필요

	int photoNo = Integer.parseInt(request.getParameter("photoNo")); // 삭제할 photoNo받아오기
	String photoPw = request.getParameter("photoPw"); // 삭제할 photoPw받아오기
	System.out.println("삭제 사진 번호 : " + photoNo);
	System.out.println("삭제 비밀번호 : " + photoPw);
	
	PhotoDao photoDao = new PhotoDao();
	
	String photoName = photoDao.selectPhotoName(photoNo);
	
	// 1) 테이블 데이터 삭제
	int delRow = photoDao.deletePhoto(photoNo, photoPw);
	
	// 2) 폴더 이미지 삭제
	if(delRow == 1) { // 테이블 데이터 삭제 성공 시
		System.out.println("이미지 삭제 성공");
		String path = application.getRealPath("uploadPhoto");
		File file = new File(path +"\\" + photoName); // 이미지 파일 불러오기
		file.delete(); // 이미지 파일 삭제
		response.sendRedirect(request.getContextPath()+"/photo/photoList.jsp"); // phtoList.jsp로 이동
	} else { // 이미지 삭제 실패 시 
		System.out.println("이미지 삭제 실패");
		response.sendRedirect(request.getContextPath()+"/photo/deletePhotoForm.jsp?photoNo="+photoNo); // 해당번호 deletePhotoForm.jsp로 이동
	}
	

%>