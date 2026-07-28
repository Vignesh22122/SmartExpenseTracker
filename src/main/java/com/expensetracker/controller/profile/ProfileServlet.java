package com.expensetracker.controller.profile;

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

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	private UserDAO userDAO;

	@Override
	public void init() throws ServletException {
		userDAO = new UserDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.sendRedirect(request.getContextPath() + "/login.jsp");

			return;
		}

		User sessionUser = (User) session.getAttribute("user");

		User user = userDAO.getUserById(sessionUser.getUserId());

		if (user == null) {

			session.invalidate();

			response.sendRedirect(request.getContextPath() + "/login.jsp?error=Account not found.");

			return;
		}

		session.setAttribute("user", user);

		request.setAttribute("profileUser", user);

		request.getRequestDispatcher("/WEB-INF/views/profile/profile.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		if (session == null || session.getAttribute("user") == null) {

			response.sendRedirect(request.getContextPath() + "/login.jsp");

			return;
		}

		User sessionUser = (User) session.getAttribute("user");

		String action = request.getParameter("action");

		if (action == null || action.isBlank()) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Invalid request.");

			return;
		}

		switch (action) {

		case "updateProfile":

			updateProfile(request, response, session, sessionUser);

			break;

		case "changePassword":

			changePassword(request, response, sessionUser);

			break;

		default:

			response.sendRedirect(request.getContextPath() + "/profile?error=Invalid action.");

			break;
		}
	}

	private void updateProfile(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			User sessionUser) throws IOException {

		String name = request.getParameter("name");

		String email = request.getParameter("email");

		if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty()) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Name and email are required.");

			return;
		}

		name = name.trim();
		email = email.trim().toLowerCase();

		if (name.length() < 2) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Name must contain at least 2 characters.");

			return;
		}

		if (name.length() > 100) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Name cannot exceed 100 characters.");

			return;
		}

		if (!isValidEmail(email)) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Enter a valid email address.");

			return;
		}

		if (email.length() > 100) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Email cannot exceed 100 characters.");

			return;
		}

		boolean emailExists = userDAO.emailExistsForAnotherUser(email, sessionUser.getUserId());

		if (emailExists) {

			response.sendRedirect(request.getContextPath() + "/profile?error=This email is already registered.");

			return;
		}

		boolean updated = userDAO.updateProfile(sessionUser.getUserId(), name, email);

		if (!updated) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Unable to update profile.");

			return;
		}

		User updatedUser = userDAO.getUserById(sessionUser.getUserId());

		if (updatedUser != null) {

			session.setAttribute("user", updatedUser);
		}

		response.sendRedirect(request.getContextPath() + "/profile?success=Profile updated successfully.");
	}

	private void changePassword(HttpServletRequest request, HttpServletResponse response, User sessionUser)
			throws IOException {

		String currentPassword = request.getParameter("currentPassword");

		String newPassword = request.getParameter("newPassword");

		String confirmPassword = request.getParameter("confirmPassword");

		if (currentPassword == null || currentPassword.isBlank() || newPassword == null || newPassword.isBlank()
				|| confirmPassword == null || confirmPassword.isBlank()) {

			response.sendRedirect(request.getContextPath() + "/profile?error=All password fields are required.");

			return;
		}

		User databaseUser = userDAO.getUserById(sessionUser.getUserId());

		if (databaseUser == null) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Unable to find your account.");

			return;
		}

		boolean validCurrentPassword = PasswordUtil.verifyPassword(currentPassword, databaseUser.getPasswordHash());

		if (!validCurrentPassword) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Current password is incorrect.");

			return;
		}

		if (newPassword.length() < 8) {

			response.sendRedirect(
					request.getContextPath() + "/profile?error=New password must contain at least 8 characters.");

			return;
		}

		if (newPassword.length() > 100) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Password is too long.");

			return;
		}

		if (!newPassword.equals(confirmPassword)) {

			response.sendRedirect(request.getContextPath() + "/profile?error=New passwords do not match.");

			return;
		}

		if (PasswordUtil.verifyPassword(newPassword, databaseUser.getPasswordHash())) {

			response.sendRedirect(request.getContextPath()
					+ "/profile?error=New password must be different from your current password.");

			return;
		}

		String newPasswordHash = PasswordUtil.hashPassword(newPassword);

		boolean updated = userDAO.updatePassword(sessionUser.getUserId(), newPasswordHash);

		if (!updated) {

			response.sendRedirect(request.getContextPath() + "/profile?error=Unable to change password.");

			return;
		}

		response.sendRedirect(request.getContextPath() + "/profile?success=Password changed successfully.");
	}

	private boolean isValidEmail(String email) {

		return email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
	}
}