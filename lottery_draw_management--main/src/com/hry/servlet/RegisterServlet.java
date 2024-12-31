package com.hry.servlet;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Map;
import java.util.HashMap;

import com.hry.dbUtils.DbUtil;
import org.apache.commons.lang3.RandomStringUtils;

import com.zhenzi.sms.ZhenziSmsClient;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.hry.bean.AdminBean;
import com.hry.dao.AdminDao;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    AdminDao userdao = new AdminDao();
    AdminDao admindao = new AdminDao();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //登录的判断
        //编码格式
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("captcha");
        AdminDao userdao = new AdminDao();
        DbUtil dbUtil=new DbUtil();
        String sql = "";
        HttpSession session = request.getSession();
        Connection conn = dbUtil.getConn();

        if (password == "") {
            String captcha = RandomStringUtils.randomAlphanumeric(4);
            System.out.print("短信验证");

            if (userdao.Login_verify(username) == false)
            {
                 sql = "INSERT INTO login (phone, date, password, email, captcha) " + "VALUES ('" + username + "', '20240605', '" + username + "', '***', '" + captcha + "');";
            }
            else
            {
                 sql = "UPDATE login SET captcha = '"+captcha+"' WHERE phone = '"+username+"'";
            }

            if (conn == null)
            {
                System.out.println("连接失败");
            }

            PreparedStatement stm = null;
            try {
                //预编译SQL，减少sql执行
                stm = conn.prepareStatement(sql);
                int rowsAffected = stm.executeUpdate();
                if(rowsAffected > 0){
                    // 更新成功
                }
            } catch (SQLException e) {
                // 异常处理
                e.printStackTrace();
            } finally {
                DbUtil.CloseDB(null, stm, conn);
            }
                //发送到注册手机

                ZhenziSmsClient client = new ZhenziSmsClient("https://sms_developer.zhenzikj.com", "113924", "31e7571c-ef2a-4388-a681-eb042fefba9f");
                Map<String, Object> params = new HashMap<String, Object>();
                params.put("number", username);
                params.put("templateId", "12946");
                String[] templateParams = new String[2];
                templateParams[0] = captcha;
                templateParams[1] = "5分钟";
                // 把参数放入map中
                params.put("templateParams", templateParams);
                //调用send方法，进行发送
                try {
                    String Result = client.send(params);
                    System.out.print(Result);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
                // 这里返回json格式的字符串，可以判断是否发送成功
             //   session.setAttribute("state", "密码错误");
                response.sendRedirect("register.jsp");

        }
        else
        {
            sql = "SELECT captcha FROM login WHERE phone = '"+username+"'";
            String captcha = "";
            PreparedStatement stm = null;
            ResultSet rs = null;
            try {
                // 预编译SQL语句
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();

                if(rs.next()){
                    captcha = rs.getString("captcha");
                    // 在这里处理获取到的验证码信息
                } else {
                    // 没有找到匹配的记录
                }
            } catch (SQLException e) {
                // 异常处理
                e.printStackTrace();
            } finally {
                DbUtil.CloseDB(rs, stm, conn);
            }
            System.out.print(password + " " + captcha);
            if (password.equals(captcha)) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                PrintWriter out = response.getWriter();
                out.println("{\"status\": \"success\"}"); // 返回一个 JSON 对象表示成功
            }
            else
            {
                session.setAttribute("state", "验证码错误或者先点击发送短信");
                response.sendRedirect("register.jsp");
                System.out.print("fail register");
            }


        }


    }


}
