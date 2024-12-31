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
@WebServlet("/GetPasswordServlet")
public class GetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    AdminDao userdao = new AdminDao();
    AdminDao admindao = new AdminDao();

    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetPasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        String phone = request.getParameter("phone"); // 假设表单中有一个名为"phone"的字段
        AdminDao userdao = new AdminDao();
        String tmp = userdao.GetPassworde(phone);
        PrintWriter out = response.getWriter();
        System.out.println(tmp);

        if (tmp.equals(""))
        {
            System.out.println("this");

// 创建一个 JSON 字符串，注意 JSON 对象的格式是键值对，用逗号分隔，并且整个对象用花括号包围
            String jsonResponse = "{\"password\": \"" + tmp + "\", \"status\": \"" + "not register" + "\"}";

// 将这个 JSON 字符串发送给客户端
            out.println(jsonResponse);
        }
        else
        {
            if (tmp.equals(phone)) {
                // 创建一个 JSON 字符串，注意 JSON 对象的格式是键值对，用逗号分隔，并且整个对象用花括号包围
                String jsonResponse = "{\"password\": \"" + tmp + "\", \"status\": \"" + "first login" + "\"}";

// 将这个 JSON 字符串发送给客户端
                out.println(jsonResponse);

            }
            else
            {
                // 创建一个 JSON 字符串，注意 JSON 对象的格式是键值对，用逗号分隔，并且整个对象用花括号包围
                String jsonResponse = "{\"password\": \"" + tmp + "\", \"status\": \"" + "update account" + "\"}";

// 将这个 JSON 字符串发送给客户端
                out.println(jsonResponse);
            }
        }
    }


}
