<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="activePage" value="dashboard" />
<%@ include file="/WEB-INF/views/layout/header.jspf"%>
<%@ include file="/WEB-INF/views/layout/sidebar.jspf"%>

<div class="flex-1 overflow-y-auto bg-slate-50 min-h-screen">

	<!-- ====================================================== -->
	<!-- DASHBOARD HEADER -->
	<!-- ====================================================== -->

	<div class="bg-white border-b border-slate-200">

		<div class="px-8 py-6">

			<div
				class="flex flex-col md:flex-row md:items-center md:justify-between gap-4">

				<div>

					<h1 class="text-3xl font-bold text-slate-900">Dashboard</h1>

					<p class="text-sm text-slate-500 mt-1">

						Welcome back, <span class="font-semibold text-slate-700"> <c:out
								value="${sessionScope.user.name}" />
						</span>

					</p>

				</div>

				<div class="flex items-center gap-3">

					<a href="${pageContext.request.contextPath}/expenses"
						class="inline-flex items-center gap-2
                              px-4 py-2.5
                              bg-emerald-600
                              hover:bg-emerald-700
                              text-white text-sm font-semibold
                              rounded-lg transition">

						<i class="fa-solid fa-plus"></i> Add Expense

					</a>

				</div>

			</div>

		</div>

	</div>


	<!-- ====================================================== -->
	<!-- DASHBOARD CONTENT -->
	<!-- ====================================================== -->

	<div class="p-6 lg:p-8">

		<div class="max-w-[1600px] mx-auto">


			<!-- ================================================== -->
			<!-- SUMMARY CARDS -->
			<!-- ================================================== -->

			<div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-5">


				<!-- TOTAL SPENT -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl p-5 shadow-sm
                            min-h-[145px]">

					<div class="flex items-start justify-between h-full">

						<div class="flex flex-col justify-between h-full">

							<div>

								<p class="text-sm font-medium text-slate-500">Total Spent</p>

								<h2 class="text-2xl font-bold text-slate-900 mt-3">

									₹
									<c:out value="${totalSpent}" default="0.00" />

								</h2>

							</div>

							<p class="text-xs text-slate-400 mt-4">Total spending this
								month</p>

						</div>


						<div
							class="w-11 h-11 rounded-xl
                                    bg-red-50
                                    flex items-center justify-center
                                    shrink-0">

							<i
								class="fa-solid fa-wallet
                                      text-red-500 text-lg"></i>

						</div>

					</div>

				</div>


				<!-- MONTHLY BUDGET -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl p-5 shadow-sm
                            min-h-[145px]">

					<div class="flex items-start justify-between h-full">

						<div class="flex flex-col justify-between h-full">

							<div>

								<p class="text-sm font-medium text-slate-500">Monthly Budget
								</p>

								<h2 class="text-2xl font-bold text-slate-900 mt-3">

									₹
									<c:out value="${budgetAmount}" default="0.00" />

								</h2>

							</div>

							<p class="text-xs text-slate-400 mt-4">Your monthly spending
								limit</p>

						</div>


						<div
							class="w-11 h-11 rounded-xl
                                    bg-blue-50
                                    flex items-center justify-center
                                    shrink-0">

							<i
								class="fa-solid fa-credit-card
                                      text-blue-600 text-lg"></i>

						</div>

					</div>

				</div>


				<!-- REMAINING -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl p-5 shadow-sm
                            min-h-[145px]">

					<div class="flex items-start justify-between h-full">

						<div class="flex flex-col justify-between h-full">

							<div>

								<p class="text-sm font-medium text-slate-500">Remaining</p>


								<c:choose>

									<c:when test="${remainingBudget < 0}">

										<h2 class="text-2xl font-bold text-red-600 mt-3">

											₹
											<c:out value="${remainingBudget}" />

										</h2>

									</c:when>

									<c:otherwise>

										<h2 class="text-2xl font-bold text-emerald-600 mt-3">

											₹
											<c:out value="${remainingBudget}" default="0.00" />

										</h2>

									</c:otherwise>

								</c:choose>

							</div>

							<p class="text-xs text-slate-400 mt-4">Available from your
								budget</p>

						</div>


						<div
							class="w-11 h-11 rounded-xl
                                    bg-emerald-50
                                    flex items-center justify-center
                                    shrink-0">

							<i
								class="fa-solid fa-piggy-bank
                                      text-emerald-600 text-lg"></i>

						</div>

					</div>

				</div>


				<!-- BUDGET USED -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl p-5 shadow-sm
                            min-h-[145px]">

					<div class="flex items-start justify-between h-full">

						<div class="flex flex-col justify-between h-full">

							<div>

								<p class="text-sm font-medium text-slate-500">Budget Used</p>

								<h2 class="text-2xl font-bold text-slate-900 mt-3">

									<c:out value="${budgetUsedPercentage}" default="0" />
									%

								</h2>

							</div>

							<p class="text-xs text-slate-400 mt-4">Percentage of budget
								consumed</p>

						</div>


						<div
							class="w-11 h-11 rounded-xl
                                    bg-orange-50
                                    flex items-center justify-center
                                    shrink-0">

							<i
								class="fa-solid fa-chart-pie
                                      text-orange-500 text-lg"></i>

						</div>

					</div>

				</div>

			</div>


			<!-- ================================================== -->
			<!-- BUDGET PROGRESS -->
			<!-- ================================================== -->

			<div
				class="bg-white border border-slate-200
                        rounded-2xl shadow-sm p-6 mt-6">

				<div
					class="flex flex-col sm:flex-row
                            sm:items-center sm:justify-between
                            gap-3">

					<div>

						<h2 class="text-xl font-bold text-slate-900">Budget Progress
						</h2>

						<p class="text-sm text-slate-500 mt-1">Track your spending
							against this month's budget.</p>

					</div>


					<div class="flex items-center gap-2">

						<span class="text-sm text-slate-500"> Used </span>


						<c:choose>

							<c:when test="${budgetUsedPercentage >= 100}">

								<span
									class="px-3 py-1
                                             bg-red-50 text-red-600
                                             text-sm font-bold rounded-full">

									${budgetUsedPercentage}% </span>

							</c:when>


							<c:when test="${budgetUsedPercentage >= 70}">

								<span
									class="px-3 py-1
                                             bg-orange-50 text-orange-600
                                             text-sm font-bold rounded-full">

									${budgetUsedPercentage}% </span>

							</c:when>


							<c:otherwise>

								<span
									class="px-3 py-1
                                             bg-emerald-50 text-emerald-600
                                             text-sm font-bold rounded-full">

									${budgetUsedPercentage}% </span>

							</c:otherwise>

						</c:choose>

					</div>

				</div>


				<!-- PROGRESS BAR -->

				<div class="mt-6">

					<div
						class="w-full h-3 bg-slate-100
                                rounded-full overflow-hidden">

						<c:choose>

							<c:when test="${budgetUsedPercentage >= 100}">

								<div
									class="h-full bg-red-500 rounded-full
                                            transition-all duration-700"
									style="width:${budgetProgressPercentage}%"></div>

							</c:when>


							<c:when test="${budgetUsedPercentage >= 70}">

								<div
									class="h-full bg-orange-500 rounded-full
                                            transition-all duration-700"
									style="width:${budgetProgressPercentage}%"></div>

							</c:when>


							<c:otherwise>

								<div
									class="h-full bg-emerald-500 rounded-full
                                            transition-all duration-700"
									style="width:${budgetProgressPercentage}%"></div>

							</c:otherwise>

						</c:choose>

					</div>

				</div>


				<!-- SPENT / REMAINING / BUDGET -->

				<div class="grid grid-cols-1 sm:grid-cols-3 gap-4 mt-6">


					<div
						class="bg-slate-50 border border-slate-100
                                rounded-xl p-4">

						<div class="flex items-center justify-between">

							<p
								class="text-xs font-medium
                                      uppercase tracking-wide
                                      text-slate-500">

								Spent</p>

							<i
								class="fa-solid fa-arrow-trend-up
                                      text-red-400"></i>

						</div>

						<p class="text-xl font-bold text-red-600 mt-2">

							₹
							<c:out value="${spentAmount}" default="0.00" />

						</p>

					</div>


					<div
						class="bg-slate-50 border border-slate-100
                                rounded-xl p-4">

						<div class="flex items-center justify-between">

							<p
								class="text-xs font-medium
                                      uppercase tracking-wide
                                      text-slate-500">

								Remaining</p>

							<i
								class="fa-solid fa-piggy-bank
                                      text-emerald-500"></i>

						</div>


						<c:choose>

							<c:when test="${remainingBudget < 0}">

								<p class="text-xl font-bold text-red-600 mt-2">

									₹
									<c:out value="${remainingBudget}" />

								</p>

							</c:when>

							<c:otherwise>

								<p class="text-xl font-bold text-emerald-600 mt-2">

									₹
									<c:out value="${remainingBudget}" default="0.00" />

								</p>

							</c:otherwise>

						</c:choose>

					</div>


					<div
						class="bg-slate-50 border border-slate-100
                                rounded-xl p-4">

						<div class="flex items-center justify-between">

							<p
								class="text-xs font-medium
                                      uppercase tracking-wide
                                      text-slate-500">

								Budget</p>

							<i
								class="fa-solid fa-wallet
                                      text-blue-500"></i>

						</div>

						<p class="text-xl font-bold text-blue-600 mt-2">

							₹
							<c:out value="${budgetAmount}" default="0.00" />

						</p>

					</div>

				</div>

			</div>
			<!-- ================================================== -->
			<!-- MONTHLY COMPARISON -->
			<!-- ================================================== -->

			<div
				class="bg-white border border-slate-200
                        rounded-2xl shadow-sm p-6 mt-6">

				<div
					class="flex flex-col lg:flex-row
                            lg:items-center lg:justify-between
                            gap-4">

					<div>

						<h2 class="text-xl font-bold text-slate-900">Monthly
							Comparison</h2>

						<p class="text-sm text-slate-500 mt-1">Compare this month's
							spending with the previous month.</p>

					</div>


					<c:choose>

						<c:when test="${spendingTrend eq 'INCREASED'}">

							<span
								class="inline-flex items-center gap-2
                                         self-start
                                         px-3 py-1.5
                                         bg-red-50 text-red-600
                                         text-sm font-semibold rounded-full">

								<i class="fa-solid fa-arrow-trend-up"></i> Spending Increased

							</span>

						</c:when>


						<c:when test="${spendingTrend eq 'DECREASED'}">

							<span
								class="inline-flex items-center gap-2
                                         self-start
                                         px-3 py-1.5
                                         bg-emerald-50 text-emerald-600
                                         text-sm font-semibold rounded-full">

								<i class="fa-solid fa-arrow-trend-down"></i> Spending Decreased

							</span>

						</c:when>


						<c:when test="${spendingTrend eq 'NEW_SPENDING'}">

							<span
								class="inline-flex items-center gap-2
                                         self-start
                                         px-3 py-1.5
                                         bg-blue-50 text-blue-600
                                         text-sm font-semibold rounded-full">

								<i class="fa-solid fa-circle-info"></i> New Spending

							</span>

						</c:when>


						<c:otherwise>

							<span
								class="inline-flex items-center gap-2
                                         self-start
                                         px-3 py-1.5
                                         bg-slate-100 text-slate-600
                                         text-sm font-semibold rounded-full">

								<i class="fa-solid fa-minus"></i> No Change

							</span>

						</c:otherwise>

					</c:choose>

				</div>


				<!-- COMPARISON METRICS -->

				<div
					class="grid grid-cols-1 sm:grid-cols-2
                            xl:grid-cols-4 gap-4 mt-6">


					<!-- CURRENT MONTH -->

					<div
						class="bg-slate-50 border border-slate-200
                                rounded-xl p-5 min-h-[150px]
                                flex flex-col justify-between">

						<div>

							<div class="flex items-center justify-between gap-3">

								<p
									class="text-xs font-medium uppercase
                                          tracking-wide text-slate-500">
									Current Month</p>

								<div
									class="w-8 h-8 rounded-lg
                                            bg-blue-100
                                            flex items-center justify-center">

									<i
										class="fa-solid fa-calendar-day
                                              text-blue-600 text-sm"></i>

								</div>

							</div>


							<p class="font-semibold text-slate-800 mt-3">

								<c:out value="${selectedMonthName}" />
								<c:out value="${selectedYear}" />

							</p>

						</div>


						<p class="text-2xl font-bold text-blue-600 mt-5">

							₹
							<c:out value="${currentMonthSpent}" default="0.00" />

						</p>

					</div>


					<!-- PREVIOUS MONTH -->

					<div
						class="bg-slate-50 border border-slate-200
                                rounded-xl p-5 min-h-[150px]
                                flex flex-col justify-between">

						<div>

							<div class="flex items-center justify-between gap-3">

								<p
									class="text-xs font-medium uppercase
                                          tracking-wide text-slate-500">
									Previous Month</p>

								<div
									class="w-8 h-8 rounded-lg
                                            bg-slate-200
                                            flex items-center justify-center">

									<i
										class="fa-solid fa-calendar
                                              text-slate-600 text-sm"></i>

								</div>

							</div>


							<p class="font-semibold text-slate-800 mt-3">

								<c:out value="${previousMonthName}" />
								<c:out value="${previousMonthYear}" />

							</p>

						</div>


						<p class="text-2xl font-bold text-slate-800 mt-5">

							₹
							<c:out value="${previousMonthSpent}" default="0.00" />

						</p>

					</div>


					<!-- DIFFERENCE -->

					<div
						class="bg-slate-50 border border-slate-200
                                rounded-xl p-5 min-h-[150px]
                                flex flex-col justify-between">

						<div class="flex items-center justify-between gap-3">

							<p
								class="text-xs font-medium uppercase
                                      tracking-wide text-slate-500">
								Difference</p>

							<div
								class="w-8 h-8 rounded-lg
                                        bg-violet-100
                                        flex items-center justify-center">

								<i
									class="fa-solid fa-code-compare
                                          text-violet-600 text-sm"></i>

							</div>

						</div>


						<c:choose>

							<c:when test="${spendingDifference > 0}">

								<div class="mt-5">

									<p
										class="text-2xl font-bold text-red-600
                                              break-words">

										+₹
										<c:out value="${spendingDifference}" />

									</p>

									<p class="text-xs text-red-500 mt-2">More than previous
										month</p>

								</div>

							</c:when>


							<c:when test="${spendingDifference < 0}">

								<div class="mt-5">

									<p
										class="text-2xl font-bold
                                              text-emerald-600 break-words">

										₹
										<c:out value="${spendingDifference}" />

									</p>

									<p class="text-xs text-emerald-600 mt-2">Less than previous
										month</p>

								</div>

							</c:when>


							<c:otherwise>

								<div class="mt-5">

									<p class="text-2xl font-bold text-slate-700">₹ 0.00</p>

									<p class="text-xs text-slate-400 mt-2">No difference</p>

								</div>

							</c:otherwise>

						</c:choose>

					</div>


					<!-- SPENDING CHANGE -->

					<div
						class="bg-slate-50 border border-slate-200
                                rounded-xl p-5 min-h-[150px]
                                flex flex-col justify-between">

						<div class="flex items-center justify-between gap-3">

							<p
								class="text-xs font-medium uppercase
                                      tracking-wide text-slate-500">
								Spending Change</p>

							<div
								class="w-8 h-8 rounded-lg
                                        bg-orange-100
                                        flex items-center justify-center">

								<i
									class="fa-solid fa-chart-line
                                          text-orange-500 text-sm"></i>

							</div>

						</div>


						<c:choose>

							<c:when test="${spendingTrend eq 'INCREASED'}">

								<div class="mt-5">

									<p class="text-2xl font-bold text-red-600">

										<i
											class="fa-solid fa-arrow-up
                                                  text-base mr-1"></i>

										<c:out value="${spendingChangePercentage}" />
										%

									</p>

									<p class="text-xs text-red-500 mt-2">Spending increased</p>

								</div>

							</c:when>


							<c:when test="${spendingTrend eq 'DECREASED'}">

								<div class="mt-5">

									<p
										class="text-2xl font-bold
                                              text-emerald-600">

										<i
											class="fa-solid fa-arrow-down
                                                  text-base mr-1"></i>

										<c:out value="${-spendingChangePercentage}" />
										%

									</p>

									<p class="text-xs text-emerald-600 mt-2">Spending decreased
									</p>

								</div>

							</c:when>


							<c:when test="${spendingTrend eq 'NEW_SPENDING'}">

								<div class="mt-5">

									<p class="text-xl font-bold text-blue-600">New Activity</p>

									<p class="text-xs text-blue-500 mt-2">No previous spending
									</p>

								</div>

							</c:when>


							<c:otherwise>

								<div class="mt-5">

									<p class="text-2xl font-bold text-slate-700">0%</p>

									<p class="text-xs text-slate-400 mt-2">No change</p>

								</div>

							</c:otherwise>

						</c:choose>

					</div>

				</div>


				<!-- COMPARISON INSIGHT -->

				<div class="mt-5">

					<c:choose>

						<c:when test="${spendingTrend eq 'INCREASED'}">

							<div
								class="flex items-start gap-3
                                        bg-red-50 border border-red-100
                                        rounded-xl p-4">

								<div
									class="w-9 h-9 rounded-lg bg-red-100
                                            flex items-center justify-center
                                            shrink-0">

									<i
										class="fa-solid fa-arrow-trend-up
                                              text-red-600"></i>

								</div>


								<div>

									<p class="font-semibold text-red-700">Spending increased</p>

									<p class="text-sm text-slate-600 mt-1">

										You spent <span class="font-semibold text-slate-800"> ₹
											<c:out value="${spendingDifference}" />
										</span> more than

										<c:out value="${previousMonthName}" />
										. That's an increase of <span
											class="font-semibold text-red-600"> <c:out
												value="${spendingChangePercentage}" />%
										</span>.

									</p>

								</div>

							</div>

						</c:when>


						<c:when test="${spendingTrend eq 'DECREASED'}">

							<div
								class="flex items-start gap-3
                                        bg-emerald-50
                                        border border-emerald-100
                                        rounded-xl p-4">

								<div
									class="w-9 h-9 rounded-lg
                                            bg-emerald-100
                                            flex items-center justify-center
                                            shrink-0">

									<i
										class="fa-solid fa-arrow-trend-down
                                              text-emerald-600"></i>

								</div>


								<div>

									<p class="font-semibold text-emerald-700">Spending
										decreased</p>

									<p class="text-sm text-slate-600 mt-1">

										Your spending is <span class="font-semibold text-emerald-600">
											<c:out value="${-spendingChangePercentage}" />%
										</span> lower than

										<c:out value="${previousMonthName}" />
										.

									</p>

								</div>

							</div>

						</c:when>


						<c:when test="${spendingTrend eq 'NEW_SPENDING'}">

							<div
								class="flex items-start gap-3
                                        bg-blue-50 border border-blue-100
                                        rounded-xl p-4">

								<div
									class="w-9 h-9 rounded-lg bg-blue-100
                                            flex items-center justify-center
                                            shrink-0">

									<i
										class="fa-solid fa-circle-info
                                              text-blue-600"></i>

								</div>


								<div>

									<p class="font-semibold text-blue-700">No previous spending
										to compare</p>

									<p class="text-sm text-slate-600 mt-1">

										No expenses were recorded in

										<c:out value="${previousMonthName}" />
										. Spending for

										<c:out value="${selectedMonthName}" />

										is currently <span class="font-semibold text-slate-800">
											₹ <c:out value="${currentMonthSpent}" />
										</span>.

									</p>

								</div>

							</div>

						</c:when>


						<c:otherwise>

							<div
								class="flex items-start gap-3
                                        bg-slate-50 border border-slate-200
                                        rounded-xl p-4">

								<div
									class="w-9 h-9 rounded-lg bg-slate-200
                                            flex items-center justify-center
                                            shrink-0">

									<i
										class="fa-solid fa-minus
                                              text-slate-600"></i>

								</div>

								<div>

									<p class="font-semibold text-slate-700">Spending remained
										unchanged</p>

									<p class="text-sm text-slate-500 mt-1">Spending is the same
										as the previous month.</p>

								</div>

							</div>

						</c:otherwise>

					</c:choose>

				</div>

			</div>

			<!-- ================================================== -->

			<!-- ANALYTICS CHARTS -->

			<!-- ================================================== -->

			<div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mt-6">
			
			
							<!-- ================================================== -->
							<!-- EXPENSE BY CATEGORY -->
							<!-- ================================================== -->
			
							<div
								class="bg-white border border-slate-200
			                            rounded-2xl shadow-sm p-6">
			
								<div class="flex items-start justify-between gap-4">
			
									<div>
			
										<h2 class="text-xl font-bold text-slate-900">Expense By
											Category</h2>
			
										<p class="text-sm text-slate-500 mt-1">See where most of your
											money is being spent.</p>
			
									</div>
			
			
									<div
										class="w-10 h-10 rounded-xl
			                                    bg-violet-50
			                                    flex items-center justify-center
			                                    shrink-0">
			
										<i
											class="fa-solid fa-chart-pie
			                                      text-violet-600"></i>
			
									</div>
			
								</div>
			
			
								<c:choose>
			
									<c:when test="${empty categoryExpense}">
			
										<div
											class="h-[360px]
			                                        flex flex-col
			                                        items-center justify-center
			                                        text-center">
			
											<div
												class="w-14 h-14
			                                            rounded-xl bg-slate-100
			                                            flex items-center justify-center">
			
												<i
													class="fa-solid fa-chart-pie
			                                              text-slate-400 text-xl"></i>
			
											</div>
			
											<p
												class="font-semibold
			                                          text-slate-700 mt-4">
												No category data</p>
			
											<p class="text-sm text-slate-400 mt-1">Add expenses to see
												your spending distribution.</p>
			
										</div>
			
									</c:when>
			
			
									<c:otherwise>
			
										<div class="relative h-[360px] mt-6">
			
											<canvas id="expenseChart"></canvas>
			
										</div>
			
									</c:otherwise>
			
								</c:choose>
			
							</div>
			
			
							<!-- ================================================== -->
							<!-- MONTHLY EXPENSE TREND -->
							<!-- ================================================== -->
			
							<div
								class="bg-white border border-slate-200
			                            rounded-2xl shadow-sm p-6">
			
								<div class="flex items-start justify-between gap-4">
			
									<div>
			
										<h2 class="text-xl font-bold text-slate-900">Monthly Expense
											Trend</h2>
			
										<p class="text-sm text-slate-500 mt-1">Track how your
											spending changes over time.</p>
			
									</div>
			
			
									<div
										class="w-10 h-10 rounded-xl
			                                    bg-emerald-50
			                                    flex items-center justify-center
			                                    shrink-0">
			
										<i
											class="fa-solid fa-chart-line
			                                      text-emerald-600"></i>
			
									</div>
			
								</div>
			
			
								<c:choose>
			
									<c:when test="${empty monthlyTrend}">
			
										<div
											class="h-[360px]
			                                        flex flex-col
			                                        items-center justify-center
			                                        text-center">
			
											<div
												class="w-14 h-14
			                                            rounded-xl bg-slate-100
			                                            flex items-center justify-center">
			
												<i
													class="fa-solid fa-chart-line
			                                              text-slate-400 text-xl"></i>
			
											</div>
			
											<p
												class="font-semibold
			                                          text-slate-700 mt-4">
												No trend data</p>
			
											<p class="text-sm text-slate-400 mt-1">Monthly spending
												history will appear here.</p>
			
										</div>
			
									</c:when>
			
			
									<c:otherwise>
			
										<div class="relative h-[360px] mt-6">
			
											<canvas id="trendChart"></canvas>
			
										</div>
			
									</c:otherwise>
			
								</c:choose>
			
							</div>
			
						</div>
			
			
						<!-- ================================================== -->
						<!-- CHART.JS -->
						<!-- ================================================== -->
			
						<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
			
						<script>
			
			                /* ==================================================
			                   CATEGORY PIE CHART
			                   ================================================== */
			
			                const expenseCanvas =
			                    document.getElementById("expenseChart");
			
			
			                if (expenseCanvas) {
			
			                    const expenseCtx =
			                        expenseCanvas.getContext("2d");
			
			
			                    new Chart(expenseCtx, {
			
			                        type: "doughnut",
			
			                        data: {
			
			                            labels: [
			
			                                <c:forEach
			                                    var="entry"
			                                    items="${categoryExpense}"
			                                    varStatus="status">
			
			                                    '<c:out value="${entry.key}"/>'
			
			                                    <c:if test="${!status.last}">
			                                        ,
			                                    </c:if>
			
			                                </c:forEach>
			
			                            ],
			
			
			                            datasets: [{
			
			                                data: [
			
			                                    <c:forEach
			                                        var="entry"
			                                        items="${categoryExpense}"
			                                        varStatus="status">
			
			                                        ${entry.value}
			
			                                        <c:if test="${!status.last}">
			                                            ,
			                                        </c:if>
			
			                                    </c:forEach>
			
			                                ],
			
			                                backgroundColor: [
			
			                                    "#3B82F6",
			                                    "#10B981",
			                                    "#F59E0B",
			                                    "#EF4444",
			                                    "#8B5CF6",
			                                    "#14B8A6",
			                                    "#EC4899",
			                                    "#6366F1"
			
			                                ],
			
			                                borderColor: "#FFFFFF",
			
			                                borderWidth: 3,
			
			                                hoverOffset: 8
			
			                            }]
			
			                        },
			
			
			                        options: {
			
			                            responsive: true,
			
			                            maintainAspectRatio: false,
			
			                            cutout: "64%",
			
			                            interaction: {
			
			                                mode: "nearest",
			
			                                intersect: true
			
			                            },
			
			
			                            plugins: {
			
			                                legend: {
			
			                                    position: "bottom",
			
			                                    labels: {
			
			                                        usePointStyle: true,
			
			                                        pointStyle: "circle",
			
			                                        padding: 18,
			
			                                        boxWidth: 8,
			
			                                        boxHeight: 8,
			
			                                        color: "#64748B",
			
			                                        font: {
			
			                                            size: 12
			
			                                        }
			
			                                    }
			
			                                },
			
			
			                                tooltip: {
			
			                                    displayColors: true,
			
			                                    callbacks: {
			
			                                        label: function(context) {
			
			                                            const value =
			                                                Number(context.raw || 0);
			
			                                            const values =
			                                                context.dataset.data;
			
			                                            const total =
			                                                values.reduce(
			                                                    (sum, item) =>
			                                                        sum + Number(item || 0),
			                                                    0
			                                                );
			
			                                            const percentage =
			                                                total > 0
			                                                    ? ((value / total) * 100)
			                                                        .toFixed(1)
			                                                    : "0.0";
			
			
			                                            return " ₹ "
			                                                + value.toLocaleString(
			                                                    "en-IN",
			                                                    {
			                                                        minimumFractionDigits: 2,
			                                                        maximumFractionDigits: 2
			                                                    }
			                                                )
			                                                + "  ("
			                                                + percentage
			                                                + "%)";
			                                        }
			
			                                    }
			
			                                }
			
			                            }
			
			                        }
			
			                    });
			
			                }
			
			
			                /* ==================================================
			                   MONTHLY TREND CHART
			                   ================================================== */
			
			                const trendCanvas =
			                    document.getElementById("trendChart");
			
			
			                if (trendCanvas) {
			
			                    const trendCtx =
			                        trendCanvas.getContext("2d");
			
			
			                    const trendGradient =
			                        trendCtx.createLinearGradient(
			                            0,
			                            0,
			                            0,
			                            360
			                        );
			
			
			                    trendGradient.addColorStop(
			                        0,
			                        "rgba(16, 185, 129, 0.25)"
			                    );
			
			                    trendGradient.addColorStop(
			                        1,
			                        "rgba(16, 185, 129, 0.01)"
			                    );
			
			
			                    new Chart(trendCtx, {
			
			                        type: "line",
			
			                        data: {
			
			                            labels: [
			
			                                <c:forEach
			                                    var="entry"
			                                    items="${monthlyTrend}"
			                                    varStatus="status">
			
			                                    '${entry.key}'
			
			                                    <c:if test="${!status.last}">
			                                        ,
			                                    </c:if>
			
			                                </c:forEach>
			
			                            ],
			
			
			                            datasets: [{
			
			                                label: "Monthly Spending",
			
			                                data: [
			
			                                    <c:forEach
			                                        var="entry"
			                                        items="${monthlyTrend}"
			                                        varStatus="status">
			
			                                        ${entry.value}
			
			                                        <c:if test="${!status.last}">
			                                            ,
			                                        </c:if>
			
			                                    </c:forEach>
			
			                                ],
			
			                                borderColor: "#10B981",
			
			                                backgroundColor: trendGradient,
			
			                                borderWidth: 3,
			
			                                fill: true,
			
			                                tension: 0.35,
			
			                                pointRadius: 4,
			
			                                pointHoverRadius: 6,
			
			                                pointBackgroundColor: "#FFFFFF",
			
			                                pointBorderColor: "#10B981",
			
			                                pointBorderWidth: 3
			
			                            }]
			
			                        },
			
			
			                        options: {
			
			                            responsive: true,
			
			                            maintainAspectRatio: false,
			
			
			                            interaction: {
			
			                                mode: "index",
			
			                                intersect: false
			
			                            },
			
			
			                            plugins: {
			
			                                legend: {
			
			                                    display: false
			
			                                },
			
			
			                                tooltip: {
			
			                                    callbacks: {
			
			                                        label: function(context) {
			
			                                            const value =
			                                                Number(context.raw || 0);
			
			                                            return " ₹ "
			                                                + value.toLocaleString(
			                                                    "en-IN",
			                                                    {
			                                                        minimumFractionDigits: 2,
			                                                        maximumFractionDigits: 2
			                                                    }
			                                                );
			                                        }
			
			                                    }
			
			                                }
			
			                            },
			
			
			                            scales: {
			
			                                x: {
			
			                                    grid: {
			
			                                        display: false
			
			                                    },
			
			                                    border: {
			
			                                        display: false
			
			                                    },
			
			                                    ticks: {
			
			                                        color: "#64748B",
			
			                                        font: {
			
			                                            size: 11
			
			                                        }
			
			                                    }
			
			                                },
			
			
			                                y: {
			
			                                    beginAtZero: true,
			
			                                    border: {
			
			                                        display: false
			
			                                    },
			
			                                    grid: {
			
			                                        color: "#F1F5F9"
			
			                                    },
			
			                                    ticks: {
			
			                                        color: "#64748B",
			
			                                        padding: 8,
			
			                                        callback: function(value) {
			
			                                            return "₹"
			                                                + Number(value)
			                                                    .toLocaleString("en-IN");
			
			                                        }
			
			                                    }
			
			                                }
			
			                            }
			
			                        }
			
			                    });
			
			                }
			
			            </script>


			<!-- ================================================== -->
			<!-- RECENT EXPENSES -->
			<!-- ================================================== -->

			<div
				class="bg-white border border-slate-200
                        rounded-2xl shadow-sm mt-6 overflow-hidden">

				<div
					class="flex items-center justify-between
                            gap-4 px-6 py-5
                            border-b border-slate-200">

					<div>

						<h2 class="text-xl font-bold text-slate-900">Recent Expenses
						</h2>

						<p class="text-sm text-slate-500 mt-1">Your latest recorded
							transactions.</p>

					</div>


					<a href="${pageContext.request.contextPath}/expenses"
						class="inline-flex items-center gap-2
                              text-sm font-semibold text-emerald-600
                              hover:text-emerald-700 transition">

						View All <i class="fa-solid fa-arrow-right text-xs"></i>

					</a>

				</div>


				<div class="overflow-x-auto">

					<table class="w-full">

						<thead class="bg-slate-50">

							<tr
								class="text-xs uppercase tracking-wide
                                       text-slate-500">

								<th class="px-6 py-4 text-left font-semibold">Expense</th>

								<th class="px-6 py-4 text-left font-semibold">Category</th>

								<th class="px-6 py-4 text-left font-semibold">Date</th>

								<th class="px-6 py-4 text-right font-semibold">Amount</th>

							</tr>

						</thead>


						<tbody class="divide-y divide-slate-100">

							<c:choose>

								<c:when test="${empty recentExpenses}">

									<tr>

										<td colspan="4" class="px-6 py-14 text-center">

											<div
												class="w-12 h-12 mx-auto
                                                        rounded-xl bg-slate-100
                                                        flex items-center justify-center">

												<i
													class="fa-solid fa-receipt
                                                          text-slate-400 text-xl"></i>

											</div>

											<p
												class="font-semibold
                                                      text-slate-700 mt-3">
												No recent expenses</p>

											<p class="text-sm text-slate-400 mt-1">Your latest
												expenses will appear here.</p>

										</td>

									</tr>

								</c:when>


								<c:otherwise>

									<c:forEach var="expense" items="${recentExpenses}">

										<tr
											class="hover:bg-slate-50
                                                   transition-colors">

											<td class="px-6 py-4">

												<div class="flex items-center gap-3">

													<div
														class="w-9 h-9
                                                                rounded-lg
                                                                bg-slate-100
                                                                flex items-center
                                                                justify-center
                                                                shrink-0">

														<i
															class="fa-solid fa-receipt
                                                                  text-slate-500
                                                                  text-sm"></i>

													</div>


													<span
														class="font-semibold
                                                                 text-slate-800">

														<c:out value="${expense.title}" />

													</span>

												</div>

											</td>


											<td class="px-6 py-4"><span
												class="inline-flex
                                                             px-3 py-1
                                                             rounded-full
                                                             bg-blue-50
                                                             text-blue-600
                                                             text-xs font-semibold">

													<c:out value="${expense.category}" />

											</span></td>


											<td
												class="px-6 py-4
                                                       text-sm text-slate-500">

												<c:out value="${expense.expenseDate}" />

											</td>


											<td class="px-6 py-4 text-right"><span
												class="font-bold text-slate-900"> ₹ <c:out
														value="${expense.amount}" />

											</span></td>

										</tr>

									</c:forEach>

								</c:otherwise>

							</c:choose>

						</tbody>

					</table>

				</div>

			</div>
			<!-- ================================================== -->
			<!-- SPENDING ANALYSIS -->
			<!-- ================================================== -->

			<div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mt-6">


				<!-- ================================================== -->
				<!-- TOP SPENDING CATEGORIES -->
				<!-- ================================================== -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl shadow-sm overflow-hidden">

					<div
						class="flex items-center justify-between
                                gap-4 px-6 py-5
                                border-b border-slate-200">

						<div>

							<h2 class="text-xl font-bold text-slate-900">Top Spending
								Categories</h2>

							<p class="text-sm text-slate-500 mt-1">Categories with the
								highest overall spending.</p>

						</div>


						<div
							class="w-10 h-10 rounded-xl
                                    bg-orange-50
                                    flex items-center justify-center
                                    shrink-0">

							<i
								class="fa-solid fa-ranking-star
                                      text-orange-500"></i>

						</div>

					</div>


					<div class="p-6">

						<c:choose>

							<c:when test="${empty categoryExpense}">

								<div
									class="min-h-[280px]
                                            flex flex-col
                                            items-center justify-center
                                            text-center">

									<div
										class="w-14 h-14
                                                rounded-xl bg-slate-100
                                                flex items-center justify-center">

										<i
											class="fa-solid fa-layer-group
                                                  text-slate-400 text-xl"></i>

									</div>

									<p
										class="font-semibold
                                              text-slate-700 mt-4">
										No spending data</p>

									<p class="text-sm text-slate-400 mt-1">Category rankings
										will appear after expenses are added.</p>

								</div>

							</c:when>


							<c:otherwise>

								<div class="space-y-3">

									<c:forEach var="entry" items="${categoryExpense}"
										varStatus="status">

										<div
											class="flex items-center gap-4
                                                    p-4 rounded-xl
                                                    border border-slate-100
                                                    hover:bg-slate-50
                                                    transition-colors">

											<!-- RANK -->

											<div
												class="w-9 h-9 rounded-lg
                                                        bg-slate-100
                                                        flex items-center
                                                        justify-center
                                                        shrink-0">

												<span
													class="text-sm font-bold
                                                             text-slate-600">

													${status.index + 1} </span>

											</div>


											<!-- CATEGORY -->

											<div class="flex-1 min-w-0">

												<div
													class="flex items-center
                                                            justify-between
                                                            gap-4">

													<div class="min-w-0">

														<p
															class="font-semibold
                                                                  text-slate-800
                                                                  truncate">

															<c:out value="${entry.key}" />

														</p>

														<p
															class="text-xs
                                                                  text-slate-400
                                                                  mt-1">

															Spending category</p>

													</div>


													<p
														class="font-bold
                                                              text-slate-900
                                                              whitespace-nowrap">

														₹
														<c:out value="${entry.value}" />

													</p>

												</div>

											</div>

										</div>

									</c:forEach>

								</div>

							</c:otherwise>

						</c:choose>

					</div>

				</div>


				<!-- ================================================== -->
				<!-- SMART INSIGHTS -->
				<!-- ================================================== -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl shadow-sm overflow-hidden">

					<div
						class="flex items-center justify-between
                                gap-4 px-6 py-5
                                border-b border-slate-200">

						<div>

							<h2 class="text-xl font-bold text-slate-900">Smart Insights
							</h2>

							<p class="text-sm text-slate-500 mt-1">Quick insights based
								on your spending activity.</p>

						</div>


						<div
							class="w-10 h-10 rounded-xl
                                    bg-indigo-50
                                    flex items-center justify-center
                                    shrink-0">

							<i
								class="fa-solid fa-lightbulb
                                      text-indigo-600"></i>

						</div>

					</div>


					<div class="p-6 space-y-4">


						<!-- BUDGET STATUS -->

						<div
							class="flex items-start gap-4
                                    bg-blue-50
                                    border border-blue-100
                                    rounded-xl p-4">

							<div
								class="w-10 h-10 rounded-lg
                                        bg-blue-100
                                        flex items-center justify-center
                                        shrink-0">

								<i
									class="fa-solid fa-wallet
                                          text-blue-600"></i>

							</div>


							<div class="min-w-0">

								<p class="font-semibold text-blue-700">Budget Status</p>


								<c:choose>

									<c:when test="${budgetAmount <= 0}">

										<p class="text-sm text-slate-600 mt-1">No budget has been
											set for this month.</p>

									</c:when>


									<c:when test="${remainingBudget < 0}">

										<p class="text-sm text-slate-600 mt-1">

											You have exceeded your monthly budget by <span
												class="font-semibold text-red-600"> ₹
												${-remainingBudget} </span>.

										</p>

									</c:when>


									<c:otherwise>

										<p class="text-sm text-slate-600 mt-1">

											You have <span class="font-semibold text-blue-700"> ₹
												${remainingBudget} </span> remaining from your monthly budget.

										</p>

									</c:otherwise>

								</c:choose>

							</div>

						</div>


						<!-- MONTHLY SPENDING -->

						<div
							class="flex items-start gap-4
                                    bg-emerald-50
                                    border border-emerald-100
                                    rounded-xl p-4">

							<div
								class="w-10 h-10 rounded-lg
                                        bg-emerald-100
                                        flex items-center justify-center
                                        shrink-0">

								<i
									class="fa-solid fa-indian-rupee-sign
                                          text-emerald-600"></i>

							</div>


							<div>

								<p class="font-semibold text-emerald-700">Monthly Spending</p>

								<p class="text-sm text-slate-600 mt-1">

									Your recorded spending for this month is <span
										class="font-semibold text-slate-800"> ₹ ${totalSpent} </span>.

								</p>

							</div>

						</div>


						<!-- BUDGET USAGE -->

						<div
							class="flex items-start gap-4
                                    bg-orange-50
                                    border border-orange-100
                                    rounded-xl p-4">

							<div
								class="w-10 h-10 rounded-lg
                                        bg-orange-100
                                        flex items-center justify-center
                                        shrink-0">

								<i
									class="fa-solid fa-gauge-high
                                          text-orange-500"></i>

							</div>


							<div>

								<p class="font-semibold text-orange-700">Budget Usage</p>


								<c:choose>

									<c:when test="${budgetAmount <= 0}">

										<p class="text-sm text-slate-600 mt-1">Set a monthly
											budget to start tracking budget utilisation.</p>

									</c:when>


									<c:when test="${budgetUsedPercentage >= 100}">

										<p class="text-sm text-slate-600 mt-1">

											You have used <span class="font-semibold text-red-600">
												${budgetUsedPercentage}% </span> of your monthly budget. Your
											spending has exceeded the limit.

										</p>

									</c:when>


									<c:when test="${budgetUsedPercentage >= 90}">

										<p class="text-sm text-slate-600 mt-1">

											You have used <span class="font-semibold text-red-600">
												${budgetUsedPercentage}% </span> of your budget. Only a small
											amount remains.

										</p>

									</c:when>


									<c:when test="${budgetUsedPercentage >= 70}">

										<p class="text-sm text-slate-600 mt-1">

											You have used <span class="font-semibold text-orange-600">
												${budgetUsedPercentage}% </span> of your monthly budget.

										</p>

									</c:when>


									<c:otherwise>

										<p class="text-sm text-slate-600 mt-1">

											You have used <span class="font-semibold text-emerald-600">
												${budgetUsedPercentage}% </span> of your monthly budget and are
											currently within a healthy range.

										</p>

									</c:otherwise>

								</c:choose>

							</div>

						</div>


						<!-- MONTH-TO-MONTH TREND -->

						<div
							class="flex items-start gap-4
                                    bg-violet-50
                                    border border-violet-100
                                    rounded-xl p-4">

							<div
								class="w-10 h-10 rounded-lg
                                        bg-violet-100
                                        flex items-center justify-center
                                        shrink-0">

								<i
									class="fa-solid fa-chart-line
                                          text-violet-600"></i>

							</div>


							<div>

								<p class="font-semibold text-violet-700">Spending Trend</p>


								<c:choose>

									<c:when test="${spendingTrend eq 'INCREASED'}">

										<p class="text-sm text-slate-600 mt-1">

											Spending increased by <span
												class="font-semibold text-red-600">
												${spendingChangePercentage}% </span> compared with

											<c:out value="${previousMonthName}" />
											.

										</p>

									</c:when>


									<c:when test="${spendingTrend eq 'DECREASED'}">

										<p class="text-sm text-slate-600 mt-1">

											Spending decreased by <span
												class="font-semibold text-emerald-600">
												${-spendingChangePercentage}% </span> compared with

											<c:out value="${previousMonthName}" />
											.

										</p>

									</c:when>


									<c:when test="${spendingTrend eq 'NEW_SPENDING'}">

										<p class="text-sm text-slate-600 mt-1">

											No expenses were recorded in

											<c:out value="${previousMonthName}" />
											, so there is no percentage comparison yet.

										</p>

									</c:when>


									<c:otherwise>

										<p class="text-sm text-slate-600 mt-1">Spending is
											unchanged from the previous month.</p>

									</c:otherwise>

								</c:choose>

							</div>

						</div>

					</div>

				</div>

			</div>


			<!-- ================================================== -->
			<!-- DASHBOARD SUMMARY -->
			<!-- ================================================== -->

			<div
				class="bg-white border border-slate-200
                        rounded-2xl shadow-sm p-6 mt-6">

				<div
					class="flex flex-col lg:flex-row
                            lg:items-center lg:justify-between
                            gap-6">


					<!-- LEFT -->

					<div>

						<div class="flex items-center gap-3">

							<div
								class="w-10 h-10 rounded-xl
                                        bg-emerald-50
                                        flex items-center justify-center">

								<i
									class="fa-solid fa-chart-simple
                                          text-emerald-600"></i>

							</div>


							<div>

								<h2 class="text-xl font-bold text-slate-900">Dashboard
									Summary</h2>

								<p class="text-sm text-slate-500 mt-1">A quick overview of
									your current finances.</p>

							</div>

						</div>

					</div>


					<!-- SUMMARY VALUES -->

					<div
						class="grid grid-cols-2 sm:grid-cols-4
                                gap-x-8 gap-y-5">


						<div>

							<p
								class="text-xs font-medium uppercase
                                      tracking-wide text-slate-400">
								Expenses</p>

							<p class="text-lg font-bold text-slate-900 mt-1">
								${totalRecords}</p>

						</div>


						<div>

							<p
								class="text-xs font-medium uppercase
                                      tracking-wide text-slate-400">
								Spent</p>

							<p class="text-lg font-bold text-red-600 mt-1">₹
								${totalSpent}</p>

						</div>


						<div>

							<p
								class="text-xs font-medium uppercase
                                      tracking-wide text-slate-400">
								Budget</p>

							<p class="text-lg font-bold text-blue-600 mt-1">₹
								${budgetAmount}</p>

						</div>


						<div>

							<p
								class="text-xs font-medium uppercase
                                      tracking-wide text-slate-400">
								Used</p>

							<p
								class="text-lg font-bold
                                      ${budgetUsedPercentage >= 100
                                      ? 'text-red-600'
                                      : budgetUsedPercentage >= 70
                                      ? 'text-orange-500'
                                      : 'text-emerald-600'}
                                      mt-1">

								${budgetUsedPercentage}%</p>

						</div>

					</div>

				</div>

			</div>


		</div>

	</div>

</div>

</body>

</html>