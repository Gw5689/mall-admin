<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.dao.*" %>
<%@ page import="gdu.mall.vo.*" %>
<%@ page import="java.util.*" %>
<%
	// 관리자만 접근할 수 있게 하는 메소드 (level 2 이상만 공지 추가 가능함)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 0) {
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return; // 코드 실행 멈춤
	}
	
	// 인코딩
		request.setCharacterEncoding("UTF-8");
	
	// 수집
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		String commentContent = request.getParameter("commentContent");
		String managerId = request.getParameter("managerId");
	// 디버깅
		System.out.println("insertCommentActionnoticeNo : "+noticeNo);
		System.out.println("insertCommentActionCommentContent : "+commentContent);
	
	// 데이터 전처리
		Comment comment = new Comment();
		
		comment.setManagerId(managerId);
		comment.setCommentContent(commentContent);
		comment.setNoticeNo(noticeNo);
		
	// 메소드 호출
		CommentDao.insertComment(comment);
	
	// 댓글 추가 후 공지 목록으로 재요청
		response.sendRedirect(request.getContextPath()+"/notice/noticeOne.jsp?noticeNo="+noticeNo);
%>
