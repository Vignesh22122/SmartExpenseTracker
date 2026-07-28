package com.expensetracker.controller.dashboard;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import com.expensetracker.dao.BudgetDAO;
import com.expensetracker.dao.ExpenseDAO;
import com.expensetracker.model.Budget;
import com.expensetracker.model.Expense;
import com.expensetracker.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private final ExpenseDAO expenseDAO = new ExpenseDAO();
	private final BudgetDAO budgetDAO = new BudgetDAO();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {
			response.sendRedirect(request.getContextPath() + "/login");
			return;
		}

		User user = (User) session.getAttribute("user");
		int userId = user.getUserId();

		LocalDate today = LocalDate.now();


		List<String> availableMonths = new ArrayList<>();

		for (int i = 0; i < 12; i++) {

			LocalDate date = today.minusMonths(i);

			availableMonths.add(String.format("%04d-%02d", date.getYear(), date.getMonthValue()));
		}


		String month = request.getParameter("month");

		if (month == null || month.isBlank()) {

			month = String.format("%04d-%02d", today.getYear(), today.getMonthValue());
		}

		String category = request.getParameter("category");

		if (category == null || category.isBlank()) {
			category = "All";
		}

		String search = request.getParameter("search");

		if (search == null) {
			search = "";
		}

		String sort = request.getParameter("sort");

		if (sort == null || sort.isBlank()) {
			sort = "latest";
		}

		int page = 1;
		int pageSize = 10;

		try {

			String pageParam = request.getParameter("page");

			if (pageParam != null && !pageParam.isBlank()) {
				page = Integer.parseInt(pageParam);
			}

		} catch (NumberFormatException e) {

			page = 1;
		}

		if (page < 1) {
			page = 1;
		}

		int totalRecords = expenseDAO.getExpenseCount(userId, search, category, month);

		int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

		if (totalPages > 0 && page > totalPages) {
			page = totalPages;
		}

		List<Expense> expenses = expenseDAO.getFilteredExpenses(userId, search, category, month, sort, page, pageSize);

		int year = today.getYear();
		int monthNumber = today.getMonthValue();

		try {

			if (!"All".equalsIgnoreCase(month)) {

				YearMonth selectedYearMonth = YearMonth.parse(month);

				year = selectedYearMonth.getYear();
				monthNumber = selectedYearMonth.getMonthValue();
			}

		} catch (Exception e) {

			year = today.getYear();
			monthNumber = today.getMonthValue();

			month = String.format("%04d-%02d", year, monthNumber);
		}

		YearMonth selectedYearMonth = YearMonth.of(year, monthNumber);

		BigDecimal totalSpent = expenseDAO.getMonthlyExpenseAmount(userId, monthNumber, year);

		if (totalSpent == null) {
			totalSpent = BigDecimal.ZERO;
		}

		BigDecimal budgetAmount = BigDecimal.ZERO;

		Budget budget = budgetDAO.getBudget(userId, monthNumber, year);

		if (budget != null && budget.getAmount() != null) {
			budgetAmount = budget.getAmount();
		}

		BigDecimal remainingBudget = budgetAmount.subtract(totalSpent);

		int budgetUsedPercentage = 0;

		if (budgetAmount.compareTo(BigDecimal.ZERO) > 0) {

			budgetUsedPercentage = totalSpent.multiply(BigDecimal.valueOf(100))
					.divide(budgetAmount, 0, RoundingMode.HALF_UP).intValue();
		}

		int budgetProgressPercentage = Math.max(0, Math.min(budgetUsedPercentage, 100));

		YearMonth previousYearMonth = selectedYearMonth.minusMonths(1);

		BigDecimal previousMonthSpent = expenseDAO.getMonthlyExpenseAmount(userId, previousYearMonth.getMonthValue(),
				previousYearMonth.getYear());

		if (previousMonthSpent == null) {
			previousMonthSpent = BigDecimal.ZERO;
		}

		BigDecimal spendingDifference = totalSpent.subtract(previousMonthSpent);

		BigDecimal spendingChangePercentage = BigDecimal.ZERO;

		if (previousMonthSpent.compareTo(BigDecimal.ZERO) > 0) {

			spendingChangePercentage = spendingDifference.multiply(BigDecimal.valueOf(100)).divide(previousMonthSpent,
					1, RoundingMode.HALF_UP);
		}

		String spendingTrend;

		if (previousMonthSpent.compareTo(BigDecimal.ZERO) == 0 && totalSpent.compareTo(BigDecimal.ZERO) > 0) {

			spendingTrend = "NEW_SPENDING";

		} else if (spendingDifference.compareTo(BigDecimal.ZERO) > 0) {

			spendingTrend = "INCREASED";

		} else if (spendingDifference.compareTo(BigDecimal.ZERO) < 0) {

			spendingTrend = "DECREASED";

		} else {

			spendingTrend = "UNCHANGED";
		}

		String selectedMonthName = selectedYearMonth.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH);

		String previousMonthName = previousYearMonth.getMonth().getDisplayName(TextStyle.FULL, Locale.ENGLISH);

		List<Expense> recentExpenses = expenseDAO.getRecentExpenses(userId, monthNumber, year);

		Map<String, BigDecimal> categoryExpense = expenseDAO.getCategoryWiseExpense(userId, monthNumber, year);

		Map<String, BigDecimal> monthlyTrend = expenseDAO.getMonthlyExpenseTrend(userId, monthNumber, year);

		request.setAttribute("expenses", expenses);

		request.setAttribute("selectedMonth", month);

		request.setAttribute("selectedCategory", category);

		request.setAttribute("search", search);

		request.setAttribute("selectedSort", sort);

		// Pagination

		request.setAttribute("currentPage", page);

		request.setAttribute("totalRecords", totalRecords);

		request.setAttribute("totalPages", totalPages);

		// Budget

		request.setAttribute("totalSpent", totalSpent);

		request.setAttribute("spentAmount", totalSpent);

		request.setAttribute("budgetAmount", budgetAmount);

		request.setAttribute("remainingBudget", remainingBudget);

		request.setAttribute("budgetUsedPercentage", budgetUsedPercentage);

		request.setAttribute("budgetProgressPercentage", budgetProgressPercentage);

		request.setAttribute("budgetMonth", monthNumber);

		request.setAttribute("budgetYear", year);

		// Month selection

		request.setAttribute("availableMonths", availableMonths);

		// Monthly comparison
		request.setAttribute("currentMonthSpent", totalSpent);
		request.setAttribute("previousMonthSpent", previousMonthSpent);
		request.setAttribute("spendingDifference", spendingDifference);
		request.setAttribute("spendingChangePercentage", spendingChangePercentage);
		request.setAttribute("spendingTrend", spendingTrend);
		request.setAttribute("selectedMonthName", selectedMonthName);
		request.setAttribute("previousMonthName", previousMonthName);
		request.setAttribute("selectedYear", selectedYearMonth.getYear());
		request.setAttribute("previousMonthYear", previousYearMonth.getYear());

		// Analytics
		request.setAttribute("recentExpenses", recentExpenses);
		request.setAttribute("categoryExpense", categoryExpense);
		request.setAttribute("monthlyTrend", monthlyTrend);

		request.getRequestDispatcher("/WEB-INF/views/dashboard/dashboard.jsp").forward(request, response);
	}
}