<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%	
	// 레벨에 따라 사용가능 여부 설정
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {  
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
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
  <title>categoryList</title>
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
	
	<!-- 페이징 할 필요가 없음, 검색어도 필요 없음, 뿌리기만. -->
	
	<!-- 관리자화면 메뉴 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- 테이블 -->
	<div class="content-wrapper">
	<div class="container-fluid">
	<div class="col-lg-6">
		<div class="card-body">
            <h5 class="card-title">카테고리 관리</h5>
            	<div class="table-responsive">
	<%
	// list 생성
		ArrayList<Category> list = CategoryDao.selectCategoryList();
	%>
	
	<!-- 카테고리 추가 버튼 -->
	<div class="form-group">
		<a href="<%=request.getContextPath()%>/category/insertCategoryFrom.jsp"><button type="button" class="btn btn-light btn-round px-5">카테고리 추가</button></a>
	</div>
	
	
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">category_Name</th>
					<th scope="col">category_Weight(수정)</th> <!-- 매니저 level 수정하듯이 수정 -->
					<th scope="col">수정</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Category c : list) {
				%>		
					
				<tr>
					<td><%=c.getCategoryName() %></td>
					<td>
						<form action="<%=request.getContextPath()%>/category/updateCategoryAction.jsp" method="post">
							<input type="hidden" name="categoryName" value="<%=c.getCategoryName()%>">
							<select name="categoryWeight" class="form-control" style="width: 70px; height: 30px">
								<%
									for(int i=0; i<11; i++){
										if(c.getCategoryWeight() == i) {
								%>
									<option value="<%=i%>" selected="selected"><%=i%></option>
								<%			
									} else {
								%>
									<option value="<%=i%>"><%=i%></option>
								<%		
										}
									}
								%>
							</select>
					<td>	
							<button type="submit" class="btn btn-light btn-round px-4">수정</button>
					</td>
						</form>
					<td>
						<a href="<%=request.getContextPath()%>/category/deleteCategoryAction.jsp?categoryName=<%=c.getCategoryName()%>">
							<button type="button" class="btn btn-light btn-round px-4">삭제</button>
						</a>
					</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		</div>
	  </div>
	</div>
	</div>
	</div>
	
	
</body>
</html>