<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="gdu.mall.vo.*"%>
<%@ page import="gdu.mall.dao.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 이미 등록된 파일 이름과 중복되지 않게 해야된다. / cos.jar : 파일 이름이 중복되지 않게함 -->
<%
	//레벨에 따라 사용가능 여부 설정 (마지막에 삽입)
	Manager manager = (Manager)session.getAttribute("sessionManager");
	if(manager == null || manager.getManagerLevel() < 1) {  
		response.sendRedirect(request.getContextPath()+"/adminIndex.jsp");
		return;
	}
	/*
	String ebookISBN = request.getParameter("ebookISBN");
	String ebookImg = request.getParameter("ebookImg");
	System.out.println(ebookISBN);	// why null? 문자열로 넘겼기 때문에 null출력
	System.out.println(ebookImg);	// why null?
	*/
	
	// 파일을 다운로드 받을 위치
	//String path = application.getRealPath("img"); // 컴퓨터 폴더 위치, (img라는 폴더의 OS상의 실제 폴더경로 위치)
		String path = "C:/goodee/web/mall_admin/WebContent/img";
	//디버깅
		System.out.println(path);
	
	// 파일 크기 (100MB)
		int size = 1024 * 1024 * 100; 
	
	//	request를 MultipartRequest한테 위임 (해석을 하기 위함, 저장할 위치, 파일크기, 인코딩, 중복된 이름이 있다면 처리)
		MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		String ebookISBN = multi.getParameter("ebookISBN");
		String ebookImg = multi.getFilesystemName("ebookImg"); // DefaultFileRenamePolicy 로 바뀌어진 이름
		System.out.println(ebookISBN);
		System.out.println(ebookImg);
	
	// 초기화
	Ebook ebook = new Ebook();
	
	ebook.setEbookImg(ebookImg);
	ebook.setEbookISBN(ebookISBN);
	
	// 메서드 호출
	EbookDao.updateEbookImg(ebook);
	
	// 재요청
	response.sendRedirect(request.getContextPath()+"/ebook/ebookListOne.jsp?ebookISBN="+ebookISBN);
%>