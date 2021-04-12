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
<%
	// 수집
		String ebookISBN = request.getParameter("ebookISBN");
		ArrayList<String> categoryNameList = CategoryDao.CategoryNameList();
		String[] ebookStateList = {"판매중","품절","절판","구편절판"};
	// 디버깅
		System.out.println("updateFormISBN : "+ebookISBN);
	
	// 메소드 호출
		Ebook ebook = EbookDao.selectEbookOne(ebookISBN);
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>updateEbookForm</title>
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
	<div class="card card-authentication1 mx-auto my-10" style="width: 50rem;">
		<div class="card-body">
		<h5 class="card-title text-uppercase text-center py-3">E-book 전체 수정</h5>
			<div class="table-responsive">
				<form action="<%=request.getContextPath()%>/ebook/updateEbookAction.jsp" method="post">
					<input type="hidden" name="ebookISBN" value="<%=ebookISBN%>">
					<table class="table table-hover">
						<tr>
							<th scope="col">E-book_No</th>
							<td>
								<input type="text" name="ebookNo" required="required" class="form-control input-shadow" placeholder="Enter E-book No" value="<%=ebook.getEbookNo()%>">
							</td>
						</tr>
						<tr>
							<th scope="col">Category_Name</th>
							<td>
								<select name="categoryName" required="required" class="form-control" style="width: 140px; height: 30px">
									<option value="">=선택=</option>
									<%
										for(String cn : categoryNameList){
											if(cn.equals(ebook.getCategoryName())){
									%>
										<option value="<%=cn%>" selected="selected"><%=cn%></option>
									<%		
										} else {
									%>
										<option value="<%=cn%>"><%=cn%></option>
									<%
										}
									}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_Title</th>
							<td>
								<input type="text" name="ebookTitle" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="Enter E-book Title" value="<%=ebook.getEbookTitle()%>">
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_Author</th>
							<td>
								<input type="text" name="ebookAuthor" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="Enter E-book Author" value="<%=ebook.getEbookAuthor() %>">
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_ISBN</th>
							<td>
								<%=ebook.getEbookISBN()%>
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_Company</th>
							<td>
								<input type="text" name="ebookCompany" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="Enter E-book Company" value="<%=ebook.getEbookCompany() %>">
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_Date</th>
							<td><%=ebook.getEbookDate().substring(0,11)%></td>
						</tr>
						<tr>
							<th scope="col">E-book_Summary</th>
							<td>
								<textarea rows="5" cols="57" name="ebookSummary" required="required" class="form-control input-shadow" placeholder="Enter E-book Summary"><%=ebook.getEbookSummary() %></textarea>
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_Price</th>
							<td>
								<input type="text" name="ebookPrice" required pattern="^[0-9]+$" class="form-control input-shadow" placeholder="Enter E-book Price" value="<%=ebook.getEbookPrice() %>">
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_Page_Count</th>
							<td>
								<input type="text" name="ebookPageCount" required pattern="^[0-9]+$" class="form-control input-shadow" placeholder="Enter E-book Page_Count" value="<%=ebook.getEbookPageCount() %>">
							</td>
						</tr>
						<tr>
							<th scope="col">E-book_State</th>
							<td>
								<select name="ebookState" class="form-control" style="width: 140px; height: 30px">
								<%
									for(String es: ebookStateList){
										if(es.equals(ebook.getEbookState())){
								%>
										<option value="<%=es%>" selected="selected"><%=es%></option>
								<%
										} else {
								%>	
										<option value="<%=es%>"><%=es%></option>
								<%
											}
										}
								%>
								</select>
							</td>
						</tr>
					</table>
					</div>
					<button type="submit" class="btn btn-light btn-round px-4">수정</button>
				</form>
			</div>
		</div>
		</div>
</body>
</html>