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
  <title>clientList</title>
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
		
		// 메일 검색창
		String searchWord = "";
		if(request.getParameter("searchWord") !=null) { // 서치워드값이 넘어오면
			searchWord = request.getParameter("searchWord");
		}
		
		//시작행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		//전체 데이터 수
		int totalRow = ClientDao.totalCount(searchWord);
		//totalRow 디버깅
		System.out.println("totalRow : "+totalRow);
			
		// list 생성
		ArrayList<Client> list = ClientDao.selectClientListByPage(rowPerPage, beginRow, searchWord);
		
	%>
	<!-- 테이블 -->
	<div class="content-wrapper">
	<div class="container-fluid">
	<div class="col-lg-6">
		<div class="card-body">
            <h5 class="card-title">고객 관리</h5>
			<div class="table-responsive">
	<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post">
		<div class="form-group">
		<input type="hidden" name="searchword" value="<%=searchWord%>">
		<select name="rowPerPage" class="form-control" style="width: 70px; height: 30px">
			<%
				for(int i=10; i<31; i+=5) {
					if(rowPerPage == i) {
			%>
					<option value="<%=i%>" selected="selected"><%=i %></option>
			<%		
					} else {
			%>
					<option value="<%=i%>"><%=i %></option>
			<%			
					}
				}
			%>
		</select>
		
		<button type="submit" class="btn btn-light btn-round px-4">보기</button>
		</div>
	
			
		<!-- 메일 검색창 -->
		<form action="<%=request.getContextPath()%>/client/clientList.jsp" method="post" class="search-bar">
			<div class="form-group">
			 <input type="hidden" value="rowPerPage" value="<%=rowPerPage%>" size="20">
				<div>
					<input type="text" name="searchWord" class="form-control" placeholder="client_Mail">
					<button type="submit" class="btn btn-light btn-round px-4"><i class="icon-magnifier"></i></button>
				</div>
			</div>
		</form>
	
	</form>
		<table class="table table-hover">
			<thead>
				<tr>
					<th scope="col">client_Mail</th>
					<th scope="col">client_Date</th>
					<th scope="col">수정</th>
					<th scope="col">삭제</th>
				</tr>
			</thead>
			<tbody>
				<%
					for(Client c : list) {
				%>		
					<tr>
						<td><%=c.getClientMail()%></td>
						<td><%=c.getClientDate().substring(0,11)%></td> <!-- 시간단위 안보이게 짜르기 -->
						<td><a href="<%=request.getContextPath()%>/client/updateClientForm.jsp?clientMail=<%=c.getClientMail()%>"><button type="button" class="btn btn-light btn-round px-4">수정</button></a></td>
						<td><a href="<%=request.getContextPath()%>/client/deleteClientAction.jsp?clientMail=<%=c.getClientMail()%>"><button type="button" class="btn btn-light btn-round px-4">삭제</button></a></td>
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
		if(currentPage > 1) {
	%>
		
			<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage-1 %>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
				<button class="btn btn-light btn-round px-4">이전</button>
			</a>
		
	<%		
		}
	
		// 마지막 페이지
		int lastPage = totalRow / rowPerPage; 
		if(totalRow % rowPerPage != 0) {
			lastPage += 1;
		}
		// lastPage 디버깅
		System.out.println("lastPage : "+lastPage);
		
		if(currentPage < lastPage) {
	%>
		
		<a href="<%=request.getContextPath()%>/client/clientList.jsp?currentPage=<%=currentPage+1 %>&rowPerPage=<%=rowPerPage%>&searchWord=<%=searchWord%>">
			<button class="btn btn-light btn-round px-4">다음</button>
		</a>
		
	<%		
		}
	%>

	</div>
	</div>
</body>
</html>