<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*,com.Bean.Soil"%>
<%
String username = (String) session.getAttribute("username");
if (username == null) {
	response.sendRedirect("login.jsp");
	return;
}

List<Soil> soilList = (List<Soil>) request.getAttribute("soilList");
%>
<!DOCTYPE html>
<html>
<head>
<title>Soil Analysis Reports</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
:root {
	--soil-dark: #8B4513;
	--soil-medium: #A0522D;
	--soil-light: #D2B48C;
	--earth-green: #556B2F;
	--leaf-green: #6B8E23;
	--growth-green: #9ACD32;
	--water-blue: #4682B4;
	--sky-blue: #87CEEB;
	--text-dark: #2F4F4F;
	--text-light: #F5F5DC;
	--shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
	--transition: all 0.3s ease;
}

body {
	background: linear-gradient(135deg, #f5f7fa 0%, #e4e8d2 100%);
	min-height: 100vh;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	color: var(--text-dark);
	position: relative;
	overflow-x: hidden;
}

/* Soil-themed background elements */
.soil-layer {
	position: absolute;
	width: 100%;
	height: 20%;
	bottom: 0;
	background: linear-gradient(to top, var(--soil-dark), var(--soil-medium));
	z-index: -1;
	border-top-left-radius: 50% 20%;
	border-top-right-radius: 50% 20%;
}

.soil-layer::before {
	content: '';
	position: absolute;
	top: -10px;
	left: 0;
	width: 100%;
	height: 20px;
	background: var(--soil-light);
	border-radius: 50%;
}

.container-custom {
	max-width: 95%;
	margin: 0 auto;
	padding: 2rem 1rem;
}

/* Header Card */
.header-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	box-shadow: var(--shadow);
	padding: 1.5rem;
	border: none;
	position: relative;
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(139, 69, 19, 0.1);
	margin-bottom: 2rem;
}

.header-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 5px;
	background: linear-gradient(to right, var(--soil-dark),
		var(--earth-green), var(--growth-green));
}

.btn-new-test {
	background: linear-gradient(to right, var(--earth-green),
		var(--leaf-green));
	border: none;
	color: white;
	font-weight: 600;
	transition: var(--transition);
}

.btn-new-test:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(85, 107, 47, 0.4);
	color: white;
}

.btn-logout {
	background: linear-gradient(to right, #dc3545, #c82333);
	border: none;
	color: white;
	font-weight: 600;
	transition: var(--transition);
}

.btn-logout:hover {
	transform: translateY(-2px);
	box-shadow: 0 5px 15px rgba(220, 53, 69, 0.4);
	color: white;
}

/* Reports Card */
.reports-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	box-shadow: var(--shadow);
	padding: 1.5rem;
	border: none;
	position: relative;
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(139, 69, 19, 0.1);
	margin-bottom: 2rem;
}

.reports-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 4px;
	background: linear-gradient(to right, var(--soil-dark),
		var(--earth-green));
}

.table thead {
	background: linear-gradient(to right, var(--soil-dark),
		var(--soil-medium));
	color: white;
}

.table tbody tr:hover {
	background-color: rgba(210, 180, 140, 0.1);
}

/* Stats Card */
.stats-card {
	background: rgba(255, 255, 255, 0.95);
	border-radius: 16px;
	box-shadow: var(--shadow);
	padding: 1.5rem;
	border: none;
	position: relative;
	overflow: hidden;
	backdrop-filter: blur(10px);
	border: 1px solid rgba(139, 69, 19, 0.1);
}

.stats-card::before {
	content: '';
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 4px;
	background: linear-gradient(to right, var(--soil-dark),
		var(--earth-green));
}

.stats-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 1.5rem;
	margin-top: 1rem;
}

.stat-item {
	background: white;
	border-radius: 12px;
	padding: 1.5rem;
	text-align: center;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
	border: 1px solid rgba(139, 69, 19, 0.1);
	transition: var(--transition);
}

.stat-item:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
}

.stat-icon {
	font-size: 2.5rem;
	margin-bottom: 1rem;
	display: block;
}

.stat-value {
	font-size: 2rem;
	font-weight: 700;
	color: var(--earth-green);
	display: block;
}

.stat-label {
	color: var(--text-dark);
	font-size: 0.9rem;
	margin-top: 0.5rem;
}

.section-title {
	color: var(--earth-green);
	font-weight: 700;
	margin-bottom: 1.5rem;
	text-align: center;
	position: relative;
	display: inline-block;
	left: 50%;
	transform: translateX(-50%);
}

.section-title::after {
	content: '';
	position: absolute;
	bottom: -8px;
	left: 25%;
	width: 50%;
	height: 3px;
	background: linear-gradient(to right, var(--soil-light),
		var(--growth-green));
	border-radius: 2px;
}

/* Soil Icon */
.soil-icon {
	display: inline-block;
	width: 24px;
	height: 24px;
	background: var(--soil-medium);
	border-radius: 50%;
	margin-right: 10px;
	position: relative;
}

