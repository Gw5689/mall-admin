package gdu.mall.dao;
import java.util.*;
import gdu.mall.util.*;
import gdu.mall.vo.*;
import java.sql.*;

public class CategoryDao {
	// 카테고리 네임
	public static ArrayList<String> CategoryNameList() throws Exception{
		// sql
			String sql = "SELECT category_name categoryName FROM category ORDER BY category_weight DESC";
		// 초기화
			ArrayList<String> list = new ArrayList<>();
			
		// 마리아db 핸들링 , 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
		// 디버깅
			System.out.println("categoryDaoListStmt : "+stmt);
			
		// 처리
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				String cn = rs.getString("categoryName");
				list.add(cn);
			}
			
		// 리턴
			return list;
	}
	
	
	// 삭제 메서드
	public static void deleteCategory(String categoryName) throws Exception{
		// sql
			String sql = "DELETE FROM category WHERE category_name=?";
			
		// 마리아db 핸들링, 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
		// 디버깅
			System.out.println("categoryDaoDeleteStmt : "+stmt);
			
		// 처리
			stmt.executeUpdate();
	}
	
	// 수정 메서드
	public static void updateCategory(String categoryName, int categoryWeight) throws Exception {
		// sql
			String sql = "UPDATE category SET category_weight=? WHERE category_name=?";
			
		// 마리아db 핸들링 , 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, categoryWeight);
			stmt.setString(2, categoryName);
		// 디버깅
			System.out.println("categoryDaoUpdateStmt : "+stmt);
			
		// 실행
			stmt.executeUpdate();
		
	}
	
	//목록 메서드
	public static ArrayList<Category> selectCategoryList() throws Exception{
		// sql
			String sql = "SELECT category_name categoryName, category_weight categoryWeight FROM category ORDER BY category_weight DESC";
		// 초기화
			ArrayList<Category> list = new ArrayList<Category>();
			
		// 마리아db 핸들링 , 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
		// 디버깅
			System.out.println("categoryDaoListStmt : "+stmt);
			
		// 처리
			ResultSet rs = stmt.executeQuery();
			
			while(rs.next()) {
				Category c = new Category();
				c.setCategoryName(rs.getString("categoryName"));
				c.setCategoryWeight(rs.getInt("categoryWeight"));
				list.add(c);
			}
		// 리턴
			return list;
	}
	
	
	// 중복된 Name이 있는지 확인코드
	public static String selectCategoryName(String categoryName) throws Exception {
			// sql
			String sql ="SELECT category_name FROM category WHERE category_name= ?";
			
			//2. 리턴타입 초기화
			String returnCategoryName = null;
			
			//3. 처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			ResultSet rs = stmt.executeQuery();
			if(rs.next()) {
				returnCategoryName = rs.getString("category_name");
			}
			
			//4. 리턴
			return returnCategoryName;
	}
		
	// 입력 메소드
	public static int insertCategory(String categoryName) throws Exception {
			// sql
			String sql = "INSERT INTO category(category_name, category_date, category_weight) VALUES(?,now(),0)";
			
			// 초기화
			int rowCnt = 0; // 입력성공시 1, 실패 시 0
			
			// 마리아db 핸들링 ,처리
			Connection conn = DBUtil.getConnection();
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, categoryName);
			
			// 디버깅
			System.out.println("categoryDaoInsertStmt : "+stmt);
			rowCnt = stmt.executeUpdate();
			
			//4. 리턴
			return rowCnt;
		}
	}
