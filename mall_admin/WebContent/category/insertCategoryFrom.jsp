<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.util.*"%>
<%	
	// 레벨에 따라 사용가능 여부 설정
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {  
		response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
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
  <title>insertCategoryForm</title>
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
	
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="row mt-3">
		      	<div class="col-lg-6">
			         <div class="card">
			           <div class="card-body">
			           	<div class="card-title">카테고리 등록</div>
				           <hr>
							<form action="<%=request.getContextPath()%>/category/insertCategoryAction.jsp" method="post">
								<div class="form-group">
									<label for="exampleInputName" class="sr-only">Category_Name</label>
										<div class="position-relative has-icon-right">
											<input type="text" name="categoryName" required pattern="^[a-zA-Z가-힣]{2,100}$" class="form-control input-shadow" placeholder="Enter Category Name">
											<button type="submit" class="btn btn-light px-4">추가</button>
						  				</div>
				  				</div>
				  			</div>
						</form>
					</div>
			  	</div>	
			</div>
		</div>
	</div>
</body>
</html>