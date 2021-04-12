package gdu.mall.dao;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.sql.*;
public class ClientDao {
	
	// Client PW수정 메소드
		public static void updateClient(String clientMail, String clientPw) throws Exception {
			// sql
			String sql = "UPDATE client SET client_pw = PASSWORD(?) WHERE client_mail=?";
			
			// 마리아db 핸들링 , 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, clientPw);
			stmt.setString(2, clientMail);
			//디버깅
			System.out.println("ClientDaoUpdateStmt : "+ stmt);
			
			stmt.executeUpdate();
		}
		
	// Client 삭제 메소드
		public static void deleteClient(String clientMail) throws Exception {
			// sql
			String sql = "DELETE FROM client WHERE client_mail=?";
			
			//	마리아db 핸들링
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, clientMail);
			//디버깅
			System.out.println("ClientDaoDeleteStmt : "+stmt);
			
			stmt.executeUpdate();	
		}
	
	//	전체 행의 수
	public static int totalCount(String searchWord) throws Exception{
		// 초기화
		int totalRow = 0;
		
		// 마리아db 핸들링
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		
		// sql
		String sql = "";
		if(searchWord.equals("")) { //searchWord가 공백이면
			sql = "SELECT COUNT(*) FROM client";
			stmt = conn.prepareStatement(sql);
		} else {	//searchWord가 공백이 아니라면
			sql = "SELECT COUNT(*) FROM client WHERE client_mail LIKE ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
		}

		
		// 디버깅
		System.out.println("ClientDaoTotalStmt : "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {	// 데이터가 존재한다면 총 개수 입력
			totalRow = rs.getInt("count(*)");
		}
		
		//	4. 리턴
		return totalRow;
	}
	
	//	목록 메서드
	
	public static ArrayList<Client> selectClientListByPage(int rowPerPage, int beginRow, String searchWord) throws Exception {
		
		//	2. 초기화
		ArrayList<Client> list = new ArrayList<Client>();
		
		//	3. 마리아 db 핸들링 ,처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = null;
		String sql = "";
		
		//searchWord가 공백이라면
		if(searchWord.equals("")) {
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
		} else {	// 공백이 아니라면
			sql = "SELECT client_mail clientMail, client_date clientDate FROM client WHERE client_mail like ? ORDER BY client_date DESC LIMIT ?, ?";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%"+searchWord+"%");
			stmt.setInt(2, beginRow);
			stmt.setInt(3, rowPerPage);
		}
		//	디버깅
		System.out.println("ClientDaoPageStmt : "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while (rs.next()) {
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			c.setClientDate(rs.getString("clientDate"));
			list.add(c);
		
		}
		//	4.리턴
		return list;
	}
}