-- ============================================================
-- Smart Expense Tracker
-- Database Schema
-- ============================================================

CREATE DATABASE IF NOT EXISTS smart_expense_tracker
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE smart_expense_tracker;


-- ============================================================
-- USERS
-- Stores registered application users.
-- Passwords are stored as hashes; plaintext passwords are never
-- stored in the database.
-- ============================================================

CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,

    name VARCHAR(100) NOT NULL,

    email VARCHAR(100) NOT NULL UNIQUE,

    password_hash VARCHAR(255) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- EXPENSES
-- Stores expenses belonging to individual users.
-- Deleting a user automatically removes their expenses.
-- ============================================================

CREATE TABLE IF NOT EXISTS expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    title VARCHAR(150) NOT NULL,

    amount DECIMAL(12, 2) NOT NULL,

    category VARCHAR(50) NOT NULL,

    expense_date DATE NOT NULL,

    description TEXT,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
        
    CONSTRAINT chk_expense_amount
    CHECK (amount > 0),

    CONSTRAINT fk_expenses_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    INDEX idx_expense_user (user_id),

    INDEX idx_expense_date (expense_date),

    INDEX idx_expense_category (category)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;


-- ============================================================
-- BUDGETS
-- Stores one monthly budget per user.
-- ============================================================

CREATE TABLE IF NOT EXISTS budgets (
    budget_id INT AUTO_INCREMENT PRIMARY KEY,

    user_id INT NOT NULL,

    month INT NOT NULL,

    year INT NOT NULL,

    amount DECIMAL(12, 2) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
        
    CONSTRAINT chk_budget_amount
    CHECK (amount > 0),

    CONSTRAINT chk_budget_month
        CHECK (month BETWEEN 1 AND 12),

    CONSTRAINT chk_budget_year
        CHECK (year >= 2000),

    CONSTRAINT fk_budgets_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE CASCADE,

    CONSTRAINT uq_budget_user_period
        UNIQUE (user_id, month, year),

    INDEX idx_budget_user (user_id),

    INDEX idx_budget_period (year, month)

) ENGINE=InnoDB
  DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci;