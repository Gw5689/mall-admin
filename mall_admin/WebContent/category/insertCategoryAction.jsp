<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="gdu.mall.util.*"%>
<%
	//레벨에 따라 사용가능 여부 설정
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 2) {  
		response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
		return;
		
	}
	//	인코딩
		request.setCharacterEncoding("UTF-8");

	// 데이터 수집
		String categoryName = request.getParameter("categoryName");
	// 디버깅
		System.out.println("insertActionCateroryName : "+categoryName);
		
	// 카테고리 네임 중복 검사코드
		String returnCategoryName = CategoryDao.selectCategoryName(categoryName);
			
		if(returnCategoryName != null) { 
		// 디버깅
		System.out.println("이미 등록된 이름 입니다.");
		
		// 동일한 이름이 존재 한다면 카테고리 폼 재요청	
		response.sendRedirect(request.getContextPath()+"/category/insertCategoryForm.jsp");
		
		return; //if문에 걸리면 디버깅을 출력하고 클라이언트한테 카테고리 인설트폼을 요청하고 끝내기
		}
		
	// 동일한 네임이 없다면 입력
		CategoryDao.insertCategory(categoryName);
	
	// 등록후 리스트로 돌아감
		response.sendRedirect(request.getContextPath()+"/category/categoryList.jsp");
%>
	
	