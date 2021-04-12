package gdu.mall.dao;
import gdu.mall.util.DBUtil;
import gdu.mall.vo.*;
import java.sql.*;
import java.util.*;


public class OrdersDao {
	
	public static ArrayList<OrdersAndEbookAndClient> selectOrdersListByPage(int rowPerPage, int beginRow) throws Exception{
		// SQL
		String sql="SELECT o.orders_no ordersNo, o.ebook_no ebookNo, e.ebook_title ebookTitle, e.ebook_ISBN ebookISBN, o.client_no clientNo, c.client_mail clientMail, o.orders_date ordersDate, o.orders_state ordersState FROM orders o INNER JOIN ebook e inner join client c ON o.ebook_no=e.ebook_no AND o.client_no=c.client_no ORDER BY o.orders_date DESC LIMIT ?, ?";
		// 초기화
		ArrayList<OrdersAndEbookAndClient> list=new ArrayList<>();
		// DB 핸들링
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setInt(1,beginRow);
		stmt.setInt(2,rowPerPage);
		ResultSet rs=stmt.executeQuery();
		// 디버깅
		System.out.println("ordersListStmt : "+stmt);
		while(rs.next()) {	// 묶음 속에 묶음
			OrdersAndEbookAndClient oec = new OrdersAndEbookAndClient();
			Orders o = new Orders();
			o.setOrdersNo(rs.getInt("ordersNo"));
			o.setEbookNo(rs.getInt("ebookNo"));
			o.setClientNo(rs.getInt("clientNo"));
			o.setOrdersDate(rs.getString("ordersDate"));
			o.setOrdersState(rs.getString("ordersState"));
			//oec.orders에 o 넣기
			oec.setOrders(o);
			Ebook e = new Ebook();
			e.setEbookTitle(rs.getString("ebookTitle"));
			e.setEbookISBN(rs.getString("ebookISBN"));
			//oec.ebook에 e 채워넣기
			oec.setEbook(e);
			Client c = new Client();
			c.setClientMail(rs.getString("clientMail"));
			//oec.client에 c 채워넣기
			oec.setClient(c);
			
			list.add(oec);
		}
		// 리턴
		return list;
	}
	public static int totalCnt() throws Exception{
		// SQL
		String sql="SELECT COUNT(*) cnt FROM orders";
		// 초기화
		int totalRow=0;
		// DB 핸들링
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		ResultSet rs=stmt.executeQuery();
		// 디버깅
		System.out.println("totalCntStmt:"+stmt);
		while(rs.next()) {
			totalRow=rs.getInt("cnt");
		}
		// 리턴
		return totalRow;
	}
	public static int updateOrders(String ordersState, int ordersNo) throws Exception{
		// SQL
		String sql="UPDATE orders SET orders_state=? WHERE orders_no=?";
		// 초기화
		int rowCnt=0;
		// DB핸들링
		Connection conn=DBUtil.getConnection();
		PreparedStatement stmt=conn.prepareStatement(sql);
		stmt.setString(1, ordersState);
		stmt.setInt(2, ordersNo);
		// 디버깅
		System.out.println("updateOrdersStmt : "+stmt);
		rowCnt=stmt.executeUpdate();
		//return
		return rowCnt;
	}
}