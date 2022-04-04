<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 스킨 -->
<div class="container-fluid bg-warning">
	<br>
	<h1 class="text-light text-center">BLOG</h1>
	<br>
</div>
<!-- 스킨 끝 -->
<!-- 다른페이지의 부분으로 사용되는 페이지 -->
<div class="container-fluid">
	<ul class="nav nav-tabs nav-justified">
		<li class="nav-item">
			<a href="<%=request.getContextPath()%>/home/home.jsp" class="nav-link text-secondary"><b>홈으로</b></a>
		</li>
		<li class="nav-item">
			<a href="<%=request.getContextPath()%>/board/boardList.jsp" class="nav-link text-secondary"><b>게시판</b></a>
		</li>
		<li class="nav-item">
			<a href="<%=request.getContextPath()%>/photo/photoList.jsp" class="nav-link text-secondary"><b>사진</b></a>
		</li>
		<li class="nav-item">
			<a href="<%=request.getContextPath()%>/guestbook/guestbookList.jsp" class="nav-link text-secondary"><b>방명록</b></a>
		</li>
		<li class="nav-item">
			<a href="<%=request.getContextPath()%>/pdf/pdfList.jsp" class="nav-link text-secondary"><b>PDF자료실</b></a>
		</li>
	</ul>
</div>