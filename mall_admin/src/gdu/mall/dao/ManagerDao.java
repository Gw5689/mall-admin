package gdu.mall.dao;
import gdu.mall.vo.*;
import java.sql.*;
import java.util.*;
import gdu.mall.util.*;

public class ManagerDao {
	
	// 매니저 목록 메소드
		public static ArrayList <Manager> selectManagerListByPage(int rowPerPage, int beginRow) throws Exception {
			// 쿼리 작성
			String sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_date DESC LIMIT ?, ?";
			
			// 배열 변수 초기화
			ArrayList<Manager> list = new ArrayList<>();
			
			// DB 메소드 사용
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, beginRow);
			stmt.setInt(2, rowPerPage);
			System.out.println(stmt + "<-- ManagerDao selectManagerListByPage의 stmt"); // 디버깅
			
			// 결과물 복사
			ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					Manager m = new Manager();
					m.setManagerNo(rs.getInt("managerNo"));
					m.setManagerId(rs.getString("managerId"));
					m.setManagerName(rs.getString("managerName"));
					m.setManagerDate(rs.getString("managerDate"));
					m.setManagerLevel(rs.getInt("managerLevel"));
					list.add(m);
				}
			
			// list 리턴
			return list;
			}
	
	public static ArrayList<Manager> selectManagerListByZero() throws Exception {
		//1.sql , 컬럼명 하고 동일하게 바꾸기
			String sql = "SELECT manager_id managerId, manager_date managerDate FROM manager WHERE manager_level=0";
				
		//2.리턴값 초기화
			ArrayList<Manager> list = new ArrayList();
				
		//3.처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Manager m = new Manager();
				m.setManagerId(rs.getString("managerId"));
				m.setManagerDate(rs.getString("managerDate"));
				list.add(m);
			}
			
		//4.리턴
			return list;
	}
	
	//수정 메소드
	public static void updateManagerLevel(int managerNo, int managerLevel) throws Exception {
		// sql
		String sql = "UPDATE manager SET manager_level=? WHERE manager_no=?";
		
		// 마리아db연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerLevel); 
		stmt.setInt(2, managerNo); 
		System.out.println("(Dao)upManagerLevel : "+ stmt);
		
		
		stmt.executeUpdate();
	}
	
	//삭제 메소드
	public static void deleteManager(int managerNo) throws Exception {
		// sql
		String sql = "DELETE FROM manager WHERE manager_no=?";
		
		//	마리아db연동
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, managerNo); //No는 숫자니까 setInt
		System.out.println("(Dao)delManagerNo : "+stmt);
		
		stmt.executeUpdate();
		
	}
	
	//	전체 행의 수
	
	public static int totalCount() throws Exception{
		//	1. sql
		String sql = "SELECT COUNT(*) FROM manager";
		
		//	2. 초기화
		int totalRow = 0;
		
		//	3. 마리아db 핸들링 , 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		// 디버깅
		System.out.println("ManagerDaoTotalStmt : "+stmt);
		
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next()) {	// 데이터가 존재한다면 총 개수 입력
			totalRow = rs.getInt("count(*)");
		}
		
		//	4. 리턴
		return totalRow;
	}
	
	//목록 메소드
	public static  ArrayList<Manager> selectManagerList() throws Exception {
		//1.sql , 컬럼명 하고 동일하게 바꾸기
		String sql = "SELECT manager_no managerNo, manager_id managerId, manager_name managerName, manager_date managerDate, manager_level managerLevel FROM manager ORDER BY manager_date DESC";
		
		//2.리턴값 초기화
		ArrayList<Manager> list = new ArrayList();
		
		//3.처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while (rs.next()) {
			Manager m = new Manager();
			m.setManagerNo(rs.getInt("managerNo"));
			m.setManagerId(rs.getString("managerId"));
			m.setManagerName(rs.getString("managerName"));
			m.setManagerDate(rs.getString("managerDate"));
			m.setManagerLevel(rs.getInt("managerLevel"));
			list.add(m);
		}
		
		//4.리턴
		return list;
	}
	
	//입력 메소드
	public static  int insertManager(String managerId, String managerPw, String managerName) throws Exception {
		//1. sql
			//	레벨은 처음에 0 으로 설정했기 떄문에 0
		String sql = "INSERT INTO manager(manager_id,manager_pw,manager_name,manager_date,manager_level) VALUES(?,?,?,now(),0)";
		
		//2. 리턴값 초기화
		int rowCnt = 0; // 입력성공시 1, 실패 시 0
		
		//3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		stmt.setString(3, managerName);
		System.out.println("stmt : "+stmt);
		rowCnt = stmt.executeUpdate();
		
		//4. 리턴
		return rowCnt;
	}
	
	//Id 사용가능여부
	public static String selectManagerId(String managerId) throws Exception {
		//1. 제일 처음은 sql
		String sql ="SELECT manager_id FROM manager WHERE manager_id = ?";
		
		//2. 리턴타입 초기화
		String returnManagerId = null;
		
		//3. 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			returnManagerId = rs.getString("manager_id");
		}
		
		//4. 리턴
		return returnManagerId;
	}
	
	// 로그인 메소드
	public static Manager login(String managerId, String managerPw) throws Exception{ // throws Exception : 메소드 안에서 예외가 발생하면 예외처리하지 않음 , 바로꺼짐
	// 동적 쿼리
		String sql = "SELECT manager_id, manager_name, manager_level FROM manager WHERE manager_id =? AND manager_pw =? AND manager_level>0"; //id와 pw가 동일할 때 name을 보내줌
		Manager manager = null;
	// 마리아db 연동, 처리
		Connection conn = DBUtil.getConnection();
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, managerId);
		stmt.setString(2, managerPw);
		System.out.println("로그인 sql : "+stmt); //디버깅 (필수)
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			manager = new Manager();
			manager.setManagerId(rs.getString("manager_id"));
			manager.setManagerName(rs.getString("manager_name"));
			manager.setManagerLevel(rs.getInt("manager_level"));
		}
	// 4. 리턴
		return manager;
	}
	
}
