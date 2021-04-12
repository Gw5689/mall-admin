<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.*"%>
<%@page import="java.util.*"%>
<%@ page import="gdu.mall.vo.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>adminIndex</title>
  <!-- loader-->
  <link href="assets/css/pace.min.css" rel="stylesheet"/>
  <script src="assets/js/pace.min.js"></script>
  <!--favicon-->
  <link rel="icon" href="assets/images/favicon.ico" type="image/x-icon">
  <!-- simplebar CSS-->
  <link href="assets/plugins/simplebar/css/simplebar.css" rel="stylesheet"/>
  <!-- Bootstrap core CSS-->
  <link href="assets/css/bootstrap.min.css" rel="stylesheet"/>
  <!-- animate CSS-->
  <link href="assets/css/animate.css" rel="stylesheet" type="text/css"/>
  <!-- Icons CSS-->
  <link href="assets/css/icons.css" rel="stylesheet" type="text/css"/>
  <!-- Sidebar CSS-->
  <link href="assets/css/sidebar-menu.css" rel="stylesheet"/>
  <!-- Custom Style-->
  <link href="assets/css/app-style.css" rel="stylesheet"/>
</head>
<body class="bg-theme bg-theme1  pace-done">
	<!-- 	
	- 2가지 화면을 분기
	- 로그인 정보는 Manager자료형 세션변수(sessionManager(변수이름))을 이용 , 세션에는 값 타입을 넣을 수 없고 참조타입을 넣을 수 있다. (형변환 필요)
		1. 관리자 로그인 폼
		2. 관리자 인증 화면 & 몰 메인페이지
	-->
