package com.expensetracker.controller.auth;

import java.io.IOException;

import com.expensetracker.dao.UserDAO;
import com.expensetracker.model.User;
import com.expensetracker.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserDAO userDAO;

	@Override
	public void init() throws ServletException {
		userDAO = new UserDAO();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String password = request.getParameter("password");

		if (email == null || email.isBlank() || password == null || password.isEmpty()) {

			response.sendRedirect(request.getContextPath() + "/login.jsp?error=Email+and+password+are+required.");

			return;
		}

		email = email.trim();

		User user = userDAO.getUserByEmail(email);

		if (user == null || !PasswordUtil.verifyPassword(password, user.getPasswordHash())) {

			response.sendRedirect(request.getContextPath() + "/login.jsp?error=Invalid+email+or+password.");

			return;
		}

		// Upgrade old SHA-256 password to PBKDF2.
		if (PasswordUtil.isLegacySHA256Hash(user.getPasswordHash())) {

			String newPasswordHash = PasswordUtil.hashPassword(password);

			boolean migrated = userDAO.updatePassword(user.getUserId(), newPasswordHash);

			if (migrated) {
				user.setPasswordHash(newPasswordHash);
			}
		}

		// Prevent reuse of an existing session after authentication.
		HttpSession oldSession = request.getSession(false);

		if (oldSession != null) {
			oldSession.invalidate();
		}

		HttpSession session = request.getSession(true);

		session.setAttribute("user", user);

		session.setMaxInactiveInterval(30 * 60);

		response.sendRedirect(request.getContextPath() + "/dashboard");
	}
}