.soil-icon::after {
	content: '';
	position: absolute;
	top: 5px;
	left: 5px;
	width: 14px;
	height: 14px;
	background: var(--soil-light);
	border-radius: 50%;
}

/* Status indicators */
.status-good {
	color: var(--leaf-green);
	font-weight: 600;
}

.status-warning {
	color: #b38b00;
	font-weight: 600;
}

.status-poor {
	color: #dc3545;
	font-weight: 600;
}

/* Parameter indicators */
.param-indicator {
	display: inline-flex;
	align-items: center;
	gap: 0.5rem;
}

.param-dot {
	width: 10px;
	height: 10px;
	border-radius: 50%;
	display: inline-block;
}

.dot-good {
	background-color: var(--leaf-green);
}

.dot-warning {
	background-color: #ffc107;
}

.dot-poor {
	background-color: #dc3545;
}

/* Responsive adjustments */
@media ( max-width : 768px) {
	.header-card, .reports-card, .stats-card {
		padding: 1rem;
	}
	.container-custom {
		padding: 1rem 0.5rem;
	}
	.soil-layer {
		height: 10%;
	}
	.d-flex.justify-content-between {
		flex-direction: column;
		gap: 1rem;
	}
	.d-flex.justify-content-between>div {
		width: 100%;
		text-align: center;
	}
	.table-responsive {
		font-size: 0.875rem;
	}
	.stats-grid {
		grid-template-columns: 1fr;
	}
}

/* Decorative elements */
.decoration-circle {
	position: absolute;
	border-radius: 50%;
	opacity: 0.1;
	z-index: -1;
}

.circle-1 {
	width: 150px;
	height: 150px;
	background: var(--soil-dark);
	top: -50px;
	right: -50px;
}

.circle-2 {
	width: 100px;
	height: 100px;
	background: var(--earth-green);
	bottom: -30px;
	left: -30px;
}

/* Empty state styling */
.empty-state {
	text-align: center;
	padding: 3rem 1rem;
	color: var(--text-dark);
}

.empty-state i {
	font-size: 3rem;
	color: var(--soil-light);
	margin-bottom: 1rem;
}

/* Summary badges */
.summary-badge {
	display: inline-flex;
	align-items: center;
	background: rgba(139, 69, 19, 0.1);
	padding: 0.5rem 1rem;
	border-radius: 20px;
	margin: 0.5rem;
	font-size: 0.9rem;
}

