<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
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
	
	//ISBN 중복체크
		if(EbookDao.checkISBN(ebookISBN) == 0) {	// 중복되는 ISBN을 0으로 받기로 함, 0값이라면 중복된 ISBN이 있으므로 프린트 출력
			response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
			System.out.println("이미 등록된 ISBN 입니다.");
			return;
		}
	
	// 데이터 
	String categoryName = request.getParameter("categoryName");
	String ebookTitle = request.getParameter("ebookTitle");
	String ebookAuthor = request.getParameter("ebookAuthor");
	String ebookCompany = request.getParameter("ebookCompany");
	int ebookPageCount = Integer.parseInt(request.getParameter("ebookPageCount"));
	int ebookPrice = Integer.parseInt(request.getParameter("ebookPrice"));
	String ebookSummary = request.getParameter("ebookSummary");
	
	// 디버깅
		System.out.println("insertAction : " + categoryName);
		System.out.println("insertAction : " + ebookISBN);
		System.out.println("insertAction : " + ebookTitle);
		System.out.println("insertAction : " + ebookAuthor);
		System.out.println("insertAction : " + ebookCompany);
		System.out.println("insertAction : " + ebookPageCount);
		System.out.println("insertAction : " + ebookPrice);
		System.out.println("insertAction : " + ebookSummary);
		
		
	// 전처리 (하나로 묶음)
		Ebook ebook = new Ebook();
	
	// 데이터 넣기
		
		ebook.setCategoryName(categoryName);
		ebook.setEbookISBN(ebookISBN);
		ebook.setEbookTitle(ebookTitle);
		ebook.setEbookAuthor(ebookAuthor);
		ebook.setEbookCompany(ebookCompany);
		ebook.setEbookSummary(ebookSummary);
		ebook.setEbookPageCount(ebookPageCount);
		ebook.setEbookPrice(ebookPrice);
		
		EbookDao.insertEbook(ebook);
		
		//재요청
		response.sendRedirect(request.getContextPath()+"/ebook/ebookList.jsp");
	
%>


