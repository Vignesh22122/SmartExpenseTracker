<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Edit Expense</title>

<script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-slate-100 min-h-screen">

	<div class="max-w-3xl mx-auto mt-12 px-4">

		<div class="bg-white shadow-lg rounded-xl overflow-hidden">

			<!-- Header -->

			<div class="border-b px-6 py-4">
				<h2 class="text-2xl font-bold text-slate-800">Edit Expense</h2>

				<p class="text-sm text-slate-500 mt-1">Update your expense
					details.</p>
			</div>


			<!-- Error Message -->

			<c:if test="${not empty param.error}">
				<div
					class="mx-6 mt-6 bg-red-50 border border-red-200
                            text-red-700 px-4 py-3 rounded-lg">
					<c:out value="${param.error}" />
				</div>
			</c:if>


			<!-- Edit Form -->

			<form action="${pageContext.request.contextPath}/expenses/edit"
				method="post" class="p-6 space-y-6">

				<!-- Expense ID -->

				<input type="hidden" name="expenseId" value="${expense.expenseId}">


				<!-- Title -->

				<div>
					<label for="title"
						class="block text-sm font-medium text-slate-700 mb-2">
						Title </label> <input type="text" id="title" name="title"
						value="<c:out value='${expense.title}'/>" maxlength="100" required
						class="w-full border border-slate-300 rounded-lg
                                  px-3 py-2 outline-none
                                  focus:border-emerald-500
                                  focus:ring-2 focus:ring-emerald-100">
				</div>


				<!-- Amount + Date -->

				<div class="grid grid-cols-1 md:grid-cols-2 gap-6">

					<div>
						<label for="amount"
							class="block text-sm font-medium text-slate-700 mb-2">
							Amount </label> <input type="number" id="amount" name="amount"
							step="0.01" min="0.01" value="${expense.amount}" required
							class="w-full border border-slate-300 rounded-lg
                                      px-3 py-2 outline-none
                                      focus:border-emerald-500
                                      focus:ring-2 focus:ring-emerald-100">
					</div>


					<div>
						<label for="expenseDate"
							class="block text-sm font-medium text-slate-700 mb-2">
							Expense Date </label> <input type="date" id="expenseDate"
							name="expenseDate" value="${expense.expenseDate}" required
							class="w-full border border-slate-300 rounded-lg
                                      px-3 py-2 outline-none
                                      focus:border-emerald-500
                                      focus:ring-2 focus:ring-emerald-100">
					</div>

				</div>


				<!-- Category -->

				<div>
					<label for="category"
						class="block text-sm font-medium text-slate-700 mb-2">
						Category </label> <select id="category" name="category" required
						class="w-full border border-slate-300 rounded-lg
                                   px-3 py-2 outline-none bg-white
                                   focus:border-emerald-500
                                   focus:ring-2 focus:ring-emerald-100">

						<option value="Food"
							${expense.category == 'Food' ? 'selected' : ''}>Food</option>

						<option value="Travel"
							${expense.category == 'Travel' ? 'selected' : ''}>
							Travel</option>

						<option value="Shopping"
							${expense.category == 'Shopping' ? 'selected' : ''}>
							Shopping</option>

						<option value="Bills"
							${expense.category == 'Bills' ? 'selected' : ''}>Bills</option>

						<option value="Entertainment"
							${expense.category == 'Entertainment' ? 'selected' : ''}>
							Entertainment</option>

						<option value="Health"
							${expense.category == 'Health' ? 'selected' : ''}>
							Health</option>

						<option value="Education"
							${expense.category == 'Education' ? 'selected' : ''}>
							Education</option>

						<option value="Other"
							${expense.category == 'Other' ? 'selected' : ''}>Other</option>

					</select>
				</div>


				<!-- Description -->

				<div>
					<label for="description"
						class="block text-sm font-medium text-slate-700 mb-2">
						Description </label>

					<textarea id="description" name="description" rows="4"
						maxlength="500"
						class="w-full border border-slate-300 rounded-lg
                                     px-3 py-2 outline-none resize-none
                                     focus:border-emerald-500
                                     focus:ring-2 focus:ring-emerald-100"><c:out
							value="${expense.description}" /></textarea>
				</div>


				<!-- Buttons -->

				<div class="flex justify-end gap-4 pt-2">

					<a href="${pageContext.request.contextPath}/expenses"
						class="px-6 py-2 rounded-lg
                              border border-slate-300
                              text-slate-700
                              hover:bg-slate-100 transition">
						Cancel </a>

					<button type="submit"
						class="bg-emerald-600 hover:bg-emerald-700
                                   text-white px-6 py-2 rounded-lg
                                   font-semibold transition">
						Update Expense</button>

				</div>

			</form>

		</div>

	</div>

</body>
</html>