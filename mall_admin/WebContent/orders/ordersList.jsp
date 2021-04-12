<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>ordersList</title>
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
<%
	//레벨에 따라 사용가능 여부 설정
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {  
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	//현재 페이지
	int currentPage = 1;
	if(request.getParameter("currentPage")!=null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}	
	//페이지당 보여줄 행의 수
	int rowPerPage = 5;
	if(request.getParameter("rowPerPage")!=null){
		rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
	}
	// 시작 페이지
	int beginRow = (currentPage-1)*rowPerPage;
	// 토탈 페이지
	int totalRow = OrdersDao.totalCnt();
	// 마지막 페이지
	int lastPage = totalRow/rowPerPage;
	// 초기화
	ArrayList<OrdersAndEbookAndClient> list = OrdersDao.selectOrdersListByPage(rowPerPage, beginRow);
%>
</head>
<body class="bg-theme bg-theme1  pace-done">
	<!-- 관리자 메뉴 네비게이션-->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="content-wrapper">
	<div class="container-fluid">
	<div class="col-lg-9">
		<div class="card-body">
            <h5 class="card-title">주문 관리</h5>
            	<div class="table-responsive">
	
	<form action="<%=request.getContextPath()%>/orders/ordersList.jsp" method="post">
		<select name="rowPerPage" class="form-control" style="width: 70px; height: 30px">
	<%
			for(int i=5; i<=20; i+=5){
				if(rowPerPage==i){
	%>
				<option value="<%=i%>" selected="selected"><%=i%></option>
	<%
				}else {
	%>
					<option value="<%=i%>"><%=i%></option>
	<%
				}
			}
	%>
		</select>
		<button type="submit" class="btn btn-light btn-round px-4">보기</button>
	</form>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">order_No</th>
				<th scope="col">ebook_No</th>
				<th scope="col">ebook_Title</th>
				<th scope="col">client_No</th>
				<th scope="col">client_Mail</th>
				<th scope="col">order_Date</th>
				<th scope="col">order_State</th>
				<th scope="col">State 수정</th>
				<th scope="col">수정</th>
			</tr>
		</thead>
		<tbody>
	<%
		for(OrdersAndEbookAndClient oec : list) {
	%>
			<tr>
				<td><%=oec.getOrders().getOrdersNo()%></td>
				<td><%=oec.getOrders().getEbookNo()%></td>
				<td>
				<a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable" 
				 href="<%=request.getContextPath()%>/ebook/ebookListOne.jsp?ebookISBN=<%=oec.getEbook().getEbookISBN()%>"><%=oec.getEbook().getEbookTitle()%></a>
				</td>
				<td><%=oec.getOrders().getClientNo()%></td>
				<td><%=oec.getClient().getClientMail()%></td>
				<td><%=oec.getOrders().getOrdersDate().substring(0,11)%></td>
				<td>
				<form action="<%=request.getContextPath()%>/orders/updateOrdersStateAction.jsp" method="post">
					<input type="hidden" name="ordersNo" value=<%=oec.getOrders().getOrdersNo()%>>
				</td>
				<td>
					<select name="ordersState" class="form-control" style="width: 110px; height: 30px">
					<%
						String[] state = {"주문완료", "주문취소"};
							for(String st : state) {
								if(st.equals(oec.getOrders().getOrdersState())) {
					%>
						<option selected="selected" value="<%=st%>"><%=st %></option>
					<%	
							} else {
					%>
						<option value="<%=st%>"><%=st %></option>
					<%	
							}
						}
					
					%>
					</select>
					
				</td>
				<td>
					<button type="submit" class="btn btn-light btn-round px-4">수정</button>
				</td>
			</tr>
			</form>
	<%
		}
	 %>
	 	</tbody>
	</table>
	</div>
	</div>
	<!-- 페이징 작업-->
	<%
		if(currentPage>1){
	%>
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=1&rowPerPage=<%=rowPerPage%>"><button class="btn btn-light btn-round px-4">첫 페이지</button></a>
		<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>"><button class="btn btn-light btn-round px-4"><%=currentPage-1%></button></a>
	<%
		}
		if(currentPage<lastPage){
	%>
			<button type=button class="btn btn-light btn-round px-4"><%=currentPage%></button>
				<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
			<button type = button class="btn btn-light btn-round px-4"><%=currentPage+1%></button></a>
				<a href="<%=request.getContextPath()%>/orders/ordersList.jsp?currentPage=<%=lastPage%>&rowPerPage=<%=rowPerPage%>">
			<button type = button class="btn btn-light btn-round px-4">마지막 페이지</button></a>	
	<%
		
		} else if(currentPage==lastPage){
	%>
			<button type=button class="btn btn-light btn-round px-4"><%=currentPage%></button>
	<%
		}
	%>
	</div>
	</div>
	</div>

</body>
</html>