<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String personSetting = request.getParameter("personSetting");
    String[] prizeLevel = request.getParameterValues("prizeLevel[]");
    String[] prizeQuantity = request.getParameterValues("prizeQuantity[]");
    String[] prizeName = request.getParameterValues("prizeName[]");
    String modeSetting = request.getParameter("modeSetting");

    // 模拟数据库保存
    // 实际代码中需要将这些信息保存到数据库，并生成唯一的规则ID
    int ruleId = new java.util.Random().nextInt(1000);

    // 假设保存成功后，将页面重定向到首页
    response.sendRedirect("index.jsp");
%>