<%

	if(session.getAttribute("sessionManager") == null) { // null이면 1번 화면 (로그인을 안했을 경우)
%>		
	<!-- Start wrapper-->	
	<div class="loader-wrapper"><div class="lds-ring"><div></div><div></div><div></div><div></div></div></div>
		<div class="card card-authentication1 mx-auto my-5">
			<div class="card-body">
				<div class="card-content p-2">
					<div class="text-center">
						<img src="assets/images/logo-icon.png" alt="logo icon">
					</div>
					<div class="card-title text-uppercase text-center py-3">Sign In</div>
						<form action="<%=request.getContextPath()%>/manager/loginManagerAction.jsp" method="post">
							<div class="form-group">
								<label for="exampleInputId" class="sr-only">ID</label>
								<div class="position-relative has-icon-right">
									<input type="text" name="managerId" class="form-control input-shadow" required pattern="^[a-z0-9]{5,20}$" placeholder="Enter ID" style="width: 100%">
										<div class="form-control-position">
					  						<i class="icon-user"></i>
				  						</div>	
								</div>
							</div>
							<div class="form-group">
							  <label for="exampleInputPassword" class="sr-only">Password</label>
							   <div class="position-relative has-icon-right">
								  <input type="password" name="managerPw" class="form-control input-shadow" required pattern="^[a-z0-9\W]{4,10}$" placeholder="Enter Password" style="width: 100%">
								  <div class="form-control-position">
									  <i class="icon-lock"></i>
								  </div>
							<div class="form-row"> 
								<div class="form-group col-6">
									<div class="icheck-material-white">
										<input type="checkbox" id="user-checkbox" checked="checked">
										<label for="user-checkbox">
											Remember me
										</label>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label for="submit" class="sr-only">Sign In</label>
									<div class="position-relative has-icon-right">
								  	<button type="submit" class="btn btn-light btn-block">Sign In</button>
								  	</div>
								  </div>
							   </div>
							</div>
						</form>
					</div>
				</div>
			<div class="card-footer text-center py-3">
				<p class="text-warning mb-0">계정이 없으신가요? <a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable"
				 href="<%=request.getContextPath()%>/manager/insertManagerForm.jsp"> 매니저 등록 </a></p>
		 	</div>
		</div>
		<hr>
		<div class="card card-authentication1 mx-auto my-10">
			<div class="card-body">
            <h5 class="card-title text-uppercase text-center py-3">승인대기 매니저 목록</h5>
			<div class="table-responsive">
				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">manager_ID</th>
							<th scope="col">manager_Date</th>
						</tr>
					</thead>
					<tbody>
		<%		
				ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
				for(Manager m : list) {
		%>
						<tr>
							<td><%=m.getManagerId() %></td>
							<td><%=m.getManagerDate().substring(0, 10) %></td>
						</tr>
		<%
				}
		%>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
<%

	} else { // 아니면 2번 화면 (로그인 성공)
		Manager manager = (Manager)(session.getAttribute("sessionManager"));
%>
		
		<!-- 관리자 화면 메뉴(네비게이션) include -->
		<div>
			<jsp:include page="/inc/adminMenu.jsp"></jsp:include> <!-- 프로젝트명 사용금지  -->
		</div>
	<div class="clearfix"></div>
	<div class="content-wrapper">
	<div class="container-fluid">
	
	<!-- 최근 등록한 공지 5개 -->
	<%
	ArrayList<Notice> noticeList = NoticeDao.selectNoticeListByPage(5, 0);
			// 매니저 메소드에 페이징 기능 추가하기
			ArrayList<Manager> managerList = ManagerDao.selectManagerListByPage(5, 0);
			ArrayList<Client> clientList = ClientDao.selectClientListByPage(5, 0, "");
			String categoryName = request.getParameter("categoryName");
			ArrayList<Ebook> ebookList = EbookDao.selectEbook(5, 0, categoryName);
			ArrayList<OrdersAndEbookAndClient> oecList = OrdersDao.selectOrdersListByPage(5, 0);
	%>
	<div class="row mt-3">
		<div class="col-lg-6">
			<div class="card">
            	<div class="card-body">
					<h5 class="card-title">공지 관리 <a href="<%=request.getContextPath()%>/notice/noticeList.jsp"><i class="zmdi zmdi-attachment-alt"></i></a></h5>
					<div class="table-responsive">
						<table class="table table-sm">
							<%
								for(Notice n : noticeList) {
							%>
								<tr>
									<td><%=n.getNoticeTitle() %></td>
									<td><%=n.getManagerId() %></td>
								</tr>
							<%		
								}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
	
	
	<!-- 최근 등록한 관리자 5개 -->
	<%
		
	%>
		<div class="col-lg-6">
			<div class="card">
            	<div class="card-body">
					<h5 class="card-title">운영자 관리 <a href="<%=request.getContextPath()%>/manager/managerList.jsp"><i class="zmdi zmdi-attachment-alt"></i></a></h5>
					<div class="table-responsive">
						<table class="table table-sm">
							<%
								for(Manager m : managerList) {
							%>
								<tr>
									<td><%=m.getManagerId() %></td>
									<td><%=m.getManagerName()%></td>
								</tr>
							<%		
								}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 최근 등록한 공지 5개 -->
	<div class="row">
		<div class="col-lg-6">
			<div class="card">
            	<div class="card-body">
					<h5 class="card-title">고객 관리 <a href="<%=request.getContextPath()%>/client/clientList.jsp"><i class="zmdi zmdi-attachment-alt"></i></a></h5>
					<div class="table-responsive">
						<table class="table table-sm">
							<%
								for(Client c : clientList) {
							%>
								<tr>
									<td><%=c.getClientMail() %></td>
									<td><%=c.getClientDate()%></td>
								</tr>
							<%		
								}
							%>
						</table>
					</div>
				</div>
			</div>	
		</div>
	
	<!-- 최근 등록한 공지 5개 -->
		<div class="col-lg-6">
			<div class="card">
            	<div class="card-body">
				<h5 class="card-title">E-book관리 <a href="<%=request.getContextPath()%>/ebook/ebookList.jsp"><i class="zmdi zmdi-attachment-alt"></i></a></h5>
					<div class="table-responsive">
						<table class="table table-sm">
							<%
								for(Ebook e : ebookList) {
							%>
								<tr>
									<td><%=e.getEbookTitle() %></td>
									<td><%=e.getEbookPrice()%></td>
								</tr>
							<%		
								}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 최근 등록한 공지 5개 -->
	<div class="row">
		<div class="col-lg-6">
			<div class="card">
            	<div class="card-body">
				<h5 class="card-title">주문 관리 <a href="<%=request.getContextPath()%>/orders/ordersList.jsp"><i class="zmdi zmdi-attachment-alt"></i></a></h5>
					<div class="table-responsive">
						<table class="table table-sm">
							<%
								for(OrdersAndEbookAndClient oec : oecList) {
							%>
								<tr>
									<td><%=oec.getOrders().getOrdersNo()%></td>
									<td><%=oec.getEbook().getEbookTitle()%></td>
									<td><%=oec.getClient().getClientMail()%></td>
								</tr>
							<%		
								}
							%>
						</table>
					</div>
				</div>	
			</div>
		</div>
	</div>
	
<%
	}
%>
		</div>			
	</div>

</body>
</html>