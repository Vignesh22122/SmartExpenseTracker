package com.expensetracker.model;

import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class Expense implements Serializable {
	private static final long serialVersionUID = 1L;

	private int expenseId;
	private int userId;
	private String title;
	private BigDecimal amount;
	private String category;
	private Date expenseDate;
	private String description;
	private Timestamp createdAt;

	public Expense() {
	}

	public Expense(int expenseId, int userId, String title, BigDecimal amount, String category, Date expenseDate,
			String description, Timestamp createdAt) {
		this.expenseId = expenseId;
		this.userId = userId;
		this.title = title;
		this.amount = amount;
		this.category = category;
		this.expenseDate = expenseDate;
		this.description = description;
		this.createdAt = createdAt;
	}

	public int getExpenseId() {
		return expenseId;
	}

	public void setExpenseId(int expenseId) {
		this.expenseId = expenseId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public Date getExpenseDate() {
		return expenseDate;
	}

	public void setExpenseDate(Date expenseDate) {
		this.expenseDate = expenseDate;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Timestamp getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
}