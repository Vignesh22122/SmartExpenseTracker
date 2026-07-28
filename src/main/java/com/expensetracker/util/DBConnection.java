package com.expensetracker.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

	private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/smart_expense_tracker";

	private DBConnection() {
	}

	public static Connection getConnection() {

		String url = System.getenv("DB_URL");
		String username = System.getenv("DB_USERNAME");
		String password = System.getenv("DB_PASSWORD");

		if (url == null || url.isBlank()) {
			url = DEFAULT_URL;
		}

		if (username == null || username.isBlank()) {
			throw new IllegalStateException("DB_USERNAME environment variable is not configured.");
		}

		if (password == null || password.isBlank()) {
			throw new IllegalStateException("DB_PASSWORD environment variable is not configured.");
		}

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			return DriverManager.getConnection(url, username, password);

		} catch (ClassNotFoundException e) {

			throw new IllegalStateException("MySQL JDBC driver was not found.", e);

		} catch (SQLException e) {

			throw new IllegalStateException("Unable to connect to the database.", e);
		}
	}
}