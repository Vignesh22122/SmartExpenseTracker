package com.expensetracker.controller.expense;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

import com.expensetracker.dao.ExpenseDAO;
import com.expensetracker.model.Expense;
import com.expensetracker.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/expenses/delete")
public class DeleteExpenseServlet extends HttpServlet {

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

		String expenseIdStr = request.getParameter("expenseId");

		if (expenseIdStr == null || expenseIdStr.isBlank()) {

			redirectError(request, response, "Invalid expense.");

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

		Expense expense = expenseDAO.getExpenseById(expenseId, user.getUserId());

		if (expense == null) {

			redirectError(request, response, "Expense not found.");

			return;
		}

		try {

			boolean deleted = expenseDAO.deleteExpense(expenseId, user.getUserId());

			if (deleted) {

				response.sendRedirect(
						request.getContextPath() + "/expenses?success=" + encode("Expense deleted successfully."));

			} else {

				redirectError(request, response, "Unable to delete expense.");
			}

		} catch (Exception e) {

			e.printStackTrace();

			redirectError(request, response, "Unable to delete expense. Please try again.");
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