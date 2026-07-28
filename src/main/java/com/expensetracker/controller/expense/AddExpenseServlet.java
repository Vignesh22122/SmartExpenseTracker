package com.expensetracker.controller.expense;

import java.io.IOException;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Date;
import java.time.LocalDate;

import com.expensetracker.dao.ExpenseDAO;
import com.expensetracker.model.Expense;
import com.expensetracker.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/expenses/add")
public class AddExpenseServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ExpenseDAO expenseDAO;

	@Override
	public void init() throws ServletException {
		expenseDAO = new ExpenseDAO();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.sendRedirect(request.getContextPath() + "/login");

			return;
		}

		User user = (User) session.getAttribute("user");

		String title = request.getParameter("title");

		String amountStr = request.getParameter("amount");

		String category = request.getParameter("category");

		String expenseDateStr = request.getParameter("expenseDate");

		String description = request.getParameter("description");

		if (title == null || title.trim().isEmpty()) {

			redirectError(request, response, "Expense title is required.");

			return;
		}

		if (amountStr == null || amountStr.trim().isEmpty()) {

			redirectError(request, response, "Expense amount is required.");

			return;
		}

		if (category == null || category.trim().isEmpty()) {

			redirectError(request, response, "Expense category is required.");

			return;
		}

		if (expenseDateStr == null || expenseDateStr.trim().isEmpty()) {

			redirectError(request, response, "Expense date is required.");

			return;
		}

		title = title.trim();
		category = category.trim();

		if (description != null) {
			description = description.trim();
		}

		if (title.length() > 100) {

			redirectError(request, response, "Expense title cannot exceed 100 characters.");

			return;
		}

		BigDecimal amount;

		try {

			amount = new BigDecimal(amountStr.trim());

		} catch (NumberFormatException e) {

			redirectError(request, response, "Enter a valid expense amount.");

			return;
		}

		if (amount.compareTo(BigDecimal.ZERO) <= 0) {

			redirectError(request, response, "Expense amount must be greater than zero.");

			return;
		}

		LocalDate expenseLocalDate;

		try {

			expenseLocalDate = LocalDate.parse(expenseDateStr.trim());

		} catch (Exception e) {

			redirectError(request, response, "Enter a valid expense date.");

			return;
		}

		if (expenseLocalDate.isAfter(LocalDate.now())) {

			redirectError(request, response, "Expense date cannot be in the future.");

			return;
		}

		Expense expense = new Expense();

		expense.setUserId(user.getUserId());

		expense.setTitle(title);

		expense.setAmount(amount);

		expense.setCategory(category);

		expense.setExpenseDate(Date.valueOf(expenseLocalDate));

		expense.setDescription(description);

		try {

			boolean success = expenseDAO.addExpense(expense);

			if (success) {

				response.sendRedirect(
						request.getContextPath() + "/expenses?success=" + encode("Expense added successfully."));

			} else {

				redirectError(request, response, "Unable to add expense.");
			}

		} catch (Exception e) {

			e.printStackTrace();

			redirectError(request, response, "Unable to add expense. Please try again.");
		}
	}
	
	private void redirectError(HttpServletRequest request, HttpServletResponse response, String message)
			throws IOException {

		response.sendRedirect(request.getContextPath() + "/expenses?error=" + encode(message));
	}

	private String encode(String value) {

		return URLEncoder.encode(value, StandardCharsets.UTF_8);
	}
}