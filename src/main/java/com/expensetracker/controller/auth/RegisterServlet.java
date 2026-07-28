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

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {

        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        response.sendRedirect(
                request.getContextPath() + "/register.jsp"
        );
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // Get registration form values
        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        String confirmPassword =
                request.getParameter("confirmPassword");


        // Check required fields
        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || password == null || password.trim().isEmpty()
                || confirmPassword == null
                || confirmPassword.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "All fields are required!"
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);

            return;
        }


        // Check whether passwords match
        if (!password.equals(confirmPassword)) {

            request.setAttribute(
                    "error",
                    "Passwords do not match!"
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);

            return;
        }


        // Remove unnecessary spaces
        name = name.trim();
        email = email.trim();


        // Check whether email already exists
        User existingUser =
                userDAO.getUserByEmail(email);

        if (existingUser != null) {

            request.setAttribute(
                    "error",
                    "Email is already registered! Please sign in."
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);

            return;
        }


        // Hash the password before storing it
        String hashedPassword =
                PasswordUtil.hashPassword(password);


        // Create new User object
        User newUser = new User(
                0,
                name,
                email,
                hashedPassword,
                null
        );


        // Save user in database
        boolean success =
                userDAO.registerUser(newUser);


        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp?success=Registration successful! Please sign in."
            );

        } else {

            request.setAttribute(
                    "error",
                    "Registration failed. Please try again."
            );

            request.getRequestDispatcher(
                    "/register.jsp"
            ).forward(request, response);
        }
    }
}