<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<c:set var="activePage" value="profile" />
<%@ include file="/WEB-INF/views/layout/header.jspf"%>
<%@ include file="/WEB-INF/views/layout/sidebar.jspf"%>

<div class="flex-1 overflow-y-auto bg-slate-50 min-h-screen">

	<!-- ====================================================== -->
	<!-- PROFILE HEADER -->
	<!-- ====================================================== -->

	<div class="bg-white border-b border-slate-200">

		<div class="px-8 py-6">

			<h1 class="text-3xl font-bold text-slate-900">Profile</h1>

			<p class="text-sm text-slate-500 mt-1">Manage your personal
				information and account security.</p>

		</div>

	</div>


	<!-- ====================================================== -->
	<!-- CONTENT -->
	<!-- ====================================================== -->

	<div class="p-6 lg:p-8">

		<div class="max-w-6xl mx-auto">


			<!-- ================================================== -->
			<!-- SUCCESS MESSAGE -->
			<!-- ================================================== -->

			<c:if test="${not empty param.success}">

				<div
					class="mb-6 flex items-start gap-3
                            bg-emerald-50
                            border border-emerald-200
                            rounded-xl p-4">

					<div
						class="w-9 h-9 rounded-lg
                                bg-emerald-100
                                flex items-center justify-center
                                shrink-0">

						<i
							class="fa-solid fa-circle-check
                                  text-emerald-600"></i>

					</div>

					<div>
						<p class="font-semibold text-emerald-700">Success</p>

						<p class="text-sm text-emerald-700 mt-1">
							<c:out value="${param.success}" />
						</p>
					</div>
				</div>

			</c:if>
			<!-- ================================================== -->
			<!-- ERROR MESSAGE -->
			<!-- ================================================== -->
			<c:if test="${not empty param.error}">
				<div
					class="mb-6 flex items-start gap-3
                            bg-red-50
                            border border-red-200
                            rounded-xl p-4">

					<div
						class="w-9 h-9 rounded-lg
                                bg-red-100
                                flex items-center justify-center
                                shrink-0">

						<i
							class="fa-solid fa-circle-exclamation
                                  text-red-600"></i>

					</div>
					<div>
						<p class="font-semibold text-red-700">Unable to complete
							request</p>
						<p class="text-sm text-red-700 mt-1">
							<c:out value="${param.error}" />
						</p>
					</div>
				</div>
			</c:if>
			<!-- ================================================== -->
			<!-- PROFILE OVERVIEW -->
			<!-- ================================================== -->
			<div
				class="bg-white border border-slate-200
                        rounded-2xl shadow-sm p-6">

				<div
					class="flex flex-col sm:flex-row
                            sm:items-center gap-5">


					<!-- AVATAR -->

					<div
						class="w-20 h-20 rounded-2xl
                                bg-emerald-100
                                flex items-center justify-center
                                shrink-0">

						<span class="text-3xl font-bold text-emerald-700"> <c:choose>

								<c:when test="${not empty profileUser.name}">
                                    ${profileUser.name.substring(0,1)}
                                </c:when>

								<c:otherwise>
                                    U
                                </c:otherwise>

							</c:choose>

						</span>

					</div>


					<!-- USER INFO -->

					<div class="flex-1">

						<h2 class="text-2xl font-bold text-slate-900">
							<c:out value="${profileUser.name}" />
						</h2>

						<p class="text-slate-500 mt-1">
							<c:out value="${profileUser.email}" />
						</p>


						<div class="flex flex-wrap items-center gap-3 mt-4">

							<span
								class="inline-flex items-center gap-2
                                         px-3 py-1.5
                                         bg-emerald-50
                                         text-emerald-700
                                         rounded-full
                                         text-xs font-semibold">

								<i class="fa-solid fa-circle-check"></i> Active Account

							</span> <span
								class="inline-flex items-center gap-2
                                         px-3 py-1.5
                                         bg-slate-100
                                         text-slate-600
                                         rounded-full
                                         text-xs font-semibold">

								<i class="fa-solid fa-user"></i> User

							</span>

						</div>

					</div>


					<!-- ACCOUNT ID -->

					<div class="sm:text-right">

						<p
							class="text-xs uppercase tracking-wide
                                  font-medium text-slate-400">
							Account ID</p>

						<p class="font-bold text-slate-700 mt-1">
							#${profileUser.userId}</p>

					</div>

				</div>

			</div>


			<!-- ================================================== -->
			<!-- MAIN PROFILE GRID -->
			<!-- ================================================== -->

			<div class="grid grid-cols-1 xl:grid-cols-2 gap-6 mt-6">


				<!-- ================================================== -->
				<!-- PERSONAL INFORMATION -->
				<!-- ================================================== -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl shadow-sm overflow-hidden">

					<div
						class="px-6 py-5
                                border-b border-slate-200">

						<div class="flex items-center gap-3">

							<div
								class="w-10 h-10 rounded-xl
                                        bg-blue-50
                                        flex items-center justify-center">

								<i
									class="fa-solid fa-user-pen
                                          text-blue-600"></i>

							</div>


							<div>

								<h2 class="text-xl font-bold text-slate-900">Personal
									Information</h2>

								<p class="text-sm text-slate-500 mt-1">Update your name and
									email address.</p>

							</div>

						</div>

					</div>


					<form action="${pageContext.request.contextPath}/profile"
						method="post" class="p-6">

						<input type="hidden" name="action" value="updateProfile">


						<!-- NAME -->

						<div>

							<label for="name"
								class="block text-sm font-semibold
                                          text-slate-700 mb-2">

								Full Name </label>


							<div class="relative">

								<div
									class="absolute inset-y-0 left-0
                                            pl-4 flex items-center
                                            pointer-events-none">

									<i
										class="fa-regular fa-user
                                              text-slate-400"></i>

								</div>


								<input type="text" id="name" name="name"
									value="<c:out value='${profileUser.name}'/>" maxlength="100"
									required autocomplete="name"
									class="w-full
                                              border border-slate-300
                                              rounded-xl
                                              pl-11 pr-4 py-3
                                              text-slate-800
                                              bg-white
                                              outline-none
                                              focus:border-emerald-500
                                              focus:ring-2
                                              focus:ring-emerald-100
                                              transition">

							</div>

						</div>


						<!-- EMAIL -->

						<div class="mt-5">

							<label for="email"
								class="block text-sm font-semibold
                                          text-slate-700 mb-2">

								Email Address </label>


							<div class="relative">

								<div
									class="absolute inset-y-0 left-0
                                            pl-4 flex items-center
                                            pointer-events-none">

									<i
										class="fa-regular fa-envelope
                                              text-slate-400"></i>

								</div>


								<input type="email" id="email" name="email"
									value="<c:out value='${profileUser.email}'/>" maxlength="100"
									required autocomplete="email"
									class="w-full
                                              border border-slate-300
                                              rounded-xl
                                              pl-11 pr-4 py-3
                                              text-slate-800
                                              bg-white
                                              outline-none
                                              focus:border-emerald-500
                                              focus:ring-2
                                              focus:ring-emerald-100
                                              transition">

							</div>

						</div>


						<!-- SAVE BUTTON -->

						<div class="flex justify-end mt-6">

							<button type="submit"
								class="inline-flex items-center
                                           justify-center gap-2
                                           px-5 py-3
                                           bg-emerald-600
                                           hover:bg-emerald-700
                                           text-white
                                           text-sm font-semibold
                                           rounded-xl
                                           transition">

								<i class="fa-solid fa-floppy-disk"></i> Save Changes

							</button>

						</div>

					</form>

				</div>


				<!-- ================================================== -->
				<!-- ACCOUNT INFORMATION -->
				<!-- ================================================== -->

				<div
					class="bg-white border border-slate-200
                            rounded-2xl shadow-sm overflow-hidden">

					<div
						class="px-6 py-5
                                border-b border-slate-200">

						<div class="flex items-center gap-3">

							<div
								class="w-10 h-10 rounded-xl
                                        bg-violet-50
                                        flex items-center justify-center">

								<i
									class="fa-solid fa-circle-info
                                          text-violet-600"></i>

							</div>


							<div>

								<h2 class="text-xl font-bold text-slate-900">Account
									Information</h2>

								<p class="text-sm text-slate-500 mt-1">Details associated
									with your account.</p>

							</div>

						</div>

					</div>


					<div class="p-6 space-y-4">


						<!-- USER ID -->

						<div
							class="flex items-center justify-between
                                    gap-4 p-4
                                    bg-slate-50
                                    border border-slate-100
                                    rounded-xl">

							<div class="flex items-center gap-3">

								<div
									class="w-9 h-9 rounded-lg
                                            bg-blue-100
                                            flex items-center justify-center">

									<i
										class="fa-solid fa-id-card
                                              text-blue-600"></i>

								</div>

								<div>

									<p
										class="text-xs font-medium
                                              uppercase tracking-wide
                                              text-slate-400">
										User ID</p>

									<p
										class="font-semibold
                                              text-slate-800 mt-1">
										${profileUser.userId}</p>

								</div>

							</div>

						</div>


						<!-- EMAIL -->

						<div
							class="flex items-center justify-between
                                    gap-4 p-4
                                    bg-slate-50
                                    border border-slate-100
                                    rounded-xl">

							<div class="flex items-center gap-3 min-w-0">

								<div
									class="w-9 h-9 rounded-lg
                                            bg-emerald-100
                                            flex items-center justify-center
                                            shrink-0">

									<i
										class="fa-solid fa-envelope
                                              text-emerald-600"></i>

								</div>

								<div class="min-w-0">

									<p
										class="text-xs font-medium
                                              uppercase tracking-wide
                                              text-slate-400">
										Email</p>

									<p
										class="font-semibold
                                              text-slate-800 mt-1
                                              break-all">
										<c:out value="${profileUser.email}" />
									</p>

								</div>

							</div>

						</div>


						<!-- CREATED AT -->

						<div
							class="flex items-center justify-between
                                    gap-4 p-4
                                    bg-slate-50
                                    border border-slate-100
                                    rounded-xl">

							<div class="flex items-center gap-3">

								<div
									class="w-9 h-9 rounded-lg
                                            bg-orange-100
                                            flex items-center justify-center">

									<i
										class="fa-regular fa-calendar
                                              text-orange-500"></i>

								</div>

								<div>

									<p
										class="text-xs font-medium
                                              uppercase tracking-wide
                                              text-slate-400">
										Account Created</p>

									<p
										class="font-semibold
                                              text-slate-800 mt-1">

										<c:choose>

											<c:when test="${not empty profileUser.createdAt}">
												<c:out value="${profileUser.createdAt}" />
											</c:when>

											<c:otherwise>
                                                Not available
                                            </c:otherwise>

										</c:choose>

									</p>

								</div>

							</div>

						</div>


						<!-- ACCOUNT STATUS -->

						<div
							class="flex items-center justify-between
                                    gap-4 p-4
                                    bg-slate-50
                                    border border-slate-100
                                    rounded-xl">

							<div class="flex items-center gap-3">

								<div
									class="w-9 h-9 rounded-lg
                                            bg-emerald-100
                                            flex items-center justify-center">

									<i
										class="fa-solid fa-shield-halved
                                              text-emerald-600"></i>

								</div>

								<div>

									<p
										class="text-xs font-medium
                                              uppercase tracking-wide
                                              text-slate-400">
										Account Status</p>

									<p
										class="font-semibold
                                              text-emerald-600 mt-1">
										Active</p>

								</div>

							</div>

						</div>

					</div>

				</div>

			</div>


			<!-- ================================================== -->
			<!-- SECURITY -->
			<!-- ================================================== -->

			<div
				class="bg-white border border-slate-200
                        rounded-2xl shadow-sm overflow-hidden mt-6">

				<div
					class="px-6 py-5
                            border-b border-slate-200">

					<div class="flex items-center gap-3">

						<div
							class="w-10 h-10 rounded-xl
                                    bg-red-50
                                    flex items-center justify-center">

							<i
								class="fa-solid fa-lock
                                      text-red-500"></i>

						</div>


						<div>

							<h2 class="text-xl font-bold text-slate-900">Security</h2>

							<p class="text-sm text-slate-500 mt-1">Change your account
								password.</p>

						</div>

					</div>

				</div>


				<form action="${pageContext.request.contextPath}/profile"
					method="post" class="p-6">

					<input type="hidden" name="action" value="changePassword">


					<div
						class="grid grid-cols-1
                                lg:grid-cols-3 gap-5">


						<!-- CURRENT PASSWORD -->

						<div>

							<label for="currentPassword"
								class="block text-sm font-semibold
                                          text-slate-700 mb-2">

								Current Password </label>


							<div class="relative">

								<input type="password" id="currentPassword"
									name="currentPassword" required autocomplete="current-password"
									placeholder="Enter current password"
									class="w-full
                                              border border-slate-300
                                              rounded-xl
                                              pl-4 pr-11 py-3
                                              text-slate-800
                                              outline-none
                                              focus:border-emerald-500
                                              focus:ring-2
                                              focus:ring-emerald-100
                                              transition">


								<button type="button"
									onclick="togglePassword(
                                            'currentPassword',
                                            'currentPasswordIcon'
                                        )"
									class="absolute inset-y-0 right-0
                                               px-4
                                               text-slate-400
                                               hover:text-slate-700">

									<i id="currentPasswordIcon" class="fa-regular fa-eye"></i>

								</button>

							</div>

						</div>


						<!-- NEW PASSWORD -->

						<div>

							<label for="newPassword"
								class="block text-sm font-semibold
                                          text-slate-700 mb-2">

								New Password </label>


							<div class="relative">

								<input type="password" id="newPassword" name="newPassword"
									minlength="8" maxlength="100" required
									autocomplete="new-password" placeholder="Minimum 8 characters"
									class="w-full
                                              border border-slate-300
                                              rounded-xl
                                              pl-4 pr-11 py-3
                                              text-slate-800
                                              outline-none
                                              focus:border-emerald-500
                                              focus:ring-2
                                              focus:ring-emerald-100
                                              transition">


								<button type="button"
									onclick="togglePassword(
                                            'newPassword',
                                            'newPasswordIcon'
                                        )"
									class="absolute inset-y-0 right-0
                                               px-4
                                               text-slate-400
                                               hover:text-slate-700">

									<i id="newPasswordIcon" class="fa-regular fa-eye"></i>

								</button>

							</div>

						</div>


						<!-- CONFIRM PASSWORD -->

						<div>

							<label for="confirmPassword"
								class="block text-sm font-semibold
                                          text-slate-700 mb-2">

								Confirm New Password </label>


							<div class="relative">

								<input type="password" id="confirmPassword"
									name="confirmPassword" minlength="8" maxlength="100" required
									autocomplete="new-password" placeholder="Repeat new password"
									class="w-full
                                              border border-slate-300
                                              rounded-xl
                                              pl-4 pr-11 py-3
                                              text-slate-800
                                              outline-none
                                              focus:border-emerald-500
                                              focus:ring-2
                                              focus:ring-emerald-100
                                              transition">


								<button type="button"
									onclick="togglePassword(
                                            'confirmPassword',
                                            'confirmPasswordIcon'
                                        )"
									class="absolute inset-y-0 right-0
                                               px-4
                                               text-slate-400
                                               hover:text-slate-700">

									<i id="confirmPasswordIcon" class="fa-regular fa-eye"></i>

								</button>

							</div>

						</div>

					</div>


					<!-- PASSWORD INFORMATION -->

					<div
						class="flex items-start gap-3
                                bg-slate-50
                                border border-slate-200
                                rounded-xl p-4 mt-5">

						<i
							class="fa-solid fa-shield-halved
                                  text-slate-500 mt-0.5"></i>

						<p class="text-sm text-slate-500">Use at least 8 characters.
							Your new password must be different from your current password.</p>

					</div>


					<!-- CHANGE PASSWORD -->

					<div class="flex justify-end mt-6">

						<button type="submit"
							class="inline-flex items-center
                                       justify-center gap-2
                                       px-5 py-3
                                       bg-slate-900
                                       hover:bg-slate-800
                                       text-white
                                       text-sm font-semibold
                                       rounded-xl
                                       transition">

							<i class="fa-solid fa-key"></i> Change Password

						</button>

					</div>

				</form>

			</div>


		</div>

	</div>

</div>


<!-- ========================================================== -->
<!-- PASSWORD VISIBILITY -->
<!-- ========================================================== -->

<script>
	function togglePassword(inputId, iconId) {

		const input = document.getElementById(inputId);

		const icon = document.getElementById(iconId);

		if (input.type === "password") {

			input.type = "text";

			icon.classList.remove("fa-eye");

			icon.classList.add("fa-eye-slash");

		} else {

			input.type = "password";

			icon.classList.remove("fa-eye-slash");

			icon.classList.add("fa-eye");

		}
	}
</script>

</body>
</html>