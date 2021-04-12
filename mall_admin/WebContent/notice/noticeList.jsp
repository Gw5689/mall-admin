<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
  <meta name="description" content=""/>
  <meta name="author" content=""/>
  <title>noticeList</title>
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
	// 관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
%>
	<!-- 관리자화면 메뉴(네비게이션) include -->
	<div>
		<!-- include 사용 시에 프로젝트명 필요없음 -->
		<jsp:include page="/inc/adminMenu.jsp"></jsp:include>
	</div>
	
	<div class="content-wrapper">
	<div class="container-fluid">
	<div class="col-lg-6">
		<div class="card-body">
            <h5 class="card-title">공지 관리</h5>
            	<div class="table-responsive">
	<!-- 공지 추가 버튼 -->
	<div class="form-group">
		<a href="<%=request.getContextPath()%>/notice/insertNoticeForm.jsp"><button type="button" class="btn btn-light btn-round px-5">공지 추가</button></a>
	</div>
	
	
	<!-- rowPerPage별 페이징 -->
	<%
		// 현재 페이지
		int currentPage = 1;
		if(request.getParameter("currentPage") != null) {
			currentPage = Integer.parseInt(request.getParameter("currentPage")); // 받아온 값 정수로 변환
		}
		
		// 페이지 당 행의 수
		int rowPerPage = 10;
		if(request.getParameter("rowPerPage") != null) {
			rowPerPage = Integer.parseInt(request.getParameter("rowPerPage")); // 받아온 값 정수로 변환
		}
		
		// 시작 행
		int beginRow = (currentPage - 1) * rowPerPage;
		
		// 전체 행의 개수
		int totalRow = NoticeDao.totalCount();
		System.out.println(totalRow+"<-- NoticeDao의 totalRow"); // 디버깅
		
		// list 생성	
		ArrayList<Notice> list = NoticeDao.selectNoticeListByPage(rowPerPage, beginRow);
	%>
			
			<!-- 한 페이지당 몇 개씩 볼건지 선택하는 기능 -->
			<form action="<%=request.getContextPath()%>/notice/noticeList.jsp" method="post">
				<select name="rowPerPage" class="form-control" style="width: 70px; height: 30px">
					<%
						for(int i=10; i<31; i+=5) {
							if(rowPerPage == i) {
					%>
							<!-- 옵션에서 선택한 개수만큼의 행이 보이게 함 -->
							<option value=<%=i%> selected="selected"><%=i%></option> 
					<%
							} else {
					%>
							<!-- 옵션 선택이 되어 있지 않으면 rowPerPage 설정 값으로 보이게 함 -->
							<option value=<%=i%>><%=i%></option>
					<%	
							}
						}
					%>
				</select>
				<button type="submit" class="btn btn-light btn-round px-4">보기</button>
			</form>
	
			<!-- 공지 목록 테이블 -->
			<table class="table table-hover">
				<thead>
					<tr>
						<th scope="col">notice_No</th>
						<th scope="col">notice_Title</th>
						<th scope="col">manager_Id</th>
						<th scope="col">notice_Date</th>
					</tr>
				</thead>
				<tbody>
					<%
						for(Notice n : list) { // for each문
					%>
							<tr>
								<td><%=n.getNoticeNo()%></td>
								<!-- noticeTitle을 클릭하면 상세보기(noticeOne)으로 넘어감 -->
								<td><a class="fc-day-grid-event fc-h-event fc-event fc-start fc-end fc-draggable fc-resizable" 
								href="<%=request.getContextPath()%>/notice/noticeOne.jsp?noticeNo=<%=n.getNoticeNo()%>"><%=n.getNoticeTitle()%></a></td>
								<td><%=n.getManagerId()%></td>
								<td><%=n.getNoticeDate().substring(0,11)%></td>
							</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
	</div>
	
	<!-- 페이징 (이전, 다음) 버튼 만들기 -->
	<% 
		// 맨 첫 페이지에서 이전 버튼이 나오지 않게 함
		if(currentPage > 1) {
	%>
			
			<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage-1%>&rowPerPage=<%=rowPerPage%>">
				<button class="btn btn-light btn-round px-4">이전</button>
			</a>
		
	<%
		}
	
		// 맨 마지막 페이지에서 다음 버튼이 보이지 않도록 함
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			lastPage += 1; // lastPage = lastPage+1; lastPage++;
		}
		
		if(currentPage < lastPage) {
	%>
		
			<a href="<%=request.getContextPath()%>/notice/noticeList.jsp?currentPage=<%=currentPage+1%>&rowPerPage=<%=rowPerPage%>">
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