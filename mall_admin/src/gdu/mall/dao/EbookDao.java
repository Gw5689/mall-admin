package gdu.mall.dao;

import java.sql.*;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;

public class EbookDao {
	// OneList 메서드
	public static void updateEbookOne(Ebook ebook) throws Exception{
		// sql
		String sql = "UPDATE ebook SET ebook_no=?, category_name=? , ebook_title= ?, ebook_author=? , ebook_summary= ?, ebook_company= ?, ebook_page_Count=?, ebook_price=? , ebook_state=? WHERE ebook_isbn=?";
		
		// db 핸들링 , 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, ebook.getEbookNo());
		stmt.setString(2, ebook.getCategoryName());
		stmt.setString(3, ebook.getEbookTitle());
		stmt.setString(4, ebook.getEbookAuthor());
		stmt.setString(5, ebook.getEbookSummary());
		stmt.setString(6, ebook.getEbookCompany());
		stmt.setInt(7, ebook.getEbookPageCount());
		stmt.setInt(8, ebook.getEbookPrice());
		stmt.setString(9, ebook.getEbookState());
		stmt.setString(10, ebook.getEbookISBN());	
		// 디버깅
		System.out.println("updateEbookOneStmt : " +stmt);
		
		// 실행
		stmt.executeQuery();
		
	}
	
	// State 수정
	public static int updateEbookState (Ebook ebook) throws Exception {
		// sql
			String sql = "UPDATE ebook SET ebook_state=? WHERE ebook_isbn=?";
			
		// db 핸들링 , 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookState());
			stmt.setString(2, ebook.getEbookISBN());
		// 디버깅
			System.out.println("updateEbookStateStmt : " + stmt);
			
			int rowCnt = stmt.executeUpdate();
			
		// 리턴
			return rowCnt;
	}
	
	
	// 삭제 메소드
	public static void deleteEbook(String ebookISBN) throws Exception{
		// sql
			String sql = "DELETE FROM ebook WHERE ebook_isbn=?";
		
		// db 핸들링, 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebookISBN);
		// 디버깅
			System.out.println("deleteEbookStmt : " + stmt);
			
		// 처리 
			stmt.executeUpdate();
			
		}
	
	// Summary 수정
	public static int updateEbookSummary(Ebook ebook) throws Exception {
		// sql
			String sql = "UPDATE ebook SET ebook_summary=? WHERE ebook_isbn=?";
		
		// db 핸들링
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookSummary());
			stmt.setString(2, ebook.getEbookISBN());
		// 디버깅
			System.out.println("updateEbookSummaryStmt :" + stmt);
			
			int rowCnt = stmt.executeUpdate();
			
