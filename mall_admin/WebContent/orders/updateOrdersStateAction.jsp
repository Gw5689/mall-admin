<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	//레벨에 따라 사용가능 여부 설정
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {  
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 인코딩
	request.setCharacterEncoding("UTF-8");

	// 초기화 
	int ordersNo = Integer.parseInt(request.getParameter("ordersNo"));
	String ordersState = request.getParameter("ordersState");
	// 디버깅
	System.out.println("StateActionOrdersNo : "+ordersNo);
	System.out.println("StateActionordersState : "+ordersState);
	// 처리
	OrdersDao.updateOrders(ordersState, ordersNo);
	// 재요청
	response.sendRedirect(request.getContextPath()+"/orders/ordersList.jsp");
%>