<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="activePage" value="budget" />
<%@ include file="/WEB-INF/views/layout/header.jspf"%>
<%@ include file="/WEB-INF/views/layout/sidebar.jspf"%>

<div class="flex-1 overflow-y-auto bg-slate-100 min-h-screen">

	<!-- HEADER -->

	<div class="bg-white border-b shadow-sm">

		<div class="px-8 py-6">

			<h1 class="text-4xl font-bold text-slate-800">Budget</h1>

			<p class="text-slate-500 mt-2">Plan your monthly spending and
				track your budget performance</p>

		</div>

	</div>


	<div class="p-8">


		<!-- SUCCESS -->

		<c:if test="${not empty param.success}">

			<div
				class="mb-6 px-5 py-4 rounded-xl
                        bg-green-100 border border-green-300
                        text-green-700">

				<i class="fa-solid fa-circle-check mr-2"></i>

				<c:out value="${param.success}" />

			</div>

		</c:if>


		<!-- ERROR -->

		<c:if test="${not empty param.error}">

			<div
				class="mb-6 px-5 py-4 rounded-xl
                        bg-red-100 border border-red-300
                        text-red-700">

				<i class="fa-solid fa-circle-exclamation mr-2"></i>

				<c:out value="${param.error}" />

			</div>

		</c:if>


		<!-- PERIOD SELECTOR -->

		<div class="bg-white rounded-xl shadow-lg p-6 mb-8">

			<div
				class="flex flex-col lg:flex-row
                        lg:items-end lg:justify-between gap-6">

				<div>

					<h2 class="text-xl font-bold text-slate-800">Budget Period</h2>

					<p class="text-slate-500 mt-1">Select a month to view its
						budget performance.</p>

				</div>


				<form action="${pageContext.request.contextPath}/budget"
					method="get" class="flex flex-col sm:flex-row gap-4 items-end">


					<div>

						<label
							class="block text-sm font-semibold
                                      text-slate-700 mb-2">
							Month </label> <select name="month"
							class="border border-slate-300 rounded-lg
                                   px-4 py-3 bg-white
                                   focus:outline-none
                                   focus:ring-2
                                   focus:ring-emerald-500">

							<option value="1"
								<c:if test="${budgetMonth == 1}">selected</c:if>>
								January</option>

							<option value="2"
								<c:if test="${budgetMonth == 2}">selected</c:if>>
								February</option>

							<option value="3"
								<c:if test="${budgetMonth == 3}">selected</c:if>>March
							</option>

							<option value="4"
								<c:if test="${budgetMonth == 4}">selected</c:if>>April
							</option>

							<option value="5"
								<c:if test="${budgetMonth == 5}">selected</c:if>>May</option>

							<option value="6"
								<c:if test="${budgetMonth == 6}">selected</c:if>>June</option>

							<option value="7"
								<c:if test="${budgetMonth == 7}">selected</c:if>>July</option>

							<option value="8"
								<c:if test="${budgetMonth == 8}">selected</c:if>>
								August</option>

							<option value="9"
								<c:if test="${budgetMonth == 9}">selected</c:if>>
								September</option>

							<option value="10"
								<c:if test="${budgetMonth == 10}">selected</c:if>>
								October</option>

							<option value="11"
								<c:if test="${budgetMonth == 11}">selected</c:if>>
								November</option>

							<option value="12"
								<c:if test="${budgetMonth == 12}">selected</c:if>>
								December</option>

						</select>

					</div>


					<div>

						<label
							class="block text-sm font-semibold
                                      text-slate-700 mb-2">
							Year </label> <input type="number" name="year" min="2000" max="2100"
							value="<c:out value='${budgetYear}'/>" required
							class="w-32 border border-slate-300
                                   rounded-lg px-4 py-3
                                   focus:outline-none
                                   focus:ring-2
                                   focus:ring-emerald-500">

					</div>


					<button type="submit"
						class="bg-slate-800 hover:bg-slate-900
                               text-white px-6 py-3
                               rounded-lg font-semibold transition">

						<i class="fa-solid fa-filter mr-2"></i> View

					</button>

				</form>

			</div>

		</div>


		<!-- SUMMARY CARDS -->

		<div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 gap-6">


			<!-- MONTHLY BUDGET -->

			<div class="bg-white rounded-xl shadow-lg p-6">

				<div class="flex items-center justify-between">

					<div>

						<p class="text-sm text-slate-500">Monthly Budget</p>

						<h2 class="text-3xl font-bold text-blue-600 mt-3">

							₹
							<c:out value="${budgetAmount}" default="0.00" />

						</h2>

					</div>

					<div
						class="w-14 h-14 rounded-xl
                                bg-blue-100
                                flex items-center justify-center">

						<i
							class="fa-solid fa-wallet
                                  text-blue-600 text-2xl"></i>

					</div>

				</div>

			</div>


			<!-- AMOUNT SPENT -->

			<div class="bg-white rounded-xl shadow-lg p-6">

				<div class="flex items-center justify-between">

					<div>

						<p class="text-sm text-slate-500">Amount Spent</p>

						<h2 class="text-3xl font-bold text-red-600 mt-3">

							₹
							<c:out value="${spentAmount}" default="0.00" />

						</h2>

					</div>

					<div
						class="w-14 h-14 rounded-xl
                                bg-red-100
                                flex items-center justify-center">

						<i
							class="fa-solid fa-arrow-trend-down
                                  text-red-600 text-2xl"></i>

					</div>

				</div>

			</div>


			<!-- REMAINING -->

			<div class="bg-white rounded-xl shadow-lg p-6">

				<div class="flex items-center justify-between">

					<div>

						<p class="text-sm text-slate-500">Remaining</p>

						<h2
							class="text-3xl font-bold mt-3
                                   ${remainingAmount < 0
                                   ? 'text-red-600'
                                   : 'text-emerald-600'}">

							₹
							<c:out value="${remainingAmount}" default="0.00" />

						</h2>

					</div>

					<div
						class="w-14 h-14 rounded-xl
                                bg-emerald-100
                                flex items-center justify-center">

						<i
							class="fa-solid fa-piggy-bank
                                  text-emerald-600 text-2xl"></i>

					</div>

				</div>

			</div>


			<!-- USED -->

			<div class="bg-white rounded-xl shadow-lg p-6">

				<div class="flex items-center justify-between">

					<div>

						<p class="text-sm text-slate-500">Budget Used</p>

						<h2 class="text-3xl font-bold text-orange-500 mt-3">

							<c:out value="${budgetUsedPercentage}" default="0" />
							%

						</h2>

					</div>

					<div
						class="w-14 h-14 rounded-xl
                                bg-orange-100
                                flex items-center justify-center">

						<i
							class="fa-solid fa-chart-pie
                                  text-orange-500 text-2xl"></i>

					</div>

				</div>

			</div>

		</div>


		<!-- BUDGET PROGRESS -->

		<div class="bg-white rounded-xl shadow-lg p-6 mt-8">


			<div
				class="flex flex-col md:flex-row
                        md:items-center md:justify-between gap-4">

				<div>

					<h2 class="text-2xl font-bold text-slate-800">Budget Progress
					</h2>

					<p class="text-slate-500 mt-1">Your spending progress for the
						selected month.</p>

				</div>


				<!-- STATUS -->

				<c:choose>

					<c:when test="${budgetStatus eq 'ON TRACK'}">

						<span
							class="bg-emerald-100
                                     text-emerald-700
                                     px-4 py-2 rounded-full
                                     font-bold">

							<i class="fa-solid fa-circle-check mr-2"></i> ON TRACK

						</span>

					</c:when>


					<c:when test="${budgetStatus eq 'WARNING'}">

						<span
							class="bg-orange-100
                                     text-orange-700
                                     px-4 py-2 rounded-full
                                     font-bold">

							<i class="fa-solid fa-triangle-exclamation mr-2"></i> WARNING

						</span>

					</c:when>


					<c:when test="${budgetStatus eq 'CRITICAL'}">

						<span
							class="bg-red-100
                                     text-red-700
                                     px-4 py-2 rounded-full
                                     font-bold">

							<i class="fa-solid fa-triangle-exclamation mr-2"></i> CRITICAL

						</span>

					</c:when>


					<c:when test="${budgetStatus eq 'BUDGET EXCEEDED'}">

						<span
							class="bg-red-600
                                     text-white
                                     px-4 py-2 rounded-full
                                     font-bold">

							<i class="fa-solid fa-circle-exclamation mr-2"></i> BUDGET
							EXCEEDED

						</span>

					</c:when>


					<c:otherwise>

						<span
							class="bg-slate-100
                                     text-slate-600
                                     px-4 py-2 rounded-full
                                     font-bold">

							NO BUDGET </span>

					</c:otherwise>

				</c:choose>

			</div>


			<!-- VALUES -->

			<div
				class="flex justify-between mt-8 mb-3
                        text-sm text-slate-600">

				<span> ₹ <c:out value="${spentAmount}" default="0.00" />
					spent

				</span> <span> ₹ <c:out value="${budgetAmount}" default="0.00" />
					budget

				</span>

			</div>


			<!-- PROGRESS BAR -->

			<div
				class="w-full bg-slate-200
                        rounded-full h-5 overflow-hidden">

				<c:choose>


					<c:when
						test="${budgetStatus eq 'BUDGET EXCEEDED'
                                  || budgetStatus eq 'CRITICAL'}">

						<div
							class="bg-red-500 h-5 rounded-full
                                   transition-all duration-700"
							style="width:<c:out value='${progressPercentage}' default='0'/>%;">
						</div>

					</c:when>


					<c:when test="${budgetStatus eq 'WARNING'}">

						<div
							class="bg-orange-500 h-5 rounded-full
                                   transition-all duration-700"
							style="width:<c:out value='${progressPercentage}' default='0'/>%;">
						</div>

					</c:when>


					<c:otherwise>

						<div
							class="bg-emerald-500 h-5 rounded-full
                                   transition-all duration-700"
							style="width:<c:out value='${progressPercentage}' default='0'/>%;">
						</div>

					</c:otherwise>

				</c:choose>

			</div>


			<div class="flex justify-between mt-3">

				<span class="text-sm text-slate-500"> 0% </span> <span
					class="font-bold text-slate-700"> <c:out
						value="${budgetUsedPercentage}" default="0" />%

				</span> <span class="text-sm text-slate-500"> 100% </span>

			</div>


			<!-- EXCEEDED ALERT -->

			<c:if test="${budgetStatus eq 'BUDGET EXCEEDED'}">

				<div
					class="mt-6 bg-red-50
                            border border-red-200
                            rounded-xl p-5">

					<div class="flex gap-4">

						<i
							class="fa-solid fa-circle-exclamation
                                  text-red-600 text-2xl"></i>

						<div>

							<h3 class="font-bold text-red-700">Monthly budget exceeded</h3>

							<p class="text-red-600 mt-1">

								Your spending has exceeded the budget by <strong> ₹ <c:out
										value="${exceededAmount}" default="0.00" />
								</strong>.

							</p>

						</div>

					</div>

				</div>

			</c:if>

		</div>


		<!-- LOWER SECTION -->

		<div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mt-8">


			<!-- SET BUDGET -->

			<div class="bg-white rounded-xl shadow-lg p-8">

				<h2 class="text-2xl font-bold text-slate-800">Set Monthly
					Budget</h2>

				<p class="text-slate-500 mt-2">Create or update the spending
					limit for a month.</p>


				<form action="${pageContext.request.contextPath}/budget"
					method="post" class="space-y-6 mt-8">


					<div>

						<label
							class="block text-sm font-semibold
                                      text-slate-700 mb-2">

							Month </label> <select name="month" required
							class="w-full border border-slate-300
                                   rounded-lg px-4 py-3
                                   focus:outline-none
                                   focus:ring-2
                                   focus:ring-emerald-500">

							<option value="1"
								<c:if test="${budgetMonth == 1}">selected</c:if>>
								January</option>

							<option value="2"
								<c:if test="${budgetMonth == 2}">selected</c:if>>
								February</option>

							<option value="3"
								<c:if test="${budgetMonth == 3}">selected</c:if>>March
							</option>

							<option value="4"
								<c:if test="${budgetMonth == 4}">selected</c:if>>April
							</option>

							<option value="5"
								<c:if test="${budgetMonth == 5}">selected</c:if>>May</option>

							<option value="6"
								<c:if test="${budgetMonth == 6}">selected</c:if>>June</option>

							<option value="7"
								<c:if test="${budgetMonth == 7}">selected</c:if>>July</option>

							<option value="8"
								<c:if test="${budgetMonth == 8}">selected</c:if>>
								August</option>

							<option value="9"
								<c:if test="${budgetMonth == 9}">selected</c:if>>
								September</option>

							<option value="10"
								<c:if test="${budgetMonth == 10}">selected</c:if>>
								October</option>

							<option value="11"
								<c:if test="${budgetMonth == 11}">selected</c:if>>
								November</option>

							<option value="12"
								<c:if test="${budgetMonth == 12}">selected</c:if>>
								December</option>

						</select>

					</div>


					<div>

						<label
							class="block text-sm font-semibold
                                      text-slate-700 mb-2">

							Year </label> <input type="number" name="year" min="2000" max="2100"
							value="<c:out value='${budgetYear}'/>" required
							class="w-full border border-slate-300
                                   rounded-lg px-4 py-3
                                   focus:outline-none
                                   focus:ring-2
                                   focus:ring-emerald-500">

					</div>


					<div>

						<label
							class="block text-sm font-semibold
                                      text-slate-700 mb-2">

							Budget Amount </label>

						<div class="relative">

							<span
								class="absolute left-4 top-3
                                         font-semibold text-slate-500">
								₹ </span> <input type="number" name="amount" min="0.01" step="0.01"
								value="<c:out value='${budgetAmount}' default='0.00'/>" required
								class="w-full border border-slate-300
                                       rounded-lg pl-9 pr-4 py-3
                                       focus:outline-none
                                       focus:ring-2
                                       focus:ring-emerald-500">

						</div>

					</div>


					<button type="submit"
						class="w-full bg-emerald-600
                               hover:bg-emerald-700
                               text-white font-semibold
                               py-3 rounded-lg transition">

						<i class="fa-solid fa-floppy-disk mr-2"></i> Save Budget

					</button>

				</form>

			</div>


			<!-- BUDGET INTELLIGENCE -->

			<div class="bg-white rounded-xl shadow-lg p-8">

				<h2 class="text-2xl font-bold text-slate-800">Budget
					Intelligence</h2>

				<p class="text-slate-500 mt-2">Understand your current spending
					position.</p>


				<div class="space-y-5 mt-8">


					<c:if test="${budgetStatus eq 'ON TRACK'}">

						<div
							class="bg-emerald-50
                                    border-l-4 border-emerald-500
                                    rounded-lg p-5">

							<h3 class="font-bold text-emerald-700">

								<i class="fa-solid fa-circle-check mr-2"></i> Spending is on
								track

							</h3>

							<p class="text-slate-700 mt-2">

								You have used <strong> <c:out
										value="${budgetUsedPercentage}" default="0" />%
								</strong> of your monthly budget and have <strong> ₹ <c:out
										value="${remainingAmount}" default="0.00" />
								</strong> remaining.

							</p>

						</div>

					</c:if>


					<c:if test="${budgetStatus eq 'WARNING'}">

						<div
							class="bg-orange-50
                                    border-l-4 border-orange-500
                                    rounded-lg p-5">

							<h3 class="font-bold text-orange-700">Spending is getting
								high</h3>

							<p class="text-slate-700 mt-2">

								You have used <strong> <c:out
										value="${budgetUsedPercentage}" default="0" />%
								</strong> of your monthly budget.

							</p>

						</div>

					</c:if>


					<c:if test="${budgetStatus eq 'CRITICAL'}">

						<div
							class="bg-red-50
                                    border-l-4 border-red-500
                                    rounded-lg p-5">

							<h3 class="font-bold text-red-700">Budget is nearly
								exhausted</h3>

							<p class="text-slate-700 mt-2">

								Only <strong> ₹ <c:out value="${remainingAmount}"
										default="0.00" />
								</strong> remains from your monthly budget.

							</p>

						</div>

					</c:if>


					<c:if test="${budgetStatus eq 'BUDGET EXCEEDED'}">

						<div
							class="bg-red-50
                                    border-l-4 border-red-600
                                    rounded-lg p-5">

							<h3 class="font-bold text-red-700">Overspending detected</h3>

							<p class="text-slate-700 mt-2">

								You have exceeded your monthly budget by <strong> ₹ <c:out
										value="${exceededAmount}" default="0.00" />
								</strong>.

							</p>

						</div>

					</c:if>


					<c:if test="${budgetStatus eq 'NO BUDGET'}">

						<div
							class="bg-slate-50
                                    border-l-4 border-slate-400
                                    rounded-lg p-5">

							<h3 class="font-bold text-slate-700">No monthly budget
								configured</h3>

							<p class="text-slate-600 mt-2">Set a budget to enable
								spending analysis.</p>

						</div>

					</c:if>


					<!-- STATUS LEVELS -->

					<div class="border border-slate-200 rounded-xl p-5">

						<h3 class="font-bold text-slate-800">Budget Status Levels</h3>


						<div class="space-y-4 mt-5">

							<div class="flex justify-between">

								<span class="text-emerald-600 font-semibold"> On Track </span> <span
									class="text-slate-500"> Below 70% </span>

							</div>


							<div class="flex justify-between">

								<span class="text-orange-600 font-semibold"> Warning </span> <span
									class="text-slate-500"> 70% - 89.9% </span>

							</div>


							<div class="flex justify-between">

								<span class="text-red-500 font-semibold"> Critical </span> <span
									class="text-slate-500"> 90% - 99.9% </span>

							</div>


							<div class="flex justify-between">

								<span class="text-red-700 font-semibold"> Exceeded </span> <span
									class="text-slate-500"> 100%+ </span>

							</div>

						</div>

					</div>

				</div>

			</div>

		</div>

	</div>
	<%@ include file="/WEB-INF/views/layout/footer.jspf"%>
</div>

</body>
</html>