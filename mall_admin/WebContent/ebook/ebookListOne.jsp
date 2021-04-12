<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%	
	// 레벨에 따라 사용가능 여부 설정 (마지막에 삽입)
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
  <title>ebookListOne</title>
  <!-- loader-->
  <link href="<%=request.getContextPath()%>/assets/css/pace.min.css" rel="stylesheet"/>
  <script src="assets/js/pace.min.js"></script>
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
	// 수집
		String ebookISBN = request.getParameter("ebookISBN");
	// 디버깅
		System.out.println("ebookOneISBN : " + ebookISBN);
	
	// 데이터 가져오기
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
%>
	<!-- 관리자화면 메뉴 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="content-wrapper">
	<div class="card card-authentication1 mx-auto my-10" style="width: 50rem;">
		<div class="card-body">
		<h5 class="card-title text-uppercase text-center py-3">E-book 상세정보</h5>
			<div class="table-responsive">
				<table class="table table-hover">
					<tr>
						<th scope="col">E-book_NO</th>
						<td><%=ebook.getEbookNo() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">Category_Name</th>
						<td><%=ebook.getCategoryName()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">E-book_Title</th>
						<td><%=ebook.getEbookTitle() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">E-book_State</th>
						<td><%=ebook.getEbookState() %></td>
						<td>
							<a href="<%=request.getContextPath()%>/ebook/updateEbookStateForm.jsp?ebookState=<%=ebook.getEbookState()%>&ebookISBN=<%=ebook.getEbookISBN()%>">
								<button type="button" class="btn btn-light btn-round px-4">책상태 수정</button>
							</a>
						</td>
					</tr>
					<tr>
						<th scope="col">E-book_Author</th>
						<td><%=ebook.getEbookAuthor() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">E-book_Img</th>
						<td><img src="<%=request.getContextPath()%>/img/<%=ebook.getEbookImg() %>"></td>
						<td>
							<a href="<%=request.getContextPath()%>/ebook/updateEbookImgForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">
								<button type="button" class="btn btn-light btn-round px-4">이미지 수정</button>
							</a>
						</td>
					</tr>
					<tr>
						<th scope="col">E-book_ISBN</th>
						<td><%=ebook.getEbookISBN() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">ebookCompany</th>
						<td><%=ebook.getEbookCompany() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">E-book_Date</th>
						<td><%=ebook.getEbookDate()%></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">E-book_Summary</th>
						<td><%=ebook.getEbookSummary() %></td>
						<td>
							<a href="<%=request.getContextPath()%>/ebook/updateEbookSummaryForm.jsp?ebookISBN=<%=ebookISBN%>&ebookSummary=<%=ebook.getEbookSummary()%>">
								<button type="button" class="btn btn-light btn-round px-4">책요약 수정</button>
							</a>
						</td>
					</tr>
					<tr>
						<th scope="col">E-book_Price</th>
						<td><%=ebook.getEbookPrice() %></td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<th scope="col">E-book_Page_Count</th>
						<td><%=ebook.getEbookPageCount() %></td>
						<td>&nbsp;</td>
					</tr>
				</table>
			</div>
			<a href="<%=request.getContextPath()%>/ebook/updateEbookForm.jsp?ebookISBN=<%=ebook.getEbookISBN()%>">
				<button type="button" class="btn btn-light btn-round px-4">전체 수정(이미지 제외)</button>
			</a>
		
			<a href="<%=request.getContextPath()%>/ebook/deleteEbookAction.jsp?ebookISBN=<%=ebookISBN%>">
				<button type="button" class="btn btn-light btn-round px-4">삭제</button>
			</a>
		</div>
	</div>
	</div>
</body>
</html>