<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%

	//인코딩
	request.setCharacterEncoding("UTF-8");

	//레벨에 따라 사용가능 여부 설정
		Manager manager = (Manager)session.getAttribute("sessionManager");
		if(manager == null || manager.getManagerLevel() < 2) {  
			response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
			return;
		}
		
	// 데이터 수집
		String categoryName = request.getParameter("categoryName");
		int categoryWeight = Integer.parseInt(request.getParameter("categoryWeight"));
	// 디버깅
		System.out.println("updateCategoryActionName : "+categoryName);
		System.out.println("updateCategoryActionWeight : "+categoryWeight);
		
	// 업데이트 메서드
		CategoryDao.updateCategory(categoryName, categoryWeight);
	
	// dao 수정 메소드 호출 코드 구현
		response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>