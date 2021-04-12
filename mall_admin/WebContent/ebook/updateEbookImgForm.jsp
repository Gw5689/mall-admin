<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%// 레벨에 따라 사용가능 여부 설정 (마지막에 삽입)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {  
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>updateEbookImgForm</title>
  <!-- loader-->
  <link href="<%=request.getContextPath()%>/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="<%=request.getContextPath()%>/assets/js/pace.min.js"></script>
  <!--favicon-->
  <link rel="icon" href="<%=request.getContextPath()%>/assets/images/favicon.ico" type="image/x-icon">
  <!-- simplebar CSS-->
  <link href="<%=request.getContextPath()%>/assets/plugins/simplebar/css/simplebar.css" rel="stylesheet"/>
  <!-- Bootstrap core CSS-->
  <link href="<%=request.getContextPath()%>/assets/css/bootstrap.min.css" rel="stylesheet"/>
  <!-- animate CSS-->
  <link href="<%=request.getContextPath()%>/assets/css/animate.css" rel="stylesheet" type="text/css"/>
  <!-- Icons CSS-->
  <link href="<%=request.getContextPath()%>/assets/css/icons.css" rel="stylesheet" type="text/css"/>
  <!-- Sidebar CSS-->
  <link href="<%=request.getContextPath()%>/assets/css/sidebar-menu.css" rel="stylesheet"/>
  <!-- Custom Style-->
  <link href="<%=request.getContextPath()%>/assets/css/app-style.css" rel="stylesheet"/>
</head>
<body class="bg-theme bg-theme1  pace-done">
	<%
		String ebookISBN = request.getParameter("ebookISBN");
	%>
	
	<!-- 관리자화면 메뉴 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="content-wrapper">
	<div class="card card-authentication1 mx-auto my-10" style="width: 50rem;">
		<div class="card-body">
		<h5 class="card-title text-uppercase text-center py-3">E-book Img 수정</h5>
	
	<!--enctype : 모든 값이 문자열로 넘어감  -->
	<form action="<%=request.getContextPath()%>/ebook/updateEbookImgAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
		<input type="file" name="ebookImg">
		
		<button type="submit" class="btn btn-light btn-round px-4">이미지 수정</button>
	</form>
</body>
</html>