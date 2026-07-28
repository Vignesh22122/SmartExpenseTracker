# Smart Expense Tracker

Smart Expense Tracker is a Java web application for tracking personal expenses, managing monthly budgets, and analyzing spending patterns through an interactive dashboard.

The application follows an MVC-style architecture using Jakarta Servlets, JSP, JDBC, and MySQL.

## Features

### Authentication
- User registration and login
- PBKDF2-HMAC-SHA256 password hashing
- Automatic migration of legacy SHA-256 password hashes
- Session-based authentication
- Protected application routes
- Secure logout

### Dashboard
- Monthly spending overview
- Budget and remaining balance summary
- Budget usage tracking
- Category-wise expense visualization
- Monthly expense trend
- Recent expense activity
- Spending insights

### Expense Management
- Add expenses
- Edit existing expenses
- Delete expenses
- Search expenses
- Filter by category and month
- Sort expense records
- Pagination
- User-specific expense isolation

### Budget Management
- Set monthly budgets
- Update existing budgets
- Track monthly spending against budget
- Remaining budget calculation
- Budget usage percentage
- Visual budget progress
- Budget status indicators

### Profile
- View user profile
- Update profile information

## Tech Stack

### Backend
- Java
- Jakarta Servlets
- JDBC

### Frontend
- JSP
- JSTL
- HTML
- CSS
- JavaScript
- Tailwind CSS

### Database
- MySQL

### Server
- Apache Tomcat 10

## Architecture

The project uses an MVC-style layered structure:

```text
Browser
   |
   v
Servlet Controller
   |
   v
DAO / Service Layer
   |
   v
MySQL Database

Servlet Controller
   |
   v
JSP View
   |
   v
Browser