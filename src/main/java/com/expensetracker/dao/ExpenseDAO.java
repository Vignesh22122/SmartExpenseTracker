package com.expensetracker.dao;

import java.util.Map;
import java.util.LinkedHashMap;

import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import com.expensetracker.model.Expense;
import com.expensetracker.util.DBConnection;

public class ExpenseDAO {

	public boolean addExpense(Expense expense) {
		String query = "INSERT INTO expenses (user_id, title, amount, category, expense_date, description) VALUES (?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, expense.getUserId());
			pstmt.setString(2, expense.getTitle());
			pstmt.setBigDecimal(3, expense.getAmount());
			pstmt.setString(4, expense.getCategory());
			pstmt.setDate(5, expense.getExpenseDate());
			pstmt.setString(6, expense.getDescription());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public boolean updateExpense(Expense expense) {
		String query = "UPDATE expenses SET title = ?, amount = ?, category = ?, expense_date = ?, description = ? WHERE expense_id = ? AND user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, expense.getTitle());
			pstmt.setBigDecimal(2, expense.getAmount());
			pstmt.setString(3, expense.getCategory());
			pstmt.setDate(4, expense.getExpenseDate());
			pstmt.setString(5, expense.getDescription());
			pstmt.setInt(6, expense.getExpenseId());
			pstmt.setInt(7, expense.getUserId());

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public Expense getExpenseById(int expenseId, int userId) {

		String query = "SELECT * FROM expenses WHERE expense_id = ? AND user_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, expenseId);
			pstmt.setInt(2, userId);

			try (ResultSet rs = pstmt.executeQuery()) {

				if (rs.next()) {

					Expense expense = new Expense();

					expense.setExpenseId(rs.getInt("expense_id"));
					expense.setUserId(rs.getInt("user_id"));
					expense.setTitle(rs.getString("title"));
					expense.setAmount(rs.getBigDecimal("amount"));
					expense.setCategory(rs.getString("category"));
					expense.setExpenseDate(rs.getDate("expense_date"));
					expense.setDescription(rs.getString("description"));
					expense.setCreatedAt(rs.getTimestamp("created_at"));

					return expense;
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	public boolean deleteExpense(int expenseId, int userId) {
		String query = "DELETE FROM expenses WHERE expense_id = ? AND user_id = ?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, expenseId);
			pstmt.setInt(2, userId);

			return pstmt.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	public List<Expense> getFilteredExpenses(int userId, String search, String category, String monthYear,
			String sortBy, int page, int pageSize) {
		List<Expense> expenses = new ArrayList<>();

		StringBuilder query = new StringBuilder("SELECT * FROM expenses WHERE user_id = ? ");

		if (search != null && !search.trim().isEmpty()) {
			query.append("AND (title LIKE ? OR description LIKE ?) ");
		}

		if (category != null && !category.isBlank() && !category.equalsIgnoreCase("All")) {

			query.append("AND category = ? ");
		}

		if (monthYear != null && !monthYear.isBlank() && !monthYear.equalsIgnoreCase("All")) {

			query.append("AND DATE_FORMAT(expense_date,'%Y-%m') = ? ");
		}

		if (sortBy == null || sortBy.isBlank()) {
			sortBy = "latest";
		}

		switch (sortBy) {

		case "oldest":
			query.append("ORDER BY expense_date ASC ");
			break;

		case "highest":
			query.append("ORDER BY amount DESC ");
			break;

		case "lowest":
			query.append("ORDER BY amount ASC ");
			break;

		default:
			query.append("ORDER BY expense_date DESC ");
		}

		query.append("LIMIT ? OFFSET ?");

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query.toString())) {

			int index = 1;

			pstmt.setInt(index++, userId);

			if (search != null && !search.trim().isEmpty()) {

				pstmt.setString(index++, "%" + search.trim() + "%");
				pstmt.setString(index++, "%" + search.trim() + "%");

			}

			if (category != null && !category.isBlank() && !category.equalsIgnoreCase("All")) {

				pstmt.setString(index++, category);

			}

			if (monthYear != null && !monthYear.isBlank() && !monthYear.equalsIgnoreCase("All")) {

				pstmt.setString(index++, monthYear);

			}

			pstmt.setInt(index++, pageSize);
			pstmt.setInt(index++, (page - 1) * pageSize);

			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				Expense expense = new Expense();

				expense.setExpenseId(rs.getInt("expense_id"));
				expense.setUserId(rs.getInt("user_id"));
				expense.setTitle(rs.getString("title"));
				expense.setAmount(rs.getBigDecimal("amount"));
				expense.setCategory(rs.getString("category"));
				expense.setExpenseDate(rs.getDate("expense_date"));
				expense.setDescription(rs.getString("description"));
				expense.setCreatedAt(rs.getTimestamp("created_at"));

				expenses.add(expense);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return expenses;
	}

	public int getExpenseCount(int userId, String search, String category, String monthYear) {

		StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM expenses WHERE user_id = ? ");

		if (search != null && !search.trim().isEmpty()) {
			query.append("AND (title LIKE ? OR description LIKE ?) ");
		}

		if (category != null && !category.equalsIgnoreCase("All")) {

			query.append("AND category = ? ");
		}

		if (monthYear != null && !monthYear.equalsIgnoreCase("All")) {

			query.append("AND DATE_FORMAT(expense_date,'%Y-%m') = ? ");
		}

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(query.toString())) {

			int index = 1;

			pstmt.setInt(index++, userId);

			if (search != null && !search.trim().isEmpty()) {
				pstmt.setString(index++, "%" + search + "%");
				pstmt.setString(index++, "%" + search + "%");
			}

			if (category != null && !category.equalsIgnoreCase("All")) {

				pstmt.setString(index++, category);
			}

			if (monthYear != null && !monthYear.equalsIgnoreCase("All")) {

				pstmt.setString(index++, monthYear);
			}

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getInt(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return 0;
	}

	public BigDecimal getTotalExpenseAmount(int userId) {

		String query = "SELECT COALESCE(SUM(amount),0) FROM expenses WHERE user_id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				return rs.getBigDecimal(1);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return BigDecimal.ZERO;
	}

	public BigDecimal getMonthlyExpenseAmount(int userId, int month, int year) {

		String query = "SELECT COALESCE(SUM(amount), 0) AS total " + "FROM expenses " + "WHERE user_id = ? "
				+ "AND MONTH(expense_date) = ? " + "AND YEAR(expense_date) = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);
			pstmt.setInt(2, month);
			pstmt.setInt(3, year);

			try (ResultSet rs = pstmt.executeQuery()) {

				if (rs.next()) {

					BigDecimal total = rs.getBigDecimal("total");

					return total != null ? total : BigDecimal.ZERO;
				}
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return BigDecimal.ZERO;
	}

	public List<Expense> getRecentExpenses(int userId, int month, int year) {

		List<Expense> expenses = new ArrayList<>();

		String query = "SELECT * FROM expenses " + "WHERE user_id = ? " + "AND MONTH(expense_date) = ? "
				+ "AND YEAR(expense_date) = ? " + "ORDER BY expense_date DESC, expense_id DESC " + "LIMIT 5";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);
			pstmt.setInt(2, month);
			pstmt.setInt(3, year);

			try (ResultSet rs = pstmt.executeQuery()) {

				while (rs.next()) {

					Expense expense = new Expense();

					expense.setExpenseId(rs.getInt("expense_id"));

					expense.setUserId(rs.getInt("user_id"));

					expense.setTitle(rs.getString("title"));

					expense.setAmount(rs.getBigDecimal("amount"));

					expense.setCategory(rs.getString("category"));

					expense.setExpenseDate(rs.getDate("expense_date"));

					expense.setDescription(rs.getString("description"));

					expense.setCreatedAt(rs.getTimestamp("created_at"));

					expenses.add(expense);
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return expenses;
	}

	public Map<String, BigDecimal> getCategoryWiseExpense(int userId, int month, int year) {

		Map<String, BigDecimal> data = new LinkedHashMap<>();

		String query = "SELECT category, COALESCE(SUM(amount), 0) AS total " + "FROM expenses " + "WHERE user_id = ? "
				+ "AND MONTH(expense_date) = ? " + "AND YEAR(expense_date) = ? " + "GROUP BY category "
				+ "ORDER BY total DESC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);
			pstmt.setInt(2, month);
			pstmt.setInt(3, year);

			try (ResultSet rs = pstmt.executeQuery()) {

				while (rs.next()) {

					data.put(rs.getString("category"), rs.getBigDecimal("total"));
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return data;
	}

	public Map<String, BigDecimal> getMonthlyExpenseTrend(int userId, int month, int year) {

		Map<String, BigDecimal> trend = new LinkedHashMap<>();

		String sql = "SELECT DATE_FORMAT(expense_date, '%Y-%m') AS month, " + "SUM(amount) AS total " + "FROM expenses "
				+ "WHERE user_id = ? " + "AND expense_date >= DATE_SUB("
				+ "STR_TO_DATE(CONCAT(?, '-', ?, '-01'), '%Y-%m-%d'), " + "INTERVAL 5 MONTH) "
				+ "AND expense_date < DATE_ADD(" + "STR_TO_DATE(CONCAT(?, '-', ?, '-01'), '%Y-%m-%d'), "
				+ "INTERVAL 1 MONTH) " + "GROUP BY DATE_FORMAT(expense_date, '%Y-%m') " + "ORDER BY month ASC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(sql)) {

			pstmt.setInt(1, userId);

			pstmt.setInt(2, year);
			pstmt.setInt(3, month);

			pstmt.setInt(4, year);
			pstmt.setInt(5, month);

			try (ResultSet rs = pstmt.executeQuery()) {

				while (rs.next()) {

					trend.put(rs.getString("month"), rs.getBigDecimal("total"));
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return trend;
	}
}