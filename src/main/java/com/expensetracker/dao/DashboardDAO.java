package com.expensetracker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import com.expensetracker.util.DBConnection;

public class DashboardDAO {

    public BigDecimal getTotalSpentForMonth(int userId, String monthYear) {
        String query = "SELECT SUM(amount) AS total FROM expenses WHERE user_id = ? AND expense_date LIKE ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            pstmt.setString(2, monthYear + "%");
            
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next() && rs.getBigDecimal("total") != null) {
                    return rs.getBigDecimal("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public Map<String, BigDecimal> getCategoryTotals(int userId, String monthYear) {
        Map<String, BigDecimal> map = new HashMap<>();
        String query = "SELECT category, SUM(amount) AS total FROM expenses WHERE user_id = ? AND expense_date LIKE ? GROUP BY category";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, userId);
            pstmt.setString(2, monthYear + "%");
            
            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    map.put(rs.getString("category"), rs.getBigDecimal("total"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }
}