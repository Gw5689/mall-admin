package gdu.mall.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;

import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;

public class CommentDao {
	// 댓글이 있는 공지글인지 질문..
	public static int selectCommentCnt(int noticeNo) throws Exception {
	      int rowCnt = 0;
	      String sql = "select count(*) cnt from comment where notice_no=?";
	      //DB 연결
	      Connection conn = DBUtil.getConnection();
	      PreparedStatement stmt = conn.prepareStatement(sql);
	      stmt.setInt(1, noticeNo);
	      //디버깅
	      System.out.println("selectCommentCnt " + stmt);
	      //처리
	      ResultSet rs = stmt.executeQuery();      
	      if(rs.next()) {
	         rowCnt = rs.getInt("cnt");
	      }
	      //디버깅
	      System.out.println(rowCnt+"<-rowCnt");
	      //리턴
	      return rowCnt;
	   }
	
	
	// 입력 메서드
	public static int insertComment(Comment comment) throws Exception{
		// sql
		String sql = "INSERT INTO comment(notice_no, manager_id, comment_content, comment_date) VALUES(?,?,?,NOW())";
		// 초기화
		int rowCnt = 0;
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, comment.getNoticeNo());
		stmt.setString(2, comment.getManagerId());
		stmt.setString(3, comment.getCommentContent());
		// 디버깅
		System.out.println("insertCommentStmt : "+ stmt);
		// 처리
		rowCnt = stmt.executeUpdate();
		
		return rowCnt;
	}
	
	// 목록 메서드
	public static ArrayList<Comment> selectCommentListNoticeNo(int noticeNo) throws Exception {

		// sql
		String sql = "SELECT comment_no commentNo, notice_no noticeNo, manager_id managerId, comment_content commentContent, comment_date commentDate FROM comment WHERE notice_no=? ORDER BY comment_date DESC";
		// 초기화
		ArrayList<Comment> list = new ArrayList<Comment>();
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, noticeNo);
		// 디버깅
		System.out.println("selectCommentListNoticeNoStmt : "+stmt);
		// 처리
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {
			Comment c = new Comment();
			c.setCommentNo(rs.getInt("commentNo"));
			c.setNoticeNo(rs.getInt("noticeNo"));
			c.setManagerId(rs.getString("managerId"));
			c.setCommentContent(rs.getString("commentContent"));
			c.setCommentDate(rs.getString("commentDate"));
			
			list.add(c);
		}
		
		return list;
	}
	
	// deleteComment 메서드 오버로딩 (이름이 같으면서 다름, 매개변수 호출 갯수에 따라 달라짐)
	public static int deleteComment(int commentNo) throws Exception {
		
		// sql
		String sql = "DELETE FROM comment WHERE comment_no=?";
		// 초기화
		int rowCnt = 0;
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		// 디버깅
		System.out.print("deleteCommentStmt : "+stmt);
		// 처리
		rowCnt = stmt.executeUpdate();
		
		// 리턴
		return rowCnt;
	}
	
	// 삭제 메서드
	public static int deleteComment(int commentNo, String managerId) throws Exception{
		
		// sql
		String sql = "DELETE FROM comment WHERE comment_no=? AND manager_id=?";
		// 초기화
		int rowCnt = 0;
		// DB 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, commentNo);
		stmt.setString(2, managerId);
		// 디버깅
		System.out.print("deleteCommentStmt : "+stmt);
		// 처리
		rowCnt = stmt.executeUpdate();
		
		// 리턴
		return rowCnt;
	}
	
}
