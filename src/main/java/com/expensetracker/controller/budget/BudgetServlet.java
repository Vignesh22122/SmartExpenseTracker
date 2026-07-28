package com.expensetracker.controller.budget;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;

import com.expensetracker.dao.BudgetDAO;
import com.expensetracker.dao.ExpenseDAO;
import com.expensetracker.model.Budget;
import com.expensetracker.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/budget")
public class BudgetServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private BudgetDAO budgetDAO;
	private ExpenseDAO expenseDAO;

	@Override
	public void init() throws ServletException {

		budgetDAO = new BudgetDAO();
		expenseDAO = new ExpenseDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		User user = (User) session.getAttribute("user");

		LocalDate today = LocalDate.now();

		int month = today.getMonthValue();
		int year = today.getYear();

		try {

			String monthParam = request.getParameter("month");
			String yearParam = request.getParameter("year");

			if (monthParam != null && !monthParam.isBlank()) {
				month = Integer.parseInt(monthParam);
			}

			if (yearParam != null && !yearParam.isBlank()) {
				year = Integer.parseInt(yearParam);
			}

		} catch (NumberFormatException e) {

			month = today.getMonthValue();
			year = today.getYear();
		}

		if (month < 1 || month > 12) {
			month = today.getMonthValue();
		}

		Budget budget = budgetDAO.getBudget(user.getUserId(), month, year);

		BigDecimal budgetAmount = BigDecimal.ZERO;

		if (budget != null && budget.getAmount() != null) {
			budgetAmount = budget.getAmount();
		}

		BigDecimal spentAmount = expenseDAO.getMonthlyExpenseAmount(user.getUserId(), month, year);

		if (spentAmount == null) {
			spentAmount = BigDecimal.ZERO;
		}

		BigDecimal remainingAmount = budgetAmount.subtract(spentAmount);

		BigDecimal budgetUsedPercentage = BigDecimal.ZERO;

		if (budgetAmount.compareTo(BigDecimal.ZERO) > 0) {

			budgetUsedPercentage = spentAmount.multiply(BigDecimal.valueOf(100)).divide(budgetAmount, 1,
					RoundingMode.HALF_UP);
		}

		int progressPercentage = budgetUsedPercentage.setScale(0, RoundingMode.HALF_UP).intValue();

		if (progressPercentage < 0) {
			progressPercentage = 0;
		}

		if (progressPercentage > 100) {
			progressPercentage = 100;
		}

		String budgetStatus;

		if (budgetAmount.compareTo(BigDecimal.ZERO) <= 0) {

			budgetStatus = "NO BUDGET";

		} else if (budgetUsedPercentage.compareTo(BigDecimal.valueOf(100)) >= 0) {

			budgetStatus = "BUDGET EXCEEDED";

		} else if (budgetUsedPercentage.compareTo(BigDecimal.valueOf(90)) >= 0) {

			budgetStatus = "CRITICAL";

		} else if (budgetUsedPercentage.compareTo(BigDecimal.valueOf(70)) >= 0) {

			budgetStatus = "WARNING";

		} else {

			budgetStatus = "ON TRACK";
		}

		BigDecimal exceededAmount = BigDecimal.ZERO;

		if (remainingAmount.compareTo(BigDecimal.ZERO) < 0) {
			exceededAmount = remainingAmount.abs();
		}

		request.setAttribute("budget", budget);

		request.setAttribute("budgetAmount", budgetAmount);

		request.setAttribute("spentAmount", spentAmount);

		request.setAttribute("remainingAmount", remainingAmount);

		request.setAttribute("budgetUsedPercentage", budgetUsedPercentage);

		request.setAttribute("progressPercentage", progressPercentage);

		request.setAttribute("budgetStatus", budgetStatus);

		request.setAttribute("exceededAmount", exceededAmount);

		request.setAttribute("budgetMonth", month);

		request.setAttribute("budgetYear", year);

		request.getRequestDispatcher("/WEB-INF/views/budget/budget.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.sendRedirect(request.getContextPath() + "/login");

			return;
		}

		User user = (User) session.getAttribute("user");

		try {

			String monthStr = request.getParameter("month");

			String yearStr = request.getParameter("year");

			String amountStr = request.getParameter("amount");

			if (monthStr == null || monthStr.isBlank() || yearStr == null || yearStr.isBlank() || amountStr == null
					|| amountStr.isBlank()) {

				response.sendRedirect(request.getContextPath() + "/budget?error=Missing budget information.");

				return;
			}

			int month = Integer.parseInt(monthStr);

			int year = Integer.parseInt(yearStr);

			BigDecimal amount = new BigDecimal(amountStr);

			if (month < 1 || month > 12) {

				response.sendRedirect(request.getContextPath() + "/budget?error=Invalid month.");

				return;
			}

			if (year < 2000 || year > 2100) {

				response.sendRedirect(request.getContextPath() + "/budget?error=Invalid year.");

				return;
			}

			if (amount.compareTo(BigDecimal.ZERO) <= 0) {

				response.sendRedirect(request.getContextPath() + "/budget?month=" + month + "&year=" + year
						+ "&error=Budget must be greater than zero.");

				return;
			}

			Budget budget = new Budget();

			budget.setUserId(user.getUserId());

			budget.setMonth(month);

			budget.setYear(year);

			budget.setAmount(amount);

			boolean success = budgetDAO.saveOrUpdateBudget(budget);

			if (success) {

				response.sendRedirect(request.getContextPath() + "/budget?month=" + month + "&year=" + year
						+ "&success=Budget updated successfully.");

			} else {

				response.sendRedirect(request.getContextPath() + "/budget?month=" + month + "&year=" + year
						+ "&error=Failed to update budget.");
			}

		} catch (NumberFormatException e) {

			response.sendRedirect(request.getContextPath() + "/budget?error=Invalid budget information.");

		} catch (Exception e) {

			e.printStackTrace();

			response.sendRedirect(request.getContextPath() + "/budget?error=Unable to update budget.");
		}
	}
}