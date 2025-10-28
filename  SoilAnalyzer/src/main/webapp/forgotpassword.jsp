<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Soil Analyzer</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--primary-color: #2e7d32;
	--primary-dark: #1b5e20;
	--primary-light: #4caf50;
	--accent-color: #ff9800;
}

body {
	background: linear-gradient(135deg, #2e7d32 0%, #1b5e20 100%);
	min-height: 100vh;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 20px;
}

.login-container {
	max-width: 420px;
	width: 100%;
}

.login-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 15px;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(255, 255, 255, 0.3);
}

.card-header {
	background: linear-gradient(135deg, var(--primary-color) 0%,
		var(--primary-dark) 100%);
	color: white;
	text-align: center;
	padding: 25px 20px;
	border-bottom: none;
}

.card-header h2 {
	margin: 0;
	font-weight: 700;
	font-size: 1.8rem;
}

.card-header p {
	margin: 8px 0 0;
	opacity: 0.9;
	font-size: 0.95rem;
}

.card-body {
	padding: 30px;
}

.form-control {
	border-radius: 10px;
	padding: 12px 15px;
	border: 2px solid #e8f5e9;
	transition: all 0.3s;
}

.form-control:focus {
	border-color: var(--primary-light);
	box-shadow: 0 0 0 0.25rem rgba(76, 175, 80, 0.25);
}

.input-group-text {
	background-color: #e8f5e9;
	border: 2px solid #e8f5e9;
	border-right: none;
	border-radius: 10px 0 0 10px;
}

.btn-login {
	background: linear-gradient(to right, var(--primary-color),
		var(--primary-dark));
	border: none;
	border-radius: 10px;
	padding: 12px;
	font-weight: 600;
	font-size: 1.1rem;
	transition: all 0.3s;
	box-shadow: 0 4px 15px rgba(46, 125, 50, 0.3);
}

.btn-login:hover {
	transform: translateY(-2px);
	box-shadow: 0 6px 20px rgba(46, 125, 50, 0.4);
}

.btn-register {
	background: transparent;
	border: 2px solid var(--primary-color);
	color: var(--primary-color);
	border-radius: 10px;
	padding: 10px;
	font-weight: 600;
	transition: all 0.3s;
}

.btn-register:hover {
	background: var(--primary-color);
	color: white;
	transform: translateY(-2px);
}

.btn-plantix {
	background: transparent;
	border: 2px solid #ff9800;
	color: #ff9800;
	border-radius: 10px;
	padding: 10px;
	font-weight: 600;
	transition: all 0.3s;
	width: 100%;
	text-decoration: none;
	display: block;
	text-align: center;
}

.btn-plantix:hover {
	background: #ff9800;
	color: white;
	transform: translateY(-2px);
}

.alert-message {
	border-radius: 10px;
	border: none;
	padding: 12px 15px;
	margin-bottom: 20px;
}

.divider {
	display: flex;
	align-items: center;
	margin: 25px 0;
}

.divider::before, .divider::after {
	content: "";
	flex: 1;
	border-bottom: 1px solid #e0e0e0;
}

.divider span {
	padding: 0 15px;
	color: #757575;
	font-size: 0.9rem;
}

.feature-icon {
	width: 80px;
	height: 80px;
	background: linear-gradient(135deg, var(--primary-light),
		var(--primary-color));
	border-radius: 50%;
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0 auto 15px;
	color: white;
	font-size: 2rem;
}

.feature-item {
	text-align: center;
	padding: 20px 15px;
}

.feature-item h5 {
	font-size: 1.1rem;
	margin-bottom: 10px;
	color: var(--primary-dark);
}

.feature-item p {
	font-size: 0.9rem;
	color: #616161;
	margin-bottom: 15px;
}

.footer-text {
	text-align: center;
	margin-top: 20px;
	color: rgba(255, 255, 255, 0.8);
	font-size: 0.85rem;
}

.soil-graphic {
	position: absolute;
	bottom: 0;
	left: 0;
	width: 100%;
	height: 80px;
	background:
		url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1200 120" preserveAspectRatio="none"><path d="M0,0V46.29c47.79,22.2,103.59,32.17,158,28,70.36-5.37,136.33-33.31,206.8-37.5C438.64,32.43,512.34,53.67,583,72.05c69.27,18,138.3,24.88,209.4,13.08,36.15-6,69.85-17.84,104.45-29.34C989.49,25,1113-14.29,1200,52.47V0Z" opacity=".25" fill="%232e7d32"/><path d="M0,0V15.81C13,36.92,27.64,56.86,47.69,72.05,99.41,111.27,165,111,224.58,91.58c31.15-10.15,60.09-26.07,89.67-39.8,40.92-19,84.73-46,130.83-49.67,36.26-2.85,70.9,9.42,98.6,31.56,31.77,25.39,62.32,62,103.63,73,40.44,10.79,81.35-6.69,119.13-24.28s75.16-39,116.92-43.05c59.73-5.85,113.28,22.88,168.9,38.84,30.2,8.66,59,6.17,87.09-7.5,22.43-10.89,48-26.93,60.65-49.24V0Z" opacity=".5" fill="%232e7d32"/><path d="M0,0V5.63C149.93,59,314.09,71.32,475.83,42.57c43-7.64,84.23-20.12,127.61-26.46,59-8.63,112.48,12.24,165.56,35.4C827.93,77.22,886,95.24,951.2,90c86.53-7,172.46-45.71,248.8-84.81V0Z" fill="%232e7d32"/></svg>');
	background-size: cover;
	background-repeat: no-repeat;
	z-index: -1;
}
</style>
</head>
<body>
	<%@ include file="loader.jsp"%>

	<div class="login-container">
		<!-- Message Section - Handles both error and msg attributes -->
		<%
		if (request.getAttribute("error") != null) {
		%>
		<div class="alert alert-danger alert-message" role="alert">
			<i class="fas fa-exclamation-triangle me-2"></i>
			<%=request.getAttribute("error")%>
		</div>
		<%
		}
		%>

		<%
		if (request.getAttribute("msg") != null) {
		%>
		<div class="alert alert-success alert-message" role="alert">
			<i class="fas fa-check-circle me-2"></i>
			<%=request.getAttribute("msg")%>
		</div>
		<%
		}
		%>

		<div class="login-card">
			<div class="card-header">
				<h2>
					<i class="fas fa-seedling me-2"></i>Soil Analyzer
				</h2>
				<p>Forgot Password</p>
			</div>

			<div class="card-body">
				<form action="ForgotPassword" method="post">
					<div class="mb-3">
						<label class="form-label fw-semibold">Email</label>
						<div class="input-group">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
							<input type="text" name="email" class="form-control"
								placeholder="Enter your Email" required>
						</div>
					</div>




					<div class="d-grid mb-3">
						<button type="submit" class="btn btn-login">
							<i class="fas fa-sign-in-alt me-2"></i>Send password
						</button>
					</div>
				</form>



			</div>
		</div>

		<div class="footer-text">
			<p>
				&copy; 2023 Soil Analyzer | <a href="#"
					class="text-light text-decoration-none">Privacy Policy</a> | <a
					href="#" class="text-light text-decoration-none">Terms of
					Service</a>
			</p>
		</div>
	</div>

	<div class="soil-graphic"></div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>