		// 리턴
			return rowCnt;
	}
	
	// 이미지 수정
	public static int updateEbookImg(Ebook ebook) throws Exception{
		// sql
			String sql = "UPDATE ebook SET ebook_img=? WHERE ebook_isbn=?";
			
		// db 핸들링, 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookImg());
			stmt.setString(2, ebook.getEbookISBN());
		// 디버깅
			System.out.println("updateImgStmt : " + stmt);
			
			int rowCnt = stmt.executeUpdate();
			
		// 리턴	
			return rowCnt;
	}
	
	
	// ISBN 중복 검사
	public static int checkISBN (String ebookISBN) throws Exception {
		// sql
			String sql = "SELECT ebook_isbn ebookISBN FROM ebook WHERE ebook_isbn = ?";
			
		// db 핸들링, 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebookISBN);
		// 디버깅
			System.out.println("checkISBNstmt : " + stmt);
		
		// 처리 
			ResultSet rs = stmt.executeQuery();
		
		// 리턴
			if(rs.next()) {	 // 중복되는 ISBN이 있다면 0 받기
				return 0;
			} else {	// 중복되는 ISBN이 없다면 1 받기
			return 1;
			}
	}
	
	
	//ebook타입
	public static Ebook selectEbookOne(String ebookISBN) throws Exception{
		// sql 쿼리 전부 다 가져오기
			String sql = "SELECT ebook_no ebookNo, ebook_isbn ebookISBN, category_name categoryName, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_company ebookCompany, ebook_page_count ebookPageCount, ebook_price ebookPrice, ebook_img ebookImg, ebook_summary ebookSummary, ebook_date ebookDate,ebook_state ebookState FROM ebook WHERE ebook_isbn = ?";
		
		// 초기화
			Ebook ebook = new Ebook();
			
		// db 핸들링, 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebookISBN);
		// 디버깅
			System.out.println("EbookDaoOneStmt : " + stmt);
			
		// 실행
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				ebook.setEbookNo(rs.getInt("ebookNo"));
				ebook.setEbookISBN(rs.getString("ebookISBN"));
				ebook.setCategoryName(rs.getString("categoryName"));
				ebook.setEbookTitle(rs.getString("ebookTitle"));
				ebook.setEbookAuthor(rs.getString("ebookAuthor"));
				ebook.setEbookCompany(rs.getString("ebookCompany"));
				ebook.setEbookPageCount(rs.getInt("ebookPageCount"));
				ebook.setEbookPrice(rs.getInt("ebookPrice"));
				ebook.setEbookImg(rs.getString("ebookImg"));
				ebook.setEbookSummary(rs.getString("ebookSummary"));
				ebook.setEbookDate(rs.getString("ebookDate"));
				ebook.setEbookState(rs.getString("ebookState"));
			}
			
		// 리턴	
			return ebook;
	}
	
	// 입력 메서드
	public static int insertEbook(Ebook ebook) throws Exception{
		// spl
		String sql = "INSERT INTO ebook(ebook_isbn,category_name,ebook_title,ebook_author,ebook_company,ebook_page_count,ebook_price,ebook_summary,ebook_img,ebook_date,ebook_state) VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'default.jpg', NOW(), '판매중')";
			int rowCnt = 0;
			
		// db핸들링 , 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, ebook.getEbookISBN());
			stmt.setString(2, ebook.getCategoryName());
			stmt.setString(3, ebook.getEbookTitle());
			stmt.setString(4, ebook.getEbookAuthor());
			stmt.setString(5, ebook.getEbookCompany());
			stmt.setInt(6, ebook.getEbookPageCount());
			stmt.setInt(7, ebook.getEbookPrice());
			stmt.setString(8, ebook.getEbookSummary());
		// 디버깅
			System.out.println("insertEbookSmtm : " + stmt);
			
		// 처리
			rowCnt = stmt.executeUpdate();
			
			return rowCnt;
	}
	
	// 목록 메서드
	public static ArrayList<Ebook> selectEbook(int rowPerPage, int beginRow, String categoryName) throws Exception{
		// 초기화
			ArrayList<Ebook> list = new ArrayList<>();
			String sql = "";
		
		// sql
			//String sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?,?";
		
		// 마리아db 핸들링 , 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = null;
			
			if(categoryName == null) {
				sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook ORDER BY ebook_date DESC LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setInt(1, beginRow);
				stmt.setInt(2, rowPerPage);
			} else {
				sql = "SELECT category_name categoryName, ebook_isbn ebookISBN, ebook_title ebookTitle, ebook_author ebookAuthor, ebook_date ebookDate, ebook_price ebookPrice FROM ebook WHERE category_name=? ORDER BY ebook_date DESC LIMIT ?,?";
				stmt = conn.prepareStatement(sql);
				stmt.setString(1, categoryName);
				stmt.setInt(2, beginRow);
				stmt.setInt(3, rowPerPage);
			}
		// 디버깅
			System.out.println("EbookDaoPageStmt : "+ stmt );	
		
		// 실행
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Ebook e = new Ebook();
			e.setCategoryName(rs.getString("categoryName"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookAuthor(rs.getString("ebookAuthor"));
			e.setEbookDate(rs.getString("ebookDate"));
			e.setEbookPrice(rs.getInt("ebookPrice"));
			list.add(e);
		}
		
		//리턴
		return list;
	}
	
	// 전체 행의 수
	public static int totalCount() throws Exception {
		Connection conn = DBUtil.getConnection();
		
		//sql
			String sql = "SELECT COUNT(*) cnt FROM ebook";
		
		int totalRow = 0;

		// 전체행의 수
			PreparedStatement stmt = conn.prepareStatement(sql);
		
		// 쿼리 실행
			ResultSet rs = stmt.executeQuery();
		
		// 전체행 갯수 totalRow변수에 대입
			if(rs.next()) {
				totalRow = rs.getInt("cnt"); 
			}
		// 디버깅
		System.out.println("ebookDaoTotalRow : "+totalRow);
		
		// 리턴
		return totalRow;
	}

}