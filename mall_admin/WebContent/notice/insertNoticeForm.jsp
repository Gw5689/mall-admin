<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 추가 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/notice/noticeList.jsp");
		return; // 코드 실행 멈춤
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
  <title>insertNoticeForm</title>
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
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
			
	<!-- 공지 추가 테이블 작성 -->
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="col-lg-6">
			<div class="card-body">
            <h5 class="card-title">공지 추가</h5>
            	<div class="table-responsive">
					<form action="<%=request.getContextPath()%>/notice/insertNoticeAction.jsp" method="post">
					<!-- action 파일에 managerId 값도 같이 넘겨줌 / 이미 로그인했기 때문에 managerId 값 넘어온 상태 -->
					<input type="hidden" name="managerId" value="<%=manager.getManagerId()%>">	
						<table class="table table-hover">
							<tr>
								<th>notice_Title</th>
								<td>
									<input type="text" name="noticeTitle" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="Enter Notice Title">
								</td>
							</tr>
							<tr>
								<th>notice_Content</th>
								<td>
									<textarea rows="10" cols="65" name="noticeContent" required="required" class="form-control input-shadow" placeholder="Enter Notice Content"></textarea>
								</td>
							</tr>
						</table>
						<hr>
						<button type="submit" class="btn btn-light btn-round px-4">등록</button>
					</form>
				</div>
			</div>
			</div>
		</div>
	</div>
</body>
</html>