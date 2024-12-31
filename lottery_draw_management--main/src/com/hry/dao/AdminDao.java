package com.hry.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.hry.bean.AdminBean;
import com.hry.dbUtils.DbUtil;



public class AdminDao {

	/**
	 * 登录验证功能，传入用户名和密码，在数据库中查找，如果找到了，返回true，没找到则返回false
	 * username、password
	 */
	public boolean Login_verify(String phone){
		//连接数据库
		DbUtil dbUtil=new DbUtil();
		Connection conn = dbUtil.getConn();
		//sql语句
		String sql = "select * from login where phone= '"+phone+"'";

		PreparedStatement stm = null;
		ResultSet rs = null;
		try {
			//预编译SQL，减少sql执行
			stm = conn.prepareStatement(sql);
			rs = stm.executeQuery();
			if(rs.next()){
				return true;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			DbUtil.CloseDB(rs, stm, conn);
		}
		return false;
	}

	public String GetPassworde(String phone) {
		// 连接数据库
		DbUtil dbUtil = new DbUtil();
		Connection conn = dbUtil.getConn();
		// SQL语句，使用?作为参数占位符
		String sql = "SELECT password FROM login WHERE phone = ?";

		PreparedStatement stm = null;
		ResultSet rs = null;
		String password = ""; // 用于存储查询到的密码
		try {
			// 预编译SQL
			stm = conn.prepareStatement(sql);
			// 设置参数值
			stm.setString(1, phone);
			// 执行查询
			rs = stm.executeQuery();

			// 如果有结果，获取密码
			if (rs.next()) {
				password = rs.getString("password");
			}
		} catch (SQLException e) {
			// 处理SQL异常
			e.printStackTrace();
		} finally {
			// 关闭资源
			DbUtil.CloseDB(rs, stm, conn);
		}

		// 返回查询到的密码（或null，如果未找到）
		return password;
	}


	/**
	 * 注册账号的函数，传入账号，密码，姓名，邮箱，手机号，借阅天数，可借阅数
	 *  username,  password,  name,  email,  phone, lend_num, max_num
	 */
	public void Register(String phone, String date, String password, String email, String captcha) {
		// TODO Auto-generated method stub
		//连接数据库
		        DbUtil dbUtil=new DbUtil();
				Connection conn = dbUtil.getConn();

				//sql语句
				String sql = "insert  into admin(phone,date,password,email,captcha) values(?,?,?,?,?)";
				int rs = 0;
				PreparedStatement stm = null;
				try {
					//预编译SQL，减少sql执行
					stm = conn.prepareStatement(sql);
					//传参
					stm.setString(1, phone);
					stm.setString(2, date);
					stm.setString(3, password);

					//执行更新
					rs = stm.executeUpdate();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
	}
	/**
	 * 根据传入的账号，密码，来查找对应的读者信息，返回一个AdminBean类型，
	 * 
	 */
	/*
	public AdminBean getAdminInfo(String username, String password) {
		// TODO Auto-generated method stub
		AdminBean adminbean = new AdminBean();
		DbUtil dbUtil=new DbUtil();
		Connection conn = dbUtil.getConn();

		String sql = "select * from admin where username='"+username+"' and password='"+password+"'";
		PreparedStatement stm = null;
		ResultSet rs = null;
		try {
			//预编译SQL，减少sql执行
			stm = conn.prepareStatement(sql);
			//执行查询
			rs = stm.executeQuery();
			if(rs.next()){
				//传参
				adminbean.setAid(rs.getInt("aid"));
				adminbean.setUsername(rs.getString("username"));
				adminbean.setName(rs.getString("name"));
				adminbean.setPassword(rs.getString("password"));
				adminbean.setEmail(rs.getString("email"));
				adminbean.setPhone(rs.getString("phone"));
				adminbean.setStatus(rs.getInt("status"));
				adminbean.setLend_num(rs.getInt("lend_num"));
				adminbean.setMax_num(rs.getInt("max_num"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		finally {
			DbUtil.CloseDB(rs, stm, conn);
		}
		
		return adminbean;
	}

	*/


	
}
