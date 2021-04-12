<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%	
	// 레벨에 따라 사용가능 여부 설정 (마지막에 삽입)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {  
		response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>insertEbookForm</title>
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

	<!-- 관리자화면 메뉴 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- 테이블 -->
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="col-lg-6">
			<div class="card-body">
            <h5 class="card-title">E-book 추가</h5>
            	<div class="table-responsive">
	
	<%
		// 수집
			ArrayList<String> categoryNameList = CategoryDao.CategoryNameList();
		// 디버깅
			System.out.println("deleteActionCategoryNameList : "+categoryNameList);
	%>
						<form action="<%=request.getContextPath()%>/ebook/insertEbookAction.jsp" method="post">
							<table class="table table-hover">
									<tr>
										<td>categoryName</td>
										<td>
											<select name="categoryName" required="required" class="form-control" style="width: 140px; height: 30px">
												<option value="">선택</option>
												<%
													for(String cn : categoryNameList) {	//카테고리 네임은 외래키기 때문에 카테고리에 존재하는 것만 가져옴
												%>
													<option value="<%=cn%>"><%=cn%></option>
												<%		
													}
												%>
											</select>
										</td>
									</tr>
									
									<tr>
										<td>Ebook_ISBN</td>
										<td><input type="text" name="ebookISBN" required pattern="^\d{9}-\d{1}$" class="form-control input-shadow" placeholder="Enter E-book ISBN"></td>
									</tr>	
									
									<tr>
										<td>Ebook_Title</td>
										<td><input type="text" name="ebookTitle" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="Enter E-book Title"></td>
									</tr>
									
									<tr>
										<td>Ebook_Author</td>
										<td><input type="text" name="ebookAuthor" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="Enter E-book Author"></td>
									</tr>
									
									<tr>
										<td>ebook_Company</td>
										<td><input type="text" name="ebookCompany" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="Enter E-book Company"></td>
									</tr>
									
									<tr>
										<td>Ebook_Page_Count</td>
										<td><input type="text" name="ebookPageCount" required pattern="^[0-9]+$" class="form-control input-shadow" placeholder="Enter E-book PageCount"></td>
									</tr>
									
									<tr>
										<td>Ebook_Price</td>
										<td><input type="text" name="ebookPrice" required pattern="^[0-9]+$" class="form-control input-shadow" placeholder="Enter E-book Price"></td>
									</tr>
									
									<tr>
										<td>Ebook_Summary</td>
										<td><textarea rows="5" cols="60" name="ebookSummary" required="required" class="form-control input-shadow" placeholder="Enter E-book Summary"></textarea></td>
									</tr>
							</table>
							<hr>
							<button type="submit" class="btn btn-light btn-round px-4">E-book 추가</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>