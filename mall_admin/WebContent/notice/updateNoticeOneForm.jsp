<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만)
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
	// 수집 (noticeOne에서 수정 버튼에서 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- updateNoticeOneForm의 noticeNo"); // 디버깅
	
	// dao 연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
%>	
	
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<!-- updateNoticeOneForm 테이블 작성 -->
	<div class="content-wrapper">
	<div class="card card-authentication1 mx-auto my-10" style="width: 50rem;">
		<div class="card-body">
		<h5 class="card-title text-uppercase text-center py-3">공지 수정</h5>
			<div class="table-responsive">
				<form action="<%=request.getContextPath()%>/notice/updateNoticeOneAction.jsp" method="post">
				<input type="hidden" name="noticeNo" required="required" class="form-control input-shadow" placeholder="Enter Notice No" value="<%=noticeNo%>">
					<table class="table table-hover">
						<tr>
							<th scope="col">Notice_No</th>
							<td><%=notice.getNoticeNo()%></td>
						</tr>
						<tr>
							<th scope="col">Notice_Title</th>
							<td>
								<input type="text" name="noticeTitle" required pattern="^[a-zA-Z가-힣\s]+$" class="form-control input-shadow" placeholder="<%=notice.getNoticeTitle()%>">
							</td>
						</tr>
						<tr>
							<th scope="col">Notice_Content</th>
							<td>
								<textarea rows="10" cols="65" name="noticeContent" required="required" class="form-control input-shadow"><%=notice.getNoticeContent()%></textarea>
							</td>
						</tr>
						<tr>
							<th scope="col">Manager_ID</th>
							<td><%=notice.getManagerId()%></td>
						</tr>
						<tr>
							<th scope="col">Notice_Date</th>
							<td><%=notice.getNoticeDate().substring(0,11)%></td>
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