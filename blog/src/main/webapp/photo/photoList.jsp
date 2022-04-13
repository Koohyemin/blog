<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "vo.*" %>
<%@ page import = "dao.*" %>
<%
	PhotoDao photoDao = new PhotoDao();

	// 페이지
	// 현재 페이지 -> 이전(-1), 다음(+1)
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("photo.currentPage : " + currentPage);
	
	int beginRow = 0; // 페이지 별 첫 게시글
	int rowPerPage = 10; // 한 페이지 당 표시할 사진 수
	beginRow = (currentPage-1)*rowPerPage; // ex) 한페이지당 10이라면 1p -> 0, 2p -> 10, 3p -> 20
	int totalRow = photoDao.selectPhotoTotalRow();
	int lastPage = (int)(Math.ceil((double)totalRow / (double)rowPerPage));
	
	// 이미지 목록보기
	ArrayList<Photo> list = photoDao.selectPhotoListByPage(beginRow, rowPerPage);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>photoList</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<br>
	
	<div class="container">
	
	<h1>이미지 목록<span class="badge badge-warning badge-pill text-light"><%=totalRow %></span></h1>
	<a href="<%=request.getContextPath()%>/photo/insertPhotoForm.jsp" class="btn btn-light text-danger">이미지 등록</a>
	<table class="table table-borderless">
		<tr>
			<%
				// 한행의 5개의 이미지 출력(tr안에 td가 5개)
				// 이미지가 3개 - tr 1 - td 5
				// 이미지가 5개 - tr 1 - td 5
				// 이미지가 10개 - tr2 - td 10
				// - 이미지가 9개 - tr 2 - td 10
				
				// td의 개수 5의 배수가 되도록
				// list.size()가 1~5 - td는 5개
				// list.size()가 6~10 - td는 10개
				System.out.println("[list.size()]:" + list.size());
			
				int startIdx = 1;
				int endIdx = (((list.size()-1/5)/5)+1)*5; // 5의 배수가 되어야한다. (한줄에 5개씩 출력하기)
				
				
				for(int i=0; i<endIdx; i++) { 
					// tr을 닫고 새로운 tr을 시작
					if(i!=0 && i%5==0) { // 5일때(0을 제외한 5의 배수일 때)
			%>
						</tr><tr>
			<%
					}
					if(i<list.size()) {
			%>
						<td>
							<a href="<%=request.getContextPath()%>/photo/selectPhotoOne.jsp?photoNo=<%=list.get(i).getPhotoNo()%>">
								<img src="<%=request.getContextPath()%>/uploadPhoto/<%=list.get(i).getPhotoName()%>" width="200" height="200" class="rounded">
								<h6 class="text-dark"><%=list.get(i).getPhotoOriginalName() %></h6>
							</a>
							by<%=list.get(i).getWriter() %>    <span class="text-secondary"><%=list.get(i).getCreateDate() %></span>
						</td>
			<%		
					} else {
			%>
						<td>&nbsp;</td>
			<%
					}
						}
			%>
		</tr>
	</table>
	
	<div>
		<%
			if(currentPage > 1) {
		%>
				<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage-1%>" class="btn btn-outline-warning btn-sm text-dark">이전</a>
		<%
			}
			if(currentPage < lastPage) {
		%>
				<a href="<%=request.getContextPath()%>/photo/photoList.jsp?currentPage=<%=currentPage+1%>" class="btn btn-outline-warning btn-sm text-dark">다음</a>
		<%
			}
		%>
	</div>
	</div>
</body>
</html>