<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import = "com.oreilly.servlet.MultipartRequest" %>
<%@ page import = "java.io.File" %>
<%@ page import = "vo.Photo" %>
<%@ page import = "dao.PhotoDao" %>
<%
	/*
	form태그의 enctype="multipart/form-data"로 넘겨져서 request.getParameter() API를 사용할 수 없다.	
	String writer = request.getParameter("writer");
	String photo = request.getParameter("photo");
	request.getParameter() API 대신 다른 API를 사용해야 하는데 너무 복잡
	--> request를 단순하게 사용하게 해주는 cos.jar같은 API(외부라이브러리)를 사용하자.
	*/
	
	request.setCharacterEncoding("utf-8");
	// DefaultFileRenamePolicy rp = new DefaultFileRenamePolicy(); -> 이름이 중복된다면 자동으로 변경
	String path = application.getRealPath("uploadPhoto"); // application변수 톰켓을 가르키는 변수
	System.out.println(path); // C:\\gdj46\\project\\blog\\src\\main\\webapp\\photo\\upload
	
	MultipartRequest multiReq = new MultipartRequest(request, path, 1024*1024*100, "utf-8", new DefaultFileRenamePolicy()); // 첨부파일은 multiReq에 자동으로 받아짐
	// new MultipartRequest(request, "폴더위치", 크기(얼마까지의 용량을 저장할 수 있는지), 인코딩, 이름 중복일 시 자동으로 변경);
	// 2^10 byte = 1 kbyte 1024 byte = 1 kbyte
	// 2^10 kbyte = 1 mbyte
	// 100 mbyte = 1024*1024*100 byte = 104857600 byte 곱셈을 계산해서 코딩하면 가독성이 떨어진다.
	
	String writer = multiReq.getParameter("writer"); // multiReq를 통해 값을 받아올 수 있다(multiReq에 getParameter 존재) 
	String photoPw = multiReq.getParameter("photoPw");
	
	// <input type="file" name="photo">에 대한 처리
	String photoOriginalName = multiReq.getOriginalFileName("photo"); // 파일 업로드시 원본의 이름
	String photoName = multiReq.getFilesystemName("photo"); //  new DefaultFileRenamePolicy() 객체를 통해 변경된 이름
	String photoType = multiReq.getContentType("photo"); // 컨텐츠 타입
	
	System.out.println("writer : " + writer);
	System.out.println("photoPw : " + photoPw);
	System.out.println("photoOriginalName : " + photoOriginalName);
	System.out.println("photoName : " + photoName);
	System.out.println("photoType : " + photoType);

	// 파일업로드 경우 100mbyte이하의 image/gif, image/png, image/jpeg 3가지 이미지만 허용
	if(photoType.equals("image/gif") || photoType.equals("image/png") || photoType.equals("image/jpeg")) {
		// db에 저장..
		System.out.println("db 저장");
		PhotoDao photoDao = new PhotoDao();
		Photo photo = new Photo();
		photo.setPhotoName(photoName);
		photo.setPhotoOriginalName(photoOriginalName);
		photo.setPhotoType(photoType);
		photo.setPhotoPw(photoPw);
		photo.setWriter(writer);
		photoDao.insertPhoto(photo); // 메서드 구현
		response.sendRedirect(request.getContextPath() + "/photo/photoList.jsp");
	} else {
		// 업로드 취소
		System.out.println("이미지파일만 업로드");
		
		// 잘못들어온 파일이므로 업로드된 파일 지우고 폼으로 이동
		File file = new File(path + "\\" + photoName); // java.io.File 잘못된 파일을 불러온다.
		file.delete(); // 잘못 업로드된 파일 삭제
		response.sendRedirect(request.getContextPath() + "/photo/insertPhotoForm.jsp");
	}
%>