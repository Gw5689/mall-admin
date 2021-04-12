<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%	
	// 레벨에 따라 사용가능 여부 설정
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {  
		response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
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
<%
	String clientMail= request.getParameter("clientMail");
%>

	<!-- 관리자 화면 네비게이션 -->
	<div>
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="content-wrapper">
	<div class="card card-authentication1 mx-auto my-10" style="width: 50rem;">
		<div class="card-body">
		<h5 class="card-title text-uppercase text-center py-3">고객정보 수정</h5>
			<div class="table-responsive">
				<form action="<%=request.getContextPath()%>/client/updateClientAction.jsp" method="post">
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">E-Mail</th>
								<th scope="col">새 비밀번호</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><%=clientMail%></td>
								<td>
									<input type="hidden" name="clientMail" value="<%=clientMail%>">
									<input type="text" name="clientPw" required pattern="^[a-z0-9\W]{4,20}$" class="form-control input-shadow" placeholder="Enter Client PW">
								</td>
							</tr>
						</tbody>
					</table>
					</div>
					<button type="submit" class="btn btn-light btn-round px-4">수정</button>
				</form>
			</div>
		</div>
	</div>
</body>
</html>