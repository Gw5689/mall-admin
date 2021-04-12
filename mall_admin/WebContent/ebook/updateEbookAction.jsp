<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%	
	// 레벨에 따라 사용가능 여부 설정 (마지막에 삽입)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {  
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
%>
<%
	// 인코딩
		request.setCharacterEncoding("UTF-8");

	// 수집 (이미지 제외 모든 데이터)
		int ebookNo =Integer.parseInt(request.getParameter("ebookNo"));
		String categoryName = request.getParameter("categoryName");
		String ebookISBN = request.getParameter("ebookISBN");
		String ebookTitle = request.getParameter("ebookTitle");
		String ebookAuthor = request.getParameter("ebookAuthor");
		String ebookCompany = request.getParameter("ebookCompany");
		int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
		int ebookPrice =Integer.parseInt(request.getParameter("ebookPrice"));
		String ebookSummary = request.getParameter("ebookSummary");
		String ebookState = request.getParameter("ebookState");
	// 디버깅
		System.out.print("EbookActionData :" + ebookNo);
		System.out.print("EbookActionData :" + categoryName);
		System.out.print("EbookActionData :" + ebookISBN);
		System.out.print("EbookActionData :" + ebookTitle);
		System.out.print("EbookActionData :" + ebookAuthor);
		System.out.print("EbookActionData :" + ebookCompany);
		System.out.print("EbookActionData :" + ebookPageCount);
		System.out.print("EbookActionData :" + ebookPrice);
		System.out.print("EbookActionData :" + ebookSummary);
		System.out.print("EbookActionData :" + ebookState);
	
		
	// 전처리	
		Ebook ebook = new Ebook();
		
		ebook.setEbookNo(ebookNo);
		ebook.setEbookISBN(ebookISBN);
		ebook.setCategoryName(categoryName);
		ebook.setEbookTitle(ebookTitle);
		ebook.setEbookAuthor(ebookAuthor);
		ebook.setEbookCompany(ebookCompany);
		ebook.setEbookPrice(ebookPrice);
		ebook.setEbookPageCount(ebookPageCount);
		ebook.setEbookSummary(ebookSummary);
		ebook.setEbookState(ebookState);
		
		// 메소드 호출
		EbookDao.updateEbookOne(ebook);
		
		// 재요청
		response.sendRedirect(request.getContextPath()+"/ebook/ebookListOne.jsp?ebookISBN="+ebookISBN);
		
		
%>
