<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager"%>
<%@ page import="gdu.mall.util.*"%>
<%@ page import="gdu.mall.dao.*"%>

<%
// 1. 데이터 요청 수집 (전처리)
	String managerId = request.getParameter("managerId");
	String managerPw = request.getParameter("managerPw");
	System.out.println("(paoam)managerId : "+managerId);
	System.out.println("(paoam)managerPw : "+managerPw);
	
	// 2. 처리
	Manager manager = ManagerDao.login(managerId, managerPw);
	//로그인 성공 시 세션에 정보를 넣음
	if(manager != null) {
		System.out.println("로그인 성공");
		session.setAttribute("sessionManager", manager);
	}
	
	// 3. 출력 or redirect / 보여줄게 있으면 출력, 아니면 다른 페이지를 재요청
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp"); //	재요청
%>