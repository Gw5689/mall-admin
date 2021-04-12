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
  <title>insertManagerAction</title>
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
//1. 수집 (전처리)
		request.setCharacterEncoding("UTF-8");
		String managerId = request.getParameter("managerId");
		String managerPw = request.getParameter("managerPw");
		String managerName = request.getParameter("managerName");
		System.out.println(managerId); //디버깅
		System.out.println(managerPw);	
		System.out.println(managerName);
		
		
		
	//2-1. 중복된 아이디가 있는지 확인, 있다면 입력폼으로 돌아가기
		//null이면 사용가능 else라면 사용불가
		String returnManagerId = ManagerDao.selectManagerId(managerId);
	
		if(returnManagerId != null) { //동일한 아이디가 존재한다
		System.out.println("이미 사용중인 아이디 입니다.");	//디버깅
		
		response.sendRedirect(request.getContextPath()+"/manager/insertManagerForm.jsp"); //매니저 인설트폼을 재요청
		return; //if문에 걸리면 디버깅을 출력하고 클라이언트한테 매니저 인설트폼을 요청하고 끝내기
		}
	//2-2. 없다면 입력
	ManagerDao.insertManager(managerId, managerPw, managerName);
	
	
	//3. 출력 (간단한 메세지 출력)
%>
	<div class="loader-wrapper"><div class="lds-ring"><div></div><div></div><div></div><div></div></div></div>
		<div class="card card-authentication1 mx-auto my-4">
			<div class="card-body">
				<div class="card-content p-2">
					<div class="text-center">
						<div class="form-group">
							매니저 등록 성공. 승인 후 사용 가능합니다.
							<a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable" 
							 href="<%=request.getContextPath()%>/adminIndex.jsp">HOME</a>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>