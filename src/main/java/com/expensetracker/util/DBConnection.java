package com.expensetracker.util;

import java.sql.Connection;
import java.sql.SQLException;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

public final class DBConnection {

    private static final String DEFAULT_URL =
            "jdbc:mysql://localhost:3306/smart_expense_tracker";

    private static final HikariDataSource DATA_SOURCE;

    static {

        String url = System.getenv("DB_URL");
        String username = System.getenv("DB_USERNAME");
        String password = System.getenv("DB_PASSWORD");

        if (url == null || url.isBlank()) {
            url = DEFAULT_URL;
        }

        if (username == null || username.isBlank()) {
            throw new IllegalStateException(
                    "DB_USERNAME environment variable is not configured.");
        }

        if (password == null || password.isBlank()) {
            throw new IllegalStateException(
                    "DB_PASSWORD environment variable is not configured.");
        }

        HikariConfig config = new HikariConfig();

        config.setJdbcUrl(url);
        config.setUsername(username);
        config.setPassword(password);

        config.setDriverClassName("com.mysql.cj.jdbc.Driver");

        // Pool configuration
        config.setMaximumPoolSize(5);
        config.setMinimumIdle(1);

        // Timeouts
        config.setConnectionTimeout(10_000);
        config.setValidationTimeout(5_000);
        config.setIdleTimeout(300_000);
        config.setMaxLifetime(1_500_000);

        // Helpful identifier in logs
        config.setPoolName("SmartExpenseTrackerPool");

        DATA_SOURCE = new HikariDataSource(config);
    }

    private DBConnection() {
    }

    public static Connection getConnection() {

        try {

            return DATA_SOURCE.getConnection();

        } catch (SQLException e) {

            throw new IllegalStateException(
                    "Unable to obtain a database connection from the pool.",
                    e
            );
        }
    }
}