<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String ruleId = request.getParameter("ruleId");
    String personSetting = request.getParameter("personSetting");
    String[] prizeLevels = request.getParameterValues("prizeLevel[]");
    String[] prizeQuantities = request.getParameterValues("prizeQuantity[]");
    String[] prizeNames = request.getParameterValues("prizeName[]");
    String modeSetting = request.getParameter("modeSetting");

    // 模拟数据库更新
    // 实际代码中需要将这些信息更新到数据库

    // 假设更新成功后，将页面重定向到首页
    response.sendRedirect("index.jsp");
%>
