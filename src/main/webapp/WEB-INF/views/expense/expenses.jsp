<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<c:set var="activePage" value="expenses" />

<%@ include file="/WEB-INF/views/layout/header.jspf"%>
<%@ include file="/WEB-INF/views/layout/sidebar.jspf"%>


<div
	class="flex-1 min-w-0 overflow-y-auto
	       bg-slate-50 min-h-screen
	       pt-16 lg:pt-0">

	<div class="bg-white shadow-sm border-b border-slate-200">

		<div
			class="px-5 sm:px-6 lg:px-8 py-6
			       flex items-center justify-between">

			<div>

				<h1
					class="text-3xl sm:text-4xl
					       font-bold text-slate-800">

					Expenses

				</h1>


				<p class="text-slate-500 mt-2">

					Manage all your expenses

				</p>

			</div>

		</div>

	</div>

	<div class="p-4 sm:p-6 lg:p-8">

		<c:if test="${not empty param.success}">

			<div
				class="mb-6 rounded-lg
				       bg-green-100 border border-green-300
				       text-green-700
				       px-4 sm:px-5 py-4">

				<c:out value="${param.success}" />

			</div>

		</c:if>

		<c:if test="${not empty param.error}">

			<div
				class="mb-6 rounded-lg
				       bg-red-100 border border-red-300
				       text-red-700
				       px-4 sm:px-5 py-4">

				<c:out value="${param.error}" />

			</div>

		</c:if>

		<div
			class="grid grid-cols-1 md:grid-cols-2
			       gap-4 sm:gap-6 mb-6 sm:mb-8">

			<div
				class="bg-white rounded-xl
				       shadow-lg
				       p-5 sm:p-6">

				<div class="flex items-start justify-between gap-4">

					<div>

						<p class="text-slate-500 text-sm">
							Total Expenses
						</p>


						<h2
							class="text-3xl sm:text-4xl
							       font-bold text-blue-600 mt-3">

							<c:out value="${totalExpenses}" />

						</h2>

					</div>


					<div
						class="w-11 h-11
						       rounded-xl bg-blue-50
						       flex items-center justify-center
						       shrink-0">

						<i
							class="fa-solid fa-receipt
							       text-blue-600"></i>

					</div>

				</div>

			</div>
			<div
				class="bg-white rounded-xl
				       shadow-lg
				       p-5 sm:p-6">

				<div class="flex items-start justify-between gap-4">

					<div class="min-w-0">

						<p class="text-slate-500 text-sm">
							Total Amount
						</p>


						<h2
							class="text-3xl sm:text-4xl
							       font-bold text-red-600 mt-3
							       break-words">

							₹ <c:out value="${totalAmount}" />

						</h2>

					</div>


					<div
						class="w-11 h-11
						       rounded-xl bg-red-50
						       flex items-center justify-center
						       shrink-0">

						<i
							class="fa-solid fa-indian-rupee-sign
							       text-red-600"></i>

					</div>

				</div>

			</div>

		</div>

		<div
			class="bg-white rounded-xl
			       shadow-lg
			       p-5 sm:p-6 lg:p-8
			       mb-6 sm:mb-8">

			<h2
				class="text-xl sm:text-2xl
				       font-bold text-slate-800
				       mb-6">

				Add New Expense

			</h2>


			<form
				action="${pageContext.request.contextPath}/expenses/add"
				method="post"
				class="grid grid-cols-1 md:grid-cols-2 gap-5 sm:gap-6">

				<div>

					<label
						for="expenseTitle"
						class="block font-medium mb-2 text-slate-700">

						Title

					</label>


					<input
						id="expenseTitle"
						type="text"
						name="title"
						required
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3
						       focus:outline-none
						       focus:ring-2
						       focus:ring-emerald-500
						       focus:border-emerald-500">

				</div>

				<div>

					<label
						for="expenseAmount"
						class="block font-medium mb-2 text-slate-700">

						Amount

					</label>


					<input
						id="expenseAmount"
						type="number"
						step="0.01"
						min="0"
						name="amount"
						required
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3
						       focus:outline-none
						       focus:ring-2
						       focus:ring-emerald-500
						       focus:border-emerald-500">

				</div>

				<div>

					<label
						for="expenseCategory"
						class="block font-medium mb-2 text-slate-700">

						Category

					</label>


					<select
						id="expenseCategory"
						name="category"
						required
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3
						       bg-white
						       focus:outline-none
						       focus:ring-2
						       focus:ring-emerald-500
						       focus:border-emerald-500">

						<option value="">
							Select Category
						</option>

						<option>Food</option>
						<option>Travel</option>
						<option>Shopping</option>
						<option>Bills</option>
						<option>Health</option>
						<option>Education</option>
						<option>Entertainment</option>
						<option>Other</option>

					</select>

				</div>
				<div>

					<label
						for="expenseDate"
						class="block font-medium mb-2 text-slate-700">

						Expense Date

					</label>


					<input
						id="expenseDate"
						type="date"
						name="expenseDate"
						required
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3
						       bg-white
						       focus:outline-none
						       focus:ring-2
						       focus:ring-emerald-500
						       focus:border-emerald-500">

				</div>

				<div class="md:col-span-2">

					<label
						for="expenseDescription"
						class="block font-medium mb-2 text-slate-700">

						Description

					</label>


					<textarea
						id="expenseDescription"
						name="description"
						rows="4"
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3
						       resize-y
						       focus:outline-none
						       focus:ring-2
						       focus:ring-emerald-500
						       focus:border-emerald-500"
						placeholder="Enter description (optional)"></textarea>

				</div>

				<div class="md:col-span-2 flex">

					<button
						type="submit"
						class="w-full md:w-auto md:ml-auto
						       bg-emerald-600
						       hover:bg-emerald-700
						       text-white font-semibold
						       px-8 py-3 rounded-lg
						       transition">

						<i class="fa-solid fa-plus mr-2"></i>

						Save Expense

					</button>

				</div>

			</form>

		</div>

		<div
			class="bg-white rounded-xl
			       shadow-lg
			       p-5 sm:p-6
			       mb-6 sm:mb-8">

			<form
				action="${pageContext.request.contextPath}/expenses"
				method="get"
				class="grid grid-cols-1
				       sm:grid-cols-2
				       lg:grid-cols-5
				       gap-4">

				<div>

					<label
						for="search"
						class="block font-medium mb-2 text-slate-700">

						Search

					</label>


					<input
						id="search"
						type="text"
						name="search"
						value="${search}"
						placeholder="Search by title..."
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3
						       focus:outline-none
						       focus:ring-2
						       focus:ring-blue-500">

				</div>

				<div>

					<label
						for="filterCategory"
						class="block font-medium mb-2 text-slate-700">

						Category

					</label>


					<select
						id="filterCategory"
						name="category"
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3 bg-white">

						<option value="All"
							${selectedCategory == 'All' ? 'selected' : ''}>
							All
						</option>

						<option value="Food"
							${selectedCategory == 'Food' ? 'selected' : ''}>
							Food
						</option>

						<option value="Travel"
							${selectedCategory == 'Travel' ? 'selected' : ''}>
							Travel
						</option>

						<option value="Shopping"
							${selectedCategory == 'Shopping' ? 'selected' : ''}>
							Shopping
						</option>

						<option value="Bills"
							${selectedCategory == 'Bills' ? 'selected' : ''}>
							Bills
						</option>

						<option value="Health"
							${selectedCategory == 'Health' ? 'selected' : ''}>
							Health
						</option>

						<option value="Education"
							${selectedCategory == 'Education' ? 'selected' : ''}>
							Education
						</option>

						<option value="Entertainment"
							${selectedCategory == 'Entertainment' ? 'selected' : ''}>
							Entertainment
						</option>

						<option value="Other"
							${selectedCategory == 'Other' ? 'selected' : ''}>
							Other
						</option>

					</select>

				</div>

				<div>

					<label
						for="filterMonth"
						class="block font-medium mb-2 text-slate-700">

						Month

					</label>


					<input
						id="filterMonth"
						type="month"
						name="month"
						value="${selectedMonth}"
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3 bg-white">

				</div>

				<div>

					<label
						for="sort"
						class="block font-medium mb-2 text-slate-700">

						Sort

					</label>


					<select
						id="sort"
						name="sort"
						class="w-full border border-slate-300
						       rounded-lg px-4 py-3 bg-white">

						<option value="latest"
							${selectedSort == 'latest' ? 'selected' : ''}>
							Latest
						</option>

						<option value="oldest"
							${selectedSort == 'oldest' ? 'selected' : ''}>
							Oldest
						</option>

						<option value="highest"
							${selectedSort == 'highest' ? 'selected' : ''}>
							Highest Amount
						</option>

						<option value="lowest"
							${selectedSort == 'lowest' ? 'selected' : ''}>
							Lowest Amount
						</option>

					</select>

				</div>

				<div class="flex items-end sm:col-span-2 lg:col-span-1">

					<button
						type="submit"
						class="w-full
						       bg-blue-600 hover:bg-blue-700
						       text-white font-semibold
						       rounded-lg py-3 px-4
						       transition">

						<i class="fa-solid fa-filter mr-2"></i>

						Apply

					</button>

				</div>

			</form>

		</div>

		<div
			class="bg-white rounded-xl
			       shadow-lg overflow-hidden">

			<div class="px-5 sm:px-6 py-5 border-b border-slate-200">

				<h2
					class="text-xl sm:text-2xl
					       font-bold text-slate-800">

					Expense History

				</h2>

			</div>

			<div class="md:hidden">

				<c:choose>

					<c:when test="${empty expenses}">

						<div
							class="px-5 py-12
							       text-center text-slate-500">

							<div
								class="w-14 h-14 mx-auto
								       bg-slate-100 rounded-xl
								       flex items-center justify-center">

								<i
									class="fa-solid fa-receipt
									       text-slate-400 text-xl"></i>

							</div>


							<p
								class="font-semibold
								       text-slate-700 mt-4">

								No expenses found

							</p>


							<p class="text-sm text-slate-400 mt-1">

								Your expenses will appear here.

							</p>

						</div>

					</c:when>

					<c:otherwise>

						<div class="divide-y divide-slate-200">

							<c:forEach var="expense" items="${expenses}">

								<div class="p-5">

									<div
										class="flex items-start
										       justify-between gap-4">

										<div class="min-w-0">

											<p
												class="font-semibold
												       text-slate-900
												       break-words">

												<c:out value="${expense.title}" />

											</p>


											<span
												class="inline-flex mt-2
												       bg-blue-100
												       text-blue-700
												       px-3 py-1
												       rounded-full
												       text-xs font-semibold">

												<c:out value="${expense.category}" />

											</span>

										</div>


										<p
											class="text-lg font-bold
											       text-red-600
											       whitespace-nowrap">

											₹ <c:out value="${expense.amount}" />

										</p>

									</div>

									<div
										class="flex items-center gap-2
										       mt-4
										       text-sm text-slate-500">

										<i class="fa-regular fa-calendar"></i>

										<span>
											<c:out value="${expense.expenseDate}" />
										</span>

									</div>

									<c:if test="${not empty expense.description}">

										<div
											class="mt-4 p-3
											       bg-slate-50
											       border border-slate-100
											       rounded-lg">

											<p
												class="text-xs font-medium
												       text-slate-400 mb-1">

												Description

											</p>


											<p
												class="text-sm text-slate-700
												       break-words">

												<c:out value="${expense.description}" />

											</p>

										</div>

									</c:if>

									<div class="grid grid-cols-2 gap-3 mt-5">

										<a
											href="${pageContext.request.contextPath}/expenses/edit?id=${expense.expenseId}"
											class="flex items-center
											       justify-center gap-2
											       bg-blue-600
											       hover:bg-blue-700
											       text-white font-medium
											       px-4 py-2.5
											       rounded-lg transition">

											<i class="fa-solid fa-pen"></i>

											Edit

										</a>


										<form
											action="${pageContext.request.contextPath}/expenses/delete"
											method="post"
											class="w-full">

											<input
												type="hidden"
												name="expenseId"
												value="${expense.expenseId}">


											<button
												type="submit"
												onclick="return confirm('Delete this expense?')"
												class="w-full
												       flex items-center
												       justify-center gap-2
												       bg-red-600
												       hover:bg-red-700
												       text-white font-medium
												       px-4 py-2.5
												       rounded-lg transition">

												<i class="fa-solid fa-trash"></i>

												Delete

											</button>

										</form>

									</div>

								</div>

							</c:forEach>

						</div>

					</c:otherwise>

				</c:choose>

			</div>


			<div class="hidden md:block overflow-x-auto">

				<table class="min-w-full">

					<thead class="bg-slate-100">

						<tr>

							<th
								scope="col"
								class="px-6 py-4 text-left
								       text-sm font-semibold
								       text-slate-700">

								Title

							</th>


							<th
								scope="col"
								class="px-6 py-4 text-left
								       text-sm font-semibold
								       text-slate-700">

								Amount

							</th>


							<th
								scope="col"
								class="px-6 py-4 text-left
								       text-sm font-semibold
								       text-slate-700">

								Category

							</th>


							<th
								scope="col"
								class="px-6 py-4 text-left
								       text-sm font-semibold
								       text-slate-700">

								Date

							</th>


							<th
								scope="col"
								class="px-6 py-4 text-left
								       text-sm font-semibold
								       text-slate-700">

								Description

							</th>


							<th
								scope="col"
								class="px-6 py-4 text-center
								       text-sm font-semibold
								       text-slate-700">

								Actions

							</th>

						</tr>

					</thead>


					<tbody>

						<c:choose>


							<c:when test="${empty expenses}">

								<tr>

									<td
										colspan="6"
										class="text-center
										       py-10 text-slate-500">

										No expenses found.

									</td>

								</tr>

							</c:when>


							<c:otherwise>

								<c:forEach var="expense" items="${expenses}">

									<tr
										class="border-b border-slate-200
										       hover:bg-slate-50
										       transition-colors">

										<td
											class="px-6 py-4
											       text-slate-800">

											<c:out value="${expense.title}" />

										</td>


										<td
											class="px-6 py-4
											       font-semibold text-red-600
											       whitespace-nowrap">

											₹ <c:out value="${expense.amount}" />

										</td>


										<td class="px-6 py-4">

											<span
												class="inline-flex
												       bg-blue-100
												       text-blue-700
												       px-3 py-1
												       rounded-full
												       text-sm
												       whitespace-nowrap">

												<c:out value="${expense.category}" />

											</span>

										</td>


										<td
											class="px-6 py-4
											       text-slate-600
											       whitespace-nowrap">

											<c:out value="${expense.expenseDate}" />

										</td>


										<td
											class="px-6 py-4
											       text-slate-600">

											<c:out value="${expense.description}" />

										</td>


										<td class="px-6 py-4">

											<div
												class="flex items-center
												       justify-center gap-2">

												<a
													href="${pageContext.request.contextPath}/expenses/edit?id=${expense.expenseId}"
													class="bg-blue-600
													       hover:bg-blue-700
													       text-white
													       px-4 py-2
													       rounded-lg
													       transition">

													Edit

												</a>


												<form
													action="${pageContext.request.contextPath}/expenses/delete"
													method="post">

													<input
														type="hidden"
														name="expenseId"
														value="${expense.expenseId}">


													<button
														type="submit"
														onclick="return confirm('Delete this expense?')"
														class="bg-red-600
														       hover:bg-red-700
														       text-white
														       px-4 py-2
														       rounded-lg
														       transition">

														Delete

													</button>

												</form>

											</div>

										</td>

									</tr>

								</c:forEach>

							</c:otherwise>

						</c:choose>

					</tbody>

				</table>

			</div>

		</div>

		<c:if test="${totalPages > 1}">

			<div
				class="flex flex-wrap justify-center
				       items-center gap-2 mt-6 sm:mt-8">

				<c:if test="${currentPage > 1}">

					<a
						href="${pageContext.request.contextPath}/expenses?page=${currentPage-1}&search=${search}&category=${selectedCategory}&month=${selectedMonth}&sort=${selectedSort}"
						class="px-3 sm:px-4 py-2
						       bg-slate-200
						       rounded-lg
						       hover:bg-slate-300
						       text-sm sm:text-base
						       transition">

						Previous

					</a>

				</c:if>

				<c:forEach begin="1" end="${totalPages}" var="i">

					<a
						href="${pageContext.request.contextPath}/expenses?page=${i}&search=${search}&category=${selectedCategory}&month=${selectedMonth}&sort=${selectedSort}"
						class="min-w-10 text-center
						       px-3 sm:px-4 py-2
						       rounded-lg
						       text-sm sm:text-base
						       transition
						       ${i == currentPage
						       ? 'bg-emerald-600 text-white'
						       : 'bg-slate-200 hover:bg-slate-300'}">

						${i}

					</a>

				</c:forEach>

				<c:if test="${currentPage < totalPages}">

					<a
						href="${pageContext.request.contextPath}/expenses?page=${currentPage+1}&search=${search}&category=${selectedCategory}&month=${selectedMonth}&sort=${selectedSort}"
						class="px-3 sm:px-4 py-2
						       bg-slate-200
						       rounded-lg
						       hover:bg-slate-300
						       text-sm sm:text-base
						       transition">

						Next

					</a>

				</c:if>

			</div>

		</c:if>

	</div>

	<%@ include file="/WEB-INF/views/layout/footer.jspf"%>

</div>

</body>

</html>