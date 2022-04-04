<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertPdfForm</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
</head>
<body>
	<!-- 메인 메뉴 -->
	<jsp:include page="/inc/upMenu.jsp"></jsp:include>
	<!-- include시 컨텍스명(프로젝트이름)을 명시하지 않는다. -->
	<!-- 메인 메뉴 끝 -->
	<br>
	<div class="container">
	<h1>pdf파일 등록</h1>
	<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp" class="btn btn-light float-right">이전으로</a>
	<form method="post" action="<%=request.getContextPath()%>/pdf/insertPdfAction.jsp" enctype="multipart/form-data">
	<table class="table">
		<tr>
			<td>작성자</td>
			<td>
				<input type="text" name="writer" class="form-control">
			</td>
		</tr>
		<tr>
			<td>pdf 파일</td>
			<td>
				<input type="file" name="pdf" class="custom-file">
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>
				<input type="password" name="pdfPw" class="form-control">
			</td>
		</tr>
	</table>
	<button type="submit" class="btn btn-warning">등록</button>
	</form>	
	</div>
</body>
</html>