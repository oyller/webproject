package com.hry.servlet;

import com.google.gson.Gson;
import com.hry.dbUtils.DbUtil;
import com.hry.dao.RuleDao;
import com.hry.model.Prize;
import com.hry.model.Rule;
import com.hry.dao.PrizeDao;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/lotteryRule")
public class LotteryRuleServlet extends HttpServlet {
    private RuleDao ruleDao = new RuleDao();
    private PrizeDao prizeDao = new PrizeDao();

    @Override
    public void init() {
        ruleDao = new RuleDao(); // 实例化 DAO 对象
        prizeDao = new PrizeDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            listRules(request, response);
        } else {
            switch (action) {
                case "editRule":
                    editRule(request, response);
                    break;
                case "deleteRule_Prize":
                    deleteRule_Prize(request, response);
                    break;
                default:
                    listRules(request, response);
                    break;
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("this");
        if ("saveRule".equals(action)) {
            saveRule(request, response);
        } else if ("deleteRule".equals(action)) {
            deleteRule_Prize(request, response);
        } else if ("saveDraft".equals(action)) {
            saveDraft(request, response);
        }
    }

    private void listRules(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        List<Rule> rules = ruleDao.getAllRules();
        if (rules == null) {
            rules = new ArrayList<>(); // 返回空列表
        }
        String jsonRules = new Gson().toJson(rules);
        response.getWriter().write(jsonRules);
    }

    private void saveRule(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ruleIdStr = request.getParameter("ruleId");
        int ruleId = 0;
        if (ruleIdStr != null && !ruleIdStr.isEmpty()) {
            try {
                ruleId = Integer.parseInt(ruleIdStr);
            } catch (NumberFormatException e) {
                ruleId = 0;
            }
        }

        String ruleName = request.getParameter("ruleName");
        String creator = request.getParameter("creator");
        String department = request.getParameter("department");
        String description = request.getParameter("description");

        // 提取奖品数据
        String[] prizeLevels = request.getParameterValues("prizeLevel");
        String[] prizeQuantities = request.getParameterValues("prizeQuantity");
        String[] prizeNames = request.getParameterValues("prizeName");
        String attendMode = request.getParameter("attendMode");
        String lotterMode = request.getParameter("lotterMode");

        Connection conn = null;
        try {
            conn = DbUtil.getConn();
            conn.setAutoCommit(false);  // Start transaction

            if (ruleId == 0) {
                // 插入新规则
                String insertRuleSql = "INSERT INTO lottery_rules (name, creator, department, description) VALUES (?, ?, ?, ?)";
                PreparedStatement psRule = conn.prepareStatement(insertRuleSql, PreparedStatement.RETURN_GENERATED_KEYS);
                psRule.setString(1, ruleName);
                psRule.setString(2, creator);
                psRule.setString(3, department);
                psRule.setString(4, description);
                psRule.executeUpdate();
                ResultSet generatedKeys = psRule.getGeneratedKeys();
                if (generatedKeys.next()) {
                    ruleId = generatedKeys.getInt(1);
                }

                // 插入奖品数据
                String insertPrizeSql = "INSERT INTO lottery_prizes (rule_id, prize_level, prize_quantity, prize_name, attend_mode, lotter_mode) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement psPrize = conn.prepareStatement(insertPrizeSql);
                for (int i = 0; i < prizeLevels.length; i++) {
                    psPrize.setInt(1, ruleId);
                    psPrize.setString(2, prizeLevels[i]);
                    psPrize.setInt(3, Integer.parseInt(prizeQuantities[i]));
                    psPrize.setString(4, prizeNames[i]);
                    psPrize.setInt(5, Integer.parseInt(attendMode));
                    psPrize.setInt(6, Integer.parseInt(lotterMode));
                    psPrize.addBatch();
                }
                psPrize.executeBatch();
            } else {
                // 更新现有规则
                String updateRuleSql = "UPDATE lottery_rules SET name = ?, creator = ?, department = ?, description = ? WHERE id = ?";
                PreparedStatement psRule = conn.prepareStatement(updateRuleSql);
                psRule.setString(1, ruleName);
                psRule.setString(2, creator);
                psRule.setString(3, department);
                psRule.setString(4, description);
                psRule.setInt(5, ruleId);
                psRule.executeUpdate();

                // 删除现有奖品数据
                String deletePrizesSql = "DELETE FROM lottery_prizes WHERE rule_id = ?";
                PreparedStatement psDeletePrizes = conn.prepareStatement(deletePrizesSql);
                psDeletePrizes.setInt(1, ruleId);
                psDeletePrizes.executeUpdate();

                // 插入新的奖品数据
                String insertPrizeSql = "INSERT INTO lottery_prizes (rule_id, prize_level, prize_quantity, prize_name, attend_mode, lotter_mode) VALUES (?, ?, ?, ?, ?, ?)";
                PreparedStatement psPrize = conn.prepareStatement(insertPrizeSql);
                for (int i = 0; i < prizeLevels.length; i++) {
                    psPrize.setInt(1, ruleId);
                    psPrize.setString(2, prizeLevels[i]);
                    psPrize.setInt(3, Integer.parseInt(prizeQuantities[i]));
                    psPrize.setString(4, prizeNames[i]);
                    psPrize.setInt(5, Integer.parseInt(attendMode));
                    psPrize.setInt(6, Integer.parseInt(lotterMode));
                    psPrize.addBatch();
                }
                psPrize.executeBatch();
            }

            conn.commit();  // Commit transaction
        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback();  // Rollback transaction in case of error
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }

        response.sendRedirect("index.jsp");
    }


    private void deleteRule_Prize(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        response.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");
        boolean isDeleted0 = prizeDao.deletePrizeByRuleId(Integer.parseInt(id));
        boolean isDeleted = ruleDao.deleteRule(Integer.parseInt(id));
        System.out.println(isDeleted + " " + isDeleted0);
        if (isDeleted && isDeleted0) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("failure");
        }
    }

