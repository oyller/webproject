package com.hry.dao;

import com.hry.dbUtils.DbUtil;
import com.hry.model.Prize;
import com.hry.model.Rule;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RuleDao {
    public List<Rule> getAllRules() {
        List<Rule> rules = new ArrayList<>();
        Connection conn = DbUtil.getConn();
        try {
            String sql = "SELECT * FROM lottery_rules";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Rule rule = new Rule();
                rule.setId(rs.getInt("id"));
                rule.setName(rs.getString("name"));
                rule.setCreationTime((Timestamp)rs.getTimestamp("creation_time"));
                rule.setCreator(rs.getString("creator"));
                rule.setDepartment(rs.getString("department"));
                rule.setDescription(rs.getString("description"));
                rules.add(rule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
        return rules;
    }

    public Rule getRuleById(int id) {
        Rule rule = null;
        Connection conn = DbUtil.getConn();
        try {
            String sql = "SELECT * FROM lottery_rules WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rule = new Rule();
                rule.setId(rs.getInt("id"));
                rule.setName(rs.getString("name"));
                rule.setCreationTime(rs.getTimestamp("creation_time"));
                rule.setCreator(rs.getString("creator"));
                rule.setDepartment(rs.getString("department"));
                rule.setDescription(rs.getString("description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
        return rule;
    }

    public boolean deleteRule(int id) {
        // 数据库删除操作
        // 返回 true 如果删除成功， 否则返回 false
        // 具体实现依赖于您的数据库逻辑
        boolean rowDeleted = false;
        Connection conn = DbUtil.getConn();
        PreparedStatement ps = null;
        try {
            String sql = "DELETE FROM lottery_rules WHERE id = ?";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rowDeleted = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.CloseDB(null, ps, conn);
        }
        return rowDeleted;
    }


}
