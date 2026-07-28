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

@WebServlet("/expenses/edit")
public class EditExpenseServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private ExpenseDAO expenseDAO;

	@Override
	public void init() throws ServletException {
		expenseDAO = new ExpenseDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = getAuthenticatedUser(request, response);

		if (user == null) {
			return;
		}

		String idParam = request.getParameter("id");

		if (idParam == null || idParam.isBlank()) {

			redirectError(request, response, "Invalid expense.");

			return;
		}

		int expenseId;

		try {

			expenseId = Integer.parseInt(idParam);

		} catch (NumberFormatException e) {

			redirectError(request, response, "Invalid expense.");

			return;
		}

		if (expenseId <= 0) {

			redirectError(request, response, "Invalid expense.");

			return;
		}

		Expense expense = expenseDAO.getExpenseById(expenseId, user.getUserId());


		if (expense == null) {

			redirectError(request, response, "Expense not found.");

			return;
		}

		request.setAttribute("expense", expense);

		request.getRequestDispatcher("/WEB-INF/views/expense/edit-expense.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		User user = getAuthenticatedUser(request, response);

		if (user == null) {
			return;
		}

		String expenseIdStr = request.getParameter("expenseId");

		String title = request.getParameter("title");

		String amountStr = request.getParameter("amount");

		String category = request.getParameter("category");

		String expenseDateStr = request.getParameter("expenseDate");

		String description = request.getParameter("description");

		if (expenseIdStr == null || expenseIdStr.isBlank()) {

			redirectError(request, response, "Invalid expense.");

			return;
		}

		if (title == null || title.trim().isEmpty()) {

			redirectEditError(request, response, expenseIdStr, "Expense title is required.");

			return;
		}

		if (amountStr == null || amountStr.trim().isEmpty()) {

			redirectEditError(request, response, expenseIdStr, "Expense amount is required.");

			return;
		}

		if (category == null || category.trim().isEmpty()) {

			redirectEditError(request, response, expenseIdStr, "Expense category is required.");

			return;
		}

		if (expenseDateStr == null || expenseDateStr.trim().isEmpty()) {

			redirectEditError(request, response, expenseIdStr, "Expense date is required.");

			return;
		}

		int expenseId;

		try {

			expenseId = Integer.parseInt(expenseIdStr);

		} catch (NumberFormatException e) {

			redirectError(request, response, "Invalid expense.");

			return;
		}

		if (expenseId <= 0) {

			redirectError(request, response, "Invalid expense.");

			return;
		}

		Expense existingExpense = expenseDAO.getExpenseById(expenseId, user.getUserId());

		if (existingExpense == null) {

			redirectError(request, response, "Expense not found.");

			return;
		}

		title = title.trim();
		category = category.trim();

		if (description != null) {
			description = description.trim();
		}

		if (title.length() > 100) {

			redirectEditError(request, response, expenseIdStr, "Expense title cannot exceed 100 characters.");

			return;
		}

		BigDecimal amount;

		try {

			amount = new BigDecimal(amountStr.trim());

		} catch (NumberFormatException e) {

			redirectEditError(request, response, expenseIdStr, "Enter a valid expense amount.");

			return;
		}

		if (amount.compareTo(BigDecimal.ZERO) <= 0) {

			redirectEditError(request, response, expenseIdStr, "Expense amount must be greater than zero.");

			return;
		}

		LocalDate expenseLocalDate;

		try {

			expenseLocalDate = LocalDate.parse(expenseDateStr.trim());

		} catch (Exception e) {

			redirectEditError(request, response, expenseIdStr, "Enter a valid expense date.");

			return;
		}

		if (expenseLocalDate.isAfter(LocalDate.now())) {

			redirectEditError(request, response, expenseIdStr, "Expense date cannot be in the future.");

			return;
		}

		existingExpense.setTitle(title);

		existingExpense.setAmount(amount);

		existingExpense.setCategory(category);

		existingExpense.setExpenseDate(Date.valueOf(expenseLocalDate));

		existingExpense.setDescription(description);

		try {

			boolean success = expenseDAO.updateExpense(existingExpense);

			if (success) {

				response.sendRedirect(
						request.getContextPath() + "/expenses?success=" + encode("Expense updated successfully."));

			} else {

				redirectEditError(request, response, expenseIdStr, "Unable to update expense.");
			}

		} catch (Exception e) {

			e.printStackTrace();

			redirectEditError(request, response, expenseIdStr, "Unable to update expense. Please try again.");
		}
	}

	private User getAuthenticatedUser(HttpServletRequest request, HttpServletResponse response) throws IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.sendRedirect(request.getContextPath() + "/login");

			return null;
		}

		return (User) session.getAttribute("user");
	}

	private void redirectError(HttpServletRequest request, HttpServletResponse response, String message)
			throws IOException {

		response.sendRedirect(request.getContextPath() + "/expenses?error=" + encode(message));
	}

	private void redirectEditError(HttpServletRequest request, HttpServletResponse response, String expenseId,
			String message) throws IOException {

		response.sendRedirect(
				request.getContextPath() + "/expenses/edit?id=" + encode(expenseId) + "&error=" + encode(message));
	}

	private String encode(String value) {

		return URLEncoder.encode(value, StandardCharsets.UTF_8);
	}
}