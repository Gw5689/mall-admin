<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	//관리자만 접근할 수 있게 하는 메소드 
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	
	//인코딩
	request.setCharacterEncoding("UTF-8");
	
	//수집
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	String managerId = manager.getManagerId();
		
	//디버깅
	System.out.printf("deleteCommentAction : "+commentNo);
	System.out.printf("deleteCommentAction : "+noticeNo);
	System.out.printf("deleteCommentAction : "+managerId);
	
	// 레벨에 따라 삭제 가능 여부
	if(manager.getManagerLevel() > 1){
		CommentDao.deleteComment(commentNo);
	} else if (manager.getManagerLevel() > 0){
		CommentDao.deleteComment(commentNo, managerId);
	}
		
	//재실행
	response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>