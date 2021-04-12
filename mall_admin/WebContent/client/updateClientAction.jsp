<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%	
	// 레벨에 따라 사용가능 여부 설정
		Manager manager = (Manager)session.getAttribute("sessionManager");
		if(manager == null || manager.getManagerLevel() < 2) {  
			response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
			return;
		}
	// 수집 코드 구현
		String clientMail = request.getParameter("clientMail");	
		String clientPw = request.getParameter("clientPw");
		//디버깅
		System.out.println("updateClientMail : " + clientMail);
		System.out.println("updateClientPw : " + clientPw);
		
		//update 메소드
		ClientDao.updateClient(clientMail, clientPw);
		
		// dao 수정 메소드 호출 코드 구현
		response.sendRedirect(request.getContextPath()+"/client/clientList.jsp");
%>