.summary-badge i {
	margin-right: 0.5rem;
	color: var(--soil-medium);
}
</style>
</head>
<body>
	<%@ include file="loader.jsp"%>

	<!-- Background elements -->
	<div class="soil-layer"></div>
	<div class="decoration-circle circle-1"></div>
	<div class="decoration-circle circle-2"></div>

	<div class="container-custom">
		<!-- Header Card -->
		<div class="header-card">
			<div
				class="d-flex justify-content-between align-items-center flex-wrap">
				<h3 class="mb-0">
					<span class="soil-icon"></span>Soil Analysis Reports
				</h3>
				<div class="d-flex align-items-center flex-wrap gap-2">
					<a href="index.jsp" class="btn btn-new-test"> <i
						class="fas fa-flask me-1"></i>New Test
					</a> <a href="LogoutServlet" class="btn btn-logout"> <i
						class="fas fa-sign-out-alt me-1"></i>Logout
					</a>
				</div>
			</div>
		</div>

		<!-- Reports Card -->
		<div class="reports-card">
			<h5 class="section-title">Soil Test History</h5>

			<!-- Summary Section -->
			<%
			if (soilList != null && !soilList.isEmpty()) {
			%>
			<div class="d-flex justify-content-center flex-wrap mb-4">
				<div class="summary-badge">
					<i class="fas fa-list"></i> <strong><%=soilList.size()%></strong>
					Total Tests
				</div>
				<div class="summary-badge">
					<i class="fas fa-map-marker-alt"></i>
					<%
					Set<String> locations = new HashSet<>();
					for (Soil soil : soilList) {
						locations.add(soil.getLocation());
					}
					%>
					<strong><%=locations.size()%></strong> Locations
				</div>
				<div class="summary-badge">
					<i class="fas fa-seedling"></i>
					<%
					Set<String> crops = new HashSet<>();
					for (Soil soil : soilList) {
						crops.add(soil.getCropRecommendation());
					}
					%>
					<strong><%=crops.size()%></strong> Crop Types
				</div>
			</div>
			<%
			}
			%>

			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead class="table-dark">
						<tr>
							<th>Date</th>
							<th>User</th>
							<th>Location</th>
							<th>pH</th>
							<th>Moisture</th>
							<th>Organic</th>
							<th>Crops</th>
							<th>Email</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (soilList != null && !soilList.isEmpty()) {
							for (Soil s : soilList) {
						%>
						<tr>
							<td><%=s.getTestDate()%></td>
							<td><%=s.getUsername()%></td>
							<td><%=s.getLocation()%></td>
							<td>
								<div class="param-indicator">
									<span
										class="param-dot <%=s.getPh() >= 6.0 && s.getPh() <= 7.5 ? "dot-good"
		: (s.getPh() >= 5.5 && s.getPh() <= 8.0 ? "dot-warning" : "dot-poor")%>"></span>
									<span
										class="<%=s.getPh() >= 6.0 && s.getPh() <= 7.5 ? "status-good"
		: (s.getPh() >= 5.5 && s.getPh() <= 8.0 ? "status-warning" : "status-poor")%>">
										<%=s.getPh()%>
									</span>
								</div>
							</td>
							<td>
								<div class="param-indicator">
									<span
										class="param-dot <%=s.getMoisture() >= 40 && s.getMoisture() <= 60 ? "dot-good"
		: (s.getMoisture() >= 30 && s.getMoisture() <= 70 ? "dot-warning" : "dot-poor")%>"></span>
									<span
										class="<%=s.getMoisture() >= 40 && s.getMoisture() <= 60 ? "status-good"
		: (s.getMoisture() >= 30 && s.getMoisture() <= 70 ? "status-warning" : "status-poor")%>">
										<%=s.getMoisture()%>%
									</span>
								</div>
							</td>
							<td>
								<div class="param-indicator">
									<span
										class="param-dot <%=s.getOrganic() >= 3.0 ? "dot-good" : (s.getOrganic() >= 1.5 ? "dot-warning" : "dot-poor")%>"></span>
									<span
										class="<%=s.getOrganic() >= 3.0 ? "status-good" : (s.getOrganic() >= 1.5 ? "status-warning" : "status-poor")%>">
										<%=s.getOrganic()%>%
									</span>
								</div>
							</td>
							<td><%=s.getCropRecommendation()%></td>
							<td><%=s.getEmail() != null ? s.getEmail() : "-"%></td>
						</tr>
						<%
						}
						} else {
						%>
						<tr>
							<td colspan="8" class="text-center py-4">
								<div class="empty-state">
									<i class="fas fa-clipboard-list"></i>
									<h5>No Soil Reports Found</h5>
									<p class="mb-0">You haven't performed any soil tests yet.</p>
									<a href="index.jsp" class="btn btn-new-test mt-3"> <i
										class="fas fa-flask me-1"></i>Perform First Test
									</a>
								</div>
							</td>
						</tr>
						<%
						}
						%>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Stats Card -->
		<%
		if (soilList != null && !soilList.isEmpty()) {
		%>
		<div class="stats-card">
			<h5 class="section-title">Soil Health Summary</h5>

			<div class="stats-grid">
				<div class="stat-item">
					<i class="fas fa-flask stat-icon"
						style="color: var(--soil-medium);"></i> <span class="stat-value"><%=soilList.size()%></span>
					<span class="stat-label">Total Tests</span>
				</div>

				<div class="stat-item">
					<i class="fas fa-map-marker-alt stat-icon"
						style="color: var(--water-blue);"></i>
					<%
					Set<String> uniqueLocations = new HashSet<>();
					for (Soil soil : soilList) {
						uniqueLocations.add(soil.getLocation());
					}
					%>
					<span class="stat-value"><%=uniqueLocations.size()%></span> <span
						class="stat-label">Test Locations</span>
				</div>

				<div class="stat-item">
					<i class="fas fa-seedling stat-icon"
						style="color: var(--leaf-green);"></i>
					<%
					Set<String> uniqueCrops = new HashSet<>();
					for (Soil soil : soilList) {
						uniqueCrops.add(soil.getCropRecommendation());
					}
					%>
					<span class="stat-value"><%=uniqueCrops.size()%></span> <span
						class="stat-label">Crop Types</span>
				</div>

				<div class="stat-item">
					<i class="fas fa-calendar-alt stat-icon"
						style="color: var(--earth-green);"></i>
					<%
					// Calculate days since first test
					if (!soilList.isEmpty()) {
						Soil firstSoil = soilList.get(0);
						// This would need proper date calculation in real implementation
					%>
					<span class="stat-value"><%=soilList.size() > 5 ? "5+" : soilList.size()%></span>
					<span class="stat-label">Recent Tests</span>
					<%
					}
					%>
				</div>
			</div>

			<!-- Legend -->
			<div class="mt-4 pt-3 border-top">
				<h6 class="text-center mb-3">Parameter Status Legend</h6>
				<div class="d-flex justify-content-center flex-wrap gap-3">
					<div class="param-indicator">
						<span class="param-dot dot-good"></span> <small>Optimal</small>
					</div>
					<div class="param-indicator">
						<span class="param-dot dot-warning"></span> <small>Acceptable</small>
					</div>
					<div class="param-indicator">
						<span class="param-dot dot-poor"></span> <small>Needs
							Attention</small>
					</div>
				</div>
			</div>
		</div>
		<%
		}
		%>
	</div>
</body>
</html>