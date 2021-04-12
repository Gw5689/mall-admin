<%@page import="gdu.mall.util.DBUtil"%>
<%@page import="java.sql.*"%>
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

<%	
		// 현재 페이지
			int currentPage = 1;
			if(request.getParameter("currentPage") !=null) {	
				currentPage = Integer.parseInt(request.getParameter("currentPage"));
			}
		// 디버깅
			System.out.println("ebookListCurrentPage : "+currentPage);
		
		// 페이지당 행의 수
			int rowPerPage = 10;
			if(request.getParameter("rowPerPage") !=null) {		
				rowPerPage = Integer.parseInt(request.getParameter("rowPerPage"));
			}
		// 디버깅
			System.out.println("ebookListrowPerPage : "+rowPerPage);
		
		
		// 시작행
			int beginRow = (currentPage - 1) * rowPerPage;
			System.out.print("ebookListbeginRow : "+beginRow);
			
		// 보여지는 카테고리 목록
			String categoryName = request.getParameter("categoryName");
			ArrayList<Ebook> ebookList = EbookDao.selectEbook(rowPerPage, beginRow, categoryName);
		
		// 전체 데이터 수
			int totalRow = EbookDao.totalCount();
		// totalRow 디버깅
			System.out.println("EbookTotalRow : "+totalRow);	
		
	%>
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

	<!-- 관리자화면 메뉴 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	
	<!-- 테이블 -->
	<div class="content-wrapper">
	<div class="container-fluid">
	<div class="col-lg-8">
		<div class="card-body">
            <h5 class="card-title">E-Book 관리</h5>
		     <!-- 카테고리별 목록을 볼 수 있는 메뉴(네비게이션) -->
			<div class="form-group">
				<a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable" 
				href="<%=request.getContextPath()%>/ebook/ebookList.jsp">전체</a>
				<%
					ArrayList<String> categoryNameList = CategoryDao.CategoryNameList();
					for(String s: categoryNameList) {
				%>
					<a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable" 
					href="<%=request.getContextPath()%>/ebook/ebookList.jsp?categoryName=<%=s%>"><%=s%></a>
				<%	
					}
				%>
			</div>
			
    <div class="table-responsive">
	
	<!-- ebook추가 버튼 -->
	<div class="form-group">
		<a href="<%=request.getContextPath()%>/ebook/insertEbookForm.jsp"><button type="button" class="btn btn-light btn-round px-5">E-book 추가</button></a>
	</div>
	
	
	<!-- rowPerPage별 페이징 (목록 5의 배수만큼 보여주기) -->
	<form action="<%=request.getContextPath()%>/ebook/ebookList.jsp" method="post">
		<select name="rowPerPage" class="form-control" style="width: 70px; height: 30px">
			<%
				for(int i=10;i<31;i+=5){
					if(rowPerPage==i){
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
		<button type="submit" class="btn btn-light btn-round px-4">보기</button>
	</form>
	
	<!-- 데이터 넣기 -->
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">category_Name</th>
				<th scope="col">ebook_ISBN</th>
				<th scope="col">ebook_Title</th>
				<th scope="col">ebook_Author</th>
				<th scope="col">ebook_Date</th>
				<th scope="col">ebook_Price</th>
			</tr>
		</thead>
		<tbody>
			<%
				for(Ebook e : ebookList) {
			%>
				<tr>
					<td><%=e.getCategoryName() %></td>
					<td><%=e.getEbookISBN() %></td>
					<td><a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable"
					 href="<%=request.getContextPath()%>/ebook/ebookListOne.jsp?ebookISBN=<%=e.getEbookISBN()%>"><%=e.getEbookTitle() %></a></td>
					<td><%=e.getEbookAuthor() %></td>
					<td><%=e.getEbookDate()%></td>
					<td><%=e.getEbookPrice() %></td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	</div>
	</div>
	
	<!-- 이전/다음 버튼  -->
	<%
		if(currentPage > 1) {
	%>
		
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage-1 %>&rowPerPage=<%=rowPerPage%>">
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
		System.out.println("ebookLastPage : "+ lastPage);
		
		if(currentPage < lastPage) {
	%>
		
			<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp?currentPage=<%=currentPage+1 %>&rowPerPage=<%=rowPerPage%>">
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