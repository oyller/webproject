package com.hry.dao;

import com.hry.dbUtils.DbUtil;
import com.hry.model.Prize;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PrizeDao {
    // 根据规则ID删除奖品信息
    public boolean deletePrizeByRuleId(int ruleId) {
        Connection conn = DbUtil.getConn();
        String sql = "DELETE FROM lottery_prizes WHERE rule_id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ruleId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }

    }

    // 获取所有奖品信息
    public List<Prize> getAllPrizes() {
        Connection conn = DbUtil.getConn();
        String sql = "SELECT * FROM lottery_prizes";
        List<Prize> prizes = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prize prize = new Prize();
                prize.setId(rs.getInt("id"));
                prize.setPrizeLevel(rs.getString("prize_level"));
                prize.setPrizeQuantity(rs.getInt("prize_quantity"));
                prize.setPrizeName(rs.getString("prize_name"));
                prize.setAttend_mode(rs.getInt("attend_mode"));
                prize.setLotter_mode(rs.getInt("lotter_mode"));
                prizes.add(prize);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
        return prizes;
    }

    // 根据规则ID获取奖品信息
    public List<Prize> getPrizesByRuleId(int ruleId) {
        Connection conn = DbUtil.getConn();
        String sql = "SELECT * FROM lottery_prizes WHERE rule_id = ?";
        List<Prize> prizes = new ArrayList<>();
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ruleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Prize prize = new Prize();
                prize.setId(rs.getInt("id"));
                prize.setPrizeLevel(rs.getString("prize_level"));
                prize.setPrizeQuantity(rs.getInt("prize_quantity"));
                prize.setPrizeName(rs.getString("prize_name"));
                prize.setAttend_mode(rs.getInt("attend_mode"));
                prize.setLotter_mode(rs.getInt("lotter_mode"));
                prizes.add(prize);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
        return prizes;
    }

    // 添加奖品信息
    public boolean addPrize(Prize prize, int ruleId) {
        Connection conn = DbUtil.getConn();
        String sql = "INSERT INTO lottery_prizes (rule_id, prize_level, prize_quantity, prize_name, attend_mode, lotter_mode) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ruleId);
            ps.setString(2, prize.getPrizeLevel());
            ps.setInt(3, prize.getPrizeQuantity());
            ps.setString(4, prize.getPrizeName());
            ps.setInt(5, prize.getAttend_mode());
            ps.setInt(6, prize.getLotter_mode());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
    }

    // 更新奖品信息
    public boolean updatePrize(Prize prize) {
        Connection conn = DbUtil.getConn();
        String sql = "UPDATE lottery_prizes SET prize_level = ?, prize_quantity = ?, prize_name = ?, attend_mode = ?, lotter_mode = ? WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, prize.getPrizeLevel());
            ps.setInt(2, prize.getPrizeQuantity());
            ps.setString(3, prize.getPrizeName());
            ps.setInt(4, prize.getAttend_mode());
            ps.setInt(5, prize.getLotter_mode());
            ps.setInt(6, prize.getId());
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
    }

    // 根据ID删除奖品信息
    public boolean deletePrizeById(int prizeId) {
        Connection conn = DbUtil.getConn();
        String sql = "DELETE FROM lottery_prizes WHERE id = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, prizeId);
            int affectedRows = ps.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
    }
}
