<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="activePage" value="expenses" />
<%@ include file="/WEB-INF/views/layout/header.jspf"%>
<%@ include file="/WEB-INF/views/layout/sidebar.jspf"%>

<div class="flex-1 overflow-y-auto bg-slate-100 min-h-screen">

    <!-- Page Header -->

    <div class="bg-white shadow-sm border-b">

        <div class="px-8 py-6 flex items-center justify-between">

            <div>

                <h1 class="text-4xl font-bold text-slate-800">

                    Expenses

                </h1>

                <p class="text-slate-500 mt-2">

                    Manage all your expenses

                </p>

            </div>

        </div>

    </div>

    <div class="p-8">

        <!-- Success Message -->

        <c:if test="${not empty param.success}">

            <div class="mb-6 rounded-lg bg-green-100 border border-green-300 text-green-700 px-5 py-4">

                ${param.success}

            </div>

        </c:if>

        <!-- Error Message -->

        <c:if test="${not empty param.error}">

            <div class="mb-6 rounded-lg bg-red-100 border border-red-300 text-red-700 px-5 py-4">

                ${param.error}

            </div>

        </c:if>

        <!-- Summary Cards -->

        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-8">

            <div class="bg-white rounded-xl shadow-lg p-6">

                <p class="text-slate-500 text-sm">

                    Total Expenses

                </p>

                <h2 class="text-4xl font-bold text-blue-600 mt-3">

                    ${totalExpenses}

                </h2>

            </div>

            <div class="bg-white rounded-xl shadow-lg p-6">

                <p class="text-slate-500 text-sm">

                    Total Amount

                </p>

                <h2 class="text-4xl font-bold text-red-600 mt-3">

                    ₹ ${totalAmount}

                </h2>

            </div>

        </div>

        <!-- Add Expense -->

        <div class="bg-white rounded-xl shadow-lg p-8 mb-8">

            <h2 class="text-2xl font-bold text-slate-800 mb-6">

                Add New Expense

            </h2>

            <form action="${pageContext.request.contextPath}/expenses/add"
                  method="post"
                  class="grid grid-cols-1 md:grid-cols-2 gap-6">

                <div>

                    <label class="block font-medium mb-2">

                        Title

                    </label>

                    <input
                        type="text"
                        name="title"
                        required
                        class="w-full border rounded-lg px-4 py-3 focus:ring-2 focus:ring-emerald-500">

                </div>

                <div>

                    <label class="block font-medium mb-2">

                        Amount

                    </label>

                    <input
                        type="number"
                        step="0.01"
                        name="amount"
                        required
                        class="w-full border rounded-lg px-4 py-3 focus:ring-2 focus:ring-emerald-500">

                </div>

                <div>

                    <label class="block font-medium mb-2">

                        Category

                    </label>

                    <select
                        name="category"
                        required
                        class="w-full border rounded-lg px-4 py-3">

                        <option value="">Select Category</option>

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

                    <label class="block font-medium mb-2">

                        Expense Date

                    </label>

                    <input
                        type="date"
                        name="expenseDate"
                        required
                        class="w-full border rounded-lg px-4 py-3">

                </div>

                <div class="md:col-span-2">

                    <label class="block font-medium mb-2">

                        Description

                    </label>

                    <textarea
                        name="description"
                        rows="4"
                        class="w-full border rounded-lg px-4 py-3"
                        placeholder="Enter description (optional)"></textarea>

                </div>

                <div class="md:col-span-2 flex justify-end">

                    <button
                        type="submit"
                        class="bg-emerald-600 hover:bg-emerald-700 text-white font-semibold px-8 py-3 rounded-lg">

                        Save Expense

                    </button>

                </div>

            </form>

        </div>
                <!-- Search & Filters -->

        <div class="bg-white rounded-xl shadow-lg p-6 mb-8">

            <form action="${pageContext.request.contextPath}/expenses"
                  method="get"
                  class="grid grid-cols-1 md:grid-cols-5 gap-4">

                <div>

                    <label class="block font-medium mb-2">

                        Search

                    </label>

                    <input
                        type="text"
                        name="search"
                        value="${search}"
                        placeholder="Search by title..."
                        class="w-full border rounded-lg px-4 py-3">

                </div>

                <div>

                    <label class="block font-medium mb-2">

                        Category

                    </label>

                    <select
                        name="category"
                        class="w-full border rounded-lg px-4 py-3">

                        <option value="All" ${selectedCategory=='All'?'selected':''}>All</option>
                        <option value="Food" ${selectedCategory=='Food'?'selected':''}>Food</option>
                        <option value="Travel" ${selectedCategory=='Travel'?'selected':''}>Travel</option>
                        <option value="Shopping" ${selectedCategory=='Shopping'?'selected':''}>Shopping</option>
                        <option value="Bills" ${selectedCategory=='Bills'?'selected':''}>Bills</option>
                        <option value="Health" ${selectedCategory=='Health'?'selected':''}>Health</option>
                        <option value="Education" ${selectedCategory=='Education'?'selected':''}>Education</option>
                        <option value="Entertainment" ${selectedCategory=='Entertainment'?'selected':''}>Entertainment</option>
                        <option value="Other" ${selectedCategory=='Other'?'selected':''}>Other</option>

                    </select>

                </div>

                <div>

                    <label class="block font-medium mb-2">

                        Month

                    </label>

                    <input
                        type="month"
                        name="month"
                        value="${selectedMonth}"
                        class="w-full border rounded-lg px-4 py-3">

                </div>

                <div>

                    <label class="block font-medium mb-2">

                        Sort

                    </label>

                    <select
                        name="sort"
                        class="w-full border rounded-lg px-4 py-3">

                        <option value="latest" ${selectedSort=='latest'?'selected':''}>Latest</option>

                        <option value="oldest" ${selectedSort=='oldest'?'selected':''}>Oldest</option>

                        <option value="highest" ${selectedSort=='highest'?'selected':''}>Highest Amount</option>

                        <option value="lowest" ${selectedSort=='lowest'?'selected':''}>Lowest Amount</option>

                    </select>

                </div>

                <div class="flex items-end">

                    <button
                        type="submit"
                        class="w-full bg-blue-600 hover:bg-blue-700 text-white rounded-lg py-3">

                        Apply

                    </button>

                </div>

            </form>

        </div>

        <!-- Expense Table -->

        <div class="bg-white rounded-xl shadow-lg overflow-hidden">

            <div class="px-6 py-5 border-b">

                <h2 class="text-2xl font-bold text-slate-800">

                    Expense History

                </h2>

            </div>

            <div class="overflow-x-auto">

                <table class="min-w-full">

                    <thead class="bg-slate-100">

                        <tr>

                            <th class="px-6 py-4 text-left">Title</th>

                            <th class="px-6 py-4 text-left">Amount</th>

                            <th class="px-6 py-4 text-left">Category</th>

                            <th class="px-6 py-4 text-left">Date</th>

                            <th class="px-6 py-4 text-left">Description</th>

                            <th class="px-6 py-4 text-center">Actions</th>

                        </tr>

                    </thead>

                    <tbody>

                        <c:choose>

                            <c:when test="${empty expenses}">

                                <tr>

                                    <td colspan="6"
                                        class="text-center py-10 text-slate-500">

                                        No expenses found.

                                    </td>

                                </tr>

                            </c:when>

                            <c:otherwise>

                                <c:forEach var="expense" items="${expenses}">

                                    <tr class="border-b hover:bg-slate-50">

                                        <td class="px-6 py-4">

                                            ${expense.title}

                                        </td>

                                        <td class="px-6 py-4 font-semibold text-red-600">

                                            ₹ ${expense.amount}

                                        </td>

                                        <td class="px-6 py-4">

                                            <span class="bg-blue-100 text-blue-700 px-3 py-1 rounded-full text-sm">

                                                ${expense.category}

                                            </span>

                                        </td>

                                        <td class="px-6 py-4">

                                            ${expense.expenseDate}

                                        </td>

                                        <td class="px-6 py-4">

                                            ${expense.description}

                                        </td>

                                        <td class="px-6 py-4 text-center">

                                            <a href="${pageContext.request.contextPath}/expenses/edit?id=${expense.expenseId}"
                                               class="bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg">

                                                Edit

                                            </a>

                                            <form action="${pageContext.request.contextPath}/expenses/delete"
                                                  method="post"
                                                  style="display:inline;">

                                                <input
                                                    type="hidden"
                                                    name="expenseId"
                                                    value="${expense.expenseId}">

                                                <button
                                                    type="submit"
                                                    onclick="return confirm('Delete this expense?')"
                                                    class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg">

                                                    Delete

                                                </button>

                                            </form>

                                        </td>

                                    </tr>

                                </c:forEach>

                            </c:otherwise>

                        </c:choose>

                    </tbody>

                </table>

            </div>

        </div>
                <!-- Pagination -->

        <c:if test="${totalPages > 1}">

            <div class="flex justify-center items-center gap-2 mt-8">

                <!-- Previous -->

                <c:if test="${currentPage > 1}">

                    <a href="${pageContext.request.contextPath}/expenses?page=${currentPage-1}&search=${search}&category=${selectedCategory}&month=${selectedMonth}&sort=${selectedSort}"
                       class="px-4 py-2 bg-slate-200 rounded-lg hover:bg-slate-300 transition">

                        Previous

                    </a>

                </c:if>

                <!-- Page Numbers -->

                <c:forEach begin="1" end="${totalPages}" var="i">

                    <a href="${pageContext.request.contextPath}/expenses?page=${i}&search=${search}&category=${selectedCategory}&month=${selectedMonth}&sort=${selectedSort}"
                       class="px-4 py-2 rounded-lg transition
                       ${i == currentPage ? 'bg-emerald-600 text-white' : 'bg-slate-200 hover:bg-slate-300'}">

                        ${i}

                    </a>

                </c:forEach>

                <!-- Next -->

                <c:if test="${currentPage < totalPages}">

                    <a href="${pageContext.request.contextPath}/expenses?page=${currentPage+1}&search=${search}&category=${selectedCategory}&month=${selectedMonth}&sort=${selectedSort}"
                       class="px-4 py-2 bg-slate-200 rounded-lg hover:bg-slate-300 transition">

                        Next

                    </a>

                </c:if>

            </div>

        </c:if>

    </div>

</div>

</body>

</html>