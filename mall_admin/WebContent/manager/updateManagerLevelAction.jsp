<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.vo.*"%>

<%
//	관리자만 들어올 수 있게 하는 코드
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	} else if(manager.getManagerLevel() < 2) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	// 수집 코드 구현
	int managerNo = Integer.parseInt(request.getParameter("managerNo"));
	int managerLevel = Integer.parseInt(request.getParameter("managerLevel"));
	System.out.println("upManagerNo : " + managerNo);
	System.out.println("upManagerLevel : " + managerLevel);
	
	//update 메소드
	ManagerDao.updateManagerLevel(managerNo, managerLevel);
	
	// dao 수정 메소드 호출 코드 구현
	response.sendRedirect(request.getContextPath()+"/manager/managerList.jsp");
%>