    private void editRule(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        if (request.getParameter("id") == null) return;
        int ruleId = Integer.parseInt(request.getParameter("id"));
        Connection conn = DbUtil.getConn();
        Rule rule = new Rule();
        List<Prize> prizes = new ArrayList<>();
        try {
            // 获取规则信息
            String selectRuleSql = "SELECT * FROM lottery_rules WHERE id = ?";
            PreparedStatement psRule = conn.prepareStatement(selectRuleSql);
            psRule.setInt(1, ruleId);
            ResultSet rsRule = psRule.executeQuery();
            if (rsRule.next()) {
                rule.setId(rsRule.getInt("id"));
                rule.setName(rsRule.getString("name"));
                rule.setCreationTime(rsRule.getTimestamp("creation_time"));
                rule.setCreator(rsRule.getString("creator"));
                rule.setDepartment(rsRule.getString("department"));
                rule.setDescription(rsRule.getString("description"));
            }

            // 获取奖品信息
            String selectPrizesSql = "SELECT * FROM lottery_prizes WHERE rule_id = ?";
            PreparedStatement psPrizes = conn.prepareStatement(selectPrizesSql);
            psPrizes.setInt(1, ruleId);
            ResultSet rsPrizes = psPrizes.executeQuery();
            while (rsPrizes.next()) {
                Prize prize = new Prize();
                prize.setId(rsPrizes.getInt("id"));
                prize.setPrizeLevel(rsPrizes.getString("prize_level"));
                prize.setPrizeQuantity(rsPrizes.getInt("prize_quantity"));
                prize.setPrizeName(rsPrizes.getString("prize_name"));
                prize.setAttend_mode(rsPrizes.getInt("attend_mode"));
                prize.setLotter_mode(rsPrizes.getInt("lotter_mode"));
                prizes.add(prize);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            DbUtil.CloseDB(null, null, conn);
        }
        request.setAttribute("rule", rule);
        request.setAttribute("prizes", prizes);
        request.getRequestDispatcher("editRule.jsp").forward(request, response);
    }

    private void saveDraft(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().setAttribute("draftRule", request.getParameterMap());
        response.sendRedirect("addRule.jsp");
    }
}
