package com.expensetracker.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.expensetracker.model.User;
import com.expensetracker.util.DBConnection;

public class UserDAO {

	public boolean registerUser(User user) {

		String query = "INSERT INTO users (name, email, password_hash) " + "VALUES (?, ?, ?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPasswordHash());

			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {

			e.printStackTrace();
			return false;
		}
	}

	public boolean registerUser(String name, String email, String passwordHash) {

		return registerUser(new User(0, name, email, passwordHash, null));
	}

	public User getUserByEmail(String email) {

		String query = "SELECT user_id, name, email, password_hash, created_at " + "FROM users " + "WHERE email = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, email);

			try (ResultSet rs = pstmt.executeQuery()) {

				if (rs.next()) {

					return mapUser(rs);
				}
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return null;
	}

	public User getUserById(int userId) {

		String query = "SELECT user_id, name, email, password_hash, created_at " + "FROM users " + "WHERE user_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setInt(1, userId);

			try (ResultSet rs = pstmt.executeQuery()) {

				if (rs.next()) {

					return mapUser(rs);
				}
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}

		return null;
	}

	public boolean emailExistsForAnotherUser(String email, int userId) {

		String query = "SELECT user_id " + "FROM users " + "WHERE email = ? AND user_id <> ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, email);
			pstmt.setInt(2, userId);

			try (ResultSet rs = pstmt.executeQuery()) {

				return rs.next();
			}

		} catch (SQLException e) {

			e.printStackTrace();
			return false;
		}
	}

	public boolean updateProfile(int userId, String name, String email) {

		String query = "UPDATE users " + "SET name = ?, email = ? " + "WHERE user_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, name);
			pstmt.setString(2, email);
			pstmt.setInt(3, userId);

			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {

			e.printStackTrace();
			return false;
		}
	}

	public boolean updatePassword(int userId, String passwordHash) {

		String query = "UPDATE users SET password_hash = ? WHERE user_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {

			pstmt.setString(1, passwordHash);
			pstmt.setInt(2, userId);

			return pstmt.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	private User mapUser(ResultSet rs) throws SQLException {

		User user = new User();

		user.setUserId(rs.getInt("user_id"));

		user.setName(rs.getString("name"));

		user.setEmail(rs.getString("email"));

		user.setPasswordHash(rs.getString("password_hash"));

		user.setCreatedAt(rs.getTimestamp("created_at"));

		return user;
	}
}