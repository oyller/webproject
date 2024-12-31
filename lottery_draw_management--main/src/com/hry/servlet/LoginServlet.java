package com.hry.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hry.bean.AdminBean;
import com.hry.dao.AdminDao;
import com.hry.dbUtils.DbUtil;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		DbUtil dbUtil=new DbUtil();
		Connection conn = dbUtil.getConn();
		String phone = request.getParameter("phone"); // 假设表单中有一个名为"phone"的字段
		String email = request.getParameter("email");
		String password = "";
		String sql = "SELECT password FROM login WHERE phone = ?"; // 使用占位符
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		System.out.println("here");
		if (conn == null) {
			System.out.println("连接失败");
		}

		PreparedStatement stm = null;
		ResultSet rs = null; // 声明ResultSet变量
		try {
			// 预编译SQL
			stm = conn.prepareStatement(sql);
			// 设置参数值
			stm.setString(1, phone); // 这里的1对应SQL语句中的第一个?
			// 执行查询
			rs = stm.executeQuery();
			if (rs.next()) { // 检查是否有结果返回
				password = rs.getString("password"); // 获取password字段的值
			} else {
				System.out.println("没有找到对应的phone");
			}
		} catch (SQLException e) {
			// 异常处理
			e.printStackTrace();
			// 在这里可以添加额外的错误处理逻辑
		} finally {
			// 关闭资源
			DbUtil.CloseDB(rs, stm, conn); // 确保rs也被关闭
		}
	    if (phone.equals(password))
		{
			 password = request.getParameter("password");
			 if (email == "")
			 {

			 }
			 sql = "UPDATE login SET password = '"+password+"',email = '"+email+"'  WHERE phone = '"+phone+"'";
			 conn = dbUtil.getConn();

	            stm = null;
			try {
				// 预编译SQL
				stm = conn.prepareStatement(sql);
				int rowsAffected = stm.executeUpdate();
				if (rowsAffected > 0) {
					System.out.println("更新成功");
				} else {
					System.out.println("没有记录被更新");
				}
			} catch (SQLException e) {
				// 异常处理
				e.printStackTrace();
				// 在这里可以添加额外的错误处理逻辑
			} finally {
				// 关闭资源
				DbUtil.CloseDB(null, stm, conn); // 确保PreparedStatement和Connection都被正确关闭
			}
			out.println("{\"status\": \"success update\"}"); // 返回一个 JSON 对象表示成功
		}
		else
		{
			System.out.println(password + " " + request.getParameter("password"));
			String tmp = request.getParameter("password");
            if (password.equals(tmp) && password.equals("") == false)
			{
				out.println("{\"status\": \"success login\"}"); // 返回一个 JSON 对象表示成功
			}
			else
			{
				out.println("{\"status\": \"password or account error\"}"); // 返回一个 JSON 对象表示成功
			}

		}
	}

}
