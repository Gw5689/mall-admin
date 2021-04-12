<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
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
  <title>noticeOne</title>
  <!-- loader-->
  <link href="<%=request.getContextPath()%>/assets/css/pace.min.css" rel="stylesheet"/>
  <script src=" <%=request.getContextPath()%>/assets/js/pace.min.js"></script>
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
<body>
<%
	// 수집 (noticeList에서 클릭한 공지 noticeNo)
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	System.out.println(noticeNo+"<-- noticeOne의 noticeNo"); // 디버깅
	
	// dao연결
	Notice notice = NoticeDao.selectNoticeOne(noticeNo);
	System.out.println(notice); // 디버깅
%>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
		
	
	<!-- noticeOne 테이블 생성 -->
	<div class="content-wrapper">
		<div class="container-fluid">
			<div class="col-lg-8">
			<h5 class="card-title text-uppercase text-center py-3">공지 안내</h5>
			<div class="table-responsive">
				<table class="table table-hover">
					<tr>
						<th scope="col">Notice_No</th>
						<td><%=notice.getNoticeNo()%></td>
					</tr>
					<tr>
						<th scope="col">Notice_Title</th>
						<td><%=notice.getNoticeTitle()%></td>
					</tr>
					<tr>
						<th scope="col">Notice_Content</th>
						<td><%=notice.getNoticeContent()%></td>
					</tr>
					<tr>
						<th scope="col">Manager_Id</th>
						<td><%=notice.getManagerId()%></td>
					</tr>
					<tr>
						<th scope="col">Notice_Date</th>
						<td><%=notice.getNoticeDate().substring(0,11)%></td>
					</tr>
					
					
					
				</table>
				<a href="<%=request.getContextPath()%>/notice/updateNoticeOneForm.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button type="button" class="btn btn-light btn-round px-4">수정</button></a>
				<a href="<%=request.getContextPath()%>/notice/deleteNoticeAction.jsp?noticeNo=<%=notice.getNoticeNo()%>"><button type="button" class="btn btn-light btn-round px-4">삭제</button></a>
				
				<hr>
				
				<!-- 댓글  -->
				<form action="<%=request.getContextPath()%>/notice/insertCommentAction.jsp?noticeNo=<%=notice.getNoticeNo() %>" method="post">
					<!-- 현재 공지글 넘버 사용 -->
					<input type="hidden" name="noticeNo" value="<%=notice.getNoticeNo()%>">
					<div>
						<!-- 세션값 사용 (value) -->
						Manager_ID : 
						<input type="text" name="managerId" required="required" class="form-control input-shadow" placeholder="Manager_ID" value="<%=manager.getManagerId()%>" readonly="readonly">
					</div>
					<div>
						<textarea name="commentContent" required="required" class="form-control input-shadow" placeholder="댓글 입력" rows="2" cols="80"></textarea>
					</div>
					<div class="form-group">
						<button type="submit" class="btn btn-light btn-round px-4">댓글 입력</button>
					</div>
				</form>
				</div>
	
				

				<!-- 댓글 리스트 -->
				<%
					ArrayList<Comment> commentList = CommentDao.selectCommentListNoticeNo(noticeNo);
					for(Comment c : commentList) {
				%>
				<table class="table table-hover">
					<tr>
						<td><%=c.getCommentContent() %></td>
						<td><%=c.getCommentDate() %></td>
						<td><%=c.getManagerId() %></td>
						<td>
							<a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable"
							 	href="<%=request.getContextPath()%>/notice/deleteCommentAction.jsp?commentNo=<%=c.getCommentNo()%>&noticeNo=<%=notice.getNoticeNo()%>">삭제
							</a>
						</td>
					</tr>
				</table>
			</div>
		</div>  
	</div>

	<%		
		}
	%>
</body>
</html>