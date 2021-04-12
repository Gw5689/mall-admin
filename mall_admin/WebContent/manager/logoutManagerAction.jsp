<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.Manager"%>
<%@ page import="gdu.mall.util.*"%>
<%@ page import="gdu.mall.dao.*"%>

<%
	session.invalidate(); // 세션 비우기 , (로그인 정보도 사라지게 된다. /로그아웃)
	response.sendRedirect(request.getContextPath()+"/adminIndex.jsp"); //	재요청  
%>
