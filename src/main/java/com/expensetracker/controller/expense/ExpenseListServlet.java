package com.expensetracker.controller.expense;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import com.expensetracker.dao.ExpenseDAO;
import com.expensetracker.model.Expense;
import com.expensetracker.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/expenses")
public class ExpenseListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private ExpenseDAO expenseDAO = new ExpenseDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");

        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }

        String category = request.getParameter("category");
        if (category == null || category.isBlank()) {
            category = "All";
        }

        String month = request.getParameter("month");
        if (month == null || month.isBlank()) {
            month = "All";
        }

        String sort = request.getParameter("sort");
        if (sort == null || sort.isBlank()) {
            sort = "latest";
        }

        int page = 1;

        try {

            String pageParam = request.getParameter("page");

            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }

        } catch (Exception e) {

            page = 1;

        }

        int pageSize = 10;

        int totalExpenses = expenseDAO.getExpenseCount(
                user.getUserId(),
                search,
                category,
                month);

        int totalPages = (int) Math.ceil((double) totalExpenses / pageSize);

        List<Expense> expenses = expenseDAO.getFilteredExpenses(
                user.getUserId(),
                search,
                category,
                month,
                sort,
                page,
                pageSize);

        BigDecimal totalAmount =
                expenseDAO.getTotalExpenseAmount(user.getUserId());

        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("totalExpenses", totalExpenses);
        request.setAttribute("expenses", expenses);

        request.setAttribute("selectedCategory", category);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedSort", sort);
        request.setAttribute("search", search);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("/WEB-INF/views/expense/expenses.jsp")
                .forward(request, response);

    }

}