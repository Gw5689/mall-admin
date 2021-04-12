<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>managerList</title>
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
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}

%>
<%	
		//현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") !=null) {	
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		}
	
		//페이지당 행의 수
		int rowPerPage = 10;
		
		if(request.getParameter("rowPerPage") !=null) {		
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
		}
		
		
		//시작행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		//전체 데이터 수
		int totalRow = ManagerDao.totalCount();
		
		//totalRow 디버깅
		System.out.println("totalRow : "+totalRow);

		
	%>
	
	<%
	ArrayList<Manager> list = ManagerDao.selectManagerListByPage(rowPerPage, beginRow);
	%>
	
	<!--관리자 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="content-wrapper">
	<div class="container-fluid">
	<div class="col-lg-10">
		<div class="card-body">
            <h5 class="card-title">운영자 관리</h5>
            	<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">manager_No</th>
								<th scope="col">manager_Id</th>
								<th scope="col">manager_Name</th>
								<th scope="col">manager_Date</th>
								<th scope="col">manager_Level</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
								
							</tr>
						</thead>
						<tbody>
								<%
									for(Manager m : list) {
								%>
									<tr>
										<td><%=m.getManagerNo()%></td>
										<td><%=m.getManagerId()%></td>
										<td><%=m.getManagerName()%></td>
										<td><%=m.getManagerDate()%></td>
										<td>
											<form action="<%=request.getContextPath() %>/manager/updateManagerLevelAction.jsp" method="post">
												<input type="hidden" name="managerNo" value="<%=m.getManagerNo()%>">
												<select name="managerLevel" class="form-control" style="width: 70px; height: 30px">
													<%
														for(int i=0; i<3; i++) {
															if(m.getManagerLevel() == i) {
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
												<button class="btn btn-light btn-round px-4">수정</button>
										</td>
											</form>
										</td>
										<td>
											<button class="btn btn-light btn-round px-4">
												<a href="<%=request.getContextPath() %>/manager/deleteManagerLevelAction.jsp?managerNo=<%=m.getManagerNo()%>">삭제</a>
											</button>
										</td>
									</tr>
								<%		
									}
								%>
						</tbody>
					</table>
				</div>
			</div>
		
	
	<!-- 페이징 -->
	<%
		if(currentPage > 1) {
	%>

			<a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage-1 %>&rowPerPage=<%=rowPerPage%>">
				<button class="btn btn-light btn-round px-4">이전</button>
			</a>
		
	<%		
		}
	
		// 마지막 페이지 초기화
			int lastPage = totalRow / rowPerPage; 
		
		// 데이터에 남으면 페이지 추가
			if(totalRow % rowPerPage != 0) {
				lastPage += 1;
			}
		// lastPage 디버깅
		System.out.println("managerLastPage : "+ lastPage);
		
		if(currentPage < lastPage) {
	%>
		
			<a href="<%=request.getContextPath()%>/manager/managerList.jsp?currentPage=<%=currentPage+1 %>&rowPerPage=<%=rowPerPage%>">
				<button class="btn btn-light btn-round px-4">다음</button>
			</a>
	<%		
		}
	%>
	</div>
	</div>
	</div>

</body>
</html>