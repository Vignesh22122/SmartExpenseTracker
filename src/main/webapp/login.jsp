<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Smart Expense Tracker</title>


<script src="https://cdn.tailwindcss.com"></script>

</head>

<body class="bg-slate-100 min-h-screen flex items-center justify-center font-sans px-4">

<div class="w-full max-w-md bg-white border border-slate-200 rounded-2xl p-8 shadow-lg">

    <!-- Header -->
    <div class="text-center mb-7">

        <div class="inline-flex items-center justify-center w-14 h-14 bg-emerald-100 text-emerald-600 rounded-full mb-4">
            <svg xmlns="http://www.w3.org/2000/svg"
                 class="w-7 h-7"
                 fill="none"
                 viewBox="0 0 24 24"
                 stroke="currentColor"
                 stroke-width="2">
                <path stroke-linecap="round"
                      stroke-linejoin="round"
                      d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
        </div>

        <h1 class="text-2xl font-bold text-slate-900">
            Welcome Back
        </h1>

        <p class="text-sm text-slate-500 mt-2">
            Sign in to your Smart Expense Tracker
        </p>

    </div>


    <!-- Error from request -->
    <c:if test="${not empty error}">
        <div class="mb-4 p-3 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">
            ${error}
        </div>
    </c:if>


    <!-- Error from URL parameter -->
    <c:if test="${not empty param.error}">
        <div class="mb-4 p-3 bg-red-50 border border-red-200 text-red-700 rounded-lg text-sm">
            ${param.error}
        </div>
    </c:if>


    <!-- Registration success message -->
    <c:if test="${not empty param.success}">
        <div class="mb-4 p-3 bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg text-sm">
            ${param.success}
        </div>
    </c:if>


    <!-- Login Form -->
    <form action="${pageContext.request.contextPath}/LoginServlet"
          method="POST"
          class="space-y-5">


        <!-- Email -->
        <div>

            <label for="email"
                   class="block text-sm font-medium text-slate-700 mb-1.5">
                Email Address
            </label>

            <input
                id="email"
                type="email"
                name="email"
                placeholder="Enter your email"
                autocomplete="email"
                class="w-full bg-white border border-slate-300 rounded-lg px-3 py-2.5 text-sm
                       text-slate-900 placeholder-slate-400
                       focus:outline-none focus:ring-2 focus:ring-emerald-500
                       focus:border-emerald-500 transition"
                required
            />

        </div>


        <!-- Password -->
        <div>

            <div class="flex justify-between items-center mb-1.5">

                <label for="password"
                       class="block text-sm font-medium text-slate-700">
                    Password
                </label>

            </div>


            <div class="relative">

                <input
                    id="password"
                    type="password"
                    name="password"
                    placeholder="Enter your password"
                    autocomplete="current-password"
                    class="w-full bg-white border border-slate-300 rounded-lg
                           px-3 py-2.5 pr-11 text-sm text-slate-900
                           placeholder-slate-400
                           focus:outline-none focus:ring-2
                           focus:ring-emerald-500
                           focus:border-emerald-500 transition"
                    required
                />


                <!-- Eye Button -->
                <button
                    type="button"
                    onclick="togglePassword('password', this)"
                    class="absolute inset-y-0 right-0 flex items-center
                           justify-center w-11 text-slate-400
                           hover:text-slate-700 focus:outline-none"
                    aria-label="Show password"
                >

                    <!-- Eye Icon -->
                    <svg class="eye-open w-5 h-5"
                         xmlns="http://www.w3.org/2000/svg"
                         fill="none"
                         viewBox="0 0 24 24"
                         stroke="currentColor"
                         stroke-width="2">

                        <path stroke-linecap="round"
                              stroke-linejoin="round"
                              d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>

                        <circle cx="12"
                                cy="12"
                                r="3"/>

                    </svg>


                    <!-- Eye Slash Icon -->
                    <svg class="eye-closed w-5 h-5 hidden"
                         xmlns="http://www.w3.org/2000/svg"
                         fill="none"
                         viewBox="0 0 24 24"
                         stroke="currentColor"
                         stroke-width="2">

                        <path stroke-linecap="round"
                              stroke-linejoin="round"
                              d="M3 3l18 18M10.6 10.6a2 2 0 002.8 2.8M9.9 4.2A9.8 9.8 0 0112 4c5 0 9 4 10 8a11.8 11.8 0 01-2.2 4M6.6 6.6A11.7 11.7 0 002 12c1 4 5 8 10 8a9.8 9.8 0 005.4-1.6"/>

                    </svg>

                </button>

            </div>

        </div>


        <!-- Login Button -->
        <button
            type="submit"
            class="w-full bg-emerald-600 hover:bg-emerald-700
                   text-white font-semibold py-2.5 px-4 rounded-lg
                   transition duration-200
                   focus:outline-none focus:ring-2
                   focus:ring-emerald-500 focus:ring-offset-2"
        >
            Log In
        </button>


        <!-- Register Link -->
        <div class="text-center text-sm text-slate-600 pt-2">

            Don't have an account?

            <a
                href="${pageContext.request.contextPath}/register.jsp"
                class="text-emerald-600 hover:text-emerald-700 font-semibold"
            >
                Create Account
            </a>

        </div>

    </form>

</div>


<!-- Password Visibility Script -->
<script>

    function togglePassword(fieldId, button) {

        const passwordField =
            document.getElementById(fieldId);

        const eyeOpen =
            button.querySelector('.eye-open');

        const eyeClosed =
            button.querySelector('.eye-closed');


        if (passwordField.type === 'password') {

            passwordField.type = 'text';

            eyeOpen.classList.add('hidden');
            eyeClosed.classList.remove('hidden');

            button.setAttribute(
                'aria-label',
                'Hide password'
            );

        } else {

            passwordField.type = 'password';

            eyeOpen.classList.remove('hidden');
            eyeClosed.classList.add('hidden');

            button.setAttribute(
                'aria-label',
                'Show password'
            );
        }
    }

</script>

</body>
</html>
