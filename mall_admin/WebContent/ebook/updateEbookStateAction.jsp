<%@page import="gdu.mall.util.DBUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%
	// 레벨에 따라 사용가능 여부 설정
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {  
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	
	// 인코딩
		request.setCharacterEncoding("UTF-8");
	
	// 수집
		String ebookISBN = request.getParameter("ebookISBN");
		String ebookState = request.getParameter("ebookState");
	// 디버깅
		System.out.println("updateEbookStateActionISBN : "+ ebookISBN);
		System.out.println("updateEbookStateActionState : "+ ebookState);
	
	// 전처리
		Ebook ebook = new Ebook();
		ebook.setEbookISBN(ebookISBN);
		ebook.setEbookState(ebookState);
		
	// 업데이트 메소드
		EbookDao.updateEbookState(ebook);
	
	// 재요청
		response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
	
	
%>
