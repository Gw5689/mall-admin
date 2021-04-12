<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="gdu.mall.dao.*"%>
<%@page import="java.util.*"%>
<%@ page import="gdu.mall.vo.*"%>
<!--Start topbar header-->
<header class="topbar-nav">
 <nav class="navbar navbar-expand fixed-top">
  <ul class="navbar-nav mr-auto align-items-center">
    <li class="nav-item">
      <a class="nav-link toggle-menu" href="javascript:void();">
       <i class="icon-menu menu-icon"></i>
     </a>
    </li>
    <li class="nav-item">
      <form class="search-bar">
        <input type="text" class="form-control" placeholder="Enter keywords">
         <a href="javascript:void();"><i class="icon-magnifier"></i></a>
      </form>
    </li>
  </ul>
  
  	<li>
  	<%
  		ArrayList<Manager> list = ManagerDao.selectManagerListByZero();
  		Manager manager = (Manager)(session.getAttribute("sessionManager"));
  	%>
  	
		<%=manager.getManagerName() %> 님 반갑습니다.
		Level : <%=manager.getManagerLevel() %>
  	</li>
     
  <ul class="navbar-nav align-items-center right-nav-link">
    <li class="nav-item dropdown-lg">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
      <i class="fa fa-envelope-open-o"></i></a>
    </li>
    <li class="nav-item dropdown-lg">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();">
      <i class="fa fa-bell-o"></i></a>
    </li>
    <li class="nav-item language">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret waves-effect" data-toggle="dropdown" href="javascript:void();"><i class="fa fa-flag"></i></a>
      <ul class="dropdown-menu dropdown-menu-right">
          <li class="dropdown-item"> <i class="flag-icon flag-icon-gb mr-2"></i> English</li>
          <li class="dropdown-item"> <i class="flag-icon flag-icon-fr mr-2"></i> French</li>
          <li class="dropdown-item"> <i class="flag-icon flag-icon-cn mr-2"></i> Chinese</li>
          <li class="dropdown-item"> <i class="flag-icon flag-icon-de mr-2"></i> German</li>
        </ul>
    </li>
    <li class="nav-item">
      <a class="nav-link dropdown-toggle dropdown-toggle-nocaret" data-toggle="dropdown" href="#">
        <span class="user-profile"><img src="https://via.placeholder.com/110x110" class="img-circle" alt="user avatar"></span>
      </a>
      <ul class="dropdown-menu dropdown-menu-right">
       <li class="dropdown-item user-details">
        <a href="javaScript:void();">
           <div class="media">
             <div class="avatar"><img class="align-self-start mr-3" src="https://via.placeholder.com/110x110" alt="user avatar"></div>
            <div class="media-body">
            <h6 class="mt-2 user-title">Sarajhon Mccoy</h6>
            <p class="user-subtitle">mccoy@example.com</p>
            </div>
           </div>
          </a>
        </li>
        <li class="dropdown-divider"></li>
        <li class="dropdown-item"><i class="icon-envelope mr-2"></i> Inbox</li>
        <li class="dropdown-divider"></li>
        <li class="dropdown-item"><i class="icon-wallet mr-2"></i> Account</li>
        <li class="dropdown-divider"></li>
        <li class="dropdown-item"><i class="icon-settings mr-2"></i> Setting</li>
        <li class="dropdown-divider"></li>
        <li class="dropdown-item"><i class="icon-power mr-2"></i> Logout</li>
      </ul>
    </li>
  </ul>
</nav>
</header>
<!--End topbar header-->

