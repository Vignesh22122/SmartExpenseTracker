package com.expensetracker.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.expensetracker.model.Budget;
import com.expensetracker.util.DBConnection;

public class BudgetDAO {

	/*
	 * Get budget for a specific user, month and year.
	 */
	public Budget getBudget(int userId, int month, int year) {

		String query = "SELECT budget_id, user_id, month, year, amount " + "FROM budgets "
				+ "WHERE user_id = ? AND month = ? AND year = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);
			pstmt.setInt(2, month);
			pstmt.setInt(3, year);

			try (ResultSet rs = pstmt.executeQuery()) {

				if (rs.next()) {

					Budget budget = new Budget();

					budget.setBudgetId(rs.getInt("budget_id"));
					budget.setUserId(rs.getInt("user_id"));
					budget.setMonth(rs.getInt("month"));
					budget.setYear(rs.getInt("year"));
					budget.setAmount(rs.getBigDecimal("amount"));

					return budget;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	/*
	 * Save a new budget or update an existing budget.
	 */
	public boolean saveOrUpdateBudget(Budget budget) {

		if (budget == null) {
			return false;
		}

		return upsertBudget(budget.getUserId(), budget.getMonth(), budget.getYear(), budget.getAmount());
	}

	/*
	 * Insert/update budget.
	 *
	 * Requires a UNIQUE constraint on: user_id + month + year
	 */
	public boolean upsertBudget(int userId, int month, int year, BigDecimal amount) {

		String query = "INSERT INTO budgets " + "(user_id, month, year, amount) " + "VALUES (?, ?, ?, ?) "
				+ "ON DUPLICATE KEY UPDATE amount = VALUES(amount)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);
			pstmt.setInt(2, month);
			pstmt.setInt(3, year);
			pstmt.setBigDecimal(4, amount);

			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {

			e.printStackTrace();

			return false;
		}
	}

	/*
	 * Check whether a budget exists.
	 */
	public boolean budgetExists(int userId, int month, int year) {

		String query = "SELECT 1 " + "FROM budgets " + "WHERE user_id = ? " + "AND month = ? " + "AND year = ? "
				+ "LIMIT 1";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);
			pstmt.setInt(2, month);
			pstmt.setInt(3, year);

			try (ResultSet rs = pstmt.executeQuery()) {

				return rs.next();
			}

		} catch (SQLException e) {

			e.printStackTrace();

			return false;
		}
	}

	/*
	 * Delete a budget.
	 */
	public boolean deleteBudget(int userId, int month, int year) {

		String query = "DELETE FROM budgets " + "WHERE user_id = ? " + "AND month = ? " + "AND year = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);
			pstmt.setInt(2, month);
			pstmt.setInt(3, year);

			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {

			e.printStackTrace();

			return false;
		}
	}
}