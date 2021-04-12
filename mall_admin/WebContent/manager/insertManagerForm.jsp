<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.Manager"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>insertManagerForm</title>
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
	
	<div class="loader-wrapper"><div class="lds-ring"><div></div><div></div><div></div><div></div></div></div>
		<div class="card card-authentication1 mx-auto my-4">
			<div class="card-body">
				<div class="card-content p-2">
					<div class="text-center">
						<img src="<%=request.getContextPath()%>/assets/images/logo-icon.png" alt="logo icon">
					</div>
					<div class="card-title text-uppercase text-center py-3">매니저 등록</div>
						<form action="<%=request.getContextPath()%>/manager/insertManagerAction.jsp" method="post">
							<div class="form-group">
								<label for="exampleInputID" class="sr-only">Manager_ID</label>
									<div class="position-relative has-icon-right">
										<input type="text" name="managerId" required pattern="^[a-z0-9]{5,20}$" class="form-control input-shadow" placeholder="Enter Your ID" style="width: 100%">
										<div class="form-control-position">
					  						<i class="icon-user"></i>
				  						</div>
									</div>
								</div>
								<div class="form-group">
								<label for="exampleInputPW" class="sr-only">Manager_PW</label>
									<div class="position-relative has-icon-right">
										<input type="password" name="managerPw" required pattern="^[a-z0-9\W]{4,20}$" class="form-control input-shadow" placeholder="Enter Your PW" style="width: 100%">
									<div class="form-control-position">
										<i class="icon-lock"></i>
									</div>
								 </div>
								</div>
								<div class="form-group">
								   <label for="exampleInputPassword" class="sr-only">Manager_Name</label>
								   <div class="position-relative has-icon-right">
										<input type="text" name="managerName" required pattern="^[a-zA-Z가-힣]{2,100}$" class="form-control input-shadow" placeholder="Enter Your Name" style="width: 100%">
									<div class="form-control-position">
										<i class="zmdi zmdi-face"></i>
									</div>
								  </div>
								</div>
							<div class="form-group">
								<button type="submit" class="btn btn-light btn-block waves-effect waves-light">등록</button>
							</div>
						</form>		
						<div class="form-group">
								<a href="<%=request.getContextPath()%>/adminIndex.jsp">
									<button type="button" class="btn btn-light btn-block waves-effect waves-light">돌아가기</button>
								</a>
						</div>
				</div>
			</div>
		</div>
						
</body>
</html>