<div id="sidebar-wrapper" data-simplebar="" data-simplebar-auto-hide="true">
     <div class="brand-logo">
      <a href="<%=request.getContextPath()%>/adminIndex.jsp">
       <img src="<%=request.getContextPath()%>/assets/images/logo-icon.png" class="logo-icon" alt="logo icon">
       <h5 class="logo-text">E-Book Admin</h5>
     </a>
   </div>
   <ul class="sidebar-menu do-nicescrol">
      <li class="sidebar-header">MAIN NAVIGATION</li>
      <li>
        <a href="<%=request.getContextPath()%>/adminIndex.jsp">
          <i class="zmdi zmdi-view-dashboard"></i> <span>HOME</span>
        </a>
      </li>

      <li>
        <a href="<%=request.getContextPath()%>/manager/managerList.jsp">
          <i class="zmdi zmdi-account-circle"></i> <span>운영자 관리</span>
        </a>
      </li>

      <li>
        <a href="<%=request.getContextPath()%>/client/clientList.jsp">
          <i class="zmdi zmdi-face"></i> <span>고객관리</span>
        </a>
      </li>

      <li>
        <a href="<%=request.getContextPath()%>/category/categoryList.jsp">
          <i class="zmdi zmdi-grid"></i> <span>카테고리 관리</span>
        </a>
      </li>

      <li>
        <a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">
          <i class="zmdi zmdi-bookmark"></i> <span>E-book관리</span>
        </a>
      </li>

      <li>
       <a href="<%=request.getContextPath()%>/orders/ordersList.jsp">
          <i class="zmdi zmdi-format-list-bulleted"></i> <span>주문 관리</span>
        </a>
      </li>

      <li>
        <a href="<%=request.getContextPath()%>/notice/noticeList.jsp">
          <i class="zmdi zmdi-notifications"></i> <span>공지 관리</span>
        </a>
      </li>

       <li>
        <a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">
          <i class="zmdi zmdi-lock"></i> <span>로그아웃</span>
        </a>
      </li>
    </ul>
    </div>
    
    <!--start color switcher-->
   <div class="right-sidebar">
    <div class="switcher-icon">
      <i class="zmdi zmdi-settings zmdi-hc-spin"></i>
    </div>
    <div class="right-sidebar-content">

      <p class="mb-0">Gaussion Texture</p>
      <hr>
      
      <ul class="switcher">
        <li id="theme1"></li>
        <li id="theme2"></li>
        <li id="theme3"></li>
        <li id="theme4"></li>
        <li id="theme5"></li>
        <li id="theme6"></li>
      </ul>

      <p class="mb-0">Gradient Background</p>
      <hr>
      
      <ul class="switcher">
        <li id="theme7"></li>
        <li id="theme8"></li>
        <li id="theme9"></li>
        <li id="theme10"></li>
        <li id="theme11"></li>
        <li id="theme12"></li>
		<li id="theme13"></li>
        <li id="theme14"></li>
        <li id="theme15"></li>
      </ul>
      
     </div>
   </div>
  <!--end color switcher-->
	</div>
	
<!-- Bootstrap core JavaScript-->
  <script src="<%=request.getContextPath()%>/assets/js/jquery.min.js"></script>
  <script src="<%=request.getContextPath()%>/assets/js/popper.min.js"></script>
  <script src="<%=request.getContextPath()%>/assets/js/bootstrap.min.js"></script>
	
 <!-- simplebar js -->
  <script src="<%=request.getContextPath()%>/assets/plugins/simplebar/js/simplebar.js"></script>
  <!-- sidebar-menu js -->
  <script src="<%=request.getContextPath()%>/assets/js/sidebar-menu.js"></script>
  <!-- loader scripts -->
  <script src="<%=request.getContextPath()%>/assets/js/jquery.loading-indicator.js"></script>
  <!-- Custom scripts -->
  <script src="<%=request.getContextPath()%>/assets/js/app-script.js"></script>
  <!-- Chart js -->
  
  <script src="<%=request.getContextPath()%>/assets/plugins/Chart.js/Chart.min.js"></script>
 
  <!-- Index js -->
  <script src="<%=request.getContextPath()%>/assets/js/index.js"></script>
 
   
  <!-- </div>
	<a href="<%=request.getContextPath()%>/adminIndex.jsp">운영자 홈</a>
	<a href="<%=request.getContextPath()%>/manager/managerList.jsp">운영자 관리</a>
	<a href="<%=request.getContextPath()%>/client/clientList.jsp">고객 관리</a>
	<a href="<%=request.getContextPath()%>/category/categoryList.jsp">상품 카테고리 관리</a>
	<a href="<%=request.getContextPath()%>/ebook/ebookList.jsp">ebook 관리</a>
	<a href="<%=request.getContextPath()%>/orders/ordersList.jsp">주문 관리</a>
	<a href="<%=request.getContextPath()%>/notice/noticeList.jsp">공지 관리</a>
	<a href="<%=request.getContextPath()%>/manager/logoutManagerAction.jsp">로그아웃</a>
</div